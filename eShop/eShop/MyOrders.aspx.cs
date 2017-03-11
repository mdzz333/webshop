using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MyOrders : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string CurrentUrl = HttpContext.Current.Request.Url.PathAndQuery;

        if (Session["UserID"] == null)
            Response.Redirect("Login.aspx?url=" + CurrentUrl);

        if (!IsPostBack)
        {
            Date1.Text = DateTime.Today.AddDays(-100).ToString("yyyy-MM-dd");

            Date2.Text = DateTime.Today.ToString("yyyy-MM-dd");

        }
    }
    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        string OrderID = DataList1.DataKeys[e.Item.ItemIndex].ToString();

        SqlDataSource dsOrderIems = (SqlDataSource)e.Item.FindControl("dsOrderIems");

        dsOrderIems.SelectParameters["OrderID"].DefaultValue = OrderID;
    }

    protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
    {

    }
}