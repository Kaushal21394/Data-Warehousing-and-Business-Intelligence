/*
Created: 2/20/2018
Modified: 2/21/2018
Model: PostgreSQL 9.5
Database: PostgreSQL 9.5
*/


-- Create tables section -------------------------------------------------

-- Table dbo.DimArtist

CREATE TABLE "dbo"."DimArtist"(
 "ArtistId" Integer NOT NULL,
 "Name" Character varying(120)
)
;

-- Add keys for table dbo.DimArtist

ALTER TABLE "dbo"."DimArtist" ADD CONSTRAINT "PK_Artist" PRIMARY KEY ("ArtistId")
;

-- Table dbo.DimCustomer

CREATE TABLE "dbo"."DimCustomer"(
 "CustomerId" Integer NOT NULL,
 "FirstName" Character varying(40) NOT NULL,
 "LastName" Character varying(20) NOT NULL,
 "Company" Character varying(80),
 "Phone" Character varying(24),
 "Fax" Character varying(24),
 "Email" Character varying(60) NOT NULL
)
;

-- Add keys for table dbo.DimCustomer

ALTER TABLE "dbo"."DimCustomer" ADD CONSTRAINT "PK_Customer" PRIMARY KEY ("CustomerId")
;

-- Table dbo.FactSales

CREATE TABLE "dbo"."FactSales"(
 "InvoiceId" Integer NOT NULL,
 "CustomerId" Integer NOT NULL,
 "Total" Numeric(10,2) NOT NULL,
 "UnitPrice" Numeric(18,0),
 "Quantity" Integer,
 "GeographyId" Integer,
 "InvoiceDate" Integer,
 "SongsId" Integer,
 "PlaylistId" Integer
)
;

-- Create indexes for table dbo.FactSales

CREATE INDEX "IFK_InvoiceCustomerId" ON "dbo"."FactSales" ("CustomerId")
;

CREATE INDEX "IX_Relationship15" ON "dbo"."FactSales" ("GeographyId")
;

CREATE INDEX "IX_Relationship16" ON "dbo"."FactSales" ("InvoiceDate")
;

CREATE INDEX "IX_Relationship20" ON "dbo"."FactSales" ("SongsId")
;

CREATE INDEX "IX_Relationship21" ON "dbo"."FactSales" ("PlaylistId")
;

-- Add keys for table dbo.FactSales

ALTER TABLE "dbo"."FactSales" ADD CONSTRAINT "PK_Invoice" PRIMARY KEY ("InvoiceId")
;

-- Table dbo.DimPlaylist

CREATE TABLE "dbo"."DimPlaylist"(
 "PlaylistId" Integer NOT NULL,
 "Name" Character varying(120)
)
;

-- Add keys for table dbo.DimPlaylist

ALTER TABLE "dbo"."DimPlaylist" ADD CONSTRAINT "PK_Playlist" PRIMARY KEY ("PlaylistId")
;

-- Table dbo.DimSongs

CREATE TABLE "dbo"."DimSongs"(
 "SongsId" Integer NOT NULL,
 "Name" Character varying(200) NOT NULL,
 "AlbumId" Integer,
 "Composer" Character varying(220),
 "Milliseconds" Integer NOT NULL,
 "Bytes" Integer,
 "UnitPrice" Numeric(10,2) NOT NULL,
 "GenreName" Text,
 "MediaName" Text,
 "AlbumName" Text,
 "ArtistId" Integer,
 "ComposerId" Integer
)
;

-- Create indexes for table dbo.DimSongs

CREATE INDEX "IFK_TrackAlbumId" ON "dbo"."DimSongs" ("AlbumId")
;

CREATE INDEX "IX_Relationship18" ON "dbo"."DimSongs" ("ArtistId")
;

CREATE INDEX "IX_Relationship19" ON "dbo"."DimSongs" ("ComposerId")
;

-- Add keys for table dbo.DimSongs

ALTER TABLE "dbo"."DimSongs" ADD CONSTRAINT "PK_Track" PRIMARY KEY ("SongsId")
;

-- Table DimGeography

CREATE TABLE "dbo"."DimGeography"(
 "GeographyId" Integer NOT NULL,
 "Address" Text,
 "City" Text,
 "State" Text,
 "Country" Text,
 "ZipCode" Text
)
;

-- Add keys for table DimGeography

ALTER TABLE "dbo"."DimGeography" ADD CONSTRAINT "Key4" PRIMARY KEY ("GeographyId")
;

-- Table DimDate

CREATE TABLE "dbo"."DimDate"(
 "DateKey" Integer NOT NULL,
 "FullDateAlternateKey" Date,
 "EnglishMonthName" Text,
 "CalendarYear" Smallint,
 "DayNumberOfWeek" Smallint,
 "WeekNumberOfYear" Smallint,
 "MonthNumberOfYear" Smallint
)
;

-- Add keys for table DimDate

ALTER TABLE "dbo"."DimDate" ADD CONSTRAINT "Key5" PRIMARY KEY ("DateKey")
;

-- Table DimComposer

CREATE TABLE "dbo"."DimComposer"(
 "ComposerId" Integer NOT NULL,
 "ComposerName" Text
)
;

-- Add keys for table DimComposer

ALTER TABLE "dbo"."DimComposer" ADD CONSTRAINT "Key6" PRIMARY KEY ("ComposerId")
;
-- Create foreign keys (relationships) section ------------------------------------------------- 

ALTER TABLE "dbo"."FactSales" ADD CONSTRAINT "FK_Playlist" FOREIGN KEY ("PlaylistId") REFERENCES "dbo"."DimPlaylist" ("PlaylistId") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "dbo"."FactSales" ADD CONSTRAINT "FK_DimSongs" FOREIGN KEY ("SongsId") REFERENCES "dbo"."DimSongs" ("SongsId") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "dbo"."DimSongs" ADD CONSTRAINT "FK_DimComposer" FOREIGN KEY ("ComposerId") REFERENCES "dbo"."DimComposer" ("ComposerId") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "dbo"."DimSongs" ADD CONSTRAINT "FK_DimArtist" FOREIGN KEY ("ArtistId") REFERENCES "dbo"."DimArtist" ("ArtistId") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "dbo"."FactSales" ADD CONSTRAINT "FK_DimGeography" FOREIGN KEY ("GeographyId") REFERENCES "dbo"."DimGeography" ("GeographyId") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "dbo"."FactSales" ADD CONSTRAINT "FK_InvoiceCustomerId" FOREIGN KEY ("CustomerId") REFERENCES "dbo"."DimCustomer" ("CustomerId") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "dbo"."FactSales" ADD CONSTRAINT "FK_DimDate" FOREIGN KEY ("InvoiceDate") REFERENCES "dbo"."DimDate" ("DateKey") ON DELETE NO ACTION ON UPDATE NO ACTION
;




