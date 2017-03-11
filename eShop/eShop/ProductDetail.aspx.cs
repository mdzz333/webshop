using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class ProductDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    private DataRow getProductByID(string ProductID)
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["eShopConnectionString"].ConnectionString);

        SqlCommand cmd = new SqlCommand("SELECT * FROM Products WHERE ProductID=@ProductID", cn);

        cmd.Parameters.Add("@ProductID", SqlDbType.NVarChar).Value = ProductID;

        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        cn.Open();

        da.Fill(ds);

        cn.Close();


        if (ds.Tables[0].Rows.Count > 0)
            return ds.Tables[0].Rows[0];
        else
            return null;

    }
    protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "Buy")
        {
            DataRow dr = getProductByID(Request.QueryString["ProductID"]);

            string ProductID = dr["ProductID"].ToString();

            string ProductName = dr["ProductName"].ToString();

            string Color = dr["Color"].ToString();

            double Price = Convert.ToDouble(dr["Price"].ToString());

            int Amount = Convert.ToInt32(((TextBox)(e.Item.FindControl("txtAmount"))).Text);

            DataTable dt;


            if (Session["Cart"] != null)
            {
                dt = (DataTable)Session["Cart"];
            }
            else
            {
                dt = new DataTable();

                DataColumn dc;

                dc = new DataColumn("ProductID", typeof(String));
                dt.Columns.Add(dc);

                dc = new DataColumn("ProductName", typeof(String));
                dt.Columns.Add(dc);

                dc = new DataColumn("Price", typeof(double));
                dt.Columns.Add(dc);

                dc = new DataColumn("Amount", typeof(double));
                dt.Columns.Add(dc);

                dc = new DataColumn("Je", typeof(double));

                dt.Columns.Add(dc);
            }

            bool IsExist = false;


            for (int I = 0; I < dt.Rows.Count; I++)
            {
                if (dt.Rows[I]["ProductID"].ToString() == ProductID)
                {
                    IsExist = true;

                    dt.Rows[I]["Amount"] = Convert.ToInt32(dt.Rows[I]["Amount"].ToString()) + Amount;

                    dt.Rows[I]["Je"] = Convert.ToInt32(dt.Rows[I]["Amount"].ToString()) * Convert.ToInt32(dt.Rows[I]["Price"].ToString());

                    break;
                }
            }

            if (!IsExist)
            {
                DataRow drNew = dt.NewRow();

                drNew["ProductID"] = ProductID;
                drNew["ProductName"] = ProductName + "(" + Color + ")";
                drNew["Price"] = Price;
                drNew["Amount"] = Amount;
                drNew["Je"] = Price * Amount;

                dt.Rows.Add(drNew);
            }

            Session["Cart"] = dt;

            Response.Redirect("AddCartSuccess.aspx");
        }

    }
}