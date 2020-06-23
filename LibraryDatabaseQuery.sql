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