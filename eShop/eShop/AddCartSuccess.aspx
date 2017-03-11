<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AddCartSuccess.aspx.cs" Inherits="AddCartSuccess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <style type="text/css">
    
        .btnContinueBuy
        {
            border-style:none;
            border-color:inherit;
            border-width:medium;
            background:url(Images/继续购物.png)no-repeat left top;
        }
        
        .btnGoCart
        {
            border-style:none;
            border-color:inherit;
            border-width:medium;
            background:url(Images/去购物车并结算.png)no-repeat left top;
        }
    
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<br />
<div style="background-image:url('Images/商品已成功加入购物车背景.png')">
    <table align="center" cellpadding="0" cellspacing="0" style="width:562px">
        <tr>
            <td colspan="2" style="background-image:url('Images/商品已成功加入购物车.png');background-repeat:no-repeat;"height="80"> </td>
        </tr>

        <tr>
            <td align="center" height="6">
                <asp:LinkButton ID="lbContinue" runat="server" CssClass="btnContinueBuy" 
                    Height="40px" Width="124px" onclick="lbContinue_Click"></asp:LinkButton>
            </td>
            <td align="center">
                <asp:LinkButton ID="lbgoShoppingCart" runat="server" CssClass="btnGoCart" 
                    Height="40px" Width="162px" onclick="lbgoShoppingCart_Click"></asp:LinkButton>
            </td>
        </tr>

    </table>
</div>

</asp:Content>

