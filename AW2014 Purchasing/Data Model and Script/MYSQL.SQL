/*
Created: 1/26/2018
Modified: 1/26/2018
Model: MySQL 5.7
Database: MySQL 5.7
*/


-- Create tables section -------------------------------------------------

-- Table DimAlbum

CREATE TABLE `DimAlbum`
(
  `AlbumId` Int NOT NULL,
  `Title` Varchar(160) NOT NULL,
  `ArtistId` Int NOT NULL,
  `Album_SK` Int NOT NULL
)
;

ALTER TABLE `DimAlbum` ADD PRIMARY KEY (`Album_SK`)
;

ALTER TABLE `DimAlbum` ADD UNIQUE `PK_Album` (`AlbumId`)
;

-- Table Customer

CREATE TABLE `Customer`
(
  `CustomerId` Int NOT NULL,
  `FirstName` Varchar(40) NOT NULL,
  `LastName` Varchar(20) NOT NULL,
  `Company` Varchar(80),
  `Phone` Varchar(24),
  `Fax` Varchar(24),
  `Email` Varchar(60) NOT NULL,
  `Customer_SK` Int NOT NULL,
  `Date_SK` Int,
  `Employee_SK` Int,
  `Geography_SK` Int
)
;

CREATE INDEX `IX_Relationship22` ON `Customer` (`Date_SK`)
;

CREATE INDEX `IX_Relationship23` ON `Customer` (`Employee_SK`)
;

CREATE INDEX `IX_Relationship25` ON `Customer` (`Geography_SK`)
;

ALTER TABLE `Customer` ADD PRIMARY KEY (`Customer_SK`)
;

ALTER TABLE `Customer` ADD UNIQUE `PK_Customer` (`CustomerId`)
;

-- Table DimEmployee

CREATE TABLE `DimEmployee`
(
  `EmployeeId` Int NOT NULL,
  `LastName` Varchar(20) NOT NULL,
  `FirstName` Varchar(20) NOT NULL,
  `Title` Varchar(30),
  `ReportsTo` Int,
  `Phone` Varchar(24),
  `Fax` Varchar(24),
  `Email` Varchar(60),
  `GeographyId` Int,
  `Employee_SK` Int NOT NULL
)
;

CREATE INDEX `IFK_EmployeeReportsTo` ON `DimEmployee` (`ReportsTo`)
;

CREATE INDEX `IX_Relationship15` ON `DimEmployee` (`GeographyId`)
;

ALTER TABLE `DimEmployee` ADD PRIMARY KEY (`Employee_SK`)
;

ALTER TABLE `DimEmployee` ADD UNIQUE `PK_Employee` (`EmployeeId`)
;

-- Table FactInvoice

CREATE TABLE `FactInvoice`
(
  `InvoiceId` Int NOT NULL,
  `Total` Decimal(10,2) NOT NULL,
  `Customer_SK` Int,
  `Date_SK` Int,
  `Geography_SK` Int
)
;

CREATE INDEX `IX_Relationship20` ON `FactInvoice` (`Customer_SK`)
;

CREATE INDEX `IX_Relationship21` ON `FactInvoice` (`Date_SK`)
;

CREATE INDEX `IX_Relationship24` ON `FactInvoice` (`Geography_SK`)
;

ALTER TABLE `FactInvoice` ADD PRIMARY KEY (`InvoiceId`)
;

-- Table FactInvoiceLine

CREATE TABLE `FactInvoiceLine`
(
  `InvoiceLineId` Int NOT NULL,
  `InvoiceId` Int NOT NULL,
  `UnitPrice` Decimal(10,2) NOT NULL,
  `Quantity` Int NOT NULL,
  `Track_Sk` Int
)
;

CREATE INDEX `IFK_InvoiceLineInvoiceId` ON `FactInvoiceLine` (`InvoiceId`)
;

CREATE INDEX `IX_Relationship26` ON `FactInvoiceLine` (`Track_Sk`)
;

ALTER TABLE `FactInvoiceLine` ADD PRIMARY KEY (`InvoiceLineId`)
;

-- Table DimPlaylist

CREATE TABLE `DimPlaylist`
(
  `PlaylistId` Int NOT NULL,
  `Name` Varchar(120),
  `Playlist_Sk` Int NOT NULL
)
;

ALTER TABLE `DimPlaylist` ADD PRIMARY KEY (`Playlist_Sk`)
;

ALTER TABLE `DimPlaylist` ADD UNIQUE `PK_Playlist` (`PlaylistId`)
;

-- Table PlaylistTrack

CREATE TABLE `PlaylistTrack`
(
  `Track_SK` Int,
  `Playlist_SK` Int
)
;

CREATE INDEX `IFK_PlaylistTrackTrackId` ON `PlaylistTrack` ()
;

CREATE INDEX `IX_Relationship27` ON `PlaylistTrack` (`Track_SK`)
;

