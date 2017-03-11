<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="OrderByID.aspx.cs" Inherits="OrderByID" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 900px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <br />

    <asp:HyperLink ID="hlPrint" runat="server"
     NavigateUrl="~/PrintPage.aspx?Report=rptOrder" Target="_blank">打印订单</asp:HyperLink>

     <br />
    <asp:DataList ID="DataList1" runat="server">
        <ItemTemplate>
            <table class="style1">
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="日期"></asp:Label>
                        <asp:Label ID="OrderDateLabel" runat="server" 
                            Text='<%# Convert.ToDateTime(Eval("OrderDate")).ToString("yyyy-MM-dd") %>'></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="订单号码"></asp:Label>
                        <asp:Label ID="OrderIDLabel" runat="server" Text='<%# Eval("OrderID") %>'></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="送货地址"></asp:Label>
                        <asp:Label ID="AddressLabel" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" Text="联系人"></asp:Label>
                        <asp:Label ID="ConsigneeLabel" runat="server" Text='<%# Eval("Consignee") %>'></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="Label5" runat="server" Text="电话号码"></asp:Label>
                        <asp:Label ID="TelLabel" runat="server" Text='<%# Eval("Tel") %>'></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="本单总金额"></asp:Label>
                        <asp:Label ID="JeLabel" runat="server" Text='<%# Eval("Je") %>'></asp:Label>
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    <asp:GridView ID="gvOrderItems" runat="server" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="ProductName" HeaderText="商品名称" />
            <asp:ImageField DataImageUrlField="ProductImage" HeaderText="图片">
            </asp:ImageField>
            <asp:BoundField DataField="Amount" HeaderText="数量" />
            <asp:BoundField DataField="Price" HeaderText="价格" />
            <asp:BoundField DataField="Je" HeaderText="金额" />
        </Columns>
    </asp:GridView>
</asp:Content>

