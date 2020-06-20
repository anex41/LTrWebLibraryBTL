using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Services;

namespace LTrWebLibraryBTL.Services
{
    /// <summary>
    /// Summary description for LoginServices
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class LoginServices : System.Web.Services.WebService
    {
        static string connStr = ConfigurationManager.ConnectionStrings["myConStr"].ConnectionString;
        SqlConnection con = new SqlConnection(connStr);

        [WebMethod(enableSession: true)]
        public int UserLogin(string username, string password, string library)
        {
            string tblpass = "", role = "";
            var hashedPassword = HashString(password).ToLower();
            SqlCommand cmd = new SqlCommand("getLibraryUserByAccount", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter acc = cmd.Parameters.Add("account", SqlDbType.VarChar, 30);
            acc.Value = username;
            SqlParameter li = cmd.Parameters.Add("library", SqlDbType.Int);
            li.Value = int.Parse(library);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                while (rdr.Read())
                {
                    tblpass = (rdr["userPassword"].ToString());
                    role = (rdr["userRole"].ToString());
                }
                con.Close();
            }
            else
            {
                con.Close();
                return -1;
            }
            if (string.Compare(hashedPassword, tblpass) == 0)
            {
                return 1;
            }
            else
            {
                return -2;
            }
        }
        private string HashString(string input)
        {
            StringBuilder sb = new StringBuilder();
            foreach (byte b in GetHash(input))
                sb.Append(b.ToString("X2"));
            return sb.ToString();
        }

        private byte[] GetHash(string inputString)
        {
            using (HashAlgorithm algorithm = SHA256.Create())
                return algorithm.ComputeHash(Encoding.UTF8.GetBytes(inputString));
        }
    }
}
