<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Regist.aspx.cs" Inherits="Regist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<style type="text/css">
#img{
    width:100px;
    height:100px;
    
}
</style>

<script type="text/javascript">
var preview = function (el) {
            var pv = document.getElementById("img");
            // IE5.5~9使用滤镜
            if (pv.filters && typeof (pv.filters.item) === 'function') {
                pv.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = el.value;
            }
            else {
                // 其他浏览器和IE10+（不支持滤镜）则使用FileReader
                var fr = new FileReader();
                fr.onload = function (evt) {
                    var pvImg = new Image();
                    pvImg.style.width = pv.offsetWidth + 'px';
                    pvImg.style.height = pv.offsetHeight + 'px';
                    pvImg.src = evt.target.result;
                    //pv.removeChild(0);
                    pv.removeChild(pv.firstChild);
                    pv.appendChild(pvImg);
                };
                fr.readAsDataURL(el.files[0]);
            }
        };
</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<br />

<table align="center" cellspacing="3" cellpadding="3" border="1">

    <tr>
        
        <td align="center" colspan="2">
            用户注册： 
        </td>
    
    </tr>
    <tr>
    
        <td align="right" width="100">            
            用户：       
        </td>
        <td width="500">
            <asp:TextBox ID="txtUserID" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="txtUserID" Display="Dynamic" ErrorMessage="用户不能为空 "></asp:RequiredFieldValidator>
        </td>
    
    </tr>
    <tr>
    
        <td align="right">
            姓名：
        </td>
        <td>
            <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
        </td>

    </tr>
    <tr>
    
        <td align="right">
            性别：
        </td>
        <td align="left">
            <asp:RadioButtonList ID="rblSex" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Selected="True">男</asp:ListItem>
                <asp:ListItem>女</asp:ListItem>
            </asp:RadioButtonList>
        </td>
    </tr>
    <tr>
    
        <td align="right">
            密 码：
        </td>
        <td>
            <asp:TextBox ID="txtPwd" runat="server" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="txtPwd" Display="Dynamic" ErrorMessage="请输入密码"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
    
        <td align="right">
            确认密码：
        </td>
    
        <td>
            <asp:TextBox ID="txtPwd2" runat="server" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                ControlToValidate="txtPwd2" Display="Dynamic" ErrorMessage="请输入确认密码"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" 
                ControlToCompare="txtPwd" ControlToValidate="txtPwd2" Display="Dynamic" 
                ErrorMessage="两次输入密码不一样"></asp:CompareValidator>
        </td>
    </tr>
    <tr>
    
        <td align="right">
            EMail:
        </td>
        <td>
            <asp:TextBox ID="txtEMail" runat="server"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                ControlToValidate="txtEMail" Display="Dynamic" ErrorMessage="请输入有效地邮箱地址" 
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
        </td>
    
    </tr>
    <tr>
    
        <td align="right">
            电话： 
        </td>
        <td>
            <asp:TextBox ID="txtTel" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
    
        <td align="right">
            上传头像：
        </td>
        <td>
            <asp:FileUpload ID="fuUser" runat="server" onchange="preview(this,'img');"/>
            <asp:Label ID="lblUpFile" runat="server" Text="Label"></asp:Label>
            <br />
            <br />

            <div id="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoder(src=<%=pic%>,sizingMehod=scale);
                width=150px;height=200px;" >
                </div>
        </td>
    </tr>

    <tr>
    
        <td align="center" colspan="2">
            <asp:Button ID="btnReg" runat="server" Text="注册" Width="100px" 
                onclick="btnReg_Click" />
        </td>
    
    </tr>
</table>

</asp:Content>

