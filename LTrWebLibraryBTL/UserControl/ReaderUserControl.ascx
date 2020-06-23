<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReaderUserControl.ascx.cs" Inherits="LTrWebLibraryBTL.UserControl.WebUserControl1" %>

<div class="row mx-0">
    <div class="text-primary text-center col-sm-12 position-relative">
        <h1>Quản lý người dùng</h1>
    </div>
    <ul class="col-sm-12 mt-3 nav nav-pills nav-fill" id="myTab" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" id="activae-tab" data-toggle="tab" href="#activeUserList" role="tab" aria-selected="true">Kích hoạt</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="disable-tab" data-toggle="tab" href="#disableUserList" role="tab" aria-selected="false">Hủy kích hoạt</a>
        </li>
    </ul>
    <hr class="w-100" />
    <div class="tab-content col-sm-12" id="myTabContent">
        <div class="tab-pane fade show active" id="activeUserList" role="tabpanel" aria-labelledby="home-tab">
            <div id="activateList" class="row mx-0">
            </div>
        </div>
        <div class="tab-pane fade" id="disableUserList" role="tabpanel" aria-labelledby="profile-tab">
            <div id="disableList" class="row mx-0">
            </div>
        </div>
    </div>
    <%--<nav class="col-sm-12 mt-3 nav nav-pills nav-fill">
        <a id="toggleActivate" class="nav-item nav-link active" style="cursor: pointer;">Kích hoạt</a>
        <a id="toggleDeactivate" class="nav-item nav-link" style="cursor: pointer;">Hủy kích hoạt</a>
    </nav>
    <div class="col-sm-12">
        <div id="activateList" class="row mx-0">
        </div>
    </div>
    <div class="col-sm-12">
        <div id="disableList" class="row mx-0">
        </div>
    </div>--%>
</div>
<script>
    var aList = document.getElementById("activateList");
    var dList = document.getElementById("disableList");
    getUserList();

    function getUserList() {
        $.ajax({
            type: "POST",
            url: window.location.origin + "/Services/UserServices.asmx/GetUserList",
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        }).then(res => {
            if (res.d !== null) appendResult(res.d);
            else showErrorToast("Lỗi!","Không thể lấy được danh sách người dùng")
        });
    };

    function appendResult(arr) {
        $(".userx").remove();
        for (let i = 0; i < arr.length; i++) {
            if (arr[i].UserStatus == 0) appendActivateList(arr[i]);
            else appendDisableList(arr[i]);
        };
    };

    function appendActivateList(item) {
        $("#activateList").append("<div class=\"userx col-sm-3 mt-4\"><div class=\"card text-center p-1\"><i class=\"fas fa-user-tie fa-10x\"></i>"
            + "<div class=\"card-body\"><h5 class=\"card-title\">" + getRole(item.UserRole) + "</h5><p class=\"card-text\">" + item.UserDisplayName + "</p>"
            + "<button id=\"user_" + item.UserId + "\" type=\"button\" class=\"btn btn-success\" onclick=\"kichHoat(this.id)\">Kích hoạt</button>"
            + "</div></div></div>");
    };

    function appendDisableList(item) {
        $("#disableList").append("<div class=\"userx col-sm-3 mt-4\"><div class=\"card text-center p-1\"><i class=\"fas fa-user-tie fa-10x\"></i>"
            + "<div class=\"card-body\"><h5 class=\"card-title\">" + getRole(item.UserRole) + "</h5><p class=\"card-text\">" + item.UserDisplayName + "</p>"
            + "<button  id=\"user_" + item.UserId + "\" type=\"button\" class=\"btn btn-outline-danger\" onclick=\"huyKichHoat(this.id)\">Hủy kích hoạt</button>"
            + "</div></div></div>");
    };

    function getRole(num) {
        return num == 1 ? "Quản trị viên" : "Người dùng";
    };

    function kichHoat(value) {
        let data = { "userID": parseInt(value.split("_")[1]) };
        $.ajax({
            type: "POST",
            url: window.location.origin + "/Services/UserServices.asmx/ApproveUser",
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        }).then(res => {
            getUserList();
            showSucceedToast("Thành công!", "Kích hoạt tài khoản thành công");
        });
    };

    function huyKichHoat(value) {
        let data = { "userID": parseInt(value.split("_")[1]) };
        $.ajax({
            type: "POST",
            url: window.location.origin + "/Services/UserServices.asmx/DisapproveUser",
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        }).then(res => {
            getUserList();
            showSucceedToast("Thành công!", "Hủy kích hoạt tài khoản thành công");
        });
    };
</script>
