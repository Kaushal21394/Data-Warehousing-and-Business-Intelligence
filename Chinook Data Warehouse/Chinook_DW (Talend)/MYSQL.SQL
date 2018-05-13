/*
Created: 2/20/2018
Modified: 2/20/2018
Model: MySQL 5.7
Database: MySQL 5.7
*/


-- Create tables section -------------------------------------------------

-- Table DimArtist

CREATE TABLE `DimArtist`
(
  `ArtistId` Int NOT NULL,
  `Name` Varchar(120)
)
;

ALTER TABLE `DimArtist` ADD PRIMARY KEY (`ArtistId`)
;

-- Table DimCustomer

CREATE TABLE `DimCustomer`
(
  `CustomerId` Int NOT NULL,
  `FirstName` Varchar(40) NOT NULL,
  `LastName` Varchar(20) NOT NULL,
  `Company` Varchar(80),
  `Phone` Varchar(24),
  `Fax` Varchar(24),
  `Email` Varchar(60) NOT NULL
)
;

ALTER TABLE `DimCustomer` ADD PRIMARY KEY (`CustomerId`)
;

-- Table FactSales

CREATE TABLE `FactSales`
(
  `InvoiceId` Int NOT NULL,
  `CustomerId` Int NOT NULL,
  `Total` Decimal(10,2) NOT NULL,
  `UnitPrice` Decimal(18,0),
  `Quantity` Int,
  `GeographyId` Int,
  `InvoiceDate` Int,
  `SongsId` Int,
  `PlaylistId` Int
)
;

CREATE INDEX `IFK_InvoiceCustomerId` ON `FactSales` (`CustomerId`)
;

CREATE INDEX `IX_Relationship15` ON `FactSales` (`GeographyId`)
;

CREATE INDEX `IX_Relationship16` ON `FactSales` (`InvoiceDate`)
;

CREATE INDEX `IX_Relationship20` ON `FactSales` (`SongsId`)
;

CREATE INDEX `IX_Relationship21` ON `FactSales` (`PlaylistId`)
;

ALTER TABLE `FactSales` ADD PRIMARY KEY (`InvoiceId`)
;

-- Table DimPlaylist

CREATE TABLE `DimPlaylist`
(
  `PlaylistId` Int NOT NULL,
  `Name` Varchar(120)
)
;

ALTER TABLE `DimPlaylist` ADD PRIMARY KEY (`PlaylistId`)
;

-- Table DimSongs

CREATE TABLE `DimSongs`
(
  `SongsId` Int NOT NULL,
  `Name` Varchar(200) NOT NULL,
  `AlbumId` Int,
  `Composer` Varchar(220),
  `Milliseconds` Int NOT NULL,
  `Bytes` Int,
  `UnitPrice` Decimal(10,2) NOT NULL,
  `GenreName` Text,
  `MediaName` Text,
  `AlbumName` Text,
  `ArtistId` Int,
  `ComposerId` Int
)
;

CREATE INDEX `IFK_TrackAlbumId` ON `DimSongs` (`AlbumId`)
;

CREATE INDEX `IX_Relationship18` ON `DimSongs` (`ArtistId`)
;

CREATE INDEX `IX_Relationship19` ON `DimSongs` (`ComposerId`)
;

ALTER TABLE `DimSongs` ADD PRIMARY KEY (`SongsId`)
;

-- Table DimGeography

CREATE TABLE `DimGeography`
(
  `GeographyId` Int NOT NULL,
  `Address` Text,
  `City` Text,
  `State` Text,
  `Country` Text,
  `ZipCode` Text
)
;

ALTER TABLE `DimGeography` ADD PRIMARY KEY (`GeographyId`)
;

-- Table DimDate

CREATE TABLE `DimDate`
(
  `DateKey` Int NOT NULL,
  `FullDateAlternateKey` Date,
  `EnglishMonthName` Text,
  `CalendarYear` Smallint,
  `DayNumberOfWeek` Smallint,
  `WeekNumberOfYear` Smallint,
  `MonthNumberOfYear` Smallint
)
;

ALTER TABLE `DimDate` ADD PRIMARY KEY (`DateKey`)
;

-- Table DimComposer

CREATE TABLE `DimComposer`
(
  `ComposerId` Int NOT NULL,
  `ComposerName` Text
)
;

ALTER TABLE `DimComposer` ADD PRIMARY KEY (`ComposerId`)
;

-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE `FactSales` ADD CONSTRAINT `FK_DimDate` FOREIGN KEY (`InvoiceDate`) REFERENCES `DimDate` (`DateKey`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


ALTER TABLE `FactSales` ADD CONSTRAINT `FK_InvoiceCustomerId` FOREIGN KEY (`CustomerId`) REFERENCES `DimCustomer` (`CustomerId`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


ALTER TABLE `FactSales` ADD CONSTRAINT `FK_DimGeography` FOREIGN KEY (`GeographyId`) REFERENCES `DimGeography` (`GeographyId`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


ALTER TABLE `DimSongs` ADD CONSTRAINT `FK_DimArtist` FOREIGN KEY (`ArtistId`) REFERENCES `DimArtist` (`ArtistId`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


ALTER TABLE `DimSongs` ADD CONSTRAINT `FK_DimComposer` FOREIGN KEY (`ComposerId`) REFERENCES `DimComposer` (`ComposerId`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


ALTER TABLE `FactSales` ADD CONSTRAINT `FK_DimSongs` FOREIGN KEY (`SongsId`) REFERENCES `DimSongs` (`SongsId`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


ALTER TABLE `FactSales` ADD CONSTRAINT `FK_Playlist` FOREIGN KEY (`PlaylistId`) REFERENCES `DimPlaylist` (`PlaylistId`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


