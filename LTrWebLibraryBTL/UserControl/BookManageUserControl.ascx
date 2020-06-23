<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BookManageUserControl.ascx.cs" Inherits="LTrWebLibraryBTL.UserControl.BookManageUserControl" %>

<div class="row mx-0">
    <div class="text-primary text-center col-sm-12 position-relative">
        <h1>Quản lý sách</h1>
    </div>
    <ul class="col-sm-12 mt-3 nav nav-pills nav-fill" id="myTab" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" id="addBooktab" data-toggle="tab" href="#addBook" role="tab" aria-selected="true">Thêm sách</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="listBooktab" data-toggle="tab" href="#listBook" role="tab" aria-selected="false">Danh sách sách</a>
        </li>
    </ul>
    <hr class="w-100" />
    <div class="tab-content col-sm-12" id="myTabContent">
        <div class="tab-pane fade show active" id="addBook" role="tabpanel" aria-labelledby="home-tab">
            <div class="row">
                <div class="col-md-12 order-md-1">
                    <form class="needs-validation" novalidate="">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label>Tên loại sách</label>
                                <input type="text" class="form-control" id="loaisach" placeholder="Sách, báo, tạp chí..." value="" required="">
                                <div class="invalid-feedback">
                                    Valid loại sách is required.
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label>Tên sách</label>
                                <input type="text" class="form-control" id="tensach" placeholder="Hóa học 12" value="" required="">
                                <div class="invalid-feedback">
                                    Valid tên sách is required.
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label>Chủ đề</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="chude" placeholder="Khoa học" required="">
                                <div class="invalid-feedback" style="width: 100%;">
                                    Chủ đề is required.
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label>Số lượng</label>
                            <input type="number" class="form-control" id="soluong">
                            <div class="invalid-feedback">
                                Vui lòng nhập số lượng.
                            </div>
                        </div>
                        <div class="mb-3">
                            <label>Giá mượn</label>
                            <input type="number" class="form-control" id="giamuon" required="">
                            <div class="invalid-feedback">
                                Vui lòng nhập vào giá mượn.
                            </div>
                        </div>
                        <hr class="mb-4">
                        <button class="btn btn-primary btn-lg btn-block" type="submit" style="width: 10% !important; margin: auto;">
                            Thêm</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="tab-pane fade" id="listBook" role="tabpanel" aria-labelledby="profile-tab">
            <div class="col-md-12 order-md-1">
                <div class="row">
                    <div class="col-md-10 mb-3">
                        Đây là 1 danh sách sách!
                    </div>
                    <div class="col-md-1 mb-3">
                        <button class="btn btn-outline-success btn-lg btn-block" type="submit" style="width: 100% !important; margin: auto;">
                            <i class="far fa-edit"></i></button>
                    </div>
                    <div class="col-md-1 mb-3">
                        <button class="btn btn-outline-danger btn-lg btn-block" type="submit" style="width: 100% !important; margin: auto;">
                           <i class="fas fa-trash"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
