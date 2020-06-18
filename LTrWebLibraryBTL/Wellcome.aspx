<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Wellcome.aspx.cs" Inherits="LTrWebLibraryBTL.Wellcome" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Bài tập lớn nhóm: x</title>

    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/modernizr") %>
    </asp:PlaceHolder>

    <webopt:BundleReference runat="server" Path="~/Content/css" />
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />

</head>
<body>
    <form runat="server">
        <asp:ScriptManager runat="server">
            <Scripts>
                <%--To learn more about bundling scripts in ScriptManager see https://go.microsoft.com/fwlink/?LinkID=301884 --%>
                <%--Framework Scripts--%>
                <asp:ScriptReference Name="MsAjaxBundle" />
                <asp:ScriptReference Name="jquery" />
                <asp:ScriptReference Name="bootstrap" />
                <asp:ScriptReference Name="WebForms.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebForms.js" />
                <asp:ScriptReference Name="WebUIValidation.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebUIValidation.js" />
                <asp:ScriptReference Name="MenuStandards.js" Assembly="System.Web" Path="~/Scripts/WebForms/MenuStandards.js" />
                <asp:ScriptReference Name="GridView.js" Assembly="System.Web" Path="~/Scripts/WebForms/GridView.js" />
                <asp:ScriptReference Name="DetailsView.js" Assembly="System.Web" Path="~/Scripts/WebForms/DetailsView.js" />
                <asp:ScriptReference Name="TreeView.js" Assembly="System.Web" Path="~/Scripts/WebForms/TreeView.js" />
                <asp:ScriptReference Name="WebParts.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebParts.js" />
                <asp:ScriptReference Name="Focus.js" Assembly="System.Web" Path="~/Scripts/WebForms/Focus.js" />
                <asp:ScriptReference Name="WebFormsBundle" />
                <%--Site Scripts--%>
            </Scripts>
        </asp:ScriptManager>
    </form>
    <div class="container-fluid body-content">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-header text-center">
                    <h1 class="text-primary">Xin chào</h1>
                </div>
                <div class="card-body row m-0">
                    <h4 class="col-sm-12 card-title">Bài tập lớn nhóm: ... </h4>
                    <div class="col-sm-10 offset-sm-2">
                        <h5>Thành viên:</h5>
                        <div class="pl-5">- Đinh Tuất Thành - Lớp: ...</div>
                        <div class="pl-5">- Phạm Đức Tèo - Lớp: ...</div>
                        <div>
                            <h5>Đề tài:</h5>
                            Xây dựng Website quản lý thư viện phân tán trực tiếp
                        </div>
                    </div>
                    <div class="col-sm-12 text-right">
                        <a href="/View/common/TrangChu.aspx" class="btn btn-success">Đến Bài tập lớn</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
