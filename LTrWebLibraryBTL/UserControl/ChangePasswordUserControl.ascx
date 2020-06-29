<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChangePasswordUserControl.ascx.cs" Inherits="LTrWebLibraryBTL.UserControl.ChangePasswordUserControl" %>
<div class="modal fade" id="modalDoiMatKhau" tabindex="-1" role="dialog" data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title text-center text-primary w-100" id="exampleModalLabel">Đổi mật khẩu</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row m-0">
                    <div class="col-sm-12 mt-4">
                        <div class="row m-0">
                            <div class="col-sm-4 m-auto">
                                Mật khẩu cũ
                            </div>
                            <div class="col-sm-8 input-group">
                                <input id="oldPasswordTxt" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12 mt-4">
                        <div class="row m-0">
                            <div class="col-sm-4 m-auto">
                                Mật khẩu mới
                            </div>
                            <div class="col-sm-8 input-group">
                                <input id="newPasswordTxt" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12 mt-4">
                        <div class="row m-0">
                            <div class="col-sm-4 m-auto">
                                Xác nhận mật khẩu mới
                            </div>
                            <div class="col-sm-8 input-group">
                                <input id="reNewPasswordTxt" class="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-danger" data-dismiss="modal">Đóng</button>
                <button type="button" class="btn btn-success" id="confirmChangePasswordBtn" onclick="validateDoiMatKhau()">Xác nhận</button>
            </div>
        </div>
    </div>
</div>
<script>
    var pass = document.getElementById("newPasswordTxt");
    var oldpass = document.getElementById("oldPasswordTxt");

    function validateDoiMatKhau() {
        doiMatKhau();
    };

    function doiMatKhau() {
        let data = { "password": pass.value.trim(), "oldpass": oldpass.value.trim() };
        $.ajax({
            type: "POST",
            url: window.location.origin + "/Services/LoginServices.asmx/ChangeUserPassword",
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
        }).then(res => {
            switch (parseInt(res.d)) {
                case -1:
                    showInfoToast("Thông báo", "Mật khẩu mới trùng với mật khẩu cũ");
                    break;
                case 0:
                    showErrorToast("Lỗi", "Mật khẩu cũ sai");
                    break;
                case 1:
                    signOut();
                    break;
            }
        });
    };

</script>

