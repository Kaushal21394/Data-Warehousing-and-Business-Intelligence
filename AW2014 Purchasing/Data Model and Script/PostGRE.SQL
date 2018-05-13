/*
Created: 1/26/2018
Modified: 1/26/2018
Model: PostgreSQL 9.5
Database: PostgreSQL 9.5
*/


-- Create tables section -------------------------------------------------

-- Table dbo.DimAlbum

CREATE TABLE "dbo"."DimAlbum"(
 "AlbumId" Integer NOT NULL,
 "Title" Character varying(160) NOT NULL,
 "ArtistId" Integer NOT NULL,
 "Album_SK" Integer NOT NULL
)
;

-- Add keys for table dbo.DimAlbum

ALTER TABLE "dbo"."DimAlbum" ADD CONSTRAINT "Album_Sk" PRIMARY KEY ("Album_SK")
;

ALTER TABLE "dbo"."DimAlbum" ADD CONSTRAINT "PK_Album" UNIQUE ("AlbumId")
;

-- Table dbo.Customer

CREATE TABLE "dbo"."Customer"(
 "CustomerId" Integer NOT NULL,
 "FirstName" Character varying(40) NOT NULL,
 "LastName" Character varying(20) NOT NULL,
 "Company" Character varying(80),
 "Phone" Character varying(24),
 "Fax" Character varying(24),
 "Email" Character varying(60) NOT NULL,
 "Customer_SK" Integer NOT NULL,
 "Date_SK" Integer,
 "Employee_SK" Integer,
 "Geography_SK" Integer
)
;

-- Create indexes for table dbo.Customer

CREATE INDEX "IX_Relationship22" ON "dbo"."Customer" ("Date_SK")
;

CREATE INDEX "IX_Relationship23" ON "dbo"."Customer" ("Employee_SK")
;

CREATE INDEX "IX_Relationship25" ON "dbo"."Customer" ("Geography_SK")
;

-- Add keys for table dbo.Customer

ALTER TABLE "dbo"."Customer" ADD CONSTRAINT "Customer_Sk" PRIMARY KEY ("Customer_SK")
;

ALTER TABLE "dbo"."Customer" ADD CONSTRAINT "PK_Customer" UNIQUE ("CustomerId")
;

-- Table dbo.DimEmployee

CREATE TABLE "dbo"."DimEmployee"(
 "EmployeeId" Integer NOT NULL,
 "LastName" Character varying(20) NOT NULL,
 "FirstName" Character varying(20) NOT NULL,
 "Title" Character varying(30),
 "ReportsTo" Integer,
 "Phone" Character varying(24),
 "Fax" Character varying(24),
 "Email" Character varying(60),
 "GeographyId" Integer,
 "Employee_SK" Integer NOT NULL
)
;

-- Create indexes for table dbo.DimEmployee

CREATE INDEX "IFK_EmployeeReportsTo" ON "dbo"."DimEmployee" ("ReportsTo")
;

CREATE INDEX "IX_Relationship15" ON "dbo"."DimEmployee" ("GeographyId")
;

-- Add keys for table dbo.DimEmployee

ALTER TABLE "dbo"."DimEmployee" ADD CONSTRAINT "Employee_Sk" PRIMARY KEY ("Employee_SK")
;

ALTER TABLE "dbo"."DimEmployee" ADD CONSTRAINT "PK_Employee" UNIQUE ("EmployeeId")
;

-- Table dbo.FactInvoice

CREATE TABLE "dbo"."FactInvoice"(
 "InvoiceId" Integer NOT NULL,
 "Total" Numeric(10,2) NOT NULL,
 "Customer_SK" Integer,
 "Date_SK" Integer,
 "Geography_SK" Integer
)
;

-- Create indexes for table dbo.FactInvoice

CREATE INDEX "IX_Relationship20" ON "dbo"."FactInvoice" ("Customer_SK")
;

