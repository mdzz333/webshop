using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] != null)
        {
            Menu1.Items[4].Text = "注销";

            lblUserName.Text = "您好，" + Session["UserName"].ToString() + ",欢迎光临本网站！";
        }

        else
        {
            Menu1.Items[4].Text = "登录";

            lblUserName.Text = "";
        }
    }
}
