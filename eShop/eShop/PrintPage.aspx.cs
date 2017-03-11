using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class PrintPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["Report"] == "rptProducts")
            {
                DataTable Products = (DataTable)Session["Products"];

                ReportViewer1.LocalReport.ReportPath = MapPath("rptProducts.rdlc");

                ReportViewer1.LocalReport.DataSources.Clear();

                ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("Products", Products));

                ReportViewer1.LocalReport.Refresh();
            }

            if (Request.QueryString["Report"] == "rptOrder")
            {
                DataSet dseShop = (DataSet)Session["dseShop"];

                ReportViewer1.LocalReport.ReportPath = MapPath("rptOrder.rdlc");

                ReportViewer1.LocalReport.DataSources.Clear();

                ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("Orders", dseShop.Tables["Orders"]));

                ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("OrderItems", dseShop.Tables["OrderItems"]));

                ReportViewer1.LocalReport.Refresh();
            }
        }



    }
}