CREATE INDEX "IX_Relationship21" ON "dbo"."FactInvoice" ("Date_SK")
;

CREATE INDEX "IX_Relationship24" ON "dbo"."FactInvoice" ("Geography_SK")
;

-- Add keys for table dbo.FactInvoice

ALTER TABLE "dbo"."FactInvoice" ADD CONSTRAINT "PK_Invoice" PRIMARY KEY ("InvoiceId")
;

-- Table dbo.FactInvoiceLine

CREATE TABLE "dbo"."FactInvoiceLine"(
 "InvoiceLineId" Integer NOT NULL,
 "InvoiceId" Integer NOT NULL,
 "UnitPrice" Numeric(10,2) NOT NULL,
 "Quantity" Integer NOT NULL,
 "Track_Sk" Integer
)
;

-- Create indexes for table dbo.FactInvoiceLine

CREATE INDEX "IFK_InvoiceLineInvoiceId" ON "dbo"."FactInvoiceLine" ("InvoiceId")
;

CREATE INDEX "IX_Relationship26" ON "dbo"."FactInvoiceLine" ("Track_Sk")
;

-- Add keys for table dbo.FactInvoiceLine

ALTER TABLE "dbo"."FactInvoiceLine" ADD CONSTRAINT "PK_InvoiceLine" PRIMARY KEY ("InvoiceLineId")
;

-- Table dbo.DimPlaylist

CREATE TABLE "dbo"."DimPlaylist"(
 "PlaylistId" Integer NOT NULL,
 "Name" Character varying(120),
 "Playlist_Sk" Integer NOT NULL
)
;

-- Add keys for table dbo.DimPlaylist

ALTER TABLE "dbo"."DimPlaylist" ADD CONSTRAINT "Playlist_SK" PRIMARY KEY ("Playlist_Sk")
;

ALTER TABLE "dbo"."DimPlaylist" ADD CONSTRAINT "PK_Playlist" UNIQUE ("PlaylistId")
;

-- Table dbo.PlaylistTrack

CREATE TABLE "dbo"."PlaylistTrack"(
 "Track_SK" Integer,
 "Playlist_SK" Integer
)
;

-- Create indexes for table dbo.PlaylistTrack

CREATE INDEX "IFK_PlaylistTrackTrackId" ON "dbo"."PlaylistTrack" ()
;

CREATE INDEX "IX_Relationship27" ON "dbo"."PlaylistTrack" ("Track_SK")
;

CREATE INDEX "IX_Relationship28" ON "dbo"."PlaylistTrack" ("Playlist_SK")
;

-- Table dbo.DimTrack

CREATE TABLE "dbo"."DimTrack"(
 "TrackId" Integer NOT NULL,
 "Name" Character varying(200) NOT NULL,
 "Composer" Character varying(220),
 "Milliseconds" Integer NOT NULL,
 "Bytes" Integer,
 "UnitPrice" Numeric(10,2) NOT NULL,
 "MediaTypeId" Integer NOT NULL,
 "GenreId" Integer NOT NULL,
 "Track_Sk" Integer NOT NULL,
 "Album_Sk" Integer
)
;

-- Create indexes for table dbo.DimTrack

CREATE INDEX "IX_Relationship29" ON "dbo"."DimTrack" ("Album_Sk")
;

-- Add keys for table dbo.DimTrack

ALTER TABLE "dbo"."DimTrack" ADD CONSTRAINT "Track_Sk" PRIMARY KEY ("Track_Sk")
;

ALTER TABLE "dbo"."DimTrack" ADD CONSTRAINT "PK_Track" UNIQUE ("TrackId")
;

-- Table DimGeography

CREATE TABLE "DimGeography"(
 "GeographyId" Integer NOT NULL,
 "Country" Text NOT NULL,
 "State" Text NOT NULL,
 "city" Text NOT NULL,
 "Zipcode" Text NOT NULL,
 "Address" Text NOT NULL,
 "Geography_SK" Integer NOT NULL
)
;

