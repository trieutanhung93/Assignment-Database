CREATE DATABASE dbPublication
GO

USE dbPublication
GO

CREATE TABLE tblWebInfo(
	IDWebInfo INT Primary key,
	Name NVARCHAR(50) NOT  NULL,
	Value NVARCHAR(50) NOT  NULL,
);

CREATE TABLE tblUsers(
	IDUser INT Primary key,
	Username VARCHAR(50) NOT  NULL UNIQUE,
	Password VARCHAR(50) NOT  NULL,
	FirstName NVARCHAR(50) NOT  NULL,
	LastName NVARCHAR(50) NOT  NULL,
	Career NVARCHAR(50) NOT  NULL,
	WorkAgency NVARCHAR(50) NOT  NULL,
	Address NVARCHAR(50) NOT  NULL,
	Phone CHAR(13) NOT NULL CHECK( Phone LIKE '%+[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%'),
	Author BIT NOT NULL DEFAULT 0,
	Reviewer BIT NOT NULL DEFAULT 0,
	Editor BIT NOT NULL DEFAULT 0,
);

CREATE TABLE tblEmailOfUser(
	IDEmail INT Primary key,
	IDUser INT FOREIGN KEY REFERENCES tblUsers(IDUser),
	Email VARCHAR(50) NOT  NULL,
);

CREATE TABLE tblAuthor(
	IDAuthor INT Primary key FOREIGN KEY REFERENCES tblUsers(IDUser),
);
	
CREATE TABLE tblReviewer(
	IDReviewer INT Primary key FOREIGN KEY REFERENCES tblUsers(IDUser),
	Level INT NOT  NULL,
	Specialize NVARCHAR(50) NOT  NULL,
	TimeCooperate DATETIME NOT NULL,
);

CREATE TABLE tblEditorialBoard(
	IDEditor INT Primary key FOREIGN KEY REFERENCES tblUsers(IDUser),
);

CREATE TABLE tblArticle(
	IDArticle INT Primary key,
	Title NVARCHAR(50) NOT  NULL,
	Summary NVARCHAR(50) NOT  NULL,
	FileArticle VARCHAR(50) NOT  NULL,
	Type VARCHAR(50) DEFAULT 'overview' CHECK(Type='research' OR Type='book review' OR Type='overview') NOT NULL,
);

CREATE TABLE tblKeyWordOfArticle(
	IDKeyWord INT Primary key,
	IDArticle INT FOREIGN KEY REFERENCES tblArticle(IDArticle),
	KeyWord NVARCHAR(50) NOT  NULL,
);

CREATE TABLE tblBookReviewer(
	IDArticle INT Primary key FOREIGN KEY REFERENCES tblArticle(IDArticle),
	Length INT CHECK(Length>=3 AND Length<=6) NOT NULL,
	Name NVARCHAR(50) NOT  NULL,
	ISBN VARCHAR(50) NOT  NULL,
	Producer NVARCHAR(50) NOT  NULL,
	YearOfManufacture DATE NOT NULL,
	NumberOfPages INT CHECK(NumberOfPages >0) NOT NULL,
);

CREATE TABLE tblResearch(
	IDArticle INT Primary key FOREIGN KEY REFERENCES tblArticle(IDArticle),
	Length INT CHECK(Length>=10 AND Length<=20) NOT NULL,
);

CREATE TABLE tblOverview(
	IDArticle INT Primary key FOREIGN KEY REFERENCES tblArticle(IDArticle),
	Length INT CHECK(Length>=3 AND Length<=10) NOT NULL,
);

CREATE TABLE tblCompilation(
	IDAuthor INT FOREIGN KEY REFERENCES tblAuthor(IDAuthor),
	IDArticle INT FOREIGN KEY REFERENCES tblArticle(IDArticle),
	PRIMARY KEY(IDAuthor,IDArticle)
);

CREATE TABLE tblSentArticle(
	IDArticle INT Primary key FOREIGN KEY REFERENCES tblArticle(IDArticle),
	Code VARCHAR(50) NOT  NULL,
	TimeSend DATETIME NOT NULL,
);

CREATE TABLE tblContact(
	IDArticle INT FOREIGN KEY REFERENCES tblArticle(IDArticle) PRIMARY KEY,
	IDAuthor INT FOREIGN KEY REFERENCES tblAuthor(IDAuthor),
);

CREATE TABLE tblReviewerArticle(
	IDReviewer INT FOREIGN KEY REFERENCES tblReviewer(IDReviewer),
	IDArticle INT FOREIGN KEY REFERENCES tblArticle(IDArticle),
	PRIMARY KEY(IDReviewer,IDArticle),
);

CREATE TABLE tblCriteria(
	IDCriteria INT PRIMARY KEY,
	Title NVARCHAR(50) NOT NULL,
	Description NVARCHAR(50) NOT NULL,
	Maxpoint INT CHECK(Maxpoint>0) NOT NULL,
);

CREATE TABLE tblEvaluation(
	IDEvaluation INT PRIMARY KEY,
	IDArticle INT FOREIGN KEY REFERENCES tblArticle(IDArticle),
	IDCriteria INT FOREIGN KEY REFERENCES tblCriteria(IDCriteria),
	Description NVARCHAR(50) NOT NULL,
	Point INT CHECK(Point>=0) NOT NULL,
	NoteForAuthor NVARCHAR(50),
	NoteForEditor NVARCHAR(50),
);

CREATE TABLE tblResult(
	IDArticle INT FOREIGN KEY REFERENCES tblArticle(IDArticle) PRIMARY KEY,
	Result VARCHAR(50) DEFAULT 'rejection' CHECK(Result='rejection' OR Result='minor revision' OR Result='major revision' OR Result='acceptance') NOT NULL,
	TimeNotify DATETIME NOT NULL,
	Note NVARCHAR(50),
);

CREATE TABLE tblPrint(
	IDArticle INT FOREIGN KEY REFERENCES tblResult(IDArticle) PRIMARY KEY,
	DIO VARCHAR(50) NOT NULL,
	OpenAccess BIT DEFAULT 0 NOT NULL,
);
