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
alter table tblLibraryUser
ADD 
CONSTRAINT [PK_tblLibraryUser.userId]  primary key (userId );
drop table tblLibraryUser

/* tạo bảng thư viện */

create table tblLibrary (
	libraryId int identity(1,1) NOT NULL,
	libraryName nvarchar(30) NOT NULL,
	libraryAddress nvarchar(30) NOT NULL
)


/* tạo bảng sách */
create table tblSach (
	iMasach int identity(1,1) NOT NULL PRIMARY KEY,
	iMaloaisach	INT NULL,
	sTensach NVARCHAR(50) NULL,
	fSoluong float NULL,
	sChude NVARCHAR(50) NULL,
	fGiathue float NULL
	foreign key (iMaloaisach) references tblloaisach(iMaloaisach),
)
/* tạo bảng loại sách */
create table tblloaisach (
	iMaloaisach int identity(1,1) NOT NULL PRIMARY KEY,
	sTenloaisach NVARCHAR(30)  NULL
)
/* tạo bảng phiếu mượn */
create table tblPhieumuon (
	iMaPhieu int identity(1,1) NOT NULL PRIMARY KEY,
	userId INT NULL,
	Ngaythue DATE NULL,
	Ngaytra DATE NULL,
	Giahan DATE NULL,
	foreign key (userId) references tblLibraryUser(userId),
)
/* tạo bảng chi tiết phiếu mượn */
create table tblChitietphieumuon(
	iMaphieu int identity(1,1) NOT NULL PRIMARY KEY,
	iMasach INT NULL, 
	fSoluongthue FLOAT NULL,
	fGiathue FLOAT NULL,
	foreign key (iMasach) references tblSach(iMasach),
)
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

/**/
drop table tblLibrary

/* tạo bảng liên kết giữa người dùng và thư viện */

create table tblUserAndLibrary (
	userId int NOT NULL,
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

/* tạo proc lấy danh sách người dùng */

create proc getLibraryUserList
as
	Begin
		select tblLibraryUser.userId, tblLibraryUser.userAccount,
			tblLibraryUser.userDisplayName, tblLibraryUser.userEmail, tblLibraryUser.userAddress,
			tblLibraryUser.userStatus, tblLibraryUser.userRole
		from tblLibraryUser
	end

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

/* tạo proc thêm người dùng */
/* tạo proc thêm người dùng */
/* tạo proc thêm người dùng */
/* tạo proc thêm người dùng */
select * from tblLibraryUser