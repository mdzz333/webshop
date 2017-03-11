<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ProductDetail.aspx.cs" Inherits="ProductDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<style type="text/css">
    .btnBuy
    {
        border-style:none;
        border-color:inherit;
        border-width:medium;
        background:url(Images/AddCart.png)no-repeat left top;
    }

</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:DataList ID="DataList1" runat="server" DataKeyField="ProductID" 
        DataSourceID="dsProducts" Width="100%" 
    onitemcommand="DataList1_ItemCommand">
        <ItemTemplate>

            <table cellpadding="6" cellspacing="6">
               <tr>
                    <td rowspan="6" width="170">
                        <asp:Image ID="Image1" runat="server" Height="160px" 
                            ImageUrl='<%# Eval("ProductImage") %>' Width="160px" />
                    </td>
                    <td valign="middle" height="23" width="100">
                        商品名称：
                    </td>
                    <td width="490">
                        <asp:Label ID="lblProductName" runat="server" 
                            Text='<%# Eval("ProductName")+"("+Eval("Color")+")" %>'></asp:Label>
                        </td>
               </tr>

                <tr>
                    <td valign="middle" height="23" class"=stylel">
                        商品编号：
                    </td>
                    <td>
                        <asp:Label ID="lblProductID" runat="server" Text='<%# Eval("ProductID") %>'></asp:Label>
                    </td>
                </tr>

                <tr>
                
                    <td valign="middle" height="23" class="stylel">
                        价格：
                    </td>
                    <td>
                        <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price","{0:C}") %>'></asp:Label>
                    </td>
                </tr>

                <tr>
                
                    <td valign="middle" height="23" class="stylel">
                        描述：    
                    </td>
                
                    <td>
                        <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                    </td>

                </tr>

                <tr>
                
                    <td valign="middle" height="23" class="stylel">
                        购买数量：    
                    </td>
                
                    <td>
                        <asp:TextBox ID="txtAmount" runat="server">1</asp:TextBox>
                    </td>

                </tr>

                <tr>
                    <td align="left" colspan="2">
                        <asp:LinkButton ID="btnBuy" runat="server" CommandName="Buy" CssClass="btnBuy" 
                            Height="30px" Width="135px"></asp:LinkButton>
                    </td>


                </tr>
            
            </table>

            <br />
            <br />

        </ItemTemplate>
    </asp:DataList>

    <asp:SqlDataSource ID="dsProducts" runat="server" 
        ConnectionString="<%$ ConnectionStrings:eShopConnectionString %>" 
        SelectCommand="SELECT * FROM [Products] WHERE ([ProductID] = @ProductID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" 
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

