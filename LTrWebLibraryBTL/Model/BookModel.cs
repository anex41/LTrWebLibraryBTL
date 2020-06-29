using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LTrWebLibraryBTL.Model
{
    public class BookModel
    {
        private int iMasach;
        private string sTensach;
        private string sTacgia;
        private string sTheloai;
        private int libraryId;

        public int Masach { get; set; }
        public string Tensach { get; set; }
        public string Tacgia { get; set; }
        public string Theloai { get; set; }
        public int LibraryId { get; set; }

        public BookModel() { }
    }
}