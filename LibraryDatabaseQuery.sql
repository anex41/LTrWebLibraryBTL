create database libraryDB
use libraryDB
drop database libraryDB

/* tạo bảng người dùng */

create table tblLibraryUser (
	userId int identity(1,1) NOT NULL,
	userAccount varchar (30) NOT NULL,
	userPassword varchar(256) NOT NULL,
	userDisplayName nvarchar (60) NOT NULL,
	userEmail varchar(60) NOT NULL,
	userAddress nvarchar(60) NOT NULL,
	userStatus int NOT NULL,
	userRole int NOT NULL
);

drop table tblLibraryUser

/* tạo bảng thư viện */

create table tblLibrary (
	libraryId int identity(1,1) NOT NULL,
	libraryName nvarchar(30) NOT NULL,
	libraryAddress nvarchar(30) NOT NULL
)

drop table tblLibrary

/* tạo bảng loại sách */
create table tblloaisach (
	iMaloaisach int identity(1,1) NOT NULL,
	sTenloaisach NVARCHAR(30)  NULL
)

/* tạo bảng sách */
create table tblSach (
	iMasach int identity(1,1) NOT NULL,
	iMaloaisach	INT NULL,
	sTensach NVARCHAR(50) NULL,
	fSoluong int NULL,
	sChude NVARCHAR(50) NULL,
	fGiathue float NULL
)

drop table tblSach

/* tạo bảng phiếu mượn */
create table tblPhieumuon (
	iMaPhieu int identity(1,1) NOT NULL,
	userId INT NULL,
	Ngaythue DATE NULL,
	Ngaytra DATE NULL,
	Giahan DATE NULL
)

drop table tblPhieumuon

/* tạo bảng chi tiết phiếu mượn */
create table tblChitietphieumuon(
	iMaphieu int identity(1,1) NOT NULL,
	iMasach INT NOT NULL, 
	fSoluongthue int NOT NULL,
	fGiathue FLOAT NOT NULL
)

drop table tblChitietphieumuon

alter table tblChitietphieumuon
add
CONSTRAINT FK_iMaSach  FOREIGN KEY(iMaSach) REFERENCES tblSach(iMaSach);
/* tạo proc thêm loại sách */
create proc Addloaisach @tenloaisach NVARCHAR(30)
as
	insert into tblloaisach(sTenloaisach)
	values (@tenloaisach)

/* tạo proc thêm sách */
create proc Addsach	@maloaisach	INT, @tensach NVARCHAR(50), @soluong float, @chude NVARCHAR(50), @giathue float 
as
	insert into tblSach(iMaloaisach,sTensach,fSoluong,sChude,fGiathue)
	values (@maloaisach,@tensach,@soluong,@chude,@giathue)

/* tạo proc thêm số lượng sách */
create proc Addsoluongsach	@masach	INT, @soluong float
	as
	update tblSach
	set fSoluong = fSoluong + @soluong
	where iMasach=@masach

/* tạo phiếu mượn và chi tiết phiếu mượn 
create proc Addphieumuon @userid INT, @ngaythue DATE, @ngaytra DATE, @masach INT, @soluongthue FLOAT, @giathue DATE
as
insert into tblPhieumuon(userId,Ngaythue,Ngaytra)
values (@userid, @ngaythue, @ngaytra)
insert into tblChitietphieumuon(iMasach,fSoluongthue,fGiathue)
*/
/* tạo proc lấy ra các sách cùng thể loại*/
create proc returnsachcungloai @maloai INT
as
	select tblSach.sTensach,sChude,tblloaisach.sTenloaisach
	from tblSach,tblloaisach
	where  tblSach.iMaloaisach=@maloai and tblloaisach.iMaloaisach = tblSach.iMaloaisach



/* tạo bảng liên kết giữa người dùng và thư viện */

create table tblUserAndLibrary (
	userId int NOT NULL,
	libraryId int NOT NULL,
	statusFlag bit NOT NULL
)

drop table tblUserAndLibrary

/* tạo bảng liên kết giữa sách và thư viện */

create table tblBookAndLibrary (
	iMasach int NOT NULL,
	libraryId int NOT NULL,
	statusFlag bit NOT NULL
)

