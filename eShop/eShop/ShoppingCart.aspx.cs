using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class ShoppingCart : System.Web.UI.Page
{
    DataTable dt;

    public void CalcSum()
    {
        double sum = 0;

        for (int I = 0; I < GridView1.Rows.Count; I++)
        {
            TextBox t = (TextBox)GridView1.Rows[I].Cells[2].FindControl("txtAmount");

            if (t.Text == "")
                dt.Rows[I]["Amount"] = 0;
            else
                dt.Rows[I]["Amount"] = t.Text;

            dt.Rows[I]["Je"] = Convert.ToDouble(dt.Rows[I]["Amount"]) * Convert.ToDouble(dt.Rows[I]["Price"]);

            GridView1.Rows[I].Cells[3].Text = string.Format("{0:N2}", dt.Rows[I]["Je"]);

            sum += Convert.ToDouble(dt.Rows[I]["Je"]);
        }

        lblSum.Text = "合计金额: " + string.Format("{0:N2}", sum);
    }


    protected void btnTemp_Click(object sender, EventArgs e)
    {
        CalcSum();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Cart"] == null)
            Response.Redirect("Products.aspx");
        else
            dt = (DataTable)Session["Cart"];       

        if (!IsPostBack)
        {
            GridView1.DataSource = dt;

            GridView1.DataBind();

            CalcSum();
        }


    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if(e.CommandName=="del")
        {
            int rowIndex=Int32.Parse((String)e.CommandArgument);

            dt.Rows.RemoveAt(rowIndex);

            GridView1.DataSource=dt;

            GridView1.DataBind();

            CalcSum();
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if(e.Row.RowType==DataControlRowType.DataRow)
        {
            ((LinkButton)e.Row.Cells[4].Controls[0]).Attributes.Add("onclick","javascipt:return confirm('确认要删除吗?')");
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        dt.Clear();

        GridView1.DataSource = dt;

        GridView1.DataBind();

        CalcSum();
    }
}