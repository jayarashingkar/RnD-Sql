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

USE [RDB]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
 [dbo].[RNDStudyType_Insert]
   @TypeDesc [varchar](30)          
AS
BEGIN	
	DECLARE @MaxTypeStudy int
	DECLARE @TypeStudy char(2)

	SET @MaxTypeStudy = (SELECT MAX(RecID) FROM [RNDStudyType] AS INT) + 1 
	
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
USE [RDB]
GO


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
	
	SET @Plant = (SELECT MAX(RecID) FROM [RNDLocation])  + 1 

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


/****** Object:  StoredProcedure [dbo].[RNDImportTestList_READ]     ******/

USE [RDB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
           
CREATE PROCEDURE 
[dbo].RNDImportTestList_READ 
@Active char 
AS
	BEGIN
		SELECT [RecID]
      ,[TestDesc]
      ,[TestTableName]
      ,[Active]
      ,[TabPos]
  FROM [dbo].[RNDTestList]
  WHERE Active = @Active
	END
GO

USE [RDB]
GO
/****** Object:  StoredProcedure [dbo].[RNDLocation_Insert]    Script Date: 3/22/2018 12:36:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
 [dbo].RNDSCCResults_Insert
 (          @SelectedTests varchar(max),
		   @StressKsi char(5) = null,
           @TimeDays char(2) = null,
           @TestStatus char(5) = null,
           @SpeciComment char(50) = null,
           @Operator char(20) = null,
           @TestStartDate datetime = null,
           @TestEndDate datetime = null,
           @EntryBy char(25),
           @EntryDate datetime
)       
AS
BEGIN	
		DECLARE @WorkStudyID char(10)
        DECLARE @MillLotNo int
        DECLARE @LotID char(10)
        DECLARE @TestingNo int
		DECLARE @maxRecID INT	

		IF (@SelectedTests IS NOT NULL)
		BEGIN
			DECLARE @x XML 
			SELECT 	@x = CAST('<A>'+ REPLACE(@SelectedTests,',','</A><A>')+ '</A>' AS XML);		
			SELECT TestingNo, [WorkStudyID],[LotID],[MillLotNo], StressKsi = @StressKsi,
			   TimeDays =@TimeDays,
			   TestStatus =@TestStatus,
			   SpeciComment =@SpeciComment,
			   Operator =@Operator,
			   TestStartDate =@TestStartDate,
			   TestEndDate =@TestEndDate,
			   EntryBy =@EntryBy,
			   EntryDate =@EntryDate,
			   [Completed] = '1'

			INTO #tempTestingNo			
			FROM RNDTesting
			WHERE TestingNo IN (SELECT t.value('.', 'int') AS inVal FROM @x.nodes('/A') AS x(t))

			SET @maxRecID = (SELECT MAX(RecId) FROM  [RNDSCCResults])

			INSERT INTO [dbo].[RNDSCCResults]
           ([WorkStudyID]
           ,[MillLotNo]
           ,[LotID]
           ,[TestingNo]
           ,[StressKsi]
           ,[TimeDays]
           ,[TestStatus]
           ,[SpeciComment]
           ,[Operator]
           ,[TestStartDate]
           ,[TestEndDate]
           ,[EntryBy]
           ,[EntryDate]
           ,[Completed])
			 SELECT 
            [WorkStudyID]
           ,[MillLotNo]
           ,[LotID]
           ,[TestingNo]
           ,[StressKsi]
           ,[TimeDays]
           ,[TestStatus]
           ,[SpeciComment]
           ,[Operator]
           ,[TestStartDate]
           ,[TestEndDate]
           ,[EntryBy]
           ,[EntryDate]
           ,[Completed]
		   FROM #tempTestingNo

		select TestingNo 
		FROM [dbo].[RNDSCCResults]
		where RecID > @maxRecID
		
		DROP TABLE #tempTestingNo
	END
END


USE [RDB]
GO
/****** Object:  StoredProcedure [dbo].[RNDLocation_Insert]    Script Date: 3/22/2018 12:36:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
 [dbo].RNDEXCOResults_Insert
 (         @SelectedTests varchar(max),
		   @ExcoRating char(4),
           @StartWT char(8),
           @FinalWT char(8),
           @ExposedArea char(8),
           @StartpH char(5),
           @FinalpH char(5),
           @SpeciComment char(50),
           @Operator char(20),
           @TestDate datetime,
           @TimeHrs char(2),
           @TimeMns char(2),
           @BatchNo char(4),
           @EntryBy char(25),
           @EntryDate datetime
)       
AS
BEGIN	
		DECLARE @WorkStudyID char(10)
        DECLARE @MillLotNo int
        DECLARE @LotID char(10)
        DECLARE @TestingNo int
		DECLARE @maxRecID INT	

		IF (@SelectedTests IS NOT NULL)
		BEGIN
			DECLARE @x XML 
			SELECT 	@x = CAST('<A>'+ REPLACE(@SelectedTests,',','</A><A>')+ '</A>' AS XML);		
			SELECT TestingNo, [WorkStudyID],[LotID],[MillLotNo], 
			ExcoRating =@ExcoRating,
          StartWT =@StartWT,
          FinalWT =@FinalWT,
          ExposedArea =@ExposedArea,
          StartpH =@StartpH,
          FinalpH =@FinalpH,
          SpeciComment =@SpeciComment,
          Operator =@Operator,
          TestDate =@TestDate,
          TimeHrs =@TimeHrs,
          TimeMns =@TimeMns,
          BatchNo =@BatchNo,
			   EntryBy =@EntryBy,
			   EntryDate =@EntryDate,
			   [Completed] = '1'

			INTO #tempTestingNo			
			FROM RNDTesting
			WHERE TestingNo IN (SELECT t.value('.', 'int') AS inVal FROM @x.nodes('/A') AS x(t))

			SET @maxRecID = (SELECT MAX(RecId) FROM  [RNDExcoResults])

			INSERT INTO [dbo].[RNDExcoResults]
          ([WorkStudyID]
           ,[MillLotNo]
           ,[LotID]
           ,[TestingNo]
           ,[ExcoRating]
           ,[StartWT]
           ,[FinalWT]
           ,[ExposedArea]
           ,[StartpH]
           ,[FinalpH]
           ,[SpeciComment]
           ,[Operator]
           ,[TestDate]
           ,[TimeHrs]
           ,[TimeMns]
           ,[BatchNo]
           ,[EntryBy]
           ,[EntryDate]
           ,[Completed])
			 SELECT 
           @WorkStudyID
           ,@MillLotNo
           ,@LotID
           ,@TestingNo
           ,@ExcoRating
           ,@StartWT
           ,@FinalWT
           ,@ExposedArea
           ,@StartpH
           ,@FinalpH
           ,@SpeciComment
           ,@Operator
           ,@TestDate
           ,@TimeHrs
           ,@TimeMns
           ,@BatchNo
           ,@EntryBy
           ,@EntryDate
           ,'1'
		   FROM #tempTestingNo

		select TestingNo 
		FROM [dbo].[RNDExcoResults]
		where RecID > @maxRecID
		
		DROP TABLE #tempTestingNo
	END
END
