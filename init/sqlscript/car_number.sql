if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[car_number]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[car_number]
GO

CREATE TABLE [dbo].[car_number] (
	[train_number] [int] NOT NULL ,
	[seriary_number] [int] NOT NULL ,
	[car_number] [nvarchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[past_time] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[car_marque] [nvarchar] (30) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

