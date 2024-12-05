using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QLSP_NoSeparateForm.Models
{
    public class Sanphams
    {
        public Sanphams(string masp, string tensp, string hangsx, string mota, double dongia, DateTime ngaydang, string hinhanh)
        {
            Masp = masp;
            Tensp = tensp;
            Hangsx = hangsx;
            Mota = mota;
            Dongia = dongia;
            Ngaydang = ngaydang;
            Hinhanh = hinhanh;
        }

        public Sanphams() { }

        public string Masp { get; set; }
        public string Tensp { get; set; }
        public string Hangsx { get; set; }
        public string Mota { get; set; }
        public double Dongia { get; set; }
        public DateTime Ngaydang { get; set; }
        public string Hinhanh { get; set; }

    }
}