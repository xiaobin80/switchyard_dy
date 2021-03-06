if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OldSwitchyard]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[OldSwitchyard]
GO

CREATE TABLE [dbo].[OldSwitchyard] (
	[journalID] [int] NOT NULL ,
	[mineName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[direction_PS] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[direction_SC] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[car_number] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[car_marque] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[carry_weight1] [numeric](9, 3) NULL ,
	[self_weight1] [numeric](9, 3) NULL ,
	[cargo_generalID] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[tonNumber] [numeric](9, 3) NULL ,
	[breed] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[switchyardNotepad] [varchar] (90) COLLATE Chinese_PRC_CI_AS NULL ,
	[past_time] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[seriary_number] [int] NULL ,
	[heavy] [bit] NULL ,
	[cumulateConsist] [int] NULL ,
	[OperID] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

