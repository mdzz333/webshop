<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="OrderInfo.aspx.cs" Inherits="OrderInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<br />
<table>

    <tr>
    
        <td style="width:100px">
            联系电话
        </td>
        <td style="width:100px">
            <asp:TextBox ID="txtTel" runat="server"></asp:TextBox>
        </td>
    
    </tr>
     <tr>
    
        <td style="width:100px">
            送货地址
        </td>
        <td style="width:100px">
            <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox>
        </td>
    
    </tr>
     <tr>
    
        <td style="width:100px">
            收货人
        </td>
        <td style="width:100px">
            <asp:TextBox ID="txtConsignee" runat="server"></asp:TextBox>
        </td>
    
    </tr>


</table>
<br />
<table>

    <tr>
        <td>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="ProductName" HeaderText="商品名称" />
                    <asp:BoundField DataField="Price" DataFormatString="{0:N2}" HeaderText="价格" />
                    <asp:BoundField DataField="Je" DataFormatString="{0:N2}" HeaderText="金额" />
                    <asp:BoundField DataField="Amount" HeaderText="数量" />
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
        </td>
    </tr>
    <tr>
    <td align="right"">
        <asp:Label ID="lblSum" runat="server" ForeColor="Red" Text="Label"></asp:Label>
    </td>
    </tr>
    <tr>
    <td align="right">
        <asp:LinkButton ID="lbOK" runat="server" onclick="lbOK_Click">提交订单</asp:LinkButton>
        </td>
    </tr>
</table>



</asp:Content>

