create database libraryDB
use libraryDB


/* tạo bảng người dùng */

create table tblLibaryUser (
	userId int identity(1,1) NOT NULL,
	userAccount varchar (30) NOT NULL,
	userPassword varchar(256) NOT NULL,
	userDisplayName nvarchar (60) NOT NULL,
	userEmail varchar(60) NOT NULL,
	userAddress nvarchar(60) NOT NULL,
	userStatus int NOT NULL,
	userRole int NOT NULL
);

drop table tblLibaryUser

/* tạo bảng thư viện */

create table tblLibrary (
	libraryId int identity(1,1) NOT NULL,
	libraryName nvarchar(30) NOT NULL,
	libraryAddress nvarchar(30) NOT NULL
)

/* tạo bảng liên kết giữa người dùng và thư viện */

create table tblUserAndLibrary (
	userId int NOT NULL,
	libraryId int NOT NULL,
	statusFlag bit NOT NULL
)

create table tblBook(
	bookId int not null,
	bookName nvarchar (50) not null,
	bookAmount float not null,
	bookType nvarchar (50) not null,

)

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
		insert into tblLibaryUser
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

/* tạo proc thêm người dùng */
/* tạo proc thêm người dùng */
/* tạo proc thêm người dùng */
/* tạo proc thêm người dùng */
/* tạo proc thêm người dùng */