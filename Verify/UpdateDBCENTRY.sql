USE [RDB]
GO

SELECT [RecID]
      ,[WorkStudyID]
      ,[SoNum]
      ,[MillLotNo]
      ,[CustPart]
      ,[UACPart]
      ,[Alloy]
      ,[Temper]
      ,[GageThickness]
      ,[Location2]
      ,[Hole]
      ,[PieceNo]
      ,[Comment]
      ,[EntryDate]
      ,[EntryBy]
      ,[DBCntry]
      ,[RCS]
  FROM [dbo].[RNDMaterial]
  where MillLotNo like'%9999%'
GO


UPDATE [RNDMaterial]
SET DBCntry = 'NO'
where MillLotNo like'%9999%'