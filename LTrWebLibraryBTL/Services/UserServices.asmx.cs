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
    /// Summary description for UserServices
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class UserServices : System.Web.Services.WebService
    {
        static string connStr = ConfigurationManager.ConnectionStrings["myConStr"].ConnectionString;
        SqlConnection con = new SqlConnection(connStr);

        [WebMethod(enableSession: true)]
        public Array GetUserList()
        {
            if (Session["currentLibrary"] == null) return null;
            List<UserModel> uml = new List<UserModel>();
            SqlCommand cmd = new SqlCommand("getLibraryUserList", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter value = cmd.Parameters.Add("libraryID", SqlDbType.Int);
            value.Value = int.Parse(Session["currentLibrary"].ToString());
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                while (rdr.Read())
                {
                    UserModel um = new UserModel();
                    um.UserId = int.Parse(rdr["userId"].ToString());
                    um.UserAccount = (rdr["userAccount"].ToString());
                    um.UserDisplayName = (rdr["userDisplayName"].ToString());
                    um.UserStatus = int.Parse(rdr["userStatus"].ToString());
                    um.UserRole = int.Parse(rdr["userRole"].ToString());
                    uml.Add(um);
                }
                con.Close();
            }
            else
            {
                con.Close();
                return null;
            }
            return uml.ToArray();
        }

        [WebMethod]
        public void DisapproveUser(int userID)
        {
            SqlCommand cmd = new SqlCommand("disapproveUser", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter value = cmd.Parameters.Add("userId", SqlDbType.Int);
            value.Value = userID;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            return;
        }

        [WebMethod]
        public void ApproveUser(int userID)
        {
            SqlCommand cmd = new SqlCommand("approveUser", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter value = cmd.Parameters.Add("userId", SqlDbType.Int);
            value.Value = userID;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            return;
        }

        [WebMethod]
        public int SignUpUser(string account, string password, string name, string email, string address, int libId)
        {
            int result = 0;
            SqlCommand cmd = new SqlCommand("signUpProc", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter Account = cmd.Parameters.Add("account", SqlDbType.VarChar, 50);
            SqlParameter Password = cmd.Parameters.Add("password", SqlDbType.VarChar, 256);
            SqlParameter Name = cmd.Parameters.Add("name", SqlDbType.NVarChar, 60);
            SqlParameter Email = cmd.Parameters.Add("email", SqlDbType.VarChar, 60);
            SqlParameter Address = cmd.Parameters.Add("address", SqlDbType.NVarChar, 60);
            SqlParameter LibraryID = cmd.Parameters.Add("library", SqlDbType.Int);
            Account.Value = account;
            Password.Value = HashString(password).ToLower();
            Name.Value = name;
            Email.Value = email;
            Address.Value = address;
            LibraryID.Value = libId;
            var returnParameter = cmd.Parameters.Add("@ReturnVal", SqlDbType.Int);
            returnParameter.Direction = ParameterDirection.ReturnValue;
            con.Open();
            cmd.ExecuteNonQuery();
            result = int.Parse(returnParameter.Value.ToString());
            con.Close();
            return result;
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
