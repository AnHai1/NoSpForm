using QLSP_NoSeparateForm;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace QLSP_NoSeparateForm.Models
{
    public class Database
    {
        SqlConnection conn;
        public void OpenConn()
        {
            string sql = @"Data Source=LAPTOP-4G5P5MP3\SQLEXPRESS;Initial Catalog=CuaHang;Integrated Security=True";
            conn = new SqlConnection(sql);
            conn.Open();
        }

        public void CloseConn()
        {
            if (conn != null && conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
        }

        public DataTable Get_AllSanPham()
        {
            DataTable tb = new DataTable();
            string sql = "SELECT * FROM sanpham";
            OpenConn();
            SqlCommand cmd = new SqlCommand(sql, conn);
            SqlDataReader dr = cmd.ExecuteReader();
            tb.Load(dr);
            CloseConn();
            return tb;
        }

        public DataTable GetSanPhamById(string masp)
        {
            DataTable tb = new DataTable();
            string sql = "SELECT * FROM sanpham WHERE Masp = @ms";
            OpenConn();
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("ms", masp);
            SqlDataReader dr = cmd.ExecuteReader();
            tb.Load(dr);
            CloseConn();
            return tb;
        }

        public void insert(Sanphams sp)
        {
            string sql = "INSERT INTO sanpham (Masp, Tensp, Hangsx, Mota, Dongia, Ngaydang, Hinhanh) VALUES(@ms, @ts, @hsx, @mt, @dg, @nd, @ha)";
            OpenConn();
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("ms", sp.Masp);
            cmd.Parameters.AddWithValue("ts", sp.Tensp);
            cmd.Parameters.AddWithValue("hsx", sp.Hangsx);
            cmd.Parameters.AddWithValue("mt", sp.Mota);
            cmd.Parameters.AddWithValue("dg", sp.Dongia);
            cmd.Parameters.AddWithValue("nd", sp.Ngaydang);
            cmd.Parameters.AddWithValue("ha", sp.Hinhanh);
            cmd.ExecuteNonQuery();
            CloseConn();
        }

        public void delete(string ms)
        {
            string sql = "DELETE FROM sanpham WHERE Masp = @masp";
            OpenConn();
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("masp", ms);
            cmd.ExecuteNonQuery();
            CloseConn();
        }

        public void update(Sanphams sp)
        {
            string sql = "UPDATE sanpham SET Tensp = @ts, Hangsx = @hsx, Mota = @mt, Dongia = @dg, Ngaydang = @nd, Hinhanh = @ha WHERE Masp = @ms";
            OpenConn();
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("ts", sp.Tensp);
            cmd.Parameters.AddWithValue("hsx", sp.Hangsx);
            cmd.Parameters.AddWithValue("mt", sp.Mota);
            cmd.Parameters.AddWithValue("dg", sp.Dongia);
            cmd.Parameters.AddWithValue("nd", sp.Ngaydang);
            cmd.Parameters.AddWithValue("ha", string.IsNullOrEmpty(sp.Hinhanh) ? DBNull.Value : (object)sp.Hinhanh);
            cmd.Parameters.AddWithValue("ms", sp.Masp);
            cmd.ExecuteNonQuery();
            CloseConn();
        }

        public Boolean CheckMa(string ms)
        {
            DataTable tb = new DataTable();
            string sql = "SELECT * FROM sanpham WHERE Masp = @ms";
            OpenConn();
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("ms", ms);
            SqlDataReader dr = cmd.ExecuteReader();
            tb.Load(dr);
            CloseConn();
            return tb.Rows.Count > 0;
        }
    }
}