/*
Created: 2/21/2018
Modified: 2/21/2018
Model: Oracle 11g Release 2
Database: Oracle 11g Release 2
*/


-- Create tables section -------------------------------------------------

-- Table DimArtist

CREATE TABLE DimArtist(
  ArtistId Integer NOT NULL,
  Name Varchar2(120 )
)
/

-- Add keys for table DimArtist

ALTER TABLE DimArtist ADD CONSTRAINT PK_Artist PRIMARY KEY (ArtistId)
/

-- Table DimCustomer

CREATE TABLE DimCustomer(
  CustomerId Integer NOT NULL,
  FirstName Varchar2(40 ) NOT NULL,
  LastName Varchar2(20 ) NOT NULL,
  Company Varchar2(80 ),
  Phone Varchar2(24 ),
  Fax Varchar2(24 ),
  Email Varchar2(60 ) NOT NULL
)
/

-- Add keys for table DimCustomer

ALTER TABLE DimCustomer ADD CONSTRAINT PK_Customer PRIMARY KEY (CustomerId)
/

-- Table FactSales

CREATE TABLE FactSales(
  InvoiceId Integer NOT NULL,
  CustomerId Integer NOT NULL,
  Total Number(10,2) NOT NULL,
  UnitPrice Number(18,0),
  Quantity Integer,
  GeographyId Integer,
  InvoiceDate Integer,
  SongsId Integer,
  PlaylistId Integer
)
/

-- Create indexes for table FactSales

CREATE INDEX IFK_InvoiceCustomerId ON FactSales (CustomerId)
/

CREATE INDEX IX_Relationship15 ON FactSales (GeographyId)
/

CREATE INDEX IX_Relationship16 ON FactSales (InvoiceDate)
/

CREATE INDEX IX_Relationship20 ON FactSales (SongsId)
/

CREATE INDEX IX_Relationship21 ON FactSales (PlaylistId)
/

-- Add keys for table FactSales

ALTER TABLE FactSales ADD CONSTRAINT PK_Invoice PRIMARY KEY (InvoiceId)
/

-- Table DimPlaylist

CREATE TABLE DimPlaylist(
  PlaylistId Integer NOT NULL,
  Name Varchar2(120 )
)
/

-- Add keys for table DimPlaylist

ALTER TABLE DimPlaylist ADD CONSTRAINT PK_Playlist PRIMARY KEY (PlaylistId)
/

-- Table DimSongs

CREATE TABLE DimSongs(
  SongsId Integer NOT NULL,
  Name Varchar2(200 ) NOT NULL,
  AlbumId Integer,
  Composer Varchar2(220 ),
  Milliseconds Integer NOT NULL,
  Bytes Integer,
  UnitPrice Number(10,2) NOT NULL,
  GenreName VARCHAR2(200),
  MediaName VARCHAR2(200),
  AlbumName VARCHAR2(200),
  ArtistId Integer,
  ComposerId Integer
)
/

-- Create indexes for table DimSongs

CREATE INDEX IFK_TrackAlbumId ON DimSongs (AlbumId)
/

CREATE INDEX IX_Relationship18 ON DimSongs (ArtistId)
/

CREATE INDEX IX_Relationship19 ON DimSongs (ComposerId)
/

-- Add keys for table DimSongs

ALTER TABLE DimSongs ADD CONSTRAINT PK_Track PRIMARY KEY (SongsId)
/

-- Table DimGeography

CREATE TABLE DimGeography(
  GeographyId Integer NOT NULL,
  Address VARCHAR2(200),
  City VARCHAR2(200),
  State VARCHAR2(200),
  Country VARCHAR2(200),
  ZipCode VARCHAR2(200)
)
/

-- Add keys for table DimGeography

ALTER TABLE DimGeography ADD CONSTRAINT Key4 PRIMARY KEY (GeographyId)
/

-- Table DimDate

CREATE TABLE DimDate(
  DateKey Integer NOT NULL,
  FullDateAlternateKey Date,
  EnglishMonthName VARCHAR2(200),
  CalendarYear Integer,
  DayNumberOfWeek Integer,
  WeekNumberOfYear Integer,
  MonthNumberOfYear Integer
)
/

-- Add keys for table DimDate

ALTER TABLE DimDate ADD CONSTRAINT Key5 PRIMARY KEY (DateKey)
/

-- Table DimComposer

CREATE TABLE DimComposer(
  ComposerId Integer NOT NULL,
  ComposerName VARCHAR2(200)
)
/

-- Add keys for table DimComposer

ALTER TABLE DimComposer ADD CONSTRAINT Key6 PRIMARY KEY (ComposerId)
/


-- Create foreign keys (relationships) section ------------------------------------------------- 

ALTER TABLE FactSales ADD CONSTRAINT FK_DimDate FOREIGN KEY (InvoiceDate) REFERENCES DimDate (DateKey)
/


ALTER TABLE FactSales ADD CONSTRAINT FK_InvoiceCustomerId FOREIGN KEY (CustomerId) REFERENCES DimCustomer (CustomerId)
/


ALTER TABLE FactSales ADD CONSTRAINT FK_DimGeography FOREIGN KEY (GeographyId) REFERENCES DimGeography (GeographyId)
/


ALTER TABLE DimSongs ADD CONSTRAINT FK_DimArtist FOREIGN KEY (ArtistId) REFERENCES DimArtist (ArtistId)
/


ALTER TABLE DimSongs ADD CONSTRAINT FK_DimComposer FOREIGN KEY (ComposerId) REFERENCES DimComposer (ComposerId)
/


ALTER TABLE FactSales ADD CONSTRAINT FK_DimSongs FOREIGN KEY (SongsId) REFERENCES DimSongs (SongsId)
/


ALTER TABLE FactSales ADD CONSTRAINT FK_Playlist FOREIGN KEY (PlaylistId) REFERENCES DimPlaylist (PlaylistId)
/





