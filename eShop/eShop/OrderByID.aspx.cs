using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class OrderByID : System.Web.UI.Page
{
    DataSet dseShop;

    private void Bind()
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["eShopConnectionString"].ConnectionString);

        string sql;

        sql = "SELECT Orders.*";

        sql += ",Je=(SELECT sum(Amount*Price) FROM OrderItems WHERE OrderID=@OrderID)";

        sql += " FROM Orders WHERE OrderID=@OrderID AND UserID=@UserID";

        SqlCommand cmd = new SqlCommand(sql, cn);

        cmd.Parameters.Add("@OrderID", SqlDbType.NVarChar).Value = Request.QueryString["OrderID"];
        cmd.Parameters.Add("@UserID", SqlDbType.NVarChar).Value = Session["UserID"];

        dseShop = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        cn.Open();
        da.Fill(dseShop,"Orders");
        cn.Close();

        DataList1.DataSource = dseShop.Tables["Orders"];

        DataList1.DataBind();

        sql = "SELECT OI.*,ProductName=ProductName+'('+Color+')',ProductImage,Je=Amount*OI.Price";

        sql += " FROM OrderItems OI,Products M";

        sql += " WHERE OI.ProductID=M.ProductID AND OrderID=@OrderID";

        cmd = new SqlCommand(sql, cn);

        cmd.Parameters.Add("@OrderID", SqlDbType.NVarChar).Value = Request.QueryString["OrderID"];

        da = new SqlDataAdapter(cmd);

        cn.Open();
        da.Fill(dseShop, "OrderItems");
        cn.Close();

        gvOrderItems.DataSource = dseShop.Tables["OrderItems"];

        gvOrderItems.DataBind();

        Session["dseShop"] = dseShop;
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["OrderID"]==null||Session["UserID"]==null)
        {
            Response.Redirect("Products.aspx");
        }
        else if (!IsPostBack)
            Bind();


    }
}