<%@ Page Title="Thông tin cá nhân" Language="C#" MasterPageFile="~/View/BTlLayout.Master" AutoEventWireup="true" CodeBehind="UserSignup.aspx.cs" Inherits="LTrWebLibraryBTL.View.client.UserInfoPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BTLContent" runat="server">
    <div class="container">
        <div class="py-5 text-center" style="padding-bottom: 0 !important;">
            <h2>Thông tin đăng ký</h2>
            <p class="lead">Việc mượn sách sẽ rất đơn giản và minh bạch khi có thông tin của độc giả. Bạn còn chần chừ gì nữa? Nhanh chóng đăng ký tài khoản ngay nào!</p>
        </div>
        <hr class="mb-4">
        <div class="row">
            <div class="col-md-12 order-md-1">
                <form class="needs-validation" novalidate="">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="firstName">Tên</label>
                            <input type="text" class="form-control" id="firstName" placeholder="Shiba" value="" required="">
                            <div id="invalid-firstName" style="color: red;">
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="lastName">Họ</label>
                            <input type="text" class="form-control" id="lastName" placeholder="Inu" value="" required="">
                            <div id="invalid-lastName" style="color: red;"> 
                            </div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label for="username">Tên đăng nhập</label>
                                <input type="text" class="form-control" id="username" placeholder="Username" required="">
                                <div id="invalid-username" style="color: red;">
                                </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="password">Mật khẩu</label>
                            <input type="password" class="form-control" id="password" placeholder="Nhập mật khẩu">
                            <input type="password" class="form-control" id="confirmpw" placeholder="Xác nhận lại mật khẩu" style="margin-top: 10px">
                            <div id="invalid-password" style="color: red;">
                            </div>
                        </div>
                        <div class="col-md-6  mb-3">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" id="email" placeholder="you@example.com">
                            <div id="invalid-email" style="color: red;">
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label>Địa chỉ</label>
                            <input type="text" class="form-control" id="address" placeholder="96 Định Công">
                            <div id="invalid-address" style="color: red;">
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label>Địa chỉ thư viện</label>
                            <select class="form-control" id="libID">
                                <option selected value="1">Thư viện Hà Nội</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="text-center" style="margin: auto; width: 80%;">
                            <button class="btn btn-primary" type="button" style="width: 10% !important;" id="btnSignup" onclick="kiemTra()">Đăng ký</button>
                            <button type="reset" class="btn btn-secondary" style="width: 10% !important; margin-left: 20px;">Hủy</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script>
        function kiemTra() {
            // kiểm tra các thứ nếu đúng hết thì gọi đăng ký
            let firstname = document.getElementById("firstName").value.trim();
            let lastname = document.getElementById("lastName").value.trim();
            let account = document.getElementById("username").value.trim();
            let pass = document.getElementById("password").value.trim();
            let confirmpw = document.getElementById("confirmpw").value.trim();
            let email = document.getElementById("email").value.trim();
            let address = document.getElementById("address").value.trim();

            if (firstname == "") {
                document.getElementById("invalid-firstName").innerHTML = "Vui lòng nhập tên.";
                document.getElementById("firstName").focus();
            } else if (lastname == "") {
                document.getElementById("invalid-lastName").innerHTML = "Vui lòng nhập họ.";
                document.getElementById("lastName").focus();
            }
            else if (account == "") {
                document.getElementById("invalid-username").innerHTML = "Vui lòng nhập tên đăng nhập.";
                document.getElementById("username").focus();
            } else if (pass == "") {
                document.getElementById("invalid-password").innerHTML = "Vui lòng nhập mật khẩu.";
                document.getElementById("password").focus();
            } else if (confirmpw == "") {
                document.getElementById("invalid-password").innerHTML = "Vui lòng nhập mật khẩu để xác nhận.";
                document.getElementById("confirmpw").focus();
            } else if (email == "") {
                document.getElementById("invalid-email").innerHTML = "Vui lòng nhập email.";
                document.getElementById("email").focus();
            } else if (address == "") {
                document.getElementById("invalid-address").innerHTML = "Vui lòng nhập địa chỉ.";
                document.getElementById("address").focus();
            } else

                dangKyNguoiDungMoi();
        };

        function xoaInput() {
            document.getElementById("firstName").value = "";
            document.getElementById("lastName").value = "";
            document.getElementById("username").value = "";
            document.getElementById("password").value = "";
            document.getElementById("confirmpw").value = "";
            document.getElementById("email").value = "";
            document.getElementById("address").value = "";
            document.getElementById("libID").value = 1;
        };

        function dangKyNguoiDungMoi() {
            let firstname = document.getElementById("firstName").value.trim();
            let lastname = document.getElementById("lastName").value.trim();
            let account = document.getElementById("username").value.trim();
            let pass = document.getElementById("password").value.trim();
            let email = document.getElementById("email").value.trim();
            let address = document.getElementById("address").value.trim();
            let libid = document.getElementById("libID").value;
            let data = {
                account: account + "", password: pass + "", name: firstname + " " + lastname,
                email: email + "", address: address + "", libId: parseInt(libid)
            };
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/UserServices.asmx/SignUpUser",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(res => {
                if (res.d == -1) {
                    showInfoToast("Thông báo", "Tài khoản đã tồn tại");
                } else {
                    showSucceedToast("Thành công", "Tạo tài khoản thành công");
                    xoaInput();
                }
            });
        }

    </script>
</asp:Content>
