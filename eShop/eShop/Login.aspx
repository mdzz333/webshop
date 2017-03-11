<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<br />

<table align="center">

    <tr>
    
        <td rowspan="7" style="width:100px">
        
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/L001.jpg" />

        </td>
        <td style="width:100px" height="60">
        
        用户号：
        
        </td>
        <td>
            <asp:TextBox ID="txtUserID" runat="server"></asp:TextBox>
        </td>
    
    </tr>
    <tr>
    
        <td width="" height="">
            密 码： 
        </td>
        <td width="160" height="60">
            <asp:TextBox ID="txtPwd" runat="server" TextMode="Password"></asp:TextBox>
        </td>
    </tr>
    <tr>
    
        <td style="width:100px" height="60">
            <asp:LinkButton ID="lbChangeCode" runat="server">换一张</asp:LinkButton>
        </td>
        <td width="160">
            <asp:Image ID="Image2" runat="server" ImageUrl="ValidateCode.aspx" />
        </td>
    </tr>
    <tr>
    
        <td style="width:100px" height="60">
            验证码：
        </td>
        <td width="160">
            <asp:TextBox ID="txtCode" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
    
        <td style="width:100px" height="60">
            <asp:LinkButton ID="lbLogin" runat="server" onclick="lbLogin_Click">登录</asp:LinkButton>
        </td>
        <td width="160">
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Regist.aspx">注册</asp:HyperLink>
        </td>
    </tr>
    <tr>
    
        <td colspan="2">
            <asp:CheckBox ID="cbMemory" runat="server" Checked="True" Text="30天内记住我" />
        </td>
    
    </tr>
</table>

</asp:Content>

