<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ShoppingCart.aspx.cs" Inherits="ShoppingCart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<script type="text/javascript">
    function txtAmountkeyup() {
        document.getElementById("ctl00_ContentPlaceHolder1_btnTemp").click();
        }    
</script>

<style type="text/css">
    .hide
    {
        display:none;
    }
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <table>
        <tr>
            <td colspan="2">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" 
                    CellPadding="3" CellSpacing="2" onrowcommand="GridView1_RowCommand" 
                    onrowdatabound="GridView1_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="ProductName" HeaderText="商品名称" />
                        <asp:BoundField DataField="Price" DataFormatString="{0:N2}" HeaderText="价格" />
                        <asp:TemplateField HeaderText="数量">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Amount") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtAmount" runat="server" Text='<%# Bind("Amount") %>' onkeyup="txtAmountkeyup()"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Je" DataFormatString="{0:N2}" HeaderText="金额" />
                        <asp:ButtonField CommandName="del" HeaderText="删除" Text="删除" />
                    </Columns>
                    <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                    <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                    <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                    <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#FFF1D4" />
                    <SortedAscendingHeaderStyle BackColor="#B95C30" />
                    <SortedDescendingCellStyle BackColor="#F1E5CE" />
                    <SortedDescendingHeaderStyle BackColor="#93451F" />
                </asp:GridView>
            </td>
        </tr>

        <tr>
            <td>
                <asp:Button ID="btnClear" runat="server" onclick="btnClear_Click" 
                    Text="清空购物车" OnClientClick="javascript:return confirm('确认要删除吗?')" />
            </td>
            <td align="right">
                <asp:Button ID="btnTemp" runat="server" Text="Button" OnClick="btnTemp_Click" CssClass="hide" />
                <asp:Label ID="lblSum" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
        
            <td align="right" colspan="2">
                <asp:HyperLink ID="hlOrderInfo" runat="server" NavigateUrl="~/OrderInfo.aspx">去 结 算</asp:HyperLink>
            </td>
        
        </tr>

    </table>
   

</asp:Content>