-- Add keys for table DimGeography

ALTER TABLE "DimGeography" ADD CONSTRAINT "Geography_Sk" PRIMARY KEY ("Geography_SK")
;

ALTER TABLE "DimGeography" ADD CONSTRAINT "pk_geographyId" UNIQUE ("GeographyId")
;

-- Table DimDate

CREATE TABLE "DimDate"(
 "DateKey" Integer NOT NULL,
 "MonthName" Text NOT NULL,
 "CalendarYear" Integer NOT NULL,
 "Date_SK" Integer NOT NULL,
 "DayOfMonth" Integer NOT NULL,
 "DayOfTheWeek" Character varying(15) NOT NULL
)
;

-- Add keys for table DimDate

ALTER TABLE "DimDate" ADD CONSTRAINT "Date_Sk" PRIMARY KEY ("Date_SK")
;

ALTER TABLE "DimDate" ADD CONSTRAINT "pk_DateKey" UNIQUE ("DateKey")
;
-- Create foreign keys (relationships) section ------------------------------------------------- 

ALTER TABLE "dbo"."PlaylistTrack" ADD CONSTRAINT "FK_DimPlaylist_Playlist_SK" FOREIGN KEY ("Playlist_SK") REFERENCES "dbo"."DimPlaylist" ("Playlist_Sk") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "dbo"."DimTrack" ADD CONSTRAINT "FK_DimAlbum_Album_SK" FOREIGN KEY ("Album_Sk") REFERENCES "dbo"."DimAlbum" ("Album_SK") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "dbo"."FactInvoice" ADD CONSTRAINT "Relationship24" FOREIGN KEY ("Geography_SK") REFERENCES "DimGeography" ("Geography_SK") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "dbo"."PlaylistTrack" ADD CONSTRAINT "FK_PlaylistTrack_Album_SK" FOREIGN KEY ("Track_SK") REFERENCES "dbo"."DimTrack" ("Track_Sk") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "dbo"."DimEmployee" ADD CONSTRAINT "fk_DimGeography_GeographyId" FOREIGN KEY ("GeographyId") REFERENCES "DimGeography" ("GeographyId") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "dbo"."Customer" ADD CONSTRAINT "FK_DimDate_Date_SK" FOREIGN KEY ("Date_SK") REFERENCES "DimDate" ("Date_SK") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "dbo"."FactInvoice" ADD CONSTRAINT "FK_DimDate_Date_SK1" FOREIGN KEY ("Date_SK") REFERENCES "DimDate" ("Date_SK") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "dbo"."DimEmployee" ADD CONSTRAINT "FK_EmployeeReportsTo" FOREIGN KEY ("ReportsTo") REFERENCES "dbo"."DimEmployee" ("EmployeeId") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "dbo"."FactInvoiceLine" ADD CONSTRAINT "FK_InvoiceLine_InvoiceId" FOREIGN KEY ("InvoiceId") REFERENCES "dbo"."FactInvoice" ("InvoiceId") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "dbo"."FactInvoice" ADD CONSTRAINT "FK_Customer_Customer_SK" FOREIGN KEY ("Customer_SK") REFERENCES "dbo"."Customer" ("Customer_SK") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "dbo"."Customer" ADD CONSTRAINT "FK_DimEmployee_Employee_SK" FOREIGN KEY ("Employee_SK") REFERENCES "dbo"."DimEmployee" ("Employee_SK") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "dbo"."Customer" ADD CONSTRAINT "FK_DimGeography_Geography_SK" FOREIGN KEY ("Geography_SK") REFERENCES "DimGeography" ("Geography_SK") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "dbo"."FactInvoiceLine" ADD CONSTRAINT "FK_DimTrack_Track_SK" FOREIGN KEY ("Track_Sk") REFERENCES "dbo"."DimTrack" ("Track_Sk") ON DELETE NO ACTION ON UPDATE NO ACTION
;




