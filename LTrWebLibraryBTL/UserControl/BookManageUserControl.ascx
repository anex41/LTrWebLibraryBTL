﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BookManageUserControl.ascx.cs" Inherits="LTrWebLibraryBTL.UserControl.BookManageUserControl" %>

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
                                <label>Tên sách</label>
                                <input type="text" class="form-control" id="tensach" placeholder="Hóa học 12" value="" required="">
                                <div id="invalid-bookName" style="color: red;">
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label>Tên tác giả</label>
                                <input type="text" class="form-control" id="tacgia" value="" required="">
                                <div id="invalid-author" style="color: red;">
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label>Thể loại</label>
                                <input type="text" class="form-control" id="theloai" value="" required="" placeholder="Trinh thám, Tiểu thuyết....">
                                <div id="invalid-type" style="color: red;">
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                            <label>Thư viện</label>
                            <select class="form-control" id="libID">
                                <option selected="" value="1">Thư viện Hà Nội</option>
                            </select>
                        </div>
                        </div>
                        <hr class="mb-4">
                        <button class="btn btn-primary btn-lg btn-block" type="button" style="width: 10% !important; margin: auto;" onclick="kiemTra()">
                            Thêm</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="tab-pane fade" id="listBook" role="tabpanel" aria-labelledby="profile-tab">
            <div class="col-md-12 order-md-1" >
                <div class="row mx-0" id="bookList">
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Sửa thông tin sách</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
                <div class="col-md-12 order-md-1">
                    <form class="needs-validation" novalidate="">
                        <div class="row">                          
                            <div class="col-md-6 mb-3">
                                <label>Tên sách</label>
                                <input type="text" class="form-control" id="ts" placeholder="Hóa học 12" value="" required="">
                                <div id="invalid-ts" style="color: red;">
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label>Tên tác giả</label>
                                <input type="text" class="form-control" id="tg" value="" required="">
                                <div id="invalid-tg" style="color: red;">
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label>Thể loại</label>
                                <input type="text" class="form-control" id="tl" value="" required="" placeholder="Trinh thám, Tiểu thuyết....">
                                <div id="invalid-tl" style="color: red;">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
      </div>
      <div class="modal-footer">
        <button type="reset" class="btn btn-secondary" data-dismiss="modal" >Hủy</button>
        <button type="button" class="btn btn-primary" onclick="kiemtraLuu()">Lưu</button>
      </div>
    </div>
  </div>
</div>


<script>
    var x;
    var bookList = document.getElementById("bookList");
    getBookList();

    function kiemTra() {
        // kiểm tra các thứ nếu đúng hết thì thêm sách
        let book = document.getElementById("tensach").value.trim();
        let author = document.getElementById("tacgia").value.trim();
        let type = document.getElementById("theloai").value.trim();

        if (book == "") {
            document.getElementById("invalid-bookName").innerHTML = "Vui lòng nhập tên sách.";
            document.getElementById("tensach").focus();
        } else if (author == "") {
            document.getElementById("invalid-author").innerHTML = "Vui lòng nhập tên tác giả.";
            document.getElementById("tacgia").focus();
        } else if (type == "") {
            document.getElementById("invalid-type").innerHTML = "Vui lòng nhập thể loại.";
            document.getElementById("theloai").focus();
        } else

            themSach();
    };

    function xoaInput() {
        document.getElementById("tensach").value = "";
        document.getElementById("tacgia").value = "";
        document.getElementById("theloai").value = "";
        document.getElementById("libID").value = 1;
    };

    function xoaInputEdit() {
        document.getElementById("ts").value= "";
        document.getElementById("tg").value= "";
        document.getElementById("tl").value = "";
    };

    function themSach() {
        let book = document.getElementById("tensach").value.trim();
        let author = document.getElementById("tacgia").value.trim();
        let type = document.getElementById("theloai").value.trim();
        let libid = document.getElementById("libID").value = 1;
        let data = {
            tensach: book + "", tacgia: author + "", theloai: type + " ", libId: parseInt(libid)
        };
        $.ajax({
            type: "POST",
            url: window.location.origin + "/Services/BookServices.asmx/AddBook",
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        }).then(res => {
            if (res.d == -1) {
                showInfoToast("Thông báo", "Sách đã tồn tại");
            } else {
                showSucceedToast("Thành công", "Thêm sách thành công");
                xoaInput();
            }
        });
    }

function getBookList() {
        $.ajax({
            type: "POST",
            url: window.location.origin + "/Services/BookServices.asmx/GetBookList",
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        }).then(res => {
            if (res.d !== null) appendBook(res.d);
            else showErrorToast("Lỗi!", "Không thể lấy được danh sách sách!")
        });
    };

    function appendBook(arr) {
        $(".bookx").remove();
        for (let i = 0; i < arr.length; i++) {
            appendBookList(arr[i]);
        };
    };

    function appendBookList(item) {
        $("#bookList").append("<div class=\"bookx col-sm-3 mt-12\"><div class=\"card text-center p-1\"><i class=\"fas fa-book fa-10x\"></i>"
            + "<div class=\"card-body\"><h5 class=\"card-title\">" + item.Tensach + "</h5><p class=\"card-text\">" + "Thể loại: " + item.Theloai + "</p><p class=\"card-text\">" + "Tác giả: " + item.Tacgia + "</p>"
            + "<button id=\"book_" + item.Masach + "\" type=\"button\" class=\"btn btn-outline-success\" data-toggle=\"modal\" data-target=\"#editModal\" onclick=\"getID(this.id)\">Sửa</button>" + "</div></div></div>");
    };

    function kiemtraLuu() {
        let a = document.getElementById("ts").value.trim();
        let b = document.getElementById("tg").value.trim();
        let c = document.getElementById("tl").value.trim();

        if (a == "") {
            document.getElementById("invalid-ts").innerHTML = "Vui lòng nhập tên sách.";
            document.getElementById("ts").focus();
        } else if (b == "") {
            document.getElementById("invalid-tg").innerHTML = "Vui lòng nhập tên tác giả.";
            document.getElementById("tg").focus();
        } else if (c == "") {
            document.getElementById("invalid-tl").innerHTML = "Vui lòng nhập thể loại.";
            document.getElementById("tl").focus();
        } else {
            let data = {
                iMasach: x, tenSach: a + "", tacGia: b + "", theLoai: c + " "
            };
            //console.log(JSON.stringify(data));
            $.ajax({
                type: "POST",
                url: window.location.origin + "/Services/BookServices.asmx/EditBook",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(res => {
                getBookList();
                showSucceedToast("Thành công!", "Sửa sách thành công");
            });
            xoaInputEdit();
            $('#editModal').modal('hide');
        }

    };

    function getID(value) {
        x = parseInt(value.split("_")[1]) ;
    };

</script>
