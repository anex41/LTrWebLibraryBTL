<%@ Page Title="Thông tin cá nhân" Language="C#" MasterPageFile="~/View/BTlLayout.Master" AutoEventWireup="true" CodeBehind="UserInfoPage.aspx.cs" Inherits="LTrWebLibraryBTL.View.client.UserInfoPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BTLContent" runat="server">
    <div class="container">
        <div class="py-5 text-center" style="padding-bottom:0 !important;">
            <h2>Thông tin đăng ký</h2>
            <p class="lead">Việc mượn sách sẽ rất đơn giản và minh bạch khi có thông tin của độc giả. Bạn còn chần chừ gì nữa? Nhanh chóng đăng ký tài khoản ngay nào!</p>
        </div>
        <hr class="mb-4">
        <div class="row">
            <div class="col-md-9 order-md-1">
                <form class="needs-validation" novalidate="">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="firstName">Họ</label>
                            <input type="text" class="form-control" id="firstName" placeholder="" value="" required="">
                            <div class="invalid-feedback">
                                Valid first name is required.
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="lastName">Tên</label>
                            <input type="text" class="form-control" id="lastName" placeholder="" value="" required="">
                            <div class="invalid-feedback">
                                Valid last name is required.
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="username">Tên đăng nhập</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">@</span>
                            </div>
                            <input type="text" class="form-control" id="username" placeholder="Username" required="">
                            <div class="invalid-feedback" style="width: 100%;">
                                Your username is required.
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="password">Mật khẩu</label>
                        <input type="password" class="form-control" id="password">
                        <div class="invalid-feedback">
                            Vui lòng nhập mật khẩu.
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="email">Email</label>
                        <input type="email" class="form-control" id="email" placeholder="you@example.com">
                        <div class="invalid-feedback">
                            Vui lòng nhập vào email để cập nhật thông tin mượn/gia hạn sách.
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="address">Địa chỉ</label>
                        <input type="text" class="form-control" id="address" placeholder="96 Định Công" required="">
                        <div class="invalid-feedback">
                            Vui lòng nhập vào địa chỉ của bạn.
                        </div>
                    </div>
                    <hr class="mb-4">
                    <button class="btn btn-primary btn-lg btn-block" type="submit">Gửi thông tin</button>
                </form>
            </div>
        </div>
    </div>
</asp:Content>
