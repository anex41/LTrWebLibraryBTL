create database libraryDB
use libraryDB

create table tblLibaryUser (
	userId int identity(1,1) NOT NULL,
	userAccount varchar (30) NOT NULL,
	userPassword varchar(256) NOT NULL,
	userDisplayName nvarchar (60) NOT NULL,
	userEmail varchar(60) NOT NULL,
	userAddress nvarchar(60) NOT NULL,
	userStatus int NOT NULL,
	userRole int NOT NULL,
	libraryId int NOT NULL
);

drop table tblLibaryUser