CREATE INDEX `IX_Relationship28` ON `PlaylistTrack` (`Playlist_SK`)
;

-- Table DimTrack

CREATE TABLE `DimTrack`
(
  `TrackId` Int NOT NULL,
  `Name` Varchar(200) NOT NULL,
  `Composer` Varchar(220),
  `Milliseconds` Int NOT NULL,
  `Bytes` Int,
  `UnitPrice` Decimal(10,2) NOT NULL,
  `MediaTypeId` Int NOT NULL,
  `GenreId` Int NOT NULL,
  `Track_Sk` Int NOT NULL,
  `Album_Sk` Int
)
;

CREATE INDEX `IX_Relationship29` ON `DimTrack` (`Album_Sk`)
;

ALTER TABLE `DimTrack` ADD PRIMARY KEY (`Track_Sk`)
;

ALTER TABLE `DimTrack` ADD UNIQUE `PK_Track` (`TrackId`)
;

-- Table DimGeography

CREATE TABLE `DimGeography`
(
  `GeographyId` Int NOT NULL,
  `Country` Text NOT NULL,
  `State` Text NOT NULL,
  `city` Text NOT NULL,
  `Zipcode` Text NOT NULL,
  `Address` Text NOT NULL,
  `Geography_SK` Int NOT NULL
)
;

ALTER TABLE `DimGeography` ADD PRIMARY KEY (`Geography_SK`)
;

ALTER TABLE `DimGeography` ADD UNIQUE `pk_geographyId` (`GeographyId`)
;

-- Table DimDate

CREATE TABLE `DimDate`
(
  `DateKey` Int NOT NULL,
  `MonthName` Text NOT NULL,
  `CalendarYear` Int NOT NULL,
  `Date_SK` Int NOT NULL,
  `DayOfMonth` Int NOT NULL,
  `DayOfTheWeek` Varchar(15) NOT NULL
)
;

ALTER TABLE `DimDate` ADD PRIMARY KEY (`Date_SK`)
;

ALTER TABLE `DimDate` ADD UNIQUE `pk_DateKey` (`DateKey`)
;

-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE `PlaylistTrack` ADD CONSTRAINT `FK_DimPlaylist_Playlist_SK` FOREIGN KEY (`Playlist_SK`) REFERENCES `DimPlaylist` (`Playlist_Sk`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


ALTER TABLE `DimTrack` ADD CONSTRAINT `FK_DimAlbum_Album_SK` FOREIGN KEY (`Album_Sk`) REFERENCES `DimAlbum` (`Album_SK`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


ALTER TABLE `FactInvoice` ADD CONSTRAINT `Relationship24` FOREIGN KEY (`Geography_SK`) REFERENCES `DimGeography` (`Geography_SK`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


ALTER TABLE `PlaylistTrack` ADD CONSTRAINT `FK_PlaylistTrack_Album_SK` FOREIGN KEY (`Track_SK`) REFERENCES `DimTrack` (`Track_Sk`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


ALTER TABLE `DimEmployee` ADD CONSTRAINT `fk_DimGeography_GeographyId` FOREIGN KEY (`GeographyId`) REFERENCES `DimGeography` (`GeographyId`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


ALTER TABLE `Customer` ADD CONSTRAINT `FK_DimDate_Date_SK` FOREIGN KEY (`Date_SK`) REFERENCES `DimDate` (`Date_SK`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


ALTER TABLE `FactInvoice` ADD CONSTRAINT `FK_DimDate_Date_SK1` FOREIGN KEY (`Date_SK`) REFERENCES `DimDate` (`Date_SK`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


ALTER TABLE `DimEmployee` ADD CONSTRAINT `FK_EmployeeReportsTo` FOREIGN KEY (`ReportsTo`) REFERENCES `DimEmployee` (`EmployeeId`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


ALTER TABLE `FactInvoiceLine` ADD CONSTRAINT `FK_InvoiceLine_InvoiceId` FOREIGN KEY (`InvoiceId`) REFERENCES `FactInvoice` (`InvoiceId`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


ALTER TABLE `FactInvoice` ADD CONSTRAINT `FK_Customer_Customer_SK` FOREIGN KEY (`Customer_SK`) REFERENCES `Customer` (`Customer_SK`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


ALTER TABLE `Customer` ADD CONSTRAINT `FK_DimEmployee_Employee_SK` FOREIGN KEY (`Employee_SK`) REFERENCES `DimEmployee` (`Employee_SK`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


ALTER TABLE `Customer` ADD CONSTRAINT `FK_DimGeography_Geography_SK` FOREIGN KEY (`Geography_SK`) REFERENCES `DimGeography` (`Geography_SK`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


ALTER TABLE `FactInvoiceLine` ADD CONSTRAINT `FK_DimTrack_Track_SK` FOREIGN KEY (`Track_Sk`) REFERENCES `DimTrack` (`Track_Sk`) ON DELETE NO ACTION ON UPDATE NO ACTION
;


