using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LTrWebLibraryBTL.View
{
    public partial class BTlLayout : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentAccount"] != null)
            {
                divDangNhap.Visible = false;
                divDangXuat.Visible = true;
                string role = Session["currentRole"].ToString();
                if (int.Parse(role) == 1)
                {
                    adminRoleA.Visible = true;
                    clientRoleA.Visible = false;
                }
                else
                {
                    adminRoleA.Visible = false;
                    clientRoleA.Visible = true;
                }
            } else
            {
                divDangNhap.Visible = true;
                divDangXuat.Visible = false;
            }
        }
    }
}