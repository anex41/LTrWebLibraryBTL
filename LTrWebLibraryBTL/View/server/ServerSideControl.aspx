<%@ Page Title="Quản lý" Language="C#" MasterPageFile="~/View/server/Server.Master" AutoEventWireup="true" CodeBehind="ServerSideControl.aspx.cs" Inherits="LTrWebLibraryBTL.View.server.ServerSideControl" %>

<%@ Register TagPrefix="ServerSide" TagName="Quanlynguoidung" Src="~/UserControl/ReaderUserControl.ascx" %>
<%@ Register TagPrefix="ServerSide" TagName="Quanlysach" Src="~/UserControl/BookManageUserControl.ascx" %>
<%@ Register TagPrefix="ServerSide" TagName="Quanlyphieumuon" Src="~/UserControl/BorrowTicketManageUserControl.ascx" %>

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
                <div class="row mx-0 my-auto h-100" onclick="changeView('QLND')" style="cursor: pointer;">
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
                <div class="row mx-0 my-auto h-100" onclick="changeView('QLS')" style="cursor: pointer;">
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
                <div class="row mx-0 my-auto h-100" onclick="changeView('QLPM')" style="cursor: pointer;">
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
            <div id="QLND" class="container-fluid">
                <ServerSide:Quanlynguoidung ID="UCQuanLyNguoiDung" runat="server" />
            </div>
            <div hidden id="QLS" class="container-fluid">
                <ServerSide:Quanlysach id="Quanlysach" runat="server" />
            </div>
            <div hidden id="QLPM" class="container-fluid">
                <ServerSide:Quanlyphieumuon id="Quanlyphieumuon" runat="server" />
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
                case "QLND":
                    $("#QLND").removeAttr("hidden");
                    $("#QLS").prop("hidden", true);
                    $("#QLPM").prop("hidden", true);
                    break;
                case "QLS":
                    $("#QLS").removeAttr("hidden");
                    $("#QLND").prop("hidden", true);
                    $("#QLPM").prop("hidden", true);
                    break;
                case "QLPM":
                    $("#QLPM").removeAttr("hidden");
                    $("#QLS").prop("hidden", true);
                    $("#QLND").prop("hidden", true);
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
