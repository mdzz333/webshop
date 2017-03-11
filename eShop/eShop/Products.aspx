 <%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Products.aspx.cs" Inherits="Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript"">
        function closeDiv() {

            document.getElementById('floater').style.visibility = 'hidden';
            document.getElementById('floater1').style.visibility = 'hidden';
        }

        self.onError = null;

        currentX = currentY = 0;

        whichIt = null;

        lastScrollX = 0;
        lastScrollY = 0;

        NS = (document.layers) ? 1 : 0;

        IE = (document.all) ? 1 : 0;

        function heartBeat(objectid) {

            if (IE) {
                diffY = document.documentElement.scrollTop;
                diffX = document.documentElement.scrollLeft;
            }

            if (NS) { diffY = self.pageYOffset; diffX = self.pageXOffset; }

            if (diffY != lastScrollY) {

                percent = .1 * (diffY - lastScrollY);

                if (percent > 0) percent = Math.ceil(percent);

                else percent = Math.floor(percent);

                if (IE) {

                    objectid = objectid.split(";");

                    for (i = 0; i < objectid.length; i++) eval("document.all." + objectid[i]).style.pixelTop += percent;
                }

                if (NS) {
                    objectid = objectid.split(";");
                    for (i = 0; i < objectid.length; i++) eval("document.all." + objectid[i]).style.top += percent;
                }

                lastScrollY = lastScrollY + percent;
            }

            if (diffX != lastScrollX) {
                percent = .1 * (diffX - lastScrollX);

                if (percent > 0) percent = Math.ceil(percent);

                else percent = Math.floor(percent);

                if (IE) {
                    objectid = objectid.split(";");

                    for (i = 0; i < objectid.length; i++) eval("document.all." + objectid[i]).style.pixelLeft += percent;
                }

                if (NS) {
                    objectid = objectid.split(";");
                    for (i = 0; i < objectid.length; i++) eval("document." + objectid[i]).left += percent;
                }

                lastScrollY = lastScrollX + percent;
            }
        }

        if (NS || IE) action = window.setInterval("heartBeat('floater;floater1')", 2);


        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="floater" style="z-index:100; left:10px; visibility:visible; width:100px;
        position:fixed; top:200px; height:100px;">

        <table>
            <tr>
                <td align="right">
                    <a href="javascript:closeDiv();" style="color:Black;">关闭</a>
                </td>
            </tr>

            <tr>
             <td>
                 <a href="http://www.samsung.com/cn;" target="_blank">
                 <asp:Image ID="Image1" runat="server" ImageUrl="Images/ad1.jpg" /></a>                        
             </td>
            </tr>

        </table>
    </div>

    <div id="floater1" style="z-index:100; right:10px; visibility:visible; width:100px;
        position:fixed; top:200px; height:100px;">
        
        <table>
            <tr>
                <td align="right">
                    <a href="javascript:closeDiv();" style="color:Black;">关闭</a>
                </td>
            </tr>
            <tr>
                <td>
                    <a href="http://store.apple.com/cn" target="_blank">
                        <asp:Image ID="Image2" runat="server" ImageUrl="Images/ad2.jpg" />
                    </a>
                </td>
            </tr>
        </table>

    </div>

    <br />
    <table width="100%">
        <tr>    
            <td valign="top">
                <asp:HyperLink ID="hlPrint" runat="server" NavigateUrl="~/PrintPage.aspx?Report=rptProducts"
                Target="_blank">打印商品清单</asp:HyperLink>
            </td>
            <td align="right" valign="top" height="20" width="100">
                <asp:Label ID="Label2" runat="server" Text="请选择品牌"></asp:Label>
            </td>
            <td>
                <asp:DataList ID="DataListSuppliers" runat="server" DataSourceID="dsSuppliers" 
                    RepeatColumns="8" RepeatDirection="Horizontal" 
                    onitemcommand="DataListSuppliers_ItemCommand" DataKeyField="SupplierID">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbSupplierName" runat="server" 
                            
                            Text='<%# Eval("SupplierName") %>' 
                            CommandArgument='<%# Eval("SupplierID") %>'></asp:LinkButton>
                        &nbsp;&nbsp; <br />
                        <br />
                    </ItemTemplate>
                </asp:DataList>
            </td>
        </tr>
        <tr>    
            <td align="right" valign="top" height="20" width="100">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    <asp:DataList ID="DataListProducts" runat="server" DataKeyField="ProductID" 
    DataSourceID="dsProducts" HorizontalAlign="Center" RepeatColumns="4" 
    RepeatDirection="Horizontal">
    <ItemTemplate>
        <table width="300">
            <tr>
                <td align="center">
                    
                    <a href='<%#Eval("ProductID","ProductDetail.aspx?ProductID={0}")%>'target="_blank">

                    <asp:Image ID="Image1" runat="server" Height="160px" 
                        ImageUrl='<%# Eval("ProductImage") %>' Width="160px" />
                    </a>

                </td>
            </tr>
            <tr>
                <td align="center" height="60" valign="top">
                    <asp:HyperLink ID="HyperLink1" runat="server" 
                        Text='<%# Eval("ProductName")+"<br/>("+Eval("Color")+")" %>' 
                        NavigateUrl='<%# Eval("ProductID","ProductDetail.aspx?ProductID={0}") %>' 
                        Target="_blank"></asp:HyperLink>
                </td>    
            </tr> 
            <tr>
                <td align="center">
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Price", "{0:C}") %>'></asp:Label>
                    <br />
                    <br />
                    <br />
                </td>
            </tr>
        </table>
    </ItemTemplate>
</asp:DataList>
<asp:SqlDataSource ID="dsProducts" runat="server" 
    ConnectionString="<%$ ConnectionStrings:eShopConnectionString %>" 
    
        
        SelectCommand="SELECT * FROM [Products] WHERE ([SupplierID] LIKE '%' + @SupplierID + '%')" 
        >
    <SelectParameters>
        <asp:Parameter Name="SupplierID" Type="String"  ConvertEmptyStringToNull="false" />
    </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsSuppliers" runat="server" 
        ConnectionString="<%$ ConnectionStrings:eShopConnectionString %>" SelectCommand="SELECT SupplierID,SupplierName FROM Suppliers
UNION
SELECT '', '全部'
ORDER BY SupplierID"></asp:SqlDataSource>
</asp:Content>

