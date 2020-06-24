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
                            <div class="invalid-feedback">
                                Valid first name is required.
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="lastName">Họ</label>
                            <input type="text" class="form-control" id="lastName" placeholder="Inu" value="" required="">
                            <div class="invalid-feedback">
                                Valid last name is required.
                            </div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label for="username">Tên đăng nhập</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="username" placeholder="Username" required="">
                                <div class="invalid-feedback" style="width: 100%;">
                                    Your username is required.
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="password">Mật khẩu</label>
                            <input type="password" class="form-control" id="password" placeholder="Nhập mật khẩu">
                            <input type="password" class="form-control" id="confirmpw" placeholder="Xác nhận lại mật khẩu" style="margin-top: 10px">
                            <div class="invalid-feedback">
                                Vui lòng nhập mật khẩu.
                            </div>
                        </div>
                        <div class="col-md-6  mb-3">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" id="email" placeholder="you@example.com">
                            <div class="invalid-feedback">
                                Vui lòng nhập vào email để cập nhật thông tin mượn/gia hạn sách.
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label>Địa chỉ</label>
                            <input type="text" class="form-control" id="address" placeholder="96 Định Công">
                            <div class="invalid-feedback">
                                Vui lòng nhập địa chỉ.
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label>Địa chỉ</label>
                            <select class="form-control" id="libID">
                                <option selected value="1">Thư viện Hà Nội</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="text-center" style="margin: auto; width: 80%;">
                            <button class="btn btn-primary" type="button" style="width: 10% !important;" onclick="kiemTra()">Đăng ký</button>
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
