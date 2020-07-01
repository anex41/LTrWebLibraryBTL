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

/* tạo bảng sách */
create table tblSach (
	iMasach int identity(1,1) NOT NULL primary key,
	sTensach NVARCHAR(50) NULL,
	sTacgia NVARCHAR(50) NULL,
	sTheloai NVARCHAR(50) NULL
)

drop table tblSach

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
alter table tblBookandLibrary
add constraint PF_BookAndLibrary primary key (iMasach,libraryId)

alter table tblBookandLibrary
add constraint FK_BookAndLibrary FOREIGN KEY (iMasach) REFERENCES  tblSach(iMasach);


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

/*tạo proc thêm sách */
create proc addBook
@tensach  nvarchar (50),
@theloai nvarchar(50),
@tacgia nvarchar(50),
@libraryId int
as
	BEGIN
		insert into tblSach
		values (@tensach,@theloai,@tacgia)

		insert into tblBookAndLibrary
		values (SCOPE_IDENTITY(), @libraryId, 1)
	END

<<<<<<< HEAD
=======

>>>>>>> d83daae46a82f1ac07fa9f59bd0f7b5d5d284b2b
/*tạo proc lấy danh sách sách*/
create proc getBookList
@libraryID int
as
	Begin
		select tblSach.iMasach, tblSach.sTensach, tblSach.sTacgia, tblSach.sTheloai
		from tblSach, tblBookAndLibrary
		where tblBookAndLibrary.iMasach = tblSach.iMasach and tblBookAndLibrary.libraryId = @libraryID
	End

drop proc getBookList

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

drop proc getLibraryUserInfor

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

exec getLibraryUserList @libraryID = 2

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
		set tblLibraryUser.userStatus = -1
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
select * from tblLibraryUser

/* tạo proc đổi mật khẩu */
create proc changeUserPassword
@account varchar(30),
@password varchar(256),
@oldpassword varchar(256)
as
	begin
		if (select tblLibraryUser.userPassword 
			from tblLibraryUser 
			where tblLibraryUser.userAccount = @account) = @oldpassword
			begin
				if (select tblLibraryUser.userPassword 
					from tblLibraryUser 
					where tblLibraryUser.userAccount = @account) = @password
						return -1;
				else
				begin
					update tblLibraryUser
					set tblLibraryUser.userPassword = @password
					where tblLibraryUser.userAccount = @account
					return 1;
				end
			end
		else
			return 0;
	end

drop proc changeUserPassword

DECLARE @return_status int;  
EXEC @return_status = changeUserPassword @account = 'anex', @password = '69596fe31f8b339800ca34029a2dc3aa14710b616b043e896e091db62203edf4'
	, @oldpassword = '05ad5a1bf7ce09dde3fd4f3cde766206321ae61f0fd596f5dfb028d5e461a162';  
SELECT 'Return Status' = @return_status; 

<<<<<<< HEAD
/*tạo proc sửa thông tin sách*/
create proc editBook
@sachId int,
@tensach nvarchar (50),
@theloai nvarchar (50),
@tacgia nvarchar (50)
as
	begin
	update tblSach
		set tblSach.sTensach = @tensach, tblSach.sTacgia = @tacgia, tblSach.sTheloai = @theloai
		where tblSach.iMasach = @sachId
	End
=======
>>>>>>> d83daae46a82f1ac07fa9f59bd0f7b5d5d284b2b

/*
taipham-pass tai3110
thanhdinh-pass thanh123
anex-pass trung123
*/

/* tạo proc tìm kiếm sách */
create proc searchBookByTitle
@searchValue nvarchar(30)
as
	begin
		select tblSach.iMaSach, tblSach.sTenSach, tblSach.sTacGia, tblSach.sTheloai, tblLibrary.libraryName
		from tblSach, tblLibrary, tblBookAndLibrary
		where tblSach.sTensach LIKE '%'+@searchValue+'%' and tblSach.iMaSach = tblBookAndLibrary.iMaSach 
			and tblBookAndLibrary.libraryId = tblLibrary.libraryId and tblBookAndLibrary.statusFlag = 1
	end

drop proc searchBookByTitle

exec searchBookByTitle @searchValue = "t"