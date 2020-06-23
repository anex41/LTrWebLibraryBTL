<%@ Page Title="Quản lý" Language="C#" MasterPageFile="~/View/server/Server.Master" AutoEventWireup="true" CodeBehind="ServerSideControl.aspx.cs" Inherits="LTrWebLibraryBTL.View.server.ServerSideControl" %>

<%@ Register TagPrefix="ServerSide" TagName="Quanlynguoidung" Src="~/UserControl/ReaderUserControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BTLContent" runat="server">
    <style>
        .ServerSideNav {
            background-color: #343a40;
            width: 22vw;
            transition: all 0.5s;
        }

        .sideNavTog {
            width: 5vw !important;
            transition: all 0.5s;
        }

        .ServerContent {
            margin-left: 22vw;
            transition: all 0.5s;
        }

        .ServerContentTog {
            margin-left: 5vw;
            transition: all 0.5s;
        }

        .toogleButtonStyle {
            background-color: #343a40;
            left: 21.9vw;
            border-top-right-radius: 15px;
            border-bottom-right-radius: 15px;
            top: 80px;
            transition: all 0.5s;
        }

        .toogleButtonTog {
            left: 4.9vw;
            transition: all 0.5s;
        }
    </style>
    <div id="ServerSideNav" class="ServerSideNav position-fixed border-right border-secondary" style="height: calc(100% - 80px);">
        <div class="row m-0">
            <div class="col-sm-12" style="height: 50px;">
                <div class="row mx-0 my-auto h-100" onclick="changeView('add')" style="cursor: pointer;">
                    <div class="sideNavTitle col-sm-10 m-auto">
                        <a class="text-white col-sm-12 my-2">Quản lý người dùng</a>
                    </div>
                    <div class=" p-0 my-auto text-center">
                        <i class="text-white fas fa-book-reader" style="font-size: 25px;"></i>
                    </div>
                </div>
            </div>
            <hr class="w-100 bg-white my-1" />
            <div class="col-sm-12" style="height: 50px;">
                <div class="row mx-0 my-auto h-100" onclick="changeView('edit')" style="cursor: pointer;">
                    <div class="sideNavTitle col-sm-10 m-auto">
                        <a class="text-white col-sm-12 my-2">Quản lý sách</a>
                    </div>
                    <div class=" p-0 my-auto text-center">
                        <i class="text-white fas fa-book" style="font-size: 25px;"></i>
                    </div>
                </div>
            </div>
            <hr class="w-100 bg-white my-1" />
            <div class="col-sm-12" style="height: 50px;">
                <div class="row mx-0 my-auto h-100" onclick="changeView('disapprove')" style="cursor: pointer;">
                    <div class="sideNavTitle col-sm-10 m-auto">
                        <a class="text-white col-sm-12 my-2">Quản lý phiếu mượn</a>
                    </div>
                    <div class=" p-0 my-auto text-center">
                        <i class="text-white fas fa-clipboard" style="font-size: 25px;"></i>
                    </div>
                </div>
            </div>
            <hr class="w-100 bg-white my-1" />
        </div>
    </div>
    <div id="ServerContent" class="ServerContent">
        <div id="sideNavToogleBtn" class="position-fixed text-danger toogleButtonStyle p-2" style="z-index: 2;" onclick="toggleSideNav()">
            <i id="faId" class="text-white fas fa-caret-left"></i>
        </div>
        <div class="row mx-0">
            <div id="productAddDiv" class="addProductDiv container-fluid">
                <ServerSide:Quanlynguoidung id="UCQuanLyNguoiDung" runat="server" />
                <%--<product:add id="ProductAdd" clientidmode="static" runat="server"></product:add>--%>
            </div>
            <div hidden id="productEditDiv" class="editProductDiv container-fluid">
                Sửa
                <%--<product:edit id="Edit" clientidmode="static" runat="server"></product:edit>--%>
            </div>
            <div hidden id="productApproveDiv" class="deactivateProductDiv container-fluid">
                Kích hoạt
                <%--<product:approve id="Approve" clientidmode="static" runat="server"></product:approve>--%>
            </div>
            <div hidden id="productDisapproveDiv" class="activateProductDiv container-fluid">
                Hủy kích hoạt
                <%--<product:disapprove id="Disapprove" clientidmode="static" runat="server"></product:disapprove>--%>
            </div>
        </div>
    </div>
    <script>
        var sideNavFlag = true;
        var fontAwesome = document.getElementById("faId");

        function toggleSideNav() {
            sideNavFlag == true ? closeSideNav() : openSideNave();
        };

        function openSideNave() {
            sideNavFlag = true;
            $(".sideNavTitle ").show();
            $("#sideNavCloseBtn").removeAttr("hidden");
            $("#sideNavOpenBtn").attr("hidden", true);
            document.getElementById("ServerSideNav").classList.toggle('sideNavTog');
            document.getElementById("ServerContent").classList.toggle('ServerContentTog');
            document.getElementById("sideNavToogleBtn").classList.toggle('toogleButtonTog');
            fontAwesome.classList.remove("fa-caret-right");
            fontAwesome.classList.add("fa-caret-left");
        };

        function closeSideNav() {
            sideNavFlag = false;
            $(".sideNavTitle ").hide();
            $("#sideNavOpenBtn").removeAttr("hidden");
            $("#sideNavCloseBtn").attr("hidden", true);
            document.getElementById("ServerSideNav").classList.toggle('sideNavTog');
            document.getElementById("ServerContent").classList.toggle('ServerContentTog');
            document.getElementById("sideNavToogleBtn").classList.toggle('toogleButtonTog');
            fontAwesome.classList.remove("fa-caret-left");
            fontAwesome.classList.add("fa-caret-right");
        };

        function changeView(value) {
            switch (value) {
                case "add":
                    $("#productAddDiv").removeAttr("hidden");
                    $("#productEditDiv").prop("hidden", true);
                    $("#productApproveDiv").prop("hidden", true);
                    $("#productDisapproveDiv").prop("hidden", true);
                    break;
                case "edit":
                    $("#productEditDiv").removeAttr("hidden");
                    $("#productApproveDiv").prop("hidden", true);
                    $("#productAddDiv").prop("hidden", true);
                    $("#productDisapproveDiv").prop("hidden", true);
                    break;
                case "approve":
                    $("#productApproveDiv").removeAttr("hidden");
                    $("#productDisapproveDiv").prop("hidden", true);
                    $("#productEditDiv").prop("hidden", true);
                    $("#productAddDiv").prop("hidden", true);
                    break;
                case "disapprove":
                    $("#productDisapproveDiv").removeAttr("hidden");
                    $("#productEditDiv").prop("hidden", true);
                    $("#productAddDiv").prop("hidden", true);
                    $("#productApproveDiv").prop("hidden", true);
                    break;
                default:
                    showInfoToast("Thông báo!", "Đường dẫn không tồn tại");
                    break;
            };
        };

        function formatDate(str) {
            return new Date(parseInt(str.replace(/\//g, "").replace(/Date/, "").replace(/\(/g, "").replace(/\)/g, "")));
        };

        function refreshAllList() {
            getApproveProductList();
            getDisapproveProductList();
            getEditProductList();
        };

        function toggleEditState() {
            if (editFlag) {
                document.getElementById("titleTxt").classList.toggle('border-limegreen');
                document.getElementById("priceTxt").classList.toggle('border-limegreen');
                document.getElementById("catalogTxt").classList.toggle('border-limegreen');
                document.getElementById("addressTxt").classList.toggle('border-limegreen');
                document.getElementById("cityTxt").classList.toggle('border-limegreen');
                document.getElementById("districtTxt").classList.toggle('border-limegreen');
                document.getElementById("descriptionTxt").classList.toggle('border-limegreen');
                document.getElementById("cke_ckEditorTxt").classList.toggle('border-limegreen');
            } else {
                document.getElementById("titleTxt").classList.toggle('border-limegreen');
                document.getElementById("priceTxt").classList.toggle('border-limegreen');
                document.getElementById("catalogTxt").classList.toggle('border-limegreen');
                document.getElementById("addressTxt").classList.toggle('border-limegreen');
                document.getElementById("cityTxt").classList.toggle('border-limegreen');
                document.getElementById("districtTxt").classList.toggle('border-limegreen');
                document.getElementById("descriptionTxt").classList.toggle('border-limegreen');
                document.getElementById("cke_ckEditorTxt").classList.toggle('border-limegreen');
            };
        };

    </script>
</asp:Content>
