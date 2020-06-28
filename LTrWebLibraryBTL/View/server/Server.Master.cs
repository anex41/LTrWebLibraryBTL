using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LTrWebLibraryBTL.View.server
{
    public partial class Server : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentAccount"] != null)
            {
                divDangNhap.Visible = false;
                divDangXuat.Visible = true;
            }
            else
            {
                divDangNhap.Visible = true;
                divDangXuat.Visible = false;
            }
        }
    }
}