<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BorrowTicketManageUserControl.ascx.cs" Inherits="LTrWebLibraryBTL.UserControl.BorrowTicketManageUserControl" %>

<div class="row mx-0">
    <div class="text-primary text-center col-sm-12 position-relative">
        <h1>Quản lý phiếu mượn</h1>
    </div>
    <ul class="col-sm-12 mt-3 nav nav-pills nav-fill" id="myTab" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" id="approveTickettab" data-toggle="tab" href="#approveTicket" role="tab" aria-selected="true">Duyệt phiếu mượn</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="disapproveTickettab" data-toggle="tab" href="#disapproveTicket" role="tab" aria-selected="false">Hủy duyệt phiếu mượn</a>
        </li>
    </ul>
    <hr class="w-100" />
    <div class="tab-content col-sm-12" id="myTabContent">
        <div class="tab-pane fade show active" id="approveTicket" role="tabpanel" aria-labelledby="home-tab">
            Đây là 1 phiếu mượn để duyệt!
        </div>
        <div class="tab-pane fade" id="disapproveTicket" role="tabpanel" aria-labelledby="profile-tab">
            Đây là 1 phiếu mượn để hủy duyệt!
        </div>
    </div>
</div>