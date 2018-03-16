/****** Object:  StoredProcedure [dbo].[RNDStudyType_Update]     ******/


--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--CREATE PROCEDURE
-- [dbo].RNDStudyType_Update
--	@RecID [int],
--   @TypeDesc [varchar](30)          
--AS
--BEGIN
	
--	UPDATE [dbo].[RNDStudyType]
--	   SET [TypeDesc] = @TypeDesc 
--	 WHERE RecID = @RecID   
--END
--GO

/****** Object:  StoredProcedure [dbo].[StudyType_Insert]     ******/


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
 [dbo].RNDStudyType_Insert
   @TypeDesc [varchar](30)          
AS
BEGIN	
	DECLARE @MaxTypeStudy int
	DECLARE @TypeStudy char(2)

	SET @MaxTypeStudy = (SELECT MAX(TypeStudy) FROM [RNDStudyType] AS INT)+1
	SET @TypeStudy = cast(@MaxTypeStudy AS char(2) )

	INSERT INTO [dbo].[RNDStudyType]
           ([TypeStudy]
           ,[TypeDesc])
     VALUES
           (@TypeStudy
           ,@TypeDesc)

	 DECLARE @RecId int
	 SELECT @RecId = [RecId]
    FROM [dbo].[RNDStudyType]
    WHERE @@ROWCOUNT > 0 AND [RecId] = scope_identity()

	SELECT t0.[RecId]
		FROM [dbo].[RNDStudyType] AS t0
		WHERE @@ROWCOUNT > 0 AND t0.[RecId] = @RecId
END
GO


/****** Object:  StoredProcedure [dbo].[[RNDLocation]]     ******/



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
 [dbo].[RNDLocation_Insert]
    @PlantDesc char(20),
    @PlantState char(2),
    @PlantType tinyint           
AS
BEGIN	
	DECLARE @Plant smallint
	
	SET @Plant = (SELECT MAX(RecID) FROM [RNDLocation]) 

	INSERT INTO [dbo].[RNDLocation]
           ([Plant]
           ,[PlantDesc]
           ,[PlantState]
           ,[PlantType])
     VALUES
           (@Plant, 
           @PlantDesc, 
           @PlantState, 
           @PlantType)

	 DECLARE @RecId int
	 SELECT @RecId = [RecId]
    FROM [dbo].[RNDLocation]
    WHERE @@ROWCOUNT > 0 AND [RecId] = scope_identity()

	SELECT t0.[RecId]
		FROM [dbo].[RNDLocation] AS t0
		WHERE @@ROWCOUNT > 0 AND t0.[RecId] = @RecId
END
GO

USE [RDB]
GO
/****** Object:  StoredProcedure [dbo].[RNDLocation_Update]    Script Date: 3/15/2018 12:00:16 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--ALTER PROCEDURE
-- [dbo].[RNDLocation_Update]
--	@RecID [int],  
--    @PlantDesc char(20),
--    @PlantState char(2),
--    @PlantType tinyint        
--AS
--BEGIN	
--	UPDATE [dbo].[RNDLocation]
--	SET 
--		[PlantDesc] = @PlantDesc
--      ,[PlantState] =  @PlantState 
--      ,[PlantType] =  @PlantType
--	 WHERE RecID = @RecID   
--END
