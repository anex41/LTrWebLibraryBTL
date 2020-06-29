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

<script>
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
        }
        else if (type == "") {
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

</script>
