<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReaderUserControl.ascx.cs" Inherits="LTrWebLibraryBTL.UserControl.WebUserControl1" %>
<div class="row m-0">
    <div class="text-primary text-center col-sm-12 position-relative">
        <h1>Quản lý người dùng</h1>
    </div>
    <nav class="col-sm-12 mt-3 nav nav-pills nav-fill">
        <a id="toggleActivate" class="nav-item nav-link active" style="cursor: pointer;">Kích hoạt</a>
        <a id="toggleDeactivate" class="nav-item nav-link" style="cursor: pointer;">Hủy kích hoạt</a>
    </nav>
    <div id="activateList" class="col-sm-12">
        <div class="row mx-0">
            <div class="col-sm-3 mt-4">
                <div class="card text-center p-1">
                    <i class="fas fa-user-tie fa-10x"></i>
                    <div class="card-body">
                        <h5 class="card-title">Người dùng</h5>
                        <p class="card-text">Thông tin người dùng</p>
                        <button type="button" class="btn btn-success">Kích hoạt</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="disableList" class="col-sm-12">
        <div class="row mx-0">
        </div>
    </div>
</div>
