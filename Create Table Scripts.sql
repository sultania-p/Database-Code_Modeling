USE [DAMG6210]
GO

/****** Object:  Table [dbo].[CUSTOMER]    Script Date: 11/1/2021 8:18:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CUSTOMER_MA](
	[CustomerID] [int] NOT NULL,
	[CustomerName] [nvarchar](25) NULL,
	[CustomerAddress] [varchar](30) NULL,
	[CustomerCity] [varchar](20) NULL,
	[CustomerState] [char](2) NULL,
	[CustomerPostalCode] [varchar](9) NULL,
	[CustomerType] [varchar](30) NULL,
)