drop table tblUserAndLibrary

/* tạo proc thêm người dùng */

create proc addLibraryUser
@userAccount varchar (30),
@userPassword varchar(256),
@userDisplayName nvarchar (60),
@userEmail varchar(60),
@userAddress nvarchar(60),
@userStatus int,
@serRole int,
@libraryId int
as
	BEGIN
		insert into tblLibraryUser
		values (@userAccount,@userPassword,@userDisplayName,@userEmail,@userAddress,@userStatus,@serRole);

		insert into tblUserAndLibrary
		values (SCOPE_IDENTITY(), @libraryId, 1)
	END

drop proc addLibraryUser

/* tạo proc lấy thông tin người dùng theo id */

create proc getLibraryUserInfor
@identity int
as
	BEGIN
		select tblLibraryUser.userId, tblLibraryUser.userAccount,
			tblLibraryUser.userDisplayName, tblLibraryUser.userEmail, tblLibraryUser.userAddress,
			tblLibraryUser.userStatus, tblLibraryUser.userRole
		from tblLibraryUser
		where tblLibraryUser.userId = @identity
	END

/* tạo proc lấy thông tin người dùng qua username */

create proc getLibraryUserByAccount
@account varchar(30),
@library int
as
	BEGIN
		select tblLibraryUser.userId, tblLibraryUser.userAccount, tblLibraryUser.userPassword,
			tblLibraryUser.userDisplayName, tblLibraryUser.userStatus, tblLibraryUser.userRole,
			tblUserAndLibrary.statusFlag
		from tblLibraryUser, tblUserAndLibrary
		where tblLibraryUser.userAccount = @account and tblUserAndLibrary.userId = tblLibraryUser.userId
			and tblUserAndLibrary.libraryId = @library
	END

drop proc getLibraryUserByAccount

exec getLibraryUserByAccount @account="vinhnguyen", @library = 1


/* tạo proc lấy danh sách người dùng */

create proc getLibraryUserList
@libraryID int
as
	Begin
		select tblLibraryUser.userId, tblLibraryUser.userAccount, tblLibraryUser.userDisplayName,
			tblLibraryUser.userStatus, tblLibraryUser.userRole
		from tblLibraryUser, tblUserAndLibrary
		where tblUserAndLibrary.userId = tblLibraryUser.userId and tblUserAndLibrary.libraryId = @libraryID
	End

drop proc getLibraryUserList

exec getLibraryUserList @libraryID = 1

/* tạo proc kích hoạt người dùng */

create proc approveUser
@userId int
as
	Begin
		update tblLibraryUser
		set tblLibraryUser.userStatus = 1
		where tblLibraryUser.userId = @userId
	End

drop proc approveUser

exec approveUser @userId = 1

/* tạo proc hủy kích hoạt người dùng */

create proc disapproveUser
@userId int
as
	Begin
		update tblLibraryUser
		set tblLibraryUser.userStatus = 0
		where tblLibraryUser.userId = @userId
	End

drop proc disapproveUser

exec disapproveUser @userId = 1

/* Tạo proc đăng ký người dùng */

create proc signUpProc
@account varchar(30),
@password varchar(256),
@name nvarchar(60),
@email varchar(60),
@address nvarchar(60),
@library int
as
	Begin
		if Exists( select top 1* from tblLibraryUser where tblLibraryUser.userAccount = @account)
			return -1
		else
			begin
				insert into tblLibraryUser
				values (@account,@password,@name,@email,@address,-1,0);
				insert into tblUserAndLibrary
				values(SCOPE_IDENTITY(), @library, 1);
				return 1;
			end
	End

drop proc signUpProc

DECLARE @return_status int;  
EXEC @return_status = signUpProc @account="tuanthanh", @password="95251db4046d8681745142ebf5abdc50e3963604c0e89d8cad2451826d0f86e7",
			@name ="Đinh Tún Thạch", @email = "thanh@xmail.com", @address="Hà Nội", @library = 1;  
SELECT 'Return Status' = @return_status;  
GO
/*
taipham-pass tai3110
thanhdinh-pass thanh123
anex-pass trung123
*/