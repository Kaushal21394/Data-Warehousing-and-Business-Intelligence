/*
Created: 1/26/2018
Modified: 1/26/2018
Model: Oracle 11g Release 2
Database: Oracle 11g Release 2
*/




-- Create tables section -------------------------------------------------

-- Table DimAlbum

CREATE TABLE "DimAlbum"(
  "AlbumId" Integer NOT NULL,
  "Title" NVarchar2(160) NOT NULL,
  "ArtistId" Integer NOT NULL,
  "Album_SK" Integer NOT NULL
)
/

-- Add keys for table DimAlbum

ALTER TABLE "DimAlbum" ADD CONSTRAINT "Album_Sk" PRIMARY KEY ("Album_SK")
/

ALTER TABLE "DimAlbum" ADD CONSTRAINT "PK_Album" UNIQUE ("AlbumId")
/

-- Table Customer

CREATE TABLE "Customer"(
  "CustomerId" Integer NOT NULL,
  "FirstName" NVarchar2(40) NOT NULL,
  "LastName" NVarchar2(20) NOT NULL,
  "Company" NVarchar2(80),
  "Phone" NVarchar2(24),
  "Fax" NVarchar2(24),
  "Email" NVarchar2(60) NOT NULL,
  "Customer_SK" Integer NOT NULL,
  "Date_SK" Integer,
  "Employee_SK" Integer,
  "Geography_SK" Integer
)
/

-- Create indexes for table Customer

CREATE INDEX "IX_Relationship22" ON "Customer" ("Date_SK")
/

CREATE INDEX "IX_Relationship23" ON "Customer" ("Employee_SK")
/

CREATE INDEX "IX_Relationship25" ON "Customer" ("Geography_SK")
/

-- Add keys for table Customer

ALTER TABLE "Customer" ADD CONSTRAINT "Customer_Sk" PRIMARY KEY ("Customer_SK")
/

ALTER TABLE "Customer" ADD CONSTRAINT "PK_Customer" UNIQUE ("CustomerId")
/

-- Table DimEmployee

CREATE TABLE "DimEmployee"(
  "EmployeeId" Integer NOT NULL,
  "LastName" NVarchar2(20) NOT NULL,
  "FirstName" NVarchar2(20) NOT NULL,
  "Title" NVarchar2(30),
  "ReportsTo" Integer,
  "Phone" NVarchar2(24),
  "Fax" NVarchar2(24),
  "Email" NVarchar2(60),
  "GeographyId" Integer,
  "Employee_SK" Integer NOT NULL
)
/

-- Create indexes for table DimEmployee

CREATE INDEX "IFK_EmployeeReportsTo" ON "DimEmployee" ("ReportsTo")
/

CREATE INDEX "IX_Relationship15" ON "DimEmployee" ("GeographyId")
/

-- Add keys for table DimEmployee

ALTER TABLE "DimEmployee" ADD CONSTRAINT "Employee_Sk" PRIMARY KEY ("Employee_SK")
/

ALTER TABLE "DimEmployee" ADD CONSTRAINT "PK_Employee" UNIQUE ("EmployeeId")
/

-- Table FactInvoice

CREATE TABLE "FactInvoice"(
  "InvoiceId" Integer NOT NULL,
  "Total" Number(10,2) NOT NULL,
  "Customer_SK" Integer,
  "Date_SK" Integer,
  "Geography_SK" Integer
)
/

-- Create indexes for table FactInvoice

CREATE INDEX "IX_Relationship20" ON "FactInvoice" ("Customer_SK")
/

CREATE INDEX "IX_Relationship21" ON "FactInvoice" ("Date_SK")
/

CREATE INDEX "IX_Relationship24" ON "FactInvoice" ("Geography_SK")
/

-- Add keys for table FactInvoice

ALTER TABLE "FactInvoice" ADD CONSTRAINT "PK_Invoice" PRIMARY KEY ("InvoiceId")
/

-- Table FactInvoiceLine

CREATE TABLE "FactInvoiceLine"(
  "InvoiceLineId" Integer NOT NULL,
  "InvoiceId" Integer NOT NULL,
  "UnitPrice" Number(10,2) NOT NULL,
  "Quantity" Integer NOT NULL,
  "Track_Sk" Integer
)
/

-- Create indexes for table FactInvoiceLine

CREATE INDEX "IFK_InvoiceLineInvoiceId" ON "FactInvoiceLine" ("InvoiceId")
/

CREATE INDEX "IX_Relationship26" ON "FactInvoiceLine" ("Track_Sk")
/

-- Add keys for table FactInvoiceLine

ALTER TABLE "FactInvoiceLine" ADD CONSTRAINT "PK_InvoiceLine" PRIMARY KEY ("InvoiceLineId")
/

-- Table DimPlaylist

CREATE TABLE "DimPlaylist"(
  "PlaylistId" Integer NOT NULL,
  "Name" NVarchar2(120),
  "Playlist_Sk" Integer NOT NULL
)
/

-- Add keys for table DimPlaylist

ALTER TABLE "DimPlaylist" ADD CONSTRAINT "Playlist_SK" PRIMARY KEY ("Playlist_Sk")
/

ALTER TABLE "DimPlaylist" ADD CONSTRAINT "PK_Playlist" UNIQUE ("PlaylistId")
/

-- Table PlaylistTrack

CREATE TABLE "PlaylistTrack"(
  "Track_SK" Integer,
  "Playlist_SK" Integer
)
/

-- Create indexes for table PlaylistTrack

