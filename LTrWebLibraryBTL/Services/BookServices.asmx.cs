using LTrWebLibraryBTL.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Services;

namespace LTrWebLibraryBTL.Services
{
    /// <summary>
    /// Summary description for BookServices
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
    [System.Web.Script.Services.ScriptService]
    public class BookServices : System.Web.Services.WebService
    {
        static string connStr = ConfigurationManager.ConnectionStrings["myConStr"].ConnectionString;
        SqlConnection con = new SqlConnection(connStr);

        [WebMethod(enableSession: true)]
        public Array GetBookList()
        {
            if (Session["currentLibrary"] == null) return null;
            List<BookModel> bml = new List<BookModel>();
            SqlCommand cmd = new SqlCommand("getBookList", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter value = cmd.Parameters.Add("libraryID", SqlDbType.Int);
            value.Value = int.Parse(Session["currentLibrary"].ToString());
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                while (rdr.Read())
                {
                    BookModel bm = new BookModel();
                    bm.Masach = int.Parse(rdr["iMasach"].ToString());
                    bm.Tensach = (rdr["sTensach"].ToString());
                    bm.Tacgia = (rdr["sTacgia"].ToString());
                    bm.Theloai = (rdr["sTheloai"].ToString());
                    bml.Add(bm);
                }
                con.Close();
            }
            else
            {
                con.Close();
                return null;
            }
            return bml.ToArray();
        }

        [WebMethod]
        public int AddBook(string tensach, string tacgia, string theloai, int libId)
        {
            int result = 0;
            SqlCommand cmd = new SqlCommand("addBook", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter tenSach = cmd.Parameters.Add("tensach", SqlDbType.NVarChar, 50);
            SqlParameter theLoai = cmd.Parameters.Add("theloai", SqlDbType.NVarChar, 50);
            SqlParameter tacGia = cmd.Parameters.Add("tacgia", SqlDbType.NVarChar, 50);
            SqlParameter LibraryID = cmd.Parameters.Add("libraryId", SqlDbType.Int);

            tenSach.Value = tensach;
            theLoai.Value = theloai;
            tacGia.Value = tacgia;
            LibraryID.Value = libId;
            var returnParameter = cmd.Parameters.Add("@ReturnVal", SqlDbType.Int);
            returnParameter.Direction = ParameterDirection.ReturnValue;

            con.Open();
            cmd.ExecuteNonQuery();
            result = int.Parse(returnParameter.Value.ToString());
            con.Close();
            return result;
        }
    }
}
