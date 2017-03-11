using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Regist : System.Web.UI.Page
{
    public string pic = "";

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnReg_Click(object sender, EventArgs e)
    {
        if (this.IsValid)
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["eShopConnectionString"].ConnectionString);

            SqlCommand cmd = new SqlCommand("INSERT Users(UserID,UserName,Sex,Pwd,Email,Tel,UserImage)VALUES(@UserID,@UserName,@Sex,@Pwd,@Email,@Tel,@UserImage)", cn);

            cmd.Parameters.Add("@UserID", SqlDbType.NVarChar).Value = txtUserID.Text;

            cmd.Parameters.Add("@UserName", SqlDbType.NVarChar).Value = txtUserName.Text;

            cmd.Parameters.Add("@Sex", SqlDbType.NVarChar).Value = rblSex.SelectedValue;

            cmd.Parameters.Add("@Pwd", SqlDbType.NVarChar).Value = txtPwd.Text;

            cmd.Parameters.Add("@Email", SqlDbType.NVarChar).Value = txtEMail.Text;

            cmd.Parameters.Add("@Tel", SqlDbType.NVarChar).Value = txtTel.Text;


            if (fuUser.HasFile)
            {
                if (fuUser.PostedFile.ContentLength < 8192)
                {
                    lblUpFile.Text = "请上传小于8MB的文件";

                    cmd.Parameters.Add("@UserImage", SqlDbType.NVarChar).Value = "";
                }
                else
                {
                    string newFileName = "UserImage/" + txtUserID.Text + " " + DateTime.Now.ToString("yyyyMMddHHmmss") + System.IO.Path.GetFileName(fuUser.FileName);

                    fuUser.PostedFile.SaveAs(Server.MapPath(newFileName));

                    lblUpFile.Text = "文件上传成功";

                    cmd.Parameters.Add("@UserImage", SqlDbType.NVarChar).Value = "newFileName";

                }
            }

            else
                cmd.Parameters.Add("@UserImage", SqlDbType.NVarChar).Value = "";

            try
            {
                cn.Open();

                cmd.ExecuteNonQuery();

                ClientScript.RegisterStartupScript(this.GetType(), "Key", "<script>alert('注册成功!');</script>");
            }
            catch
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Key", "<script>alert('注册失败!');</script>");

            }
            finally
            {
                cn.Close();
            }
        }
    }
}