CREATE INDEX "IFK_PlaylistTrackTrackId" ON "PlaylistTrack" ()
/

CREATE INDEX "IX_Relationship27" ON "PlaylistTrack" ("Track_SK")
/

CREATE INDEX "IX_Relationship28" ON "PlaylistTrack" ("Playlist_SK")
/

-- Table DimTrack

CREATE TABLE "DimTrack"(
  "TrackId" Integer NOT NULL,
  "Name" NVarchar2(200) NOT NULL,
  "Composer" NVarchar2(220),
  "Milliseconds" Integer NOT NULL,
  "Bytes" Integer,
  "UnitPrice" Number(10,2) NOT NULL,
  "MediaTypeId" Integer NOT NULL,
  "GenreId" Integer NOT NULL,
  "Track_Sk" Integer NOT NULL,
  "Album_Sk" Integer
)
/

-- Create indexes for table DimTrack

CREATE INDEX "IX_Relationship29" ON "DimTrack" ("Album_Sk")
/

-- Add keys for table DimTrack

ALTER TABLE "DimTrack" ADD CONSTRAINT "Track_Sk" PRIMARY KEY ("Track_Sk")
/

ALTER TABLE "DimTrack" ADD CONSTRAINT "PK_Track" UNIQUE ("TrackId")
/

-- Table DimGeography

CREATE TABLE "DimGeography"(
  "GeographyId" Integer NOT NULL,
  "Country" NClob NOT NULL,
  "State" NClob NOT NULL,
  "city" NClob NOT NULL,
  "Zipcode" NClob NOT NULL,
  "Address" NClob NOT NULL,
  "Geography_SK" Integer NOT NULL
)
/

-- Add keys for table DimGeography

ALTER TABLE "DimGeography" ADD CONSTRAINT "Geography_Sk" PRIMARY KEY ("Geography_SK")
/

ALTER TABLE "DimGeography" ADD CONSTRAINT "pk_geographyId" UNIQUE ("GeographyId")
/

-- Table DimDate

CREATE TABLE "DimDate"(
  "DateKey" Integer NOT NULL,
  "MonthName" NClob NOT NULL,
  "CalendarYear" Integer NOT NULL,
  "Date_SK" Integer NOT NULL,
  "DayOfMonth" Integer NOT NULL,
  "DayOfTheWeek" NVarchar2(15) NOT NULL
)
/

-- Add keys for table DimDate

ALTER TABLE "DimDate" ADD CONSTRAINT "Date_Sk" PRIMARY KEY ("Date_SK")
/

ALTER TABLE "DimDate" ADD CONSTRAINT "pk_DateKey" UNIQUE ("DateKey")
/


-- Create foreign keys (relationships) section ------------------------------------------------- 

ALTER TABLE "PlaylistTrack" ADD CONSTRAINT "FK_DimPlaylist_Playlist_SK" FOREIGN KEY ("Playlist_SK") REFERENCES "DimPlaylist" ("Playlist_Sk")
/


ALTER TABLE "DimTrack" ADD CONSTRAINT "FK_DimAlbum_Album_SK" FOREIGN KEY ("Album_Sk") REFERENCES "DimAlbum" ("Album_SK")
/


ALTER TABLE "FactInvoice" ADD CONSTRAINT "Relationship24" FOREIGN KEY ("Geography_SK") REFERENCES "DimGeography" ("Geography_SK")
/


ALTER TABLE "PlaylistTrack" ADD CONSTRAINT "FK_PlaylistTrack_Album_SK" FOREIGN KEY ("Track_SK") REFERENCES "DimTrack" ("Track_Sk")
/


ALTER TABLE "DimEmployee" ADD CONSTRAINT "fk_DimGeography_GeographyId" FOREIGN KEY ("GeographyId") REFERENCES "DimGeography" ("GeographyId")
/


ALTER TABLE "Customer" ADD CONSTRAINT "FK_DimDate_Date_SK" FOREIGN KEY ("Date_SK") REFERENCES "DimDate" ("Date_SK")
/


ALTER TABLE "FactInvoice" ADD CONSTRAINT "FK_DimDate_Date_SK1" FOREIGN KEY ("Date_SK") REFERENCES "DimDate" ("Date_SK")
/


ALTER TABLE "DimEmployee" ADD CONSTRAINT "FK_EmployeeReportsTo" FOREIGN KEY ("ReportsTo") REFERENCES "DimEmployee" ("EmployeeId")
/


ALTER TABLE "FactInvoiceLine" ADD CONSTRAINT "FK_InvoiceLine_InvoiceId" FOREIGN KEY ("InvoiceId") REFERENCES "FactInvoice" ("InvoiceId")
/


ALTER TABLE "FactInvoice" ADD CONSTRAINT "FK_Customer_Customer_SK" FOREIGN KEY ("Customer_SK") REFERENCES "Customer" ("Customer_SK")
/


ALTER TABLE "Customer" ADD CONSTRAINT "FK_DimEmployee_Employee_SK" FOREIGN KEY ("Employee_SK") REFERENCES "DimEmployee" ("Employee_SK")
/


ALTER TABLE "Customer" ADD CONSTRAINT "FK_DimGeography_Geography_SK" FOREIGN KEY ("Geography_SK") REFERENCES "DimGeography" ("Geography_SK")
/


ALTER TABLE "FactInvoiceLine" ADD CONSTRAINT "FK_DimTrack_Track_SK" FOREIGN KEY ("Track_Sk") REFERENCES "DimTrack" ("Track_Sk")
/







