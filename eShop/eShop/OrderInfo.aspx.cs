using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


public partial class OrderInfo : System.Web.UI.Page
{
    DataTable dt;

    public void CalcSum()
    {
        double sum = 0;

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            sum += Convert.ToDouble(dt.Rows[i]["Je"]);
        }


            lblSum.Text = "合计金额: " + string.Format("{0:N2}", sum);
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Cart"] == null)
            Response.Redirect("Products.aspx");
        else
        {
            dt = (DataTable)Session["Cart"];

            if (dt.Rows.Count == 0)
            {
                lbOK.Enabled = false;
            }
        }

        string CurrentUrl = HttpContext.Current.Request.Url.PathAndQuery;       
        
        if(Session["UserID"]==null)
        {
            Response.Redirect("Login.aspx?url=" + CurrentUrl);
        }

        if (!IsPostBack)
        {
            if (Session["UserID"] == null)
            {
                SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["eShopConnectionString"].ConnectionString);

                SqlCommand cmd = new SqlCommand("SELECT TOP 1 * FROM Orders WHERE UserID=@UserID ORDER BY OrederDate DESC", cn);

                cmd.Parameters.Add("@UserID", SqlDbType.NVarChar).Value = Session["UserID"].ToString();



                DataSet ds = new DataSet();

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                cn.Open();
                da.Fill(ds);
                cn.Close();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    txtTel.Text = ds.Tables[0].Rows[0]["Tel"].ToString();

                    txtAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();

                    txtConsignee.Text = ds.Tables[0].Rows[0]["Consignee"].ToString();
                }
            }
            

            if (Session["Cart"]!=null)
            {
                dt = (DataTable)Session["Cart"];

                GridView1.DataSource = dt;

                GridView1.DataBind();

                CalcSum();
            }

            else
            {
                lblSum.Text = "购物车中没有商品";
            }


        }
    }

    protected void lbOK_Click(object sender, EventArgs e)
    {
        string OrderID = Guid.NewGuid().ToString();

        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["eShopConnectionString"].ConnectionString);

        SqlCommand cmd = new SqlCommand("INSERT Orders(OrderID,UserID,Tel,Address,Consignee)VALUES(@OrderID,@UserID,@Tel,@Address,@Consignee)", cn);

        cmd.Parameters.Add("@OrderID", SqlDbType.NVarChar).Value = OrderID;
        cmd.Parameters.Add("@UserID", SqlDbType.NVarChar).Value = Session["UserID"].ToString();
        cmd.Parameters.Add("@Tel", SqlDbType.NVarChar).Value = txtTel.Text.Trim();
        cmd.Parameters.Add("@Address", SqlDbType.NVarChar).Value = txtAddress.Text.Trim();
        cmd.Parameters.Add("@Consignee", SqlDbType.NVarChar).Value = txtConsignee.Text.Trim();

        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        cn.Open();
        da.Fill(ds);
        cn.Close();
        cmd = new SqlCommand("INSERT OrderItems(OrderID,ProductID,Amount,Price) VALUES(@OrderID,@ProductID,@Amount,@Price)", cn);

        dt = (DataTable)Session["Cart"];

        for (int I = 0; I < dt.Rows.Count; I++)
        {
            cmd.Parameters.Clear();
            cmd.Parameters.Add("@OrderID", SqlDbType.NVarChar).Value = OrderID;
            cmd.Parameters.Add("@ProductID", SqlDbType.NVarChar).Value = dt.Rows[I]["ProductID"];
            cmd.Parameters.Add("@Amount", SqlDbType.NVarChar).Value = Convert.ToDecimal(dt.Rows[I]["Amount"]);
            cmd.Parameters.Add("@Price", SqlDbType.NVarChar).Value = Convert.ToDecimal(dt.Rows[I]["Price"]);

            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
        }

        Session["Cart"] = null;

        Response.Redirect("OrderByID.aspx?OrderID="+ OrderID);
    }
}
