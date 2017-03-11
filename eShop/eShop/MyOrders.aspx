<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MyOrders.aspx.cs" Inherits="MyOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="My97DatePicker/WdatePicker.js" type="text/javascript"></script>
   
    <style type="text/css">
        
        .style1
        {
            width: 800px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Text="请选择开始日期:(默认最近100天)"></asp:Label>
                <asp:TextBox ID="Date1" runat="server"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
            <td>
                <asp:Label ID="Label2" runat="server" Text="请选择结束日期"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="Date2" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Button ID="Button1" runat="server" Text="查询" />
            </td>
        </tr>
    </table>
    <asp:DataList ID="DataList1" runat="server" DataKeyField="OrderID" 
        DataSourceID="dsOrders" onitemdatabound="DataList1_ItemDataBound" 
        onitemcommand="DataList1_ItemCommand">

    <ItemTemplate>
        <table>
            <tr>
                <td>
                    日期：<asp:Label ID="OrderDateLabel" runat="server" 
                        Text='<%# Convert.ToDateTime(Eval("OrderDate")).ToString("yyyy-MM-dd") %>'></asp:Label>
&nbsp;</td>
                <td>
                    订单号码：<asp:HyperLink ID="HyperLink1" runat="server" 
                        NavigateUrl='<%# Eval("OrderID","OrderByID.aspx?OrderID={0}") %>' 
                        Target="_blank" Text='<%# Eval("OrderID") %>'></asp:HyperLink>
&nbsp;</td>
                <td align="right">
                    送货地址：<asp:Label ID="AddressLabel" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
&nbsp;</td>

            </tr>
            <tr>
                <td>
                    联系人：
                 
                    <asp:Label ID="ConsigneeLabel" runat="server" Text='<%# Eval("Consignee") %>'></asp:Label>
                </td>
                <td>
                    电话号码： 
                 
                    <asp:Label ID="TelLabel" runat="server" Text='<%# Eval("Tel") %>'></asp:Label>
                </td>
                <td align="right">
                    本单总金额：<asp:Label ID="SumJeLabel" runat="server" Text='<%# Eval("SumJe") %>'></asp:Label>
&nbsp;</td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:GridView ID="Items" runat="server" AutoGenerateColumns="False" 
                        BorderColor="#333333" BorderWidth="1px" DataKeyNames="OrderItemID" 
                        DataSourceID="dsOrderIems" Width="920px">
                        <Columns>
                            <asp:BoundField DataField="ProductName" HeaderText="商品名称" 
                                SortExpression="ProductName" />
                            <asp:ImageField DataImageUrlField="ProductImage" HeaderText="图片">
                                <ControlStyle Height="60px" Width="60px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:ImageField>
                            <asp:BoundField DataField="Amount" HeaderText="数量" SortExpression="Amount" />
                            <asp:BoundField DataField="Price" HeaderText="价格" SortExpression="Price" />
                            <asp:BoundField DataField="Je" HeaderText="金额" SortExpression="Je" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="dsOrderIems" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:eShopConnectionString %>" SelectCommand="SELECT OrderItems.OrderItemID,OrderItems.OrderID,OrderItems.ProductID,
OrderItems.Amount,OrderItems.Price,Je=(Amount*OrderItems.Price),
Products.ProductName+'('+Products.Color+')'AS ProductName,ProductImage FROM OrderItems
INNER JOIN Products ON OrderItems.ProductID = Products.ProductID
WHERE OrderID=@OrderID">
                        <SelectParameters>
                            <asp:Parameter Name="OrderID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
        <br />
        <br />
    </ItemTemplate>

    </asp:DataList>
    <asp:SqlDataSource ID="dsOrders" runat="server" 
        ConnectionString="<%$ ConnectionStrings:eShopConnectionString %>" SelectCommand="SELECT *,SumJe=
(SELECT SUM(Price*Amount)FROM OrderItems WHERE OrderID=Orders.OrderID)
FROM Orders
WHERE convert(varchar(10),OrderDate,120)&gt;=@Date1
AND convert(varchar(10),OrderDate,120)&lt;=@Date2
ORDER BY [OrderDate]DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="Date1" Name="Date1" PropertyName="Text" />
            <asp:ControlParameter ControlID="Date2" Name="Date2" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

