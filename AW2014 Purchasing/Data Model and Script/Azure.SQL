/*
Created: 1/26/2018
Modified: 1/26/2018
Model: Microsoft Azure SQL Database V12
Database: MS Azure SQL Database V12
*/



-- Create tables section -------------------------------------------------

-- Table dbo.DimAlbum

CREATE TABLE [dbo].[DimAlbum]
(
 [AlbumId] Int NOT NULL,
 [Title] Nvarchar(160) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [ArtistId] Int NOT NULL,
 [Album_SK] Int NOT NULL
)
go

-- Add keys for table dbo.DimAlbum

ALTER TABLE [dbo].[DimAlbum] ADD CONSTRAINT [Album_Sk] PRIMARY KEY ([Album_SK])
go

ALTER TABLE [dbo].[DimAlbum] ADD CONSTRAINT [PK_Album] UNIQUE CLUSTERED ([AlbumId])
go

-- Table dbo.Customer

CREATE TABLE [dbo].[Customer]
(
 [CustomerId] Int NOT NULL,
 [FirstName] Nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [LastName] Nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [Company] Nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [Phone] Nvarchar(24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [Fax] Nvarchar(24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [Email] Nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [Customer_SK] Int NOT NULL,
 [Date_SK] Int NULL,
 [Employee_SK] Int NULL,
 [Geography_SK] Int NULL
)
go

-- Create indexes for table dbo.Customer

CREATE INDEX [IX_Relationship22] ON [dbo].[Customer] ([Date_SK])
go

CREATE INDEX [IX_Relationship23] ON [dbo].[Customer] ([Employee_SK])
go

CREATE INDEX [IX_Relationship25] ON [dbo].[Customer] ([Geography_SK])
go

-- Add keys for table dbo.Customer

ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [Customer_Sk] PRIMARY KEY ([Customer_SK])
go

ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [PK_Customer] UNIQUE CLUSTERED ([CustomerId])
go

-- Table dbo.DimEmployee

CREATE TABLE [dbo].[DimEmployee]
(
 [EmployeeId] Int NOT NULL,
 [LastName] Nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [FirstName] Nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [Title] Nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [ReportsTo] Int NULL,
 [Phone] Nvarchar(24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [Fax] Nvarchar(24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [Email] Nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [GeographyId] Int NULL,
 [Employee_SK] Int NOT NULL
)
go

-- Create indexes for table dbo.DimEmployee

CREATE INDEX [IFK_EmployeeReportsTo] ON [dbo].[DimEmployee] ([ReportsTo])
go

CREATE INDEX [IX_Relationship15] ON [dbo].[DimEmployee] ([GeographyId])
go

-- Add keys for table dbo.DimEmployee

ALTER TABLE [dbo].[DimEmployee] ADD CONSTRAINT [Employee_Sk] PRIMARY KEY ([Employee_SK])
go

ALTER TABLE [dbo].[DimEmployee] ADD CONSTRAINT [PK_Employee] UNIQUE CLUSTERED ([EmployeeId])
go

-- Table dbo.FactInvoice

CREATE TABLE [dbo].[FactInvoice]
(
 [InvoiceId] Int NOT NULL,
 [Total] Numeric(10,2) NOT NULL,
 [Customer_SK] Int NULL,
 [Date_SK] Int NULL,
 [Geography_SK] Int NULL
)
go

-- Create indexes for table dbo.FactInvoice

CREATE INDEX [IX_Relationship20] ON [dbo].[FactInvoice] ([Customer_SK])
go

CREATE INDEX [IX_Relationship21] ON [dbo].[FactInvoice] ([Date_SK])
go

CREATE INDEX [IX_Relationship24] ON [dbo].[FactInvoice] ([Geography_SK])
go

-- Add keys for table dbo.FactInvoice

ALTER TABLE [dbo].[FactInvoice] ADD CONSTRAINT [PK_Invoice] PRIMARY KEY ([InvoiceId])
go

-- Table dbo.FactInvoiceLine

CREATE TABLE [dbo].[FactInvoiceLine]
(
 [InvoiceLineId] Int NOT NULL,
 [InvoiceId] Int NOT NULL,
 [UnitPrice] Numeric(10,2) NOT NULL,
 [Quantity] Int NOT NULL,
 [Track_Sk] Int NULL
)
go

-- Create indexes for table dbo.FactInvoiceLine

CREATE INDEX [IFK_InvoiceLineInvoiceId] ON [dbo].[FactInvoiceLine] ([InvoiceId])
go

CREATE INDEX [IX_Relationship26] ON [dbo].[FactInvoiceLine] ([Track_Sk])
go

-- Add keys for table dbo.FactInvoiceLine

ALTER TABLE [dbo].[FactInvoiceLine] ADD CONSTRAINT [PK_InvoiceLine] PRIMARY KEY ([InvoiceLineId])
go

-- Table dbo.DimPlaylist

CREATE TABLE [dbo].[DimPlaylist]
(
 [PlaylistId] Int NOT NULL,
 [Name] Nvarchar(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [Playlist_Sk] Int NOT NULL
)
go

-- Add keys for table dbo.DimPlaylist

ALTER TABLE [dbo].[DimPlaylist] ADD CONSTRAINT [Playlist_SK] PRIMARY KEY ([Playlist_Sk])
go

ALTER TABLE [dbo].[DimPlaylist] ADD CONSTRAINT [PK_Playlist] UNIQUE CLUSTERED ([PlaylistId])
go

-- Table dbo.PlaylistTrack

CREATE TABLE [dbo].[PlaylistTrack]
(
 [Track_SK] Int NULL,
 [Playlist_SK] Int NULL
)
go

-- Create indexes for table dbo.PlaylistTrack


go

CREATE INDEX [IX_Relationship27] ON [dbo].[PlaylistTrack] ([Track_SK])
go

CREATE INDEX [IX_Relationship28] ON [dbo].[PlaylistTrack] ([Playlist_SK])
go

-- Table dbo.DimTrack

CREATE TABLE [dbo].[DimTrack]
(
 [TrackId] Int NOT NULL,
 [Name] Nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [Composer] Nvarchar(220) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [Milliseconds] Int NOT NULL,
 [Bytes] Int NULL,
 [UnitPrice] Numeric(10,2) NOT NULL,
 [MediaTypeId] Int NOT NULL,
 [GenreId] Int NOT NULL,
 [Track_Sk] Int NOT NULL,
 [Album_Sk] Int NULL
)
go

-- Create indexes for table dbo.DimTrack

CREATE INDEX [IX_Relationship29] ON [dbo].[DimTrack] ([Album_Sk])
go

-- Add keys for table dbo.DimTrack

ALTER TABLE [dbo].[DimTrack] ADD CONSTRAINT [Track_Sk] PRIMARY KEY ([Track_Sk])
go

ALTER TABLE [dbo].[DimTrack] ADD CONSTRAINT [PK_Track] UNIQUE CLUSTERED ([TrackId])
go

-- Table DimGeography

CREATE TABLE [DimGeography]
(
 [GeographyId] Int NOT NULL,
 [Country] Nvarchar(max) NOT NULL,
 [State] Nvarchar(max) NOT NULL,
 [city] Nvarchar(max) NOT NULL,
 [Zipcode] Nvarchar(max) NOT NULL,
 [Address] Nvarchar(max) NOT NULL,
 [Geography_SK] Int NOT NULL
)
go

-- Add keys for table DimGeography

ALTER TABLE [DimGeography] ADD CONSTRAINT [Geography_Sk] PRIMARY KEY ([Geography_SK])
go

ALTER TABLE [DimGeography] ADD CONSTRAINT [pk_geographyId] UNIQUE CLUSTERED ([GeographyId])
go

-- Table DimDate

CREATE TABLE [DimDate]
(
 [DateKey] Int NOT NULL,
 [MonthName] Nvarchar(max) NOT NULL,
 [CalendarYear] Int NOT NULL,
 [Date_SK] Int NOT NULL,
 [DayOfMonth] Int NOT NULL,
 [DayOfTheWeek] Nvarchar(15) NOT NULL
)
go

-- Add keys for table DimDate

ALTER TABLE [DimDate] ADD CONSTRAINT [Date_Sk] PRIMARY KEY ([Date_SK])
go

ALTER TABLE [DimDate] ADD CONSTRAINT [pk_DateKey] UNIQUE CLUSTERED ([DateKey])
go

-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE [dbo].[PlaylistTrack] ADD CONSTRAINT [FK_DimPlaylist_Playlist_SK] FOREIGN KEY ([Playlist_SK]) REFERENCES [dbo].[DimPlaylist] ([Playlist_Sk]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [dbo].[DimTrack] ADD CONSTRAINT [FK_DimAlbum_Album_SK] FOREIGN KEY ([Album_Sk]) REFERENCES [dbo].[DimAlbum] ([Album_SK]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [dbo].[FactInvoice] ADD CONSTRAINT [Relationship24] FOREIGN KEY ([Geography_SK]) REFERENCES [DimGeography] ([Geography_SK]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [dbo].[PlaylistTrack] ADD CONSTRAINT [FK_PlaylistTrack_Album_SK] FOREIGN KEY ([Track_SK]) REFERENCES [dbo].[DimTrack] ([Track_Sk]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [dbo].[DimEmployee] ADD CONSTRAINT [fk_DimGeography_GeographyId] FOREIGN KEY ([GeographyId]) REFERENCES [DimGeography] ([GeographyId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [FK_DimDate_Date_SK] FOREIGN KEY ([Date_SK]) REFERENCES [DimDate] ([Date_SK]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [dbo].[FactInvoice] ADD CONSTRAINT [FK_DimDate_Date_SK1] FOREIGN KEY ([Date_SK]) REFERENCES [DimDate] ([Date_SK]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [dbo].[DimEmployee] ADD CONSTRAINT [FK_EmployeeReportsTo] FOREIGN KEY ([ReportsTo]) REFERENCES [dbo].[DimEmployee] ([EmployeeId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [dbo].[FactInvoiceLine] ADD CONSTRAINT [FK_InvoiceLine_InvoiceId] FOREIGN KEY ([InvoiceId]) REFERENCES [dbo].[FactInvoice] ([InvoiceId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [dbo].[FactInvoice] ADD CONSTRAINT [FK_Customer_Customer_SK] FOREIGN KEY ([Customer_SK]) REFERENCES [dbo].[Customer] ([Customer_SK]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [FK_DimEmployee_Employee_SK] FOREIGN KEY ([Employee_SK]) REFERENCES [dbo].[DimEmployee] ([Employee_SK]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [FK_DimGeography_Geography_SK] FOREIGN KEY ([Geography_SK]) REFERENCES [DimGeography] ([Geography_SK]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [dbo].[FactInvoiceLine] ADD CONSTRAINT [FK_DimTrack_Track_SK] FOREIGN KEY ([Track_Sk]) REFERENCES [dbo].[DimTrack] ([Track_Sk]) ON UPDATE NO ACTION ON DELETE NO ACTION
go






