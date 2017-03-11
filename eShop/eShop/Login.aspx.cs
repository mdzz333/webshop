using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["UserID"] = null;

        if (!IsPostBack)
        {

            HttpCookie cookie = Request.Cookies["UserID"];

            if (cookie != null && cookie["UserID"].ToString() != "")
            {
                txtUserID.Text = cookie["UserID"].ToString();
            }
        }
    }
    protected void lbLogin_Click(object sender, EventArgs e)
    {
        if (txtCode.Text.ToUpper() != Session["VNum"].ToString())
        {

            Response.Write("<script>alert('!');</script>");
        }
        else
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["eShopConnectionString"].ConnectionString);

            SqlCommand cmd = new SqlCommand("SELECT * FROM Users WHERE UserID=@UserID AND Pwd=@Pwd", cn);
            cmd.Parameters.Add("@UserID", SqlDbType.NVarChar).Value = txtUserID.Text;

            cmd.Parameters.Add("@Pwd", SqlDbType.NVarChar).Value = txtPwd.Text;

            DataSet ds = new DataSet();

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            cn.Open();
            da.Fill(ds);
            cn.Close();

            if (ds.Tables[0].Rows.Count > 0)
            {

                HttpCookie cookie = Request.Cookies["UserID"];

                if (cookie == null)
                {
                    cookie = new HttpCookie("UserID");
                }

                cookie.Values.Set("UserID", txtUserID.Text);

                if (cbMemory.Checked)
                    cookie.Expires = System.DateTime.Now.AddDays(30);
                else
                    cookie.Expires = System.DateTime.Now;

                Response.SetCookie(cookie);

                Session["UserID"] = txtUserID.Text;

                Session["UserName"] = ds.Tables[0].Rows[0]["UserName"];

                if (Request.QueryString["url"] != null)
                {
                    Response.Redirect(Request.QueryString["url"]);
                }
                else
                    Response.Redirect("Products.aspx");
            }
            else
            {
                Session["UserID"] = null;

                Response.Write("<script language='javascript'> alert('该用户还没注册或者密码错误！')</script>");
            }
        }

                
    }
}