using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

public partial class Products : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ShowAllSuppliers();

            setSessionProducts();
        }
    }

    //报表
    private void setSessionProducts()
    {
        DataTable Products = ((DataView)dsProducts.Select(DataSourceSelectArguments.Empty)).ToTable();

        Products.Columns.Add("picture", Type.GetType("System.Byte[]"));

        for (int I = 0; I < Products.Rows.Count; I++)
        {
            string picPath = Server.MapPath(".") + @"\" + Products.Rows[I]["ProductImage"].ToString();

            if (File.Exists(picPath))
            {
                FileStream fs = new FileStream(picPath, FileMode.Open, FileAccess.Read);

                BinaryReader br = new BinaryReader(fs);

                byte[] bt = br.ReadBytes((int)fs.Length);

                Products.Rows[I]["picture"] = bt;
                fs.Close();
            }
        }

        Session["Products"] = Products;
    }


    private void ShowAllSuppliers()
    {
        for (int i = 0; i < DataListSuppliers.Items.Count; i++)
        {
            LinkButton x = (LinkButton)DataListSuppliers.Items[i].FindControl("lbSupplierName");

            x.BackColor = System.Drawing.Color.White;
        }

        LinkButton all = (LinkButton)DataListSuppliers.Items[0].FindControl("lbSupplierName");

        all.BackColor = System.Drawing.Color.Aqua;

        dsProducts.SelectParameters["SupplierID"].DefaultValue = "";

    }

    protected void DataListSuppliers_ItemCommand(object source, DataListCommandEventArgs e)
    {
        for (int i = 0; i < DataListSuppliers.Items.Count; i++)
        {
            LinkButton x = (LinkButton)DataListSuppliers.Items[i].FindControl("lbSupplierName");

            x.BackColor = System.Drawing.Color.White;
        }

        LinkButton l =(LinkButton)e.Item.FindControl("lbSupplierName");

        l.BackColor = System.Drawing.Color.Aqua;

        dsProducts.SelectParameters["SupplierID"].DefaultValue = l.CommandArgument;

        DataListProducts.DataBind();
    }
}