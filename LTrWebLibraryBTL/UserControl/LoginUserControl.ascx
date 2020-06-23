<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoginUserControl.ascx.cs" Inherits="LTrWebLibraryBTL.UserControl.LoginUserControl" %>
<div class="row col-sm-12 mx-0">
    <div class="col-sm-12 px-0 row mx-0 mb-3">
        <div class="col-sm-5 m-auto">
            Tài khoản
        </div>
        <div class="col-sm-7 input-group">
            <input type="text" id="txtName" class="form-control" />
        </div>
    </div>
    <div class="col-sm-12 px-0 row mx-0 mb-3">
        <div class="col-sm-5 m-auto">
            Mật khẩu
        </div>
        <div class="col-sm-7 input-group">
            <input type="text" id="txtPassword" class="form-control" />
        </div>
    </div>
    <div class="col-sm-12 px-0 row mx-0 mb-3">
        <div class="col-sm-5 m-auto">
            Hệ thống thư viện
        </div>
        <div class="col-sm-7 input-group">
            <select id="libraryType" class="form-control">
                <option value="1">Thư viện Hà Nội</option>
                <option value="2">Thư viện Hồ Chí Minh</option>
            </select>
        </div>
    </div>
    <div class="col-sm-12 px-0 mx-0 mb-3 text-right">
        <button type="button" class="btn btn-primary" id="btnLogin" onclick="dangNhap()">Đăng nhập</button>
    </div>
</div>
<script>
    var username = document.getElementById("txtName");
    var password = document.getElementById("txtPassword");
    var librarytype = document.getElementById("libraryType");
    var loginbtn = document.getElementById("btnLogin");
    function dangNhap() {
        if (kiemtradangnhap()) {
            let data = { "username": username.value.trim() + "", "password": password.value.trim() + "", "library": librarytype.value };
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/LoginServices.asmx/UserLogin",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(res => {
                switch (parseInt(res.d)) {
                    case -2:
                        showErrorToast("Lỗi", "Sai mật khẩu, hãy kiểm tra lại");
                        break;
                    case -1:
                        showInfoToast("Thông báo", "Tài khoản không tồn tại");
                        break;
                    case 1:
                        showSucceedToast("Thành công", "Đăng nhập thành công");
                        break;
                }
            });
        } else {
            showErrorToast("Thất bại", "Đăng nhập thất bại");
        };
    };

    function kiemtradangnhap() {
        let result = true;
        let tendangnhap = username.value.trim();
        let matkhau = password.value.trim();
        if (tendangnhap == undefined || tendangnhap == "") {
            showErrorToast("Lỗi!", "Bạn chưa điền tên đăng nhập");
            result = false;
        } else {
            if (tendangnhap.length < 4 || tendangnhap.length > 12) {
                showErrorToast("Lỗi!", "Tên đăng nhập có chiều dài từ 4 đến 12 ký tự");
                result = false;
            } else {
                result = true;
            };
        };
        if (result) {
            if (matkhau == undefined || matkhau == "") {
                showErrorToast("Lỗi!", "Bạn chưa điền mật khẩu");
                result = false;
            } else {
                if (matkhau.length < 4 || matkhau.length > 12) {
                    showErrorToast("Lỗi!", "Mật khẩu có chiều dài từ 4 đến 12 ký tự");
                    result = false;
                } else {
                    result = true;
                };
            };
        }
        return result;
    };

    //$(document).ready(function () {
    //    $("#btnLogin").on("click", function () {
    //        if (!validateRequired()) {
    //            $('.toastError').toast('show');
    //        } else {
    //            if (validateLength()) {
    //                let data = { "username": $("#txtName").val().trim(), "password": $("#txtPassword").val() };
    //                $.ajax({
    //                    type: "POST",
    //                    url: window.location.origin + "/Services/Login.asmx/UserLogin",
    //                    data: JSON.stringify(data),
    //                    contentType: "application/json; charset=utf-8",
    //                    dataType: "json",
    //                    success: function (response) {
    //                        if (response.d == null) {
    //                            $('#exampleModal').modal('hide');
    //                            showErrorToast("Lỗi!", "Đã có lỗi xảy ra trong quá trình đăng nhập");
    //                        }
    //                        else {
    //                            createSession(data, (response.d).toString());
    //                        }
    //                    }
    //                });
    //            } else {
    //                showErrorToast("Lỗi!", "Đã có lỗi xảy ra trong quá trình đăng nhập");
    //            }
    //        }
    //    });
    //});

    //function validateLength() {
    //    let result = true;
    //    let name = $("#txtName").val().trim();
    //    let pass = $("#txtPassword").val().trim();
    //    if (name.length < 4 || name.length > 12) {
    //        $("#txtNameLength").show();
    //        result = false;
    //    } else {
    //        $("#txtNameLength").hide();
    //        result = true;
    //    }
    //    if (result) {
    //        if (pass.length < 6 || pass.length > 12) {
    //            $("#txtPasswordLength").show();
    //            result = false;
    //        } else {
    //            $("#txtPasswordLength").hide();
    //            result = true;
    //        }
    //    }
    //    return result;
    //}

    //function redirectPage(str) {
    //    if (str == "1") {
    //        window.location.replace(window.location.origin + "/View/BTL/view/admin/adminControllerView");
    //    } else if (str == "0") {
    //        window.location.replace(window.location.origin + "/View/BTL/view/client/clientControllerView");
    //    } else {
    //        showErrorToast("Lỗi!", "Đã có lỗi xảy ra trong quá trình đăng nhập");
    //    }
    //}

    //function createSession(obj, str) {
    //    $.ajax({
    //        type: "POST",
    //        url: window.location.origin + "/Services/Login.asmx/CreateSession",
    //        data: JSON.stringify(obj),
    //        contentType: "application/json; charset=utf-8",
    //        dataType: "json"
    //    }).then(redirectPage(str));
    //}
</script>
