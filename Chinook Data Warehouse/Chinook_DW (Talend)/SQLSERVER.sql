/*
Created: 2/21/2018
Modified: 2/21/2018
Model: Microsoft SQL Server 2016
Database: MS SQL Server 2016
*/


-- Create tables section -------------------------------------------------

-- Table dbo.DimArtist

CREATE TABLE [dbo].[DimArtist]
(
 [ArtistId] Int NOT NULL,
 [Name] nvarchar(120) NULL
)
go

-- Add keys for table dbo.DimArtist

ALTER TABLE [dbo].[DimArtist] ADD CONSTRAINT [PK_Artist] PRIMARY KEY ([ArtistId])
go

-- Table dbo.DimCustomer

CREATE TABLE [dbo].[DimCustomer]
(
 [CustomerId] Int NOT NULL,
 [FirstName] nvarchar(40) NOT NULL,
 [LastName] nvarchar(20) NOT NULL,
 [Company] nvarchar(80) NULL,
 [Phone] nvarchar(24) NULL,
 [Fax] nvarchar(24) NULL,
 [Email] nvarchar(60) NOT NULL
)
go

-- Add keys for table dbo.DimCustomer

ALTER TABLE [dbo].[DimCustomer] ADD CONSTRAINT [PK_Customer] PRIMARY KEY ([CustomerId])
go

-- Table dbo.FactSales

CREATE TABLE [dbo].[FactSales]
(
 [InvoiceId] Int NOT NULL,
 [CustomerId] Int NOT NULL,
 [Total] Decimal(10,2) NOT NULL,
 [UnitPrice] Decimal(10,2) NULL,
 [Quantity] Int NULL,
 [GeographyId] Int NULL,
 [InvoiceDate] Int NULL,
 [SongsId] Int NULL,
 [PlaylistId] Int NULL
)
go

-- Create indexes for table dbo.FactSales

CREATE INDEX [IFK_InvoiceCustomerId] ON [dbo].[FactSales] ([CustomerId])
go

CREATE INDEX [IX_Relationship15] ON [dbo].[FactSales] ([GeographyId])
go

CREATE INDEX [IX_Relationship16] ON [dbo].[FactSales] ([InvoiceDate])
go

CREATE INDEX [IX_Relationship20] ON [dbo].[FactSales] ([SongsId])
go

CREATE INDEX [IX_Relationship21] ON [dbo].[FactSales] ([PlaylistId])
go

-- Add keys for table dbo.FactSales

ALTER TABLE [dbo].[FactSales] ADD CONSTRAINT [PK_Invoice] PRIMARY KEY ([InvoiceId])
go

-- Table dbo.DimPlaylist

CREATE TABLE [dbo].[DimPlaylist]
(
 [PlaylistId] Int NOT NULL,
 [Name] nvarchar(120) NULL
)
go

-- Add keys for table dbo.DimPlaylist

ALTER TABLE [dbo].[DimPlaylist] ADD CONSTRAINT [PK_Playlist] PRIMARY KEY ([PlaylistId])
go

-- Table dbo.DimSongs

CREATE TABLE [dbo].[DimSongs]
(
 [SongsId] Int NOT NULL,
 [Name] nvarchar(200) NOT NULL,
 [AlbumId] Int NULL,
 [Composer] nvarchar(220) NULL,
 [Milliseconds] Int NOT NULL,
 [Bytes] Int NULL,
 [UnitPrice] Decimal(10,2) NOT NULL,
 [GenreName] nvarchar(200) NULL,
 [MediaName] nvarchar(200) NULL,
 [AlbumName] nvarchar(200) NULL,
 [ArtistId] Int NULL,
 [ComposerId] Int NULL
)
go

-- Create indexes for table dbo.DimSongs

CREATE INDEX [IFK_TrackAlbumId] ON [dbo].[DimSongs] ([AlbumId])
go

CREATE INDEX [IX_Relationship18] ON [dbo].[DimSongs] ([ArtistId])
go

CREATE INDEX [IX_Relationship19] ON [dbo].[DimSongs] ([ComposerId])
go

-- Add keys for table dbo.DimSongs

ALTER TABLE [dbo].[DimSongs] ADD CONSTRAINT [PK_Track] PRIMARY KEY ([SongsId])
go

-- Table DimGeography

CREATE TABLE [DimGeography]
(
 [GeographyId] Int NOT NULL,
 [Address] nvarchar(200) NULL,
 [City] nvarchar(200) NULL,
 [State] nvarchar(200) NULL,
 [Country] nvarchar(200) NULL,
 [ZipCode] nvarchar(200) NULL
)
go

-- Add keys for table DimGeography

ALTER TABLE [dbo].[DimGeography] ADD CONSTRAINT [Key4] PRIMARY KEY ([GeographyId])
go

-- Table DimDate

CREATE TABLE [DimDate]
(
 [DateKey] Int NOT NULL,
 [FullDateAlternateKey] Datetime NULL,
 [EnglishMonthName] nvarchar(200) NULL,
 [CalendarYear] int NULL,
 [DayNumberOfWeek] int NULL,
 [WeekNumberOfYear] int NULL,
 [MonthNumberOfYear] int NULL
)
go

-- Add keys for table DimDate

ALTER TABLE [dbo].[DimDate] ADD CONSTRAINT [Key5] PRIMARY KEY ([DateKey])
go

-- Table DimComposer

CREATE TABLE [dbo].[DimComposer]
(
 [ComposerId] Int NOT NULL,
 [ComposerName] nvarchar(max) NULL
)
go

-- Add keys for table DimComposer

ALTER TABLE [dbo].[DimComposer] ADD CONSTRAINT [Key6] PRIMARY KEY ([ComposerId])
go

-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE [dbo].[FactSales] ADD CONSTRAINT [FK_DimDate] FOREIGN KEY ([InvoiceDate]) REFERENCES [dbo].[DimDate] ([DateKey]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [dbo].[FactSales] ADD CONSTRAINT [FK_InvoiceCustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[DimCustomer] ([CustomerId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [dbo].[FactSales] ADD CONSTRAINT [FK_DimGeography] FOREIGN KEY ([GeographyId]) REFERENCES [dbo].[DimGeography] ([GeographyId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [dbo].[DimSongs] ADD CONSTRAINT [FK_DimArtist] FOREIGN KEY ([ArtistId]) REFERENCES [dbo].[DimArtist] ([ArtistId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [dbo].[DimSongs] ADD CONSTRAINT [FK_DimComposer] FOREIGN KEY ([ComposerId]) REFERENCES [dbo].[DimComposer] ([ComposerId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [dbo].[FactSales] ADD CONSTRAINT [FK_DimSongs] FOREIGN KEY ([SongsId]) REFERENCES [dbo].[DimSongs] ([SongsId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [dbo].[FactSales] ADD CONSTRAINT [FK_Playlist] FOREIGN KEY ([PlaylistId]) REFERENCES [dbo].[DimPlaylist] ([PlaylistId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go




