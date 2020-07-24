<%@ Page Title="Tìm Kiếm" Language="C#" MasterPageFile="~/View/BTlLayout.Master" AutoEventWireup="true" CodeBehind="TimKiem.aspx.cs" Inherits="LTrWebLibraryBTL.View.common.TimKiem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BTLContent" runat="server">
    <div class="container-fluid">
        <div id="danhSachTimKiem" class="row mx-0">
        </div>
    </div>
    <script>
        layTuKhoa();
        //tytytyty
        function layTuKhoa() {
            let currentUrl = window.location.href.split("?")[1];
            let data = { "str": decodeURIComponent(currentUrl).split("=")[1] };
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/BookServices.asmx/GetBookByTitle",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(res => {
                if (res.d == null) {
                    appendSearchResult(null, false);
                    showInfoToast("Thông báo", "Không tìm được sách theo từ khóa được cung cấp");
                } else {
                    appendSearchResult(res.d, true);
                }
            });
        };

        function appendSearchResult(arr, flag) {
            if (flag) {
                for (let i = 0; i < arr.length; i++) {
                    $("#danhSachTimKiem").append("<div class=\"col-md-4 mb-3\"\style=\"margin-top: 20px\"><div class= \"card text-center p-3\"><i class=\"fas fa-book fa-6x\"></i>"
                        + "<div class=\"card-body\"><h5 class=\"card-title\">" + arr[i].Tensach + "</h5><div class=\"text-justify row mx-0\">"
                        + "<div class=\"col-md-12 mb-2\"><div class=\"row mx-0\"><div class=\"col-md-6\"> Thể Loại:"
                        + "</div><div class=\"col-md-6\">" + arr[i].Theloai + "</div></div></div><div class=\"col-md-12 mb-2\"><div class=\"row mx-0\">"
                        + "<div class=\"col-md-6\">Tác giả:</div><div class=\"col-md-6\">" + arr[i].Tacgia + "</div></div></div><div class=\"col-md-12 mb-2\">"
                        + "<div class=\"row mx-0\"><div class=\"col-md-6\">Thư Viện:</div><div class=\"col-md-6\">"
                        + arr[i].LibraryName + "</div></div></div></div>"
                        + "</div></div></div>");
                };
            } else {
                $("#danhSachTimKiem").append("<div class=\"mt-3 w-100 text-center text-danger\"><h1>Không tìm thấy kết quả</h1></div>")
            };
        };
    </script>
</asp:Content>
