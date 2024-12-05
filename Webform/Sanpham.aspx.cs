using QLSP_NoSeparateForm.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static QLSP_NoSeparateForm.Sanpham;

namespace QLSP_NoSeparateForm
{
    public partial class Sanpham : System.Web.UI.Page
    {
            Database db = new Database();

            protected void Page_Load(object sender, EventArgs e)
            {
                if (!Page.IsPostBack)
                {
                    LoadLuoi();
                }
            }

            public void LoadLuoi()
            {
                db.OpenConn();
                gvSanPham.DataSource = db.Get_AllSanPham();
                gvSanPham.DataBind();
                db.CloseConn();
            }

            protected void btn_Them_Click(object sender, EventArgs e)
            {
                string masp = txt_masp.Text.Trim();
                string tensp = txt_tensp.Text.Trim();
                string hangsx = txt_hangsx.Text.Trim();
                string mota = txt_mota.Text.Trim();
                double dongia;

                if (string.IsNullOrEmpty(masp) || string.IsNullOrEmpty(tensp) ||
                    string.IsNullOrEmpty(hangsx) || string.IsNullOrEmpty(mota) ||
                    !double.TryParse(txt_dongia.Text.Trim(), out dongia))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Vui lòng điền đầy đủ thông tin!');", true);
                    return;
                }

                if (FileUpload1.HasFile)
                {
                    string hinhAnh = FileUpload1.FileName;
                    string filepath = MapPath("~/Images/" + hinhAnh);
                    FileUpload1.SaveAs(filepath);

                    if (!db.CheckMa(masp))
                    {
                        db.OpenConn();
                        Sanphams sp = new Sanphams(masp, tensp, hangsx, mota, dongia, DateTime.Now, hinhAnh);
                        db.insert(sp);
                        db.CloseConn();
                        LoadLuoi();
                        ClearFields();
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Thêm sản phẩm thành công!');", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Mã sản phẩm đã tồn tại!');", true);
                    }
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Vui lòng chọn hình ảnh!');", true);
                }
            }

            protected void btn_xoa_Click(object sender, EventArgs e)
            {
                bool hasSelectedProduct = false;
                bool isDeleted = false;

                foreach (GridViewRow row in gvSanPham.Rows)
                {
                    CheckBox ck = (CheckBox)row.FindControl("ckb_ma");
                    if (ck != null && ck.Checked)
                    {
                        hasSelectedProduct = true;
                        break;
                    }
                }

                if (!hasSelectedProduct)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Không có sản phẩm nào được chọn để xóa!');", true);
                }
                else
                {
                    string confirmScript = "if (confirm('Bạn có chắc chắn muốn xóa sản phẩm đã chọn không?')) { __doPostBack('" + btn_xoa.UniqueID + "', 'confirm'); }";
                    ClientScript.RegisterStartupScript(this.GetType(), "confirmDelete", confirmScript, true);
                }

                if (Request["__EVENTARGUMENT"] == "confirm")
                {
                    foreach (GridViewRow row in gvSanPham.Rows)
                    {
                        CheckBox ck = (CheckBox)row.FindControl("ckb_ma");
                        if (ck != null && ck.Checked)
                        {
                            string masp = gvSanPham.DataKeys[row.RowIndex].Value.ToString();
                            db.OpenConn();
                            db.delete(masp);
                            db.CloseConn();
                            isDeleted = true;
                        }
                    }
                    LoadLuoi();
                    if (isDeleted)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Xóa sản phẩm thành công!');", true);
                    }
                }
            }

            protected void btn_nhaplai_Click(object sender, EventArgs e)
            {
                ClearFields();
            }

            private void ClearFields()
            {
                txt_masp.Text = "";
                txt_tensp.Text = "";
                txt_hangsx.Text = "";
                txt_mota.Text = "";
                txt_dongia.Text = "";
                FileUpload1.Attributes.Clear();
            }

            protected void gvSanPham_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
            {
                gvSanPham.EditIndex = -1;
                LoadLuoi();
            }

            protected void gvSanPham_RowEditing(object sender, GridViewEditEventArgs e)
            {
                gvSanPham.EditIndex = e.NewEditIndex;
                LoadLuoi();
            }

            protected void gvSanPham_RowUpdating(object sender, GridViewUpdateEventArgs e)
            {
                string masp = gvSanPham.DataKeys[e.RowIndex].Value.ToString();
                string tensp = ((TextBox)gvSanPham.Rows[e.RowIndex].Cells[2].Controls[0]).Text;
                string hangsx = ((TextBox)gvSanPham.Rows[e.RowIndex].Cells[3].Controls[0]).Text;
                string mota = ((TextBox)gvSanPham.Rows[e.RowIndex].Cells[4].Controls[0]).Text;
                double dongia = double.Parse(((TextBox)gvSanPham.Rows[e.RowIndex].Cells[5].Controls[0]).Text);

                FileUpload ha = (FileUpload)gvSanPham.Rows[e.RowIndex].FindControl("FileUpload2");
                string hinhAnh = null;

                if (ha.HasFile)
                {
                    hinhAnh = ha.FileName;
                    string pathha = MapPath("~/Images/" + hinhAnh);
                    ha.SaveAs(pathha);
                }
                else
                {
                    DataTable dt = db.GetSanPhamById(masp);
                    if (dt.Rows.Count > 0)
                    {
                        hinhAnh = dt.Rows[0]["Hinhanh"].ToString();
                    }
                }

                Sanphams sp = new Sanphams(masp, tensp, hangsx, mota, dongia, DateTime.Now, hinhAnh);
                db.update(sp);
                gvSanPham.EditIndex = -1;
                LoadLuoi();
            }

            protected void ck_all_CheckedChanged(object sender, EventArgs e)
            {
                CheckBox ck_all = (CheckBox)gvSanPham.HeaderRow.FindControl("ck_all");
                foreach (GridViewRow row in gvSanPham.Rows)
                {
                    CheckBox ck = (CheckBox)row.FindControl("ckb_ma");
                    ck.Checked = ck_all.Checked;
                }
            }
        }
}