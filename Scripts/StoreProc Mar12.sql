USE [RDB]
GO
/****** Object:  StoredProcedure [dbo].[RNDAgeLotID_Read]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDAgeLotID_Read] @WorkStudyId varchar(10)
AS
	BEGIN
		select distinct [AgeLotID] from [dbo].[RNDProcessing] 
		where WorkStudyID = @WorkStudyID
------------------------------------------------------------------------------------------------------------
--DELETE  FLAGS
		AND ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------

	END



GO
/****** Object:  StoredProcedure [dbo].[RNDAssignMaterial_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDAssignMaterial_Insert]
	@WorkStudyID [char](10),
	@SoNum [char](10) = NULL,
	@MillLotNo [int] = NULL,
	@CustPart [char](30) = NULL,
	@UACPart [numeric](5, 0) = NULL,
	@Alloy [char](10) = NULL,
	@Temper [char](6) = NULL,
	@GageThickness [char](7) = NULL,
	@Location2 [char](6) = NULL,
	@Hole [char](2) = NULL,
	@PieceNo [char](2) = NULL,
	@Comment [char](40) = NULL,
	@EntryDate [datetime] = NULL,
	@EntryBy [char](25) = NULL,
	@DBCntry [char](3) = NULL
	--@RCS [char](1) = NULL
AS
	BEGIN
------------------------------------------------------------------------------------------------------------
--DELETE WITHOUT FLAGS

		--INSERT [dbo].[RNDMaterial]
		--		([WorkStudyID], [SoNum], [MillLotNo], [CustPart], [UACPart], [Alloy], [Temper], [GageThickness], [Location2], [Hole], [PieceNo], [Comment], [EntryDate], [EntryBy])
		--VALUES(@WorkStudyID, @SoNum, @MillLotNo, @CustPart, @UACPart, @Alloy, @Temper, @GageThickness, @Location2, @Hole, @PieceNo, @Comment, @EntryDate, @EntryBy)		

------------------------------------------------------------------------------------------------------------
--DELETE FLAGS
		INSERT [dbo].[RNDMaterial]
		([WorkStudyID], [SoNum], [MillLotNo], [CustPart], [UACPart], [Alloy], [Temper], [GageThickness], [Location2], [Hole], [PieceNo], [Comment], [EntryDate], [EntryBy], DBCntry, Deleted)
		VALUES(@WorkStudyID, @SoNum, @MillLotNo, @CustPart, @UACPart, @Alloy, @Temper, @GageThickness, @Location2, @Hole, @PieceNo, @Comment, @EntryDate, @EntryBy, @DBCntry, 0)		
 	
------------------------------------------------------------------------------------------------------------
		
		DECLARE @RecId int
		SELECT @RecId = [RecId]
		FROM [dbo].[RNDMaterial]
		WHERE @@ROWCOUNT > 0 AND [RecId] = scope_identity()
    
		SELECT t0.[RecId]
		FROM [dbo].[RNDMaterial] AS t0
		WHERE @@ROWCOUNT > 0 AND t0.[RecId] = @RecId
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDAssignMaterial_Read]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDAssignMaterial_Read] @CurrentPage INT, @NoOfRecords INT, @WorkStudyID VARCHAR(50) = NULL, 
				@AlloyTypes VARCHAR(50) = NULL, @TemperTypes VARCHAR(50) = NULL, @CustPartNo VARCHAR(50) = NULL,
				@MillLotNo VARCHAR(50) = NULL,
				 --@UacPartNo VARCHAR(50) = NULL
				 @UACPart VARCHAR(50) = NULL
AS
	BEGIN
		DECLARE @total INT
		
		--SELECT @total = COUNT(*) FROM [dbo].[RNDMaterial]

		IF OBJECT_ID('tempdb..#TempRNDAssignMaterial') IS NOT NULL
		BEGIN
			DROP TABLE #TempRNDAssignMaterial
		END

------------------------------------------------------------------------------------------------------------
----DELETE WITHOUT FLAGS
		--SELECT AM.RecId AS RecId,	AM.WorkStudyID, AM.SoNum, AM.MillLotNo, AM.CustPart, ISNULL(AM.UACPart,0) UACPart, 
		--AM.Alloy, AM.Temper, AM.GageThickness, AM.Location2, AM.Hole, AM.PieceNo, AM.Comment, 
		--AM.EntryDate AS EntryDate, AM.DBCntry, AM.EntryBy
		----, ISNULL(AM.RCS,'') RCS
		--INTO #TempRNDAssignMaterial
		--FROM [dbo].[RNDMaterial] AS AM WITH(NOLOCK)
		--WHERE 1 = 1 AND AM.RecId > 0
		--AND (@WorkStudyID IS NULL OR AM.WorkStudyID = @WorkStudyID)
		--AND (@CustPartNo IS NULL OR AM.CustPart LIKE '%' + @CustPartNo + '%')
		--AND (@MillLotNo IS NULL OR AM.MillLotNo = @MillLotNo )
		--AND (@AlloyTypes IS NULL OR AM.Alloy = @AlloyTypes)
		--AND (@TemperTypes IS NULL OR AM.Temper = @TemperTypes)
		----AND (@UacPartNo IS NULL OR AM.UACPart = @UacPartNo)
		----AND (@UACPart IS NULL OR AM.UACPart = @UACPart)
		--AND (@UACPart IS NULL OR convert(varchar(50),UACPart) like '%' + @UACPart + '%' )
		----ORDER BY RecId DESC
		----	OFFSET ((@CurrentPage) * @NoOfRecords) ROWS
		----	FETCH NEXT @NoOfRecords ROWS ONLY
------------------------------------------------------------------------------------------------------------
----DELETE FLAGS
		SELECT AM.RecId AS RecId,	AM.WorkStudyID, AM.SoNum, AM.MillLotNo, AM.CustPart, ISNULL(AM.UACPart,0) UACPart, 
		AM.Alloy, AM.Temper, AM.GageThickness, AM.Location2, AM.Hole, AM.PieceNo, AM.Comment, 
		AM.EntryDate AS EntryDate, AM.DBCntry, AM.EntryBy		
		INTO #TempRNDAssignMaterial
		FROM [dbo].[RNDMaterial] AS AM WITH(NOLOCK)
		WHERE 1 = 1 AND AM.RecId > 0
		AND (@WorkStudyID IS NULL OR AM.WorkStudyID = @WorkStudyID)
		AND (@CustPartNo IS NULL OR AM.CustPart LIKE '%' + @CustPartNo + '%')
		AND (@MillLotNo IS NULL OR AM.MillLotNo = @MillLotNo )
		AND (@AlloyTypes IS NULL OR AM.Alloy = @AlloyTypes)
		AND (@TemperTypes IS NULL OR AM.Temper = @TemperTypes)	
		AND (@UACPart IS NULL OR convert(varchar(50),UACPart) like '%' + @UACPart + '%' )	
		AND ((Deleted != 1 )or(Deleted is null)) 
  	
------------------------------------------------------------------------------------------------------------

		SELECT @total = COUNT(*) FROM #TempRNDAssignMaterial WITH(NOLOCK)

		SELECT @total AS total, AM.RecId AS RecId,	AM.WorkStudyID, AM.SoNum, AM.MillLotNo, AM.CustPart, ISNULL(AM.UACPart,0) UACPart, 
		AM.Alloy, AM.Temper, AM.GageThickness, AM.Location2, AM.Hole, AM.PieceNo, AM.Comment, 
		AM.EntryDate AS EntryDate, AM.DBCntry, AM.EntryBy
		--, ISNULL(AM.RCS,'') RCS
		FROM #TempRNDAssignMaterial AS AM WITH(NOLOCK)
		ORDER BY RecId DESC
			OFFSET ((@CurrentPage) * @NoOfRecords) ROWS
			FETCH NEXT @NoOfRecords ROWS ONLY

		DROP TABLE #TempRNDAssignMaterial
	END




GO
/****** Object:  StoredProcedure [dbo].[RNDAssignMaterial_ReadByID]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDAssignMaterial_ReadByID] @RecId INT
AS
	BEGIN

------------------------------------------------------------------------------------------------------------
----DELETE WITHOUT FLAGS

--		SELECT @RecId AS RecId,	RTRIM(WorkStudyID) AS WorkStudyID, SoNum, MillLotNo, CustPart, UACPart, 
--		RTRIM(ISNULL(Alloy,'')) AS Alloy , RTRIM(ISNULL(Temper,'')) AS Temper, GageThickness, Location2, Hole, PieceNo, Comment, 
--		EntryDate AS EntryDate, DBCntry,EntryBy
--		--, ISNULL(RCS,'') AS RCS	
--		FROM [dbo].[RNDMaterial]
--		WHERE RecId = @RecId
------------------------------------------------------------------------------------------------------------
--DELETE FLAGS
		SELECT @RecId AS RecId,	RTRIM(WorkStudyID) AS WorkStudyID, SoNum, MillLotNo, CustPart, UACPart, 
		RTRIM(ISNULL(Alloy,'')) AS Alloy , RTRIM(ISNULL(Temper,'')) AS Temper, GageThickness, Location2, Hole, PieceNo, Comment, 
		EntryDate AS EntryDate, DBCntry,EntryBy
		--, ISNULL(RCS,'') AS RCS	
		FROM [dbo].[RNDMaterial]
		WHERE RecId = @RecId
		AND Deleted != 1 
  	
------------------------------------------------------------------------------------------------------------

	END


GO
/****** Object:  StoredProcedure [dbo].[RNDAssignMaterial_Update]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDAssignMaterial_Update]
	@RecId [int],
    @WorkStudyID [char](10),
	@SoNum [char](10) = NULL,
	@MillLotNo [int] = NULL,
	@CustPart [char](30) = NULL,
	@UACPart [numeric](5, 0) = NULL,
	@Alloy [char](10) = NULL,
	@Temper [char](6) = NULL,
	@GageThickness [char](7) = NULL,
	@Location2 [char](6) = NULL,
	@Hole [char](2) = NULL,
	@PieceNo [char](2) = NULL,
	@Comment [char](40) = NULL,
	@EntryDate [datetime] = NULL,
	@EntryBy [char](25) = NULL,
	@DBCntry [char](3) = NULL
	--@RCS [char](1) = NULL
AS
	BEGIN
		UPDATE [dbo].[RNDMaterial]
		SET [SoNum] = @SoNum, [MillLotNo] = @MillLotNo, [CustPart] = @CustPart, [UACPart] = @UACPart, [Alloy] = @Alloy,
		[Temper] = @Temper, [GageThickness] = @GageThickness, [Location2] = @Location2, [Hole] = @Hole,
		[PieceNo] = @PieceNo, [Comment] = @Comment, [EntryDate] = @EntryDate, [EntryBy] = @EntryBy,
		[DBCntry] = @DBCntry
		--, [RCS] = @RCS
		WHERE [RecId] = @RecId AND [WorkStudyID] = @WorkStudyID
	END



GO
/****** Object:  StoredProcedure [dbo].[RNDBearing_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDBearing_Insert]
		@WorkStudyID char(10),
        @TestNo int,
        @SubConduct numeric(4,1),
        @SurfConduct numeric(4,1),
		@eDCalc numeric(4,1),
        @FbruKsi numeric(4,1),
		@FbryKsi numeric(4,1),      
        @SpeciComment char(50),
        @Operator char(20),
        @TestDate datetime,
        @TestTime char(15),
        @EntryBy char(25),
        @EntryDate datetime,
        @Completed char(1)
AS
BEGIN		
	INSERT INTO [dbo].[RNDBearingResults]
      ([WorkStudyID]
      ,[TestNo]
      ,[SubConduct]
      ,[SurfConduct]
	  ,[eDCalc]
      ,[FbruKsi]
	  ,[FbryKsi]      
      ,[SpeciComment]
      ,[Operator]
      ,[TestDate]
      ,[TestTime]
      ,[EntryBy]
      ,[EntryDate]
      ,[Completed])
     VALUES
	 (
	 	@WorkStudyID , 
		@TestNo ,
        @SubConduct ,
        @SurfConduct ,
		@eDCalc,
        @FbruKsi ,   
        @FbryKsi ,
        @SpeciComment ,
        @Operator ,
        @TestDate ,
        @TestTime ,
        @EntryBy ,
        @EntryDate ,
        @Completed 
	 )

    DECLARE @RecId int

	SELECT @RecId = [RecID]
	FROM [dbo].[RNDBearingResults]
	WHERE @@ROWCOUNT > 0 AND [RecID] = scope_identity()

	SELECT t0.[RecID]
	FROM [dbo].[RNDBearingResults] AS t0
	WHERE @@ROWCOUNT > 0 AND t0.[RecID] = @RecId
END



GO
/****** Object:  StoredProcedure [dbo].[RNDCheckUserExists]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDCheckUserExists]
	@UserName [nvarchar](100)
AS
	BEGIN
		SELECT COUNT(*) FROM [RNDLogin] WHERE UserName = @UserName
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDCompression_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDCompression_Insert]
		@WorkStudyID char(10),
        @TestNo int,
        @SubConduct numeric(4,1),
        @SurfConduct numeric(4,1),
        @FcyKsi numeric(4,1),
        @EcModulusMpsi numeric(4,1),
        @SpeciComment char(50),
        @Operator char(20),
        @TestDate datetime,
        @TestTime char(15),
        @EntryBy char(25),
        @EntryDate datetime,
        @Completed char(1)
AS
BEGIN		
	INSERT INTO [dbo].[RNDCompressionResults]
           ([WorkStudyID]
      ,[TestNo]
      ,[SubConduct]
      ,[SurfConduct]
      ,[FcyKsi]
      ,[EcModulusMpsi]
      ,[SpeciComment]
      ,[Operator]
      ,[TestDate]
      ,[TestTime]
      ,[EntryBy]
      ,[EntryDate]
      ,[Completed])
     VALUES
	 (
	 	@WorkStudyID , 
		@TestNo ,
        @SubConduct ,
        @SurfConduct ,
        @FcyKsi ,   
        @EcModulusMpsi ,
        @SpeciComment ,
        @Operator ,
        @TestDate ,
        @TestTime ,
        @EntryBy ,
        @EntryDate ,
        @Completed 
	 )

    DECLARE @RecId int

	SELECT @RecId = [RecID]
	FROM [dbo].[RNDCompressionResults]
	WHERE @@ROWCOUNT > 0 AND [RecID] = scope_identity()

	SELECT t0.[RecID]
	FROM [dbo].[RNDCompressionResults] AS t0
	WHERE @@ROWCOUNT > 0 AND t0.[RecID] = @RecId
END



GO
/****** Object:  StoredProcedure [dbo].[RNDCompressionReports_Read]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--RNDCompressionReports_Read
CREATE  PROCEDURE 
[dbo].[RNDCompressionReports_Read] 
	@CurrentPage INT, @NoOfRecords INT,@WorkStudyID VARCHAR(50) = NULL,@TestType VARCHAR(35),
	@Alloy VARCHAR(10) = NULL,@Temper VARCHAR(10) = NULL,@CustPart VARCHAR(30) = NULL, @UACPart VARCHAR(MAX) = NULL
AS
	BEGIN
		DECLARE @total INT
		--SELECT @total = COUNT(*) FROM [dbo].[RNDWorkStudy]

		IF OBJECT_ID('tempdb..#TempCompressionReports') IS NOT NULL
		BEGIN
			DROP TABLE #TempRNDCompressionReports
		END

		SELECT A.RecId AS RecID, RTRIM(A.WorkStudyID) AS WorkStudyID, A.TestNo, 
		B.Alloy,B.Temper, B.CustPart, B.UACPart, 
		A.SubConduct, A.SurfConduct, 
		A.FcyKsi, 
		A.EcModulusMpsi, 
		RTRIM(A.SpeciComment) AS SpeciComment, RTRIM(A.Operator) AS Operator, 
		CONVERT(VARCHAR,A.TestDate,101) AS TestDate,
		RTRIM(A.TestTime) AS TestTime, 
		CONVERT(VARCHAR,A.EntryDate,101) AS EntryDate,
		A.EntryBy, Completed		
		INTO #TempRNDCompressionReports
		FROM RNDCompressionResults A
		LEFT JOIN RNDTesting B 
		ON A.testNo = B.testingNo 
		WHERE 1=1
		AND (@WorkStudyID IS NULL OR A.WorkStudyID LIKE '%' + @WorkStudyID + '%')
		AND (@TestType IS NULL OR B.TestType LIKE '%' + @TestType + '%')
		AND (@Alloy IS NULL OR B.Alloy LIKE '%' + @Alloy + '%')
		AND (@Temper IS NULL OR B.Temper LIKE '%' + @Temper + '%')
		AND (@CustPart IS NULL OR B.CustPart LIKE '%' + @CustPart + '%')
		AND (@UACPart IS NULL OR CAST(B.UACPart AS VARCHAR(MAX)) LIKE '%' + @UACPart + '%')
		AND ((Deleted != 1 )or(Deleted is null)) 
-----------------------------------------------------------------------------------------------------------
		SELECT @total = COUNT(*) FROM #TempRNDCompressionReports WITH(NOLOCK)

		SELECT @total AS [total], 
		RecID,  WorkStudyID, TestNo, 
		Alloy, Temper, CustPart, UACPart, 
		SubConduct, SurfConduct, 
		FcyKsi, 
		EcModulusMpsi, 
		SpeciComment,  Operator, 
		TestDate,
		 TestTime, 
		 EntryDate,
		EntryBy, Completed
		FROM #TempRNDCompressionReports WITH(NOLOCK)
		ORDER BY RecId DESC
			OFFSET ((@CurrentPage)*@NoOfRecords) ROWS
			FETCH NEXT @NoOfRecords ROWS ONLY

		DROP TABLE #TempRNDCompressionReports		
	END 

GO
/****** Object:  StoredProcedure [dbo].[RNDFatigueTesting_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDFatigueTesting_Insert]
		@WorkStudyID char(10),  
		@TestNo int,
        @SpecimenDrawing char(50),
        @MinStress numeric(4,1),
        @MaxStress numeric(4,1),
        @MinLoad numeric(7,2),
        @MaxLoad numeric(7,2),
        @WidthOrDia numeric(8,5),
        @Thickness numeric(8,5),
        @HoleDia numeric(8,5),
        @AvgChamferDepth numeric(8,5),
        @Frequency char(5),
        @CyclesToFailure numeric(8,0),
        @Roughness numeric(5,2),
        @TestFrame char(5),
        @Comment char(50),
        @FractureLocation char(50),
        @Operator char(20),
        @TestDate datetime,
        @TestTime char(15),
        @EntryBy char(25),
        @EntryDate datetime,
        @Completed char(1)
AS
BEGIN		
	INSERT INTO [dbo].[RNDFatigueTestingResults]	
     (
			[WorkStudyID]     
		   ,[TestNo]    
           ,[SpecimenDrawing]
           ,[MinStress]
           ,[MaxStress]
           ,[MinLoad]
           ,[MaxLoad]
           ,[WidthOrDia]
           ,[Thickness]
           ,[HoleDia]
           ,[AvgChamferDepth]
           ,[Frequency]
           ,[CyclesToFailure]
           ,[Roughness]
           ,[TestFrame]
           ,[Comment]
           ,[FractureLocation]
           ,[Operator]
           ,[TestDate]
           ,[TestTime]
           ,[EntryBy]
           ,[EntryDate]
           ,[Completed])
     VALUES
	 (
	 		@WorkStudyID          
		   ,@TestNo
           ,@SpecimenDrawing
           ,@MinStress
           ,@MaxStress
           ,@MinLoad
           ,@MaxLoad
           ,@WidthOrDia
           ,@Thickness
           ,@HoleDia
           ,@AvgChamferDepth
           ,@Frequency
           ,@CyclesToFailure
           ,@Roughness
           ,@TestFrame
           ,@Comment
           ,@FractureLocation
           ,@Operator
           ,@TestDate
           ,@TestTime
           ,@EntryBy
           ,@EntryDate
           ,@Completed)

    DECLARE @RecId int

	SELECT @RecId = [RecID]
	FROM [dbo].[RNDFatigueTestingResults]
	WHERE @@ROWCOUNT > 0 AND [RecID] = scope_identity()

	SELECT t0.[RecID]
	FROM [dbo].[RNDFatigueTestingResults] AS t0
	WHERE @@ROWCOUNT > 0 AND t0.[RecID] = @RecId
END



GO
/****** Object:  StoredProcedure [dbo].[RNDFractureToughness_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDFractureToughness_Insert]
		@WorkStudyID char(10),
        @TestNo int,
        @SubConduct numeric(4,1),
        @SurfConduct numeric(4,1),
		@Validity char(20),
        @KKsiIn numeric(4,1),
		@KmaxKsiIn numeric(4,1),
         @PqLBS numeric(7,0),
           @PmaxLBS numeric(7,0),
           @aOIn numeric(7,4),
           @WIn numeric(7,4),
           @BIn numeric(7,4),
           @BnIn numeric(7,4),
           @AvgFinalPreCrack numeric(7,4),
           @SpeciComment char(50),
           @Operator char(20),
           @TestDate datetime,
           @TestTime char(15),
           @EntryBy char(25),
           @EntryDate datetime,
           @Completed char(1)
AS
BEGIN		
	INSERT INTO [dbo].RNDFractureToughnessResults
      ([WorkStudyID]
      ,[TestNo]
      ,[SubConduct]
      ,[SurfConduct]
	  ,[Validity]
      ,[KKsiIn]
	  ,[KmaxKsiIn]
	  ,[PqLBS]
      ,[PmaxLBS]
      ,[aOIn]
      ,[WIn]
      ,[BIn]
      ,[BnIn]
      ,[AvgFinalPreCrack]
      ,[SpeciComment]
      ,[Operator]
      ,[TestDate]
      ,[TestTime]
      ,[EntryBy]
      ,[EntryDate]
      ,[Completed])
     VALUES
	 (
	 	@WorkStudyID,
        @TestNo ,
        @SubConduct ,
        @SurfConduct,
		@Validity ,
        @KKsiIn ,
		@KmaxKsiIn ,
        @PqLBS ,
        @PmaxLBS ,
        @aOIn ,
        @WIn ,
        @BIn ,
        @BnIn ,
        @AvgFinalPreCrack ,
        @SpeciComment ,
        @Operator ,
        @TestDate ,
        @TestTime ,
        @EntryBy ,
        @EntryDate ,
        @Completed 
	 )

    DECLARE @RecId int

	SELECT @RecId = [RecID]
	FROM [dbo].RNDFractureToughnessResults
	WHERE @@ROWCOUNT > 0 AND [RecID] = scope_identity()

	SELECT t0.[RecID]
	FROM [dbo].RNDFractureToughnessResults AS t0
	WHERE @@ROWCOUNT > 0 AND t0.[RecID] = @RecId
END



GO
/****** Object:  StoredProcedure [dbo].[RNDGageThickness_READ]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDGageThickness_READ]
@WorkStudyID varchar(10) = null,
@MillLotNo int = null,
@Loc2 varchar(6) = null
AS
	BEGIN
		SELECT top 1 GageThickness FROM RNDMaterial where Location2 = @Loc2 and @MillLotNo = MillLotNo and @WorkStudyID = WorkStudyID
------------------------------------------------------------------------------------------------------------
--DELETE  FLAGS
		AND ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------

	END


GO
/****** Object:  StoredProcedure [dbo].[RNDGetAlloyPartTemper]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDGetAlloyPartTemper]
@MillLotNo char(10)
AS
	BEGIN
		SELECT TOP 1 UACPart, CustPart, RTRIM(ISNULL(Alloy,'')) AS Alloy , RTRIM(ISNULL(Temper,'')) AS Temper FROM RNDMaterial where @MillLotNo = MillLotNo
-----------------------------------------------------------------------------------------------------------
--DELETE  FLAGS
		AND ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------

	END


GO
/****** Object:  StoredProcedure [dbo].[RNDGetHole]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDGetHole]
@ProcessID char(10)
AS
	BEGIN
		SELECT DISTINCT Hole 		
		FROM RNDProcessing 		
		where @ProcessID = ProcessID		
		AND  (Hole not like '%'+'-1'+'%')
		AND (Hole is not NULL)
------------------------------------------------------------------------------------------------------------
--DELETE FLAGS
		AND ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDGetLocation2]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDGetLocation2]
@MillLotNo char(10),
@WorkStudyID VARCHAR(50) = NULL
AS
	BEGIN
		SELECT distinct Location2 FROM RNDMaterial where 
		@MillLotNo = MillLotNo	
		AND @WorkStudyID = WorkStudyID	
		AND Location2 is not NULL
		 
------------------------------------------------------------------------------------------------------------
--DELETE FLAGS
		AND ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDGetPieceNo]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDGetPieceNo]
@ProcessID char(10)
AS
	BEGIN
		SELECT PieceNo FROM RNDProcessing where @ProcessID = ProcessID		
		AND  PieceNo not like '%'+'-1'+'%'
		AND PieceNo is not NULL
------------------------------------------------------------------------------------------------------------
--DELETE FLAGS
		AND ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDGetSoNumByProcessID]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDGetSoNumByProcessID]
@ProcessID char(10)
AS
	BEGIN
		SELECT Sonum FROM RNDProcessing where @ProcessID = ProcessID
------------------------------------------------------------------------------------------------------------
--DELETE  FLAGS
		AND ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDGetTestTypeFromTesting]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDGetTestTypeFromTesting]
(
@WorkStudyID VARCHAR(MAX)
)
AS
BEGIN		
	SELECT distinct TestType FROM RNDTesting where WorkStudyID = @WorkStudyID
	AND ((Deleted != 1 )or(Deleted is null))
END;


GO
/****** Object:  StoredProcedure [dbo].[RNDGetUser_ReadByID]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDGetUser_ReadByID] (@Token VARCHAR(100) = NULL)
AS
	BEGIN		
		DECLARE @UserId INT
		SELECT @UserId = UserId FROM RNDSecurityTokens WITH(NOLOCK)
		WHERE Token = @Token

		SELECT [UserId], [UserName], ([FirstName] + ' ' + [LastName]) AS [FullName]
		FROM RNDLogin WITH(NOLOCK)
		WHERE UserId = @UserId	AND StatusCode != 'D'
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDGetWorkStudyFromTesting]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDGetWorkStudyFromTesting]
 (
@TestType VARCHAR(MAX)
)
AS
BEGIN		
	--DECLARE @firstWorkStudyID varchar(10)
	--SET @firstWorkStudyID = (SELECT TOP 1 WorkStudyID FROM  RNDTesting 
	--WHERE ((Deleted != 1 )or(Deleted is null))
	--)
	SELECT distinct WorkStudyID --, @firstWorkStudyID AS firstWorkStudyID 
	FROM RNDTesting 	
	------------------------------------------------------------------------------------------------------------
--DELETE WITH FLAGS
	WHERE ((Deleted != 1 )or(Deleted is null))
	AND TestType = @TestType
------------------------------------------------------------------------------------------------------------

END;

GO
/****** Object:  StoredProcedure [dbo].[RNDGroupName_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
 [dbo].[RNDGroupName_Insert]
(
@GroupType VARCHAR(MAX),
@GroupName VARCHAR(MAX),
@SelectedRecords VARCHAR(MAX)
)
AS
BEGIN
	BEGIN TRY
		DECLARE @NewGroupName VARCHAR(MAX)		
		DECLARE @MaxNo INT
		BEGIN TRANSACTION 
			DECLARE @x XML 
			SELECT 	@x = CAST('<A>'+ REPLACE(@SelectedRecords,',','</A><A>')+ '</A>' AS XML);
			

			IF (@GroupType = 'HTLogID')
			BEGIN
				DECLARE @HTLogNo INT
				SET @HTLogNo = 0
				IF(@GroupName != 'NEW')
				BEGIN
					SET @NewGroupName = @GroupName

					DECLARE @TempHTLogNo varchar(10)					
					SET @TempHTLogNo = substring(@GroupName,2,5)
					SET @HTLogNo = CAST(@TempHTLogNo as int)
					--SET @HTLogNo = (SELECT TOP 1 HTLogNo FROM RNDProcessing 
					--				WHERE HTLogID LIKE '%'+@GroupName+'%')									
				END
				ELSE
				BEGIN
					SET @MaxNo = (SELECT MAX(HTLogNo) FROM RNDProcessing )+1

					IF (@MaxNo>0 AND @MaxNo <10)
					BEGIN
						SET @NewGroupName = 'H'+'000'+cast(@MaxNo as varchar(10))
					END
					IF (@MaxNo>10 AND @MaxNo <100)
					BEGIN
						SET @NewGroupName = 'H'+'000'+cast(@MaxNo as varchar(10))
					END
					ELSE IF (@MaxNo>100 AND @MaxNo <1000)
					BEGIN
						SET @NewGroupName = 'H'+'00'+cast(@MaxNo as varchar(10))
					END
					ELSE IF (@MaxNo>1000 AND @MaxNo <10000)
					BEGIN
						SET @NewGroupName = 'H'+'0'+ cast(@MaxNo as varchar(10))

					END
					ELSE IF (@MaxNo>10000 AND @MaxNo <100000)
					BEGIN
						SET @NewGroupName = 'H'+cast(@MaxNo as varchar(10))
					END

					SET @HTLogNo = @MaxNo

				END
				UPDATE  [dbo].[RNDProcessing]  
				SET [HTLogID]=@NewGroupName , HTLogNo = @HTLogNo
					WHERE  [RecID] IN  (SELECT t.value('.', 'int') AS inVal FROM @x.nodes('/A') AS x(t))
			END
			ELSE
			BEGIN
				IF (@GroupType = 'AgeLotID')
				BEGIN
					DECLARE @AgeLotNo INT
					SET @AgeLotNo = 0
					IF(@GroupName != 'NEW')
					BEGIN
						SET @NewGroupName = @GroupName

						DECLARE @TempAgeLotNo varchar(10)					
						SET @TempAgeLotNo = substring(@GroupName,2,5)
						SET @AgeLotNo = CAST(@TempAgeLotNo as int)

						--SET @AgeLotNo = (SELECT TOP 1 AgeLotNo FROM RNDProcessing 
						--			WHERE AgeLotID LIKE '%'+@GroupName+'%')		
					END										
					ELSE
					BEGIN
						SET @MaxNo = (SELECT MAX(AgeLotNo) FROM RNDProcessing )+1

						IF (@MaxNo>0 AND @MaxNo <10)
						BEGIN
							SET @NewGroupName = 'A'+'000'+cast(@MaxNo as varchar(10))
						END
						ELSE IF (@MaxNo>10 AND @MaxNo <100)
						BEGIN
							SET @NewGroupName = 'A'+'000'+cast(@MaxNo as varchar(10))
						END
						ELSE IF (@MaxNo>100 AND @MaxNo <1000)
						BEGIN
							SET @NewGroupName = 'A'+'00'+cast(@MaxNo as varchar(10))
						END
						ELSE IF (@MaxNo>1000 AND @MaxNo <10000)
						BEGIN
							SET @NewGroupName = 'A'+'0'+ cast(@MaxNo as varchar(10))
						END
						ELSE IF (@MaxNo>10000 AND @MaxNo <100000)
						BEGIN
							SET @NewGroupName = 'A'+cast(@MaxNo as varchar(10))
						END

						SET @AgeLotNo = @MaxNo

					END
					UPDATE  [dbo].[RNDProcessing]  
					SET [AgeLotID]=@NewGroupName, AgeLotNo = @AgeLotNo
							WHERE [RecID] IN  (SELECT t.value('.', 'int') AS inVal FROM @x.nodes('/A') AS x(t));
			
				END
			END;

-- ??? Set the [AgeLotNo][HTLogNo] 
	
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		DECLARE @ERRORMSG VARCHAR(MAX);
		SET @ERRORMSG=ERROR_MESSAGE();	
		RAISERROR(@ERRORMSG,12,1);
	END CATCH;
END;


GO
/****** Object:  StoredProcedure [dbo].[RNDHole_READByMillLotNo]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDHole_READByMillLotNo] 
@MillLotNo int,
@WorkStudyId varchar(10)
AS
	BEGIN
		SELECT distinct Hole FROM [dbo].[RNDMaterial]
		 WHERE MillLotNo = @MillLotNo 
		AND WorkStudyID = @WorkStudyId
		AND  (Hole not like '%'+'-1'+'%')
		AND (Hole is not NULL)
		AND (rtrim(Hole) != '')
------------------------------------------------------------------------------------------------------------
--DELETE WITHOUT FLAGS
		AND ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------

	END


GO
/****** Object:  StoredProcedure [dbo].[RNDHTLogID_Read]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE 
[dbo].[RNDHTLogID_Read] @WorkStudyId varchar(10)
AS
	BEGIN
		select distinct [HTLogID] from [dbo].[RNDProcessing] 
		where WorkStudyID = @WorkStudyID
------------------------------------------------------------------------------------------------------------
--DELETE  FLAGS
		AND ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------

	END


GO
/****** Object:  StoredProcedure [dbo].[RNDLocation_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
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
/****** Object:  StoredProcedure [dbo].[RNDLocation_READ]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDLocation_READ] 
AS
	BEGIN
		SELECT RecID,Plant,PlantDesc,PlantState,PlantType FROM RNDLocation
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDLogin_Delete]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDLogin_Delete]
    @UserId [int]
AS
BEGIN
	--UPDATE [RNDLogin] SET StatusCode='D' WHERE UserId = @UserId AND PermissionLevel != 'SuperAdmin'
	DELETE [RNDLogin] WHERE UserId = @UserId 
END



GO
/****** Object:  StoredProcedure [dbo].[RNDLogin_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RNDLogin_Insert]
	@UserName [nvarchar](100),
 	@FirstName [nvarchar](250),
    @LastName [nvarchar](250),    
    @PasswordHash [varbinary](max),
    @PasswordSalt [varbinary](max),
    @UserType [nvarchar](50) = NULL,
	@PermissionLevel [nvarchar](50),
    @CreatedBy [int],
    @CreatedOn [datetime2](7),    
    @StatusCode [nvarchar](8)
AS
BEGIN
    INSERT [dbo].[RNDLogin](UserName,FirstName,LastName,UserType,PasswordHash,PasswordSalt,PermissionLevel,CreatedBy,CreatedOn,StatusCode)
			VALUES (@UserName,@FirstName,@LastName,@UserType,@PasswordHash,@PasswordSalt,@PermissionLevel,@CreatedBy,@CreatedOn,@StatusCode)

	DECLARE @User_Id int
	SELECT @User_Id = UserId
	FROM [dbo].[RNDLogin]
	WHERE @@ROWCOUNT > 0 AND UserId = scope_identity()
    
	SELECT t0.UserId
	FROM [dbo].[RNDLogin] AS t0
	WHERE @@ROWCOUNT > 0 AND t0.UserId = @User_Id
END


GO
/****** Object:  StoredProcedure [dbo].[RNDLogin_ReadByID]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDLogin_ReadByID] @UserName VARCHAR(100)
AS
	BEGIN
		SELECT UserId,FirstName,LastName,UserType,PasswordHash,PasswordSalt,PermissionLevel,IssueDate,CreatedBy,CreatedOn,StatusCode
		FROM RNDLogin
		WHERE UserName = @UserName And StatusCode != 'D'
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDLogin_Update]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RNDLogin_Update]
	@UserId INT,
 	@FirstName [nvarchar](250),
    @LastName [nvarchar](250),    
    @UserType [nvarchar](50) = NULL,
	@PermissionLevel [nvarchar](50)
AS
BEGIN
    UPDATE [RNDLogin] SET FirstName = @FirstName, LastName = @LastName, UserType = @UserType, PermissionLevel = @PermissionLevel 
			WHERE UserId = @UserId
END


GO
/****** Object:  StoredProcedure [dbo].[RNDLotID_READ]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDLotID_READ]
@WorkStudyID varchar(10)
AS
	BEGIN
		SELECT distinct ProcessID as LotID into #tempRNDProcessing FROM RNDProcessing where @WorkStudyID = WorkStudyID
		 AND ProcessID is not NULL
------------------------------------------------------------------------------------------------------------
--DELETE FLAGS
		AND ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------

insert into #tempRNDProcessing (LotID)
	select distinct MillLotNo as LotID from RNDMaterial where @WorkStudyID = WorkStudyID
		 AND MillLotNo is not NULL
------------------------------------------------------------------------------------------------------------
--DELETE FLAGS
		AND ((Deleted != 1 )or(Deleted is null))

		 select * from #tempRNDProcessing


		 drop table #tempRNDProcessing	END


GO
/****** Object:  StoredProcedure [dbo].[RNDMaterial_Delete]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDMaterial_Delete]
    @RecId [int]
	--@WorkStudyID 
AS
BEGIN
	
-----------------------------------------------------------------------------------------------------------
--DELETE WITHOUT FLAGS

 --   INSERT [dbo].[RNDMaterialDeleted]
	--		( [RecID], [WorkStudyID], [SoNum], [MillLotNo], [CustPart], [UACPart], [Alloy], [Temper], [GageThickness], [Location2],
	--		[Hole], [PieceNo], [Comment], [EntryDate], [EntryBy], [DBCntry] )
	
	--SELECT [RecID], [WorkStudyID], [SoNum], [MillLotNo], [CustPart], [UACPart], [Alloy], [Temper], [GageThickness], [Location2],
	--[Hole], [PieceNo], [Comment], [EntryDate], [EntryBy], [DBCntry]
	--FROM RNDMaterial WITH(NOLOCK)
	--WHERE RecID = @RecId

	--DELETE [dbo].[RNDMaterial] WHERE ([RecId] = @RecId)
------------------------------------------------------------------------------------------------------------
--DELETE FLAGS
		UPDATE [dbo].[RNDMaterial]
		SET Deleted = 1 
		WHERE [RecId] = @RecId
		AND ((Deleted != 1 )or(Deleted is null))
  	
------------------------------------------------------------------------------------------------------------

END



GO
/****** Object:  StoredProcedure [dbo].[RNDMillLotNo_READ]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDMillLotNo_READ] @WorkStudyID char(10)
AS
	BEGIN
		SELECT distinct MillLotNo FROM [dbo].[RNDMaterial] 
		where WorkStudyID = @WorkStudyID
------------------------------------------------------------------------------------------------------------
--DELETE WITH FLAGS
		AND ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDModulusCompression_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDModulusCompression_Insert]
		@WorkStudyID char(10),
        @TestNo int,
        @SubConduct numeric(4,1),
        @SurfConduct numeric(4,1),
		@EModulusCompression numeric(4,1),		
        @SpeciComment char(50),
        @Operator char(20),
        @TestDate datetime,
        @TestTime char(15),
        @EntryBy char(25),
        @EntryDate datetime,
        @Completed char(1)
AS
BEGIN		
	INSERT INTO [dbo].[RNDModulusCompressionResults]	
      ([WorkStudyID]
      ,[TestNo]
      ,[SubConduct]
      ,[SurfConduct]
	  ,[EModulusCompression]      
      ,[SpeciComment]
      ,[Operator]
      ,[TestDate]
      ,[TestTime]
      ,[EntryBy]
      ,[EntryDate]
      ,[Completed])
     VALUES
	 (
	 	@WorkStudyID,
        @TestNo ,
        @SubConduct ,
        @SurfConduct,
		@EModulusCompression ,       
        @SpeciComment ,
        @Operator ,
        @TestDate ,
        @TestTime ,
        @EntryBy ,
        @EntryDate ,
        @Completed 
	 )

    DECLARE @RecId int

	SELECT @RecId = [RecID]
	FROM [dbo].[RNDModulusCompressionResults]
	WHERE @@ROWCOUNT > 0 AND [RecID] = scope_identity()

	SELECT t0.[RecID]
	FROM [dbo].[RNDModulusCompressionResults] AS t0
	WHERE @@ROWCOUNT > 0 AND t0.[RecID] = @RecId
END



GO
/****** Object:  StoredProcedure [dbo].[RNDModulusTension_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDModulusTension_Insert]
		@WorkStudyID char(10),
        @TestNo int,
        @SubConduct numeric(4,1),
        @SurfConduct numeric(4,1),
		@EModulusTension numeric(4,1),		
        @SpeciComment char(50),
        @Operator char(20),
        @TestDate datetime,
        @TestTime char(15),
        @EntryBy char(25),
        @EntryDate datetime,
        @Completed char(1)
AS
BEGIN		
	INSERT INTO [dbo].RNDModulusTensionResults
      ([WorkStudyID]
      ,[TestNo]
      ,[SubConduct]
      ,[SurfConduct]
	  ,[EModulusTension]      
      ,[SpeciComment]
      ,[Operator]
      ,[TestDate]
      ,[TestTime]
      ,[EntryBy]
      ,[EntryDate]
      ,[Completed])
     VALUES
	 (
	 	@WorkStudyID,
        @TestNo ,
        @SubConduct ,
        @SurfConduct,
		@EModulusTension ,       
        @SpeciComment ,
        @Operator ,
        @TestDate ,
        @TestTime ,
        @EntryBy ,
        @EntryDate ,
        @Completed 
	 )

    DECLARE @RecId int

	SELECT @RecId = [RecID]
	FROM [dbo].RNDModulusTensionResults
	WHERE @@ROWCOUNT > 0 AND [RecID] = scope_identity()

	SELECT t0.[RecID]
	FROM [dbo].RNDModulusTensionResults AS t0
	WHERE @@ROWCOUNT > 0 AND t0.[RecID] = @RecId
END



GO
/****** Object:  StoredProcedure [dbo].[RNDNotchYield_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDNotchYield_Insert]
		@WorkStudyID char(10),
        @TestNo int,
        @SubConduct numeric(4,1),
        @SurfConduct numeric(4,1),
		@NotchStrengthKsi numeric(4,1),
        @YieldStrengthKsi numeric(3,0),
        @NotchYieldRatio numeric(5,3),
        @SpeciComment char(50),
        @Operator char(20),
        @TestDate datetime,
        @TestTime char(15),
        @EntryBy char(25),
        @EntryDate datetime,
        @Completed char(1)
AS
BEGIN		
	INSERT INTO [dbo].[RNDNotchYieldResults]
		([WorkStudyID]
		,[TestNo]
		,[SubConduct]
		,[SurfConduct]
		,[NotchStrengthKsi]
		,[YieldStrengthKsi]
		,[NotchYieldRatio]
		,[SpeciComment]
		,[Operator]
		,[TestDate]
		,[TestTime]
		,[EntryBy]
		,[EntryDate]
		,[Completed])
     VALUES
	 (
	 	@WorkStudyID
		,@TestNo
		,@SubConduct
		,@SurfConduct
		,@NotchStrengthKsi
		,@YieldStrengthKsi
		,@NotchYieldRatio
		,@SpeciComment
		,@Operator
		,@TestDate
		,@TestTime
		,@EntryBy
		,@EntryDate
		,@Completed
	 )

    DECLARE @RecId int

	SELECT @RecId = [RecID]
	FROM [dbo].[RNDNotchYieldResults]
	WHERE @@ROWCOUNT > 0 AND [RecID] = scope_identity()

	SELECT t0.[RecID]
	FROM [dbo].[RNDNotchYieldResults] AS t0
	WHERE @@ROWCOUNT > 0 AND t0.[RecID] = @RecId
END



GO
/****** Object:  StoredProcedure [dbo].[RNDOpticalMountReports_Read]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
CREATE PROCEDURE 
[dbo].[RNDOpticalMountReports_Read] 
	@CurrentPage INT, @NoOfRecords INT,@WorkStudyID VARCHAR(50) = NULL,@TestType VARCHAR(35),
	@Alloy VARCHAR(10) = NULL,@Temper VARCHAR(10) = NULL,@CustPart VARCHAR(30) = NULL, @UACPart VARCHAR(MAX) = NULL
AS
	BEGIN
		DECLARE @total INT
		--SELECT @total = COUNT(*) FROM [dbo].[RNDWorkStudy]

		IF OBJECT_ID('tempdb..#TempOpticalMountReports') IS NOT NULL
		BEGIN
			DROP TABLE #TempRNDOpticalMountReports
		END

		SELECT A.RecId AS RecId, RTRIM(A.WorkStudyID) AS WorkStudyID, A.TestingNo as TestNo, 
		B.Alloy,B.Temper, B.CustPart, B.UACPart, 
		RTRIM(A.SpeciComment) AS SpeciComment, RTRIM(A.Operator) AS Operator, 
		CONVERT(VARCHAR,A.TestDate,101) AS TestDate,
		RTRIM(A.TimeHrs) AS TimeHrs, RTRIM(A.TimeMns) AS TimeMns, 
		CONVERT(VARCHAR,A.EntryDate,101) AS EntryDate,
		A.EntryBy, Completed		
		INTO #TempRNDOpticalMountReports
		FROM RNDOpticalMountResults A
		LEFT JOIN RNDTesting B 
		ON A.TestingNo = B.testingNo 
		WHERE 1=1
		AND (@WorkStudyID IS NULL OR A.WorkStudyID LIKE '%' + @WorkStudyID + '%')
		AND (@TestType IS NULL OR B.TestType LIKE '%' + @TestType + '%')
		AND (@Alloy IS NULL OR B.Alloy LIKE '%' + @Alloy + '%')
		AND (@Temper IS NULL OR B.Temper LIKE '%' + @Temper + '%')
		AND (@CustPart IS NULL OR B.CustPart LIKE '%' + @CustPart + '%')
		AND (@UACPart IS NULL OR CAST(B.UACPart AS VARCHAR(MAX)) LIKE '%' + @UACPart + '%')
		AND ((Deleted != 1 )or(Deleted is null)) 
-----------------------------------------------------------------------------------------------------------
		SELECT @total = COUNT(*) FROM #TempRNDOpticalMountReports WITH(NOLOCK)

		SELECT @total AS [total], 
		RecId, WorkStudyID, TestNo, 
		Alloy,Temper, CustPart, UACPart, 
		SpeciComment,  Operator, 
		TestDate, TimeHrs,TimeMns,  EntryDate, EntryBy, Completed	
		FROM #TempRNDOpticalMountReports WITH(NOLOCK)
		ORDER BY RecId DESC
			OFFSET ((@CurrentPage)*@NoOfRecords) ROWS
			FETCH NEXT @NoOfRecords ROWS ONLY

		DROP TABLE #TempRNDOpticalMountReports		
	END 

GO
/****** Object:  StoredProcedure [dbo].[RNDPcNo_READByMilLotNo]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDPcNo_READByMilLotNo] 
@MillLotNo int,
@WorkStudyId varchar(10)
AS
	BEGIN
		SELECT distinct PieceNo FROM [dbo].[RNDMaterial] where MillLotNo = @MillLotNo and WorkStudyID = @WorkStudyId
		
		AND  (PieceNo not like '%'+'-1'+'%')
		AND (PieceNo is not NULL)
		AND (rtrim(PieceNo) != '')
------------------------------------------------------------------------------------------------------------
--DELETE WITHOUT FLAGS
		AND ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------

	END


GO
/****** Object:  StoredProcedure [dbo].[RNDPrintTesting]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDPrintTesting]
(
@TestingNos VARCHAR(MAX) = NULL,
@WorkStudyID VARCHAR(MAX) = NULL
)
AS
BEGIN	
	DECLARE @total INT
	IF (@TestingNos IS NOT NULL)
	BEGIN
		DECLARE @x XML 
		SELECT 	@x = CAST('<A>'+ REPLACE(@TestingNos,',','</A><A>')+ '</A>' AS XML);		
		
		SET @total = (SELECT COUNT(*) FROM [dbo].[RNDTesting]  
------------------------------------------------------------------------------------------------------------
--DELETE  FLAGS
		WHERE ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------
		AND TestingNo IN 
		(SELECT t.value('.', 'int') AS inVal FROM @x.nodes('/A') AS x(t)))

		 UPDATE [RNDTesting]
		 SET Printed = 'X'
		 WHERE ((Deleted != 1 )or(Deleted is null))
		 AND TestingNo IN (SELECT t.value('.', 'int') AS inVal FROM @x.nodes('/A') AS x(t))

		SELECT @total as total, TestingNo, Alloy, GageThickness, Hole,Location1, Location2, Location3, LotID,
		Orientation, PieceNo, SpeciComment, TestType, SubTestType, Temper, TestLab, UACPart, WorkStudyID,[Printed] 
		 FROM [dbo].[RNDTesting] 
------------------------------------------------------------------------------------------------------------
--DELETE  FLAGS
		WHERE ((Deleted != 1 )or(Deleted is null))

------------------------------------------------------------------------------------------------------------
		 AND TestingNo IN (SELECT t.value('.', 'int') AS inVal FROM @x.nodes('/A') AS x(t))

		
	END
	ELSE	
	BEGIN
		SET @total = (SELECT COUNT(*) FROM [dbo].[RNDTesting] 
				WHERE ((Deleted != 1 )or(Deleted is null))
				AND WorkStudyID = @WorkStudyID
				)
				 
		UPDATE [RNDTesting]
		 SET Printed = 'X'
		 WHERE ((Deleted != 1 )or(Deleted is null))	
		 AND WorkStudyID = @WorkStudyID

		SELECT @total as total, TestingNo, Alloy, GageThickness, Hole,Location1, Location2, Location3, LotID,
		Orientation, PieceNo, SpeciComment, TestType, SubTestType, Temper, TestLab, UACPart, WorkStudyID,[Printed]
		FROM [dbo].[RNDTesting]
		WHERE ((Deleted != 1 )or(Deleted is null))
		AND WorkStudyID = @WorkStudyID
------------------------------------------------------------------------------------------------------------
--DELETE WITHOUT FLAGS
	--	SET @total = (SELECT COUNT(*) FROM [dbo].[RNDTesting] )
		
		--SELECT @total as total, TestingNo, Alloy, GageThickness, Hole,Location1, Location2, Location3, LotID,
		--Orientation, PieceNo, SpeciComment, TestType, SubTestType, Temper, TestLab, UACPart, WorkStudyID
		--FROM [dbo].[RNDTesting]

------------------------------------------------------------------------------------------------------------
	 	
	END
END;


GO
/****** Object:  StoredProcedure [dbo].[RNDProcessing_Delete]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDProcessing_Delete]
    @RecId [int]
AS
BEGIN
	IF EXISTS(
		SELECT 	RecID
		FROM RNDProcessing WITH(NOLOCK)
		WHERE RecID = @RecId 
		AND ((Deleted != 1 )or(Deleted is null)))
	BEGIN
		UPDATE RNDProcessing SET Deleted = 1 where ([RecId] = @RecId)
	END
END



GO
/****** Object:  StoredProcedure [dbo].[RNDProcessingMaterial_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDProcessingMaterial_Insert]

@WorkStudyID [char](10) = NULL,
@MillLotNo [int] ,
@PieceNo [char](2) = NULL, 
@FinalTemper[char](10) = NULL,
@AgeLotNo [int] , 
@Hole [char](2) = NULL,  
@SHTTemp [char](2) = NULL,
@SHSoakHrs [char](2) = NULL, 
@SHSoakMns [char](2) = NULL, 
@SHTStartHrs[char](2) = NULL, 
@SHTStartMns[char](2) = NULL,
@StretchPct [char](5) = NULL, 
@SHTDate [datetime] = NULL, 
@AfterSHTHrs[char](2) = NULL,
@AfterSHTMns[char](2) = NULL, 
@NatAgingHrs[char](2) = NULL, 
@NatAgingMns [char](2) = NULL, 
@ArtStartHrs[char](2) = NULL,
@ArtStartMns [char](2) = NULL, 
@ArtAgeDate [datetime]= NULL, 
@ArtAgeTemp1[char](5) = NULL, 
@ArtAgeHrs1 [char](2) = NULL,
@ArtAgeMns1 [char](2) = NULL, 
@ArtAgeTemp2 [char](5) = NULL, 
@ArtAgeHrs2 [char](2) = NULL, 
@ArtAgeMns2 [char](2) = NULL,
@ArtAgeTemp3 [char](5) = NULL, 
@ArtAgeHrs3[char](2) = NULL, 
@ArtAgeMns3[char](2) = NULL, 
@TargetCount[char](10) = NULL,
@ActualCount[char](10) = NULL, 
@total [int] , 
@RNDLotID [char](5) = NULL, 
@HTLogNo [int]

AS
BEGIN

		declare @MillLotNoChar nvarchar(10)			
		declare @CountInt int
		declare @ProcessID [char](10) = NULL
		declare @ProcessNo [char](10) = NULL
		declare @Sonum [char](10) = NULL

		set @MillLotNoChar =  CAST( @MillLotNo as varchar(10) )		

		--set @CountInt = (select count(*) from  rndprocessing where ProcessID like '%'+@MillLotNoChar+'%' )
		set @CountInt = (select count(*) from  rndprocessing where MillLotNo = @MillLotNo)+1

		set @ProcessNo = cast(@CountInt as varchar(10))
		set @ProcessID =  @MillLotNoChar +'-P' + cast(@CountInt as varchar(10))

		set @Sonum =  (select top 1 [SoNum] from [dbo].[RNDMaterial] where [MillLotNo] = @MillLotNo)

------------------------------------------------------------------------------------------------------------
--DELETE WITHOUT FLAGS
		 
	--INSERT [dbo].[RNDProcessing]
	--( WorkStudyID, MillLotNo, Sonum, ProcessNo,
	-- ProcessID,
	--HTLogNo,  AgeLotNo,  Hole, PieceNo,
	--SHTTemp, SHSoakHrs, SHSoakMns, SHTStartHrs, SHTStartMns, SHTDate, StretchPct, AfterSHTHrs, AfterSHTMns, NatAgingHrs,
	--NatAgingMns, ArtStartHrs, ArtStartMns, ArtAgeDate, ArtAgeTemp1, ArtAgeHrs1, ArtAgeMns1, ArtAgeTemp2, ArtAgeHrs2,
	--ArtAgeMns2, ArtAgeTemp3, ArtAgeHrs3, ArtAgeMns3, FinalTemper, TargetCount, ActualCount
	--)
	--VALUES( @WorkStudyID, @MillLotNo, @Sonum, @ProcessNo, 
	--@ProcessID, 
	--@HTLogNo,  @AgeLotNo, @Hole, @PieceNo,
	--@SHTTemp, @SHSoakHrs, @SHSoakMns, @SHTStartHrs, @SHTStartMns, @SHTDate, @StretchPct, @AfterSHTHrs, @AfterSHTMns, @NatAgingHrs,
	--@NatAgingMns, @ArtStartHrs, @ArtStartMns, @ArtAgeDate, @ArtAgeTemp1, @ArtAgeHrs1, @ArtAgeMns1, @ArtAgeTemp2, @ArtAgeHrs2,
	--@ArtAgeMns2, @ArtAgeTemp3, @ArtAgeHrs3, @ArtAgeMns3, @FinalTemper, @TargetCount, @ActualCount
	--)

	
------------------------------------------------------------------------------------------------------------
--DELETE WITH FLAGS

	INSERT [dbo].[RNDProcessing]
	( WorkStudyID, MillLotNo, Sonum, ProcessNo,
	 ProcessID,
	HTLogNo,  AgeLotNo,  Hole, PieceNo,
	SHTTemp, SHSoakHrs, SHSoakMns, SHTStartHrs, SHTStartMns, SHTDate, StretchPct, AfterSHTHrs, AfterSHTMns, NatAgingHrs,
	NatAgingMns, ArtStartHrs, ArtStartMns, ArtAgeDate, ArtAgeTemp1, ArtAgeHrs1, ArtAgeMns1, ArtAgeTemp2, ArtAgeHrs2,
	ArtAgeMns2, ArtAgeTemp3, ArtAgeHrs3, ArtAgeMns3, FinalTemper, TargetCount, ActualCount,Deleted
	)
	VALUES( @WorkStudyID, @MillLotNo, 
	@Sonum, @ProcessNo, 	@ProcessID, 
	@HTLogNo,  @AgeLotNo, @Hole, @PieceNo,
	@SHTTemp, @SHSoakHrs, @SHSoakMns, @SHTStartHrs, @SHTStartMns, @SHTDate, @StretchPct, @AfterSHTHrs, @AfterSHTMns, @NatAgingHrs,
	@NatAgingMns, @ArtStartHrs, @ArtStartMns, @ArtAgeDate, @ArtAgeTemp1, @ArtAgeHrs1, @ArtAgeMns1, @ArtAgeTemp2, @ArtAgeHrs2,
	@ArtAgeMns2, @ArtAgeTemp3, @ArtAgeHrs3, @ArtAgeMns3, @FinalTemper, @TargetCount, @ActualCount,0
	)
------------------------------------------------------------------------------------------------------------

    DECLARE @RecId int
    SELECT @RecId = [RecId]
    FROM [dbo].[RNDProcessing]
    WHERE @@ROWCOUNT > 0 AND [RecId] = scope_identity()
    
    SELECT t0.[RecId]
    FROM [dbo].[RNDProcessing] AS t0
    WHERE @@ROWCOUNT > 0 AND t0.[RecId] = @RecId

END



GO
/****** Object:  StoredProcedure [dbo].[RNDProcessingMaterial_Read]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDProcessingMaterial_Read] 
	@CurrentPage INT, @NoOfRecords INT, @WorkStudyID VARCHAR(50) = NULL, @MillLotNo VARCHAR(50) = NULL,
	@HTLogID VARCHAR(10) = NULL , @AgeLotID VARCHAR(10) = NULL

	--,@StudyType VARCHAR(10) = NULL,	@Plant VARCHAR(10) = NULL,@StudyStatus VARCHAR(10) = NULL
AS
	BEGIN
		DECLARE @total INT
		--SELECT @total = COUNT(*) FROM [dbo].[RNDProcessing]

		IF OBJECT_ID('tempdb..#TempRNDProcessingMaterial') IS NOT NULL
		BEGIN
			DROP TABLE #TempRNDProcessingMaterial
		END

		SELECT pm.RecId AS RecId,RTRIM(pm.WorkStudyID) AS WorkStudyID,
		pm.MillLotNo,pm.Hole,pm.PieceNo, pm.FinalTemper, pm.Sonum, pm.ProcessNo , pm.ProcessID,
		pm.HTLogNo, pm.HTLogID, pm.AgeLotNo, pm.AgeLotID, pm.SHTTemp, pm.SHSoakHrs, pm.SHSoakMns,
		pm.SHTStartHrs , pm.SHTStartMns , 
		CONVERT(VARCHAR,SHTDate,101) AS SHTDate,
		pm.StretchPct, pm.AfterSHTHrs , pm.AfterSHTMns, pm.NatAgingHrs , pm.NatAgingMns,
		pm.ArtStartHrs, pm.ArtStartMns, 
		CONVERT(VARCHAR,ArtAgeDate,101) AS ArtAgeDate,
		pm.ArtAgeTemp1, pm.ArtAgeHrs1, pm.ArtAgeMns1,
		pm.ArtAgeTemp2, pm.ArtAgeHrs2, pm.ArtAgeMns2,
		pm.ArtAgeTemp3, pm.ArtAgeHrs3, pm.ArtAgeMns3,
		pm.TargetCount, pm.ActualCount,'' AS RNDLotID
		INTO #TempRNDProcessingMaterial
		FROM [RNDProcessing] pm WITH(NOLOCK)
		--LEFT JOIN RNDstudyscope scope ON RTRIM(ws.WorkStudyID) = RTRIM(scope.WorkStudyID)
		--LEFT JOIN RNDLot_ID lot ON RTRIM(PM.WorkStudyID) = RTRIM(lot.WorkStudyID)
		WHERE 1=1
		AND (@WorkStudyID IS NULL OR pm.WorkStudyID LIKE '%' + @WorkStudyID + '%')
		AND (@MillLotNo IS NULL OR pm.MillLotNo =  @MillLotNo )
		AND (@HTLogID IS NULL OR pm.HTLogID = @HTLogID)
		AND (@AgeLotID IS NULL OR pm.AgeLotID = @AgeLotID)
------------------------------------------------------------------------------------------------------------
--DELETE WITHOUT FLAGS
		AND ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------

		SELECT @total = COUNT(*) FROM  #TempRNDProcessingMaterial WITH(NOLOCK)

		SELECT @total AS total, pm.RecId AS RecId,RTRIM(pm.WorkStudyID) AS WorkStudyID,
		pm.MillLotNo,pm.Hole,pm.PieceNo, pm.FinalTemper, pm.Sonum, pm.ProcessNo , pm.ProcessID,
		pm.HTLogNo, pm.HTLogID, pm.AgeLotNo, pm.AgeLotID, pm.SHTTemp, pm.SHSoakHrs, pm.SHSoakMns,
		pm.SHTStartHrs , pm.SHTStartMns, 
		CONVERT(VARCHAR,SHTDate,101) AS SHTDate,
		pm.StretchPct, pm.AfterSHTHrs , pm.AfterSHTMns, pm.NatAgingHrs , pm.NatAgingMns,
		pm.ArtStartHrs, pm.ArtStartMns, 
		CONVERT(VARCHAR,ArtAgeDate,101) AS ArtAgeDate,
		pm.ArtAgeTemp1, pm.ArtAgeHrs1, pm.ArtAgeMns1,
		pm.ArtAgeTemp2, pm.ArtAgeHrs2, pm.ArtAgeMns2,
		pm.ArtAgeTemp3, pm.ArtAgeHrs3, pm.ArtAgeMns3,
		pm.TargetCount, pm.ActualCount, '' AS RNDLotID		
		FROM #TempRNDProcessingMaterial pm
		ORDER BY RecId DESC
			OFFSET ((@CurrentPage)*@NoOfRecords) ROWS
			FETCH NEXT @NoOfRecords ROWS ONLY

		DROP TABLE #TempRNDProcessingMaterial
	END



GO
/****** Object:  StoredProcedure [dbo].[RNDProcessingMaterial_ReadByID]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDProcessingMaterial_ReadByID] @RecId INT
AS
	BEGIN
		SELECT @RecId AS RecId,RTRIM(pm.WorkStudyID) AS WorkStudyID,
		pm.MillLotNo,pm.Hole,pm.PieceNo, pm.FinalTemper, pm.Sonum, pm.ProcessNo , pm.ProcessID,
		pm.HTLogNo, pm.HTLogID, pm.AgeLotNo, pm.AgeLotID, pm.SHTTemp, pm.SHSoakHrs, pm.SHSoakMns,
		pm.SHTStartHrs , pm.SHTStartMns , 
		CONVERT(VARCHAR,SHTDate,101) AS SHTDate,
		pm.StretchPct, pm.AfterSHTHrs , pm.AfterSHTMns, pm.NatAgingHrs , pm.NatAgingMns,
		pm.ArtStartHrs, pm.ArtStartMns, 
		CONVERT(VARCHAR,ArtAgeDate,101) AS ArtAgeDate,
		pm.ArtAgeTemp1, pm.ArtAgeHrs1, pm.ArtAgeMns1,
		pm.ArtAgeTemp2, pm.ArtAgeHrs2, pm.ArtAgeMns2,
		pm.ArtAgeTemp3, pm.ArtAgeHrs3, pm.ArtAgeMns3,
		pm.TargetCount, pm.ActualCount, '' AS RNDLotID,0 AS total
		FROM RNDProcessing pm
		--JOIN RNDstudyscope scope ON RTRIM(ws.WorkStudyID) = RTRIM(scope.WorkStudyID)
		WHERE pm.RecId = @RecId
------------------------------------------------------------------------------------------------------------
--DELETE FLAGS
		AND ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------

	END


GO
/****** Object:  StoredProcedure [dbo].[RNDProcessingMaterial_Update]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDProcessingMaterial_Update]
@RecId [int], 
@WorkStudyID [char](10) = NULL, 
@MillLotNo [int] = NULL, 
--@Sonum [char](10) = NULL, 
--@ProcessNo[tinyint] = NULL, 
--@ProcessID [char](10) = NULL,
--@HTLogNo [int] = NULL,
--@HTLogID [char](10) = NULL, 
--@AgeLotNo [int] = NULL, 
--@AgeLotID [char](10) = NULL,
@Hole [char](2) = NULL, 
@PieceNo [char](2) = NULL,
@SHTTemp [char](2) = NULL,
@SHSoakHrs [char](2) = NULL, 
@SHSoakMns [char](2) = NULL, 
@SHTStartHrs[char](2) = NULL,
@SHTStartMns[char](2) = NULL,
@SHTDate [datetime] = NULL, 
@StretchPct [char](5) = NULL, 
@AfterSHTHrs[char](2) = NULL,
@AfterSHTMns[char](2) = NULL, 
@NatAgingHrs[char](2) = NULL, 
@NatAgingMns [char](2) = NULL, 
@ArtStartHrs[char](2) = NULL,
@ArtStartMns [char](2) = NULL, 
@ArtAgeDate [datetime] = NULL, 
@ArtAgeTemp1[char](5) = NULL,
@ArtAgeHrs1 [char](2) = NULL,
@ArtAgeMns1 [char](2) = NULL, 
@ArtAgeTemp2 [char](5) = NULL, 
@ArtAgeHrs2 [char](2) = NULL, 
@ArtAgeMns2 [char](2) = NULL,
@ArtAgeTemp3 [char](5) = NULL, 
@ArtAgeHrs3[char](2) = NULL, 
@FinalTemper[char](10) = NULL,
@TargetCount[char](10) = NULL,
@ActualCount[char](10) = NULL,
@ArtAgeMns3[char](2) = NULL 
AS
BEGIN

    UPDATE [dbo].RNDProcessing
    SET 
--	[Sonum] = @Sonum, 
--      [ProcessNo] = @ProcessNo,
--      [ProcessID] = @ProcessID, 
      --[HTLogNo] = @HTLogNo, 
      --[HTLogID] = @HTLogID, 
     -- [AgeLotNo] = @AgeLotNo, 
      --[AgeLotID] = @AgeLotID, 
      [Hole] = @Hole, 
      [PieceNo] = @PieceNo,
      [SHTTemp] = @SHTTemp, 
      [SHSoakHrs] = @SHSoakHrs, 
      [SHSoakMns] = @SHSoakMns,
      [SHTStartHrs] = @SHTStartHrs, 
      [SHTStartMns] = @SHTStartMns, 
      [SHTDate] = @SHTDate, 
      [StretchPct] = @StretchPct,    
	  [AfterSHTHrs] = @AfterSHTHrs, 
      [AfterSHTMns] = @AfterSHTMns, 
      [NatAgingHrs] = @NatAgingHrs, 
      [NatAgingMns] = @NatAgingMns, 
      [ArtStartHrs] = @ArtStartHrs, 
      [ArtStartMns] = @ArtStartMns, 
      [ArtAgeDate] = @ArtAgeDate, 
      [ArtAgeTemp1] = @ArtAgeTemp1, 
      [ArtAgeHrs1] = @ArtAgeHrs1, 
      [ArtAgeMns1] = @ArtAgeMns1, 
      [ArtAgeTemp2] = @ArtAgeTemp2, 
      [ArtAgeHrs2] = @ArtAgeHrs2,   
	  [ArtAgeMns2] = @ArtAgeMns2, 
      [ArtAgeTemp3] = @ArtAgeTemp3, 
      [ArtAgeHrs3] = @ArtAgeHrs3, 
      [ArtAgeMns3] = @ArtAgeMns3, 
      [FinalTemper] = @FinalTemper, 
      [TargetCount] = @TargetCount, 
      [ActualCount] = @ActualCount
	--MillLotNo = @MillLotNo, 
	--Sonum = @Sonum, 
	--ProcessNo = @ProcessNo, 
	--ProcessID = @ProcessID,
	--HTLogNo = @HTLogNo, AgeLotNo = @AgeLotNo, Hole = @Hole, PieceNo = @PieceNo,
	--SHTTemp = @SHTTemp, SHSoakHrs = @SHSoakHrs, SHSoakMns = @SHSoakMns, SHTStartHrs = @SHTStartHrs, SHTStartMns = @SHTStartMns,
	--SHTDate = @SHTDate, StretchPct = @StretchPct, AfterSHTHrs = @AfterSHTHrs, AfterSHTMns = @AfterSHTMns, NatAgingHrs = @NatAgingHrs,
	--NatAgingMns = @NatAgingMns, ArtStartHrs = @ArtStartHrs, ArtStartMns = @ArtStartMns, ArtAgeDate = @ArtAgeDate, 
	--ArtAgeTemp1 = @ArtAgeTemp1, ArtAgeHrs1 = @ArtAgeHrs1, ArtAgeMns1 = @ArtAgeMns1, ArtAgeTemp2 = @ArtAgeTemp2, 
	--ArtAgeHrs2 = @ArtAgeHrs2, ArtAgeMns2 = @ArtAgeMns2, ArtAgeTemp3 = @ArtAgeTemp3, ArtAgeHrs3 = @ArtAgeHrs3, 
	--ArtAgeMns3 = @ArtAgeMns3, FinalTemper = @FinalTemper, TargetCount = @TargetCount, ActualCount = @ActualCount
	WHERE [RecId] = @RecId 
	--AND [WorkStudyID] = @WorkStudyID
END



GO
/****** Object:  StoredProcedure [dbo].[RNDRegisteredUser_Read]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDRegisteredUser_Read] @CurrentPage INT, @NoOfRecords INT, @UserId VARCHAR(50) = NULL, 
				@UserName VARCHAR(50) = NULL, @FirstName VARCHAR(50) = NULL, @LastName VARCHAR(50) = NULL, @PermissionLevel VARCHAR(50) = NULL
AS
	BEGIN

		IF OBJECT_ID('tempdb..#TempRNDLogin') IS NOT NULL
		BEGIN
			DROP TABLE #TempRNDLogin
		END

		DECLARE @total INT
		--SELECT @total = COUNT(*) FROM [dbo].[RNDLogin] WITH(NOLOCK)		
		declare @CreatedBy nvarchar(100)
		set @CreatedBy = (select UserName FROM [dbo].[RNDLogin] WITH(NOLOCK)
						 where CreatedBy = UserId)
		
		SELECT UserId AS UserId, UserName, FirstName, LastName, PermissionLevel,					
		@CreatedBy AS CreatedBy, CONVERT(VARCHAR,CreatedOn,101) AS CreatedOn, StatusCode
		INTO #TempRNDLogin
		FROM [dbo].[RNDLogin] WITH(NOLOCK)
		WHERE 1 = 1 AND UserId > 0 
		--AND StatusCode != 'D' AND PermissionLevel != 'SuperAdmin'
		AND (@UserId IS NULL OR UserId = @UserId)
		AND (@UserName IS NULL OR UserName LIKE '%' + @UserName + '%')
		AND (@FirstName IS NULL OR FirstName LIKE '%' + @FirstName + '%')
		AND (@LastName IS NULL OR LastName LIKE '%' + @LastName + '%')
		--AND (@PermissionLevel IS NULL OR PermissionLevel LIKE '%' + @PermissionLevel + '%')	
		AND (@PermissionLevel IS NULL OR upper(rtrim(PermissionLevel)) = upper(rtrim(@PermissionLevel)))
		--ORDER BY UserId DESC
		--	OFFSET ((@CurrentPage) * @NoOfRecords) ROWS
		--	FETCH NEXT @NoOfRecords ROWS ONLY

		SELECT @total = COUNT(*) FROM #TempRNDLogin WITH(NOLOCK)

		SELECT @total AS [total], UserId AS UserId, UserName, FirstName, LastName, PermissionLevel,					
		@CreatedBy AS CreatedBy, CONVERT(VARCHAR,CreatedOn,101) AS CreatedOn, StatusCode
		FROM #TempRNDLogin WITH(NOLOCK)
		ORDER BY UserId DESC
			OFFSET ((@CurrentPage) * @NoOfRecords) ROWS
			FETCH NEXT @NoOfRecords ROWS ONLY

		DROP TABLE #TempRNDLogin
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDRegisteredUser_ReadByID]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDRegisteredUser_ReadByID] @UserId INT = NULL
				
AS
	BEGIN		
		SELECT UD.UserId, UD.UserName, UD.FirstName, UD.LastName, UD.PermissionLevel
		FROM [dbo].[RNDLogin] AS UD WITH(NOLOCK)		
		WHERE UD.UserId = @UserId		
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDReports_Read]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDReports_Read]
(
    @CurrentPage INT, @NoOfRecords INT,@WorkStudyID VARCHAR(50) = NULL,
    @searchFromDate datetime = NULL,
	@searchToDate datetime= NULL,
	@TestType varchar(35) = NULL
)
AS
	BEGIN

	IF ((@searchFromDate = NULL) OR (@searchToDate = NULL))
	BEGIN 
		set @searchFromDate = getdate() - 365
		set @searchToDate = getdate() + 365
	END 	
		DECLARE @total INT		
		DECLARE @StudyDesc VARCHAR(40) 
		
		IF OBJECT_ID('tempdb..#TempRNDReports') IS NOT NULL
		BEGIN
			DROP TABLE #TempRNDReports
		END

---- GET @StudyDesc FROM RNDWorkStudy Table
	
		SET  @StudyDesc = (SELECT [StudyDesc] 
				FROM RNDWorkStudy where WorkStudyID = @WorkStudyID
				AND ((Deleted != 1 )or(Deleted is null)))

----------for TestType = 'Tension'

	if (@TestType = 'Tension')
	begin
		SELECT RecId, RTRIM(WorkStudyID) AS WorkStudyID,[TestNo],
		@StudyDesc as [StudyDesc] ,
			[SubConduct],[SurfConduct],[FtuKsi],[FtyKsi],[eElongation],[EModulusMpsi],[SpeciComment],[Operator],
			CONVERT(VARCHAR,TestDate,101) AS TestDate, EntryDate,
			[TestTime],[EntryBy],[Completed]
		INTO #TempRNDReports
		FROM RNDTensionResults
		WHERE 1=1
		AND (@WorkStudyID IS NULL OR WorkStudyID LIKE '%' + @WorkStudyID + '%')				
		AND EntryDate between  @searchFromDate and @searchToDate
		
		--ORDER BY RecId DESC
		--	OFFSET ((@CurrentPage)*@NoOfRecords) ROWS
		--	FETCH NEXT @NoOfRecords ROWS ONLY

		SELECT @total = COUNT(*) FROM #TempRNDReports WITH(NOLOCK)

		SELECT @total AS [total], 
				 RecId AS RecId, RTRIM(WorkStudyID) AS WorkStudyID,TestNo,
				StudyDesc,
			   SubConduct,SurfConduct,FtuKsi,FtyKsi,eElongation,EModulusMpsi,SpeciComment,Operator,
				TestDate, EntryDate,
				TestTime,EntryBy,Completed		
		FROM #TempRNDReports WITH(NOLOCK)
		ORDER BY RecId DESC
			OFFSET ((@CurrentPage)*@NoOfRecords) ROWS
			FETCH NEXT @NoOfRecords ROWS ONLY

		DROP TABLE #TempRNDReports		
	end
	------------

	----------for TestType = 'Compression'

	else if (@TestType = 'Compression')
	begin
		IF OBJECT_ID('tempdb..#TempRNDReportsCompression') IS NOT NULL
		BEGIN
			DROP TABLE #TempRNDReportsCompression
		END
		SELECT RecId, RTRIM(WorkStudyID) AS WorkStudyID,[TestNo],
		@StudyDesc as [StudyDesc] ,
			[SubConduct],[SurfConduct],[FcyKsi] as FtuKsi,[EcModulusMpsi] as FtyKsi,
			[eElongation] = 0,
			[EModulusMpsi] = 0,
			[SpeciComment],[Operator],
			CONVERT(VARCHAR,TestDate,101) AS TestDate, EntryDate,
			[TestTime],[EntryBy],[Completed]
		INTO #TempRNDReportsCompression
		FROM [RNDCompressionResults]
		WHERE 1=1
		AND (@WorkStudyID IS NULL OR WorkStudyID LIKE '%' + @WorkStudyID + '%')				
		AND EntryDate between  @searchFromDate and @searchToDate
		
		ORDER BY RecId DESC
			OFFSET ((@CurrentPage)*@NoOfRecords) ROWS
			FETCH NEXT @NoOfRecords ROWS ONLY

		SELECT @total = COUNT(*) FROM #TempRNDReportsCompression WITH(NOLOCK)

		SELECT @total AS [total], 
				 RecId AS RecId, RTRIM(WorkStudyID) AS WorkStudyID,TestNo,
				StudyDesc,
			   SubConduct,SurfConduct,FtuKsi,FtyKsi,eElongation,EModulusMpsi,SpeciComment,Operator,
				TestDate, EntryDate,
				TestTime,EntryBy,Completed		
		FROM #TempRNDReportsCompression WITH(NOLOCK)
		
		DROP TABLE #TempRNDReports		

	end
	------------
	
	END;


GO
/****** Object:  StoredProcedure [dbo].[RNDResetPassword]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RNDResetPassword]
(
@UserName VARCHAR(MAX),
@UserAnswer VARCHAR(MAX)
)
AS
BEGIN
	SELECT 
			A.UserId,
			A.FirstName,
			A.LastName,
			A.UserType,			
			A.PermissionLevel,
			A.IssueDate,
			A.CreatedBy,
			A.CreatedOn,
			A.StatusCode,
			D.Token
	FROM RNDLogin A
	JOIN RNDUserSecurityAnswers B ON A.UserId=B.RNDLoginId
	JOIN RNDSecurityQuestions C ON B.RNDSecurityQuestionId= C.RNDSecurityQuestionId
	JOIN RNDSecurityTokens D ON A.UserId=D.UserId
	WHERE A.UserName=@UserName AND B.SecurityAnswer=@UserAnswer
END


GO
/****** Object:  StoredProcedure [dbo].[RNDResidualStrength_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDResidualStrength_Insert]
		@WorkStudyID char(10),
        @TestNo int,
        @SubConduct numeric(4,1),
        @SurfConduct numeric(4,1),
		@Validity char(5),
        @ResidualStrength numeric(4,1),
        @PmaxLBS numeric(7,0),
        @WIn numeric(7,4),
        @BIn numeric(7,4),
        @AvgFinalPreCrack numeric(7,4),
        @SpeciComment char(50),
        @Operator char(20),
        @TestDate datetime,
        @TestTime char(15),
        @EntryBy char(25),
        @EntryDate datetime,
        @Completed char(1)
AS
BEGIN		
	INSERT INTO [dbo].RNDResidualStrengthResults
		([WorkStudyID]
		,[TestNo]
		,[SubConduct]
		,[SurfConduct]
		,[Validity]
        ,[ResidualStrength]
        ,[PmaxLBS]
        ,[WIn]
        ,[BIn]
        ,[AvgFinalPreCrack]
        ,[SpeciComment]
        ,[Operator]
        ,[TestDate]
        ,[TestTime]
        ,[EntryBy]
        ,[EntryDate]
        ,[Completed])
     VALUES
	 (
	 	@WorkStudyID
		,@TestNo
		,@SubConduct
		,@SurfConduct
		,@Validity
        ,@ResidualStrength
        ,@PmaxLBS
        ,@WIn
        ,@BIn
        ,@AvgFinalPreCrack
        ,@SpeciComment
        ,@Operator
        ,@TestDate
        ,@TestTime
        ,@EntryBy
        ,@EntryDate
        ,@Completed
	 )

    DECLARE @RecId int

	SELECT @RecId = [RecID]
	FROM [dbo].RNDResidualStrengthResults
	WHERE @@ROWCOUNT > 0 AND [RecID] = scope_identity()

	SELECT t0.[RecID]
	FROM [dbo].RNDResidualStrengthResults AS t0
	WHERE @@ROWCOUNT > 0 AND t0.[RecID] = @RecId
END



GO
/****** Object:  StoredProcedure [dbo].[RNDSecurityQuestions_READ]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RNDSecurityQuestions_READ]
AS
	BEGIN
		SELECT RNDSecurityQuestionId,Question FROM RNDSecurityQuestions
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDSecurityTokens_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RNDSecurityTokens_Insert] (@UserId INT, @Token VARCHAR(100) = NULL)
AS
	BEGIN
		DELETE FROM RNDSecurityTokens WHERE UserId = @UserId

		INSERT INTO RNDSecurityTokens ([UserId], [Token])
		SELECT @UserId, @Token
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDShear_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDShear_Insert]
		@WorkStudyID char(10),
        @TestNo int,
        @SubConduct numeric(4,1),
        @SurfConduct numeric(4,1),
		@FsuKsi numeric(4,1),     
        @SpeciComment char(50),
        @Operator char(20),
        @TestDate datetime,
        @TestTime char(15),
        @EntryBy char(25),
        @EntryDate datetime,
        @Completed char(1)
AS
BEGIN		
	INSERT INTO [dbo].[RNDShearResults]
      ([WorkStudyID]
      ,[TestNo]
      ,[SubConduct]
      ,[SurfConduct]
      ,[FsuKsi]    
      ,[SpeciComment]
      ,[Operator]
      ,[TestDate]
      ,[TestTime]
      ,[EntryBy]
      ,[EntryDate]
      ,[Completed])
     VALUES
	 (
	 	@WorkStudyID , 
		@TestNo ,
        @SubConduct ,
        @SurfConduct ,
		@FsuKsi,
        @SpeciComment ,
        @Operator ,
        @TestDate ,
        @TestTime ,
        @EntryBy ,
        @EntryDate ,
        @Completed 
	 )

    DECLARE @RecId int

	SELECT @RecId = [RecID]
	FROM [dbo].[RNDShearResults]
	WHERE @@ROWCOUNT > 0 AND [RecID] = scope_identity()

	SELECT t0.[RecID]
	FROM [dbo].[RNDShearResults] AS t0
	WHERE @@ROWCOUNT > 0 AND t0.[RecID] = @RecId
END



GO
/****** Object:  StoredProcedure [dbo].[RNDStudyStatus_READ]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RNDStudyStatus_READ]
AS
	BEGIN
		SELECT StudyStatus,StatusDesc FROM RNDStudyStatus
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDStudyType_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
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
/****** Object:  StoredProcedure [dbo].[RNDStudyType_READ]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDStudyType_READ]
AS
	BEGIN
		SELECT RecID,TypeStudy,TypeDesc FROM RNDStudyType
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDSubTestType_READ]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDSubTestType_READ] 
 @TestType varchar(35)
AS
	BEGIN
		SELECT distinct SubTestType FROM [RNDTestListAndType]  where TestDesc = @TestType

	END


GO
/****** Object:  StoredProcedure [dbo].[RNDTension_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDTension_Insert]
		@WorkStudyID char(10),
        @TestNo int,
        @SubConduct numeric(4,1),
        @SurfConduct numeric(4,1),
        @FtuKsi numeric(4,1),
        @FtyKsi numeric(4,1),
        @eElongation numeric(4,1),
        @EModulusMpsi numeric(4,1),
        @SpeciComment char(50),
        @Operator char(20),
        @TestDate datetime,
        @TestTime char(15),
        @EntryBy char(25),
        @EntryDate datetime,
        @Completed char(1)
AS
BEGIN		
	INSERT INTO [dbo].[RNDTensionResults]
           ([WorkStudyID]
           ,[TestNo]
           ,[SubConduct]
           ,[SurfConduct]
           ,[FtuKsi]
           ,[FtyKsi]
           ,[eElongation]
           ,[EModulusMpsi]
           ,[SpeciComment]
           ,[Operator]
           ,[TestDate]
           ,[TestTime]
           ,[EntryBy]
           ,[EntryDate]
           ,[Completed])
     VALUES
	 (
	 	@WorkStudyID , 
		@TestNo ,
        @SubConduct ,
        @SurfConduct ,
        @FtuKsi ,
        @FtyKsi ,
        @eElongation ,
        @EModulusMpsi ,
        @SpeciComment ,
        @Operator ,
        @TestDate ,
        @TestTime ,
        @EntryBy ,
        @EntryDate ,
        @Completed 
	 )

    DECLARE @RecId int

	SELECT @RecId = [RecID]
	FROM [dbo].[RNDTestList]
	WHERE @@ROWCOUNT > 0 AND [RecID] = scope_identity()

	SELECT t0.[RecID]
	FROM [dbo].[RNDTensionResults] AS t0
	WHERE @@ROWCOUNT > 0 AND t0.[RecID] = @RecId
END



GO
/****** Object:  StoredProcedure [dbo].[RNDTensionReports_Read]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
CREATE PROCEDURE 
[dbo].[RNDTensionReports_Read] 
	@CurrentPage INT, @NoOfRecords INT,@WorkStudyID VARCHAR(50) = NULL,@TestType VARCHAR(35),
	@Alloy VARCHAR(10) = NULL,@Temper VARCHAR(10) = NULL,@CustPart VARCHAR(30) = NULL, @UACPart VARCHAR(MAX) = NULL
AS
	BEGIN
		DECLARE @total INT
		--SELECT @total = COUNT(*) FROM [dbo].[RNDWorkStudy]

		IF OBJECT_ID('tempdb..#TempTensionReports') IS NOT NULL
		BEGIN
			DROP TABLE #TempRNDTensionReports
		END

		SELECT A.RecId AS RecId, RTRIM(A.WorkStudyID) AS WorkStudyID, A.TestNo, 
		B.Alloy,B.Temper, B.CustPart, B.UACPart, 
		A.SubConduct, A.SurfConduct, A.FtuKsi, A.FtyKsi,
		A.eElongation, A.EModulusMpsi, RTRIM(A.SpeciComment) AS SpeciComment, RTRIM(A.Operator) AS Operator, 
		CONVERT(VARCHAR,A.TestDate,101) AS TestDate,
		RTRIM(A.TestTime) AS TestTime, 
		CONVERT(VARCHAR,A.EntryDate,101) AS EntryDate,
		A.EntryBy, Completed		
		INTO #TempRNDTensionReports
		FROM RNDTensionResults A
		LEFT JOIN RNDTesting B 
		ON A.testNo = B.testingNo 
		WHERE 1=1
		AND (@WorkStudyID IS NULL OR A.WorkStudyID LIKE '%' + @WorkStudyID + '%')
		AND (@TestType IS NULL OR B.TestType LIKE '%' + @TestType + '%')
		AND (@Alloy IS NULL OR B.Alloy LIKE '%' + @Alloy + '%')
		AND (@Temper IS NULL OR B.Temper LIKE '%' + @Temper + '%')
		AND (@CustPart IS NULL OR B.CustPart LIKE '%' + @CustPart + '%')
		AND (@UACPart IS NULL OR CAST(B.UACPart AS VARCHAR(MAX)) LIKE '%' + @UACPart + '%')
		AND ((Deleted != 1 )or(Deleted is null)) 
-----------------------------------------------------------------------------------------------------------
		SELECT @total = COUNT(*) FROM #TempRNDTensionReports WITH(NOLOCK)

		SELECT @total AS [total], 
		RecId, WorkStudyID, TestNo, 
		Alloy,Temper, CustPart, UACPart, 
		SubConduct, SurfConduct, FtuKsi, FtyKsi,
		eElongation, EModulusMpsi,  SpeciComment,  Operator, 
		TestDate, TestTime, EntryDate, EntryBy, Completed	
		FROM #TempRNDTensionReports WITH(NOLOCK)
		ORDER BY RecId DESC
			OFFSET ((@CurrentPage)*@NoOfRecords) ROWS
			FETCH NEXT @NoOfRecords ROWS ONLY

		DROP TABLE #TempRNDTensionReports		
	END 

GO
/****** Object:  StoredProcedure [dbo].[RNDTesting_Delete]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RNDTesting_Delete]
    --@RecId [int]
	--@WorkStudyID [char](10)
	@TestingNo [int]
AS
BEGIN
------------------------------------------------------------------------------------------------------------
----DELETE WITHOUT FLAGS
--    INSERT [dbo].[RNDTestingDeleted]
--			(  [TestingNo], [WorkStudyID], [LotID], [MillLotNo], [SoNum], [Hole], [PieceNo], [Alloy], [Temper], 
--		   [CustPart], [UACPart], [GageThickness], [Orientation], [Location1], [Location2], [Location3], [TestType], 
--		   [SubTestType], [Status], [Selected], [EntryDate], [EntryBy], [TestLab], [Printed], [Replica]	 )
	
--	SELECT 
--		   [TestingNo], [WorkStudyID], [LotID], [MillLotNo], [SoNum], [Hole], [PieceNo], [Alloy], [Temper], 
--		   [CustPart], [UACPart], [GageThickness], [Orientation], [Location1], [Location2], [Location3], [TestType], 
--		   [SubTestType], [Status], [Selected], [EntryDate], [EntryBy], [TestLab], [Printed], [Replica]	
--	FROM RNDTesting WITH(NOLOCK)
--	--WHERE WorkStudyID = @WorkStudyID
--	WHERE TestingNo = @TestingNo

--	DELETE [dbo].RNDTesting WHERE ([TestingNo] = @TestingNo)

------------------------------------------------------------------------------------------------------------
--DELETE WITH FLAGS
	UPDATE RNDTesting SET Deleted = 1 WHERE ([TestingNo] = @TestingNo)
	
------------------------------------------------------------------------------------------------------------
END


GO
/****** Object:  StoredProcedure [dbo].[RNDTestingMaterial_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDTestingMaterial_Insert]
		   @WorkStudyID [char](10),
           @LotID [char](10) = NULL,
           @MillLotNo [int] = NULL,
           @SoNum [char](10) = NULL,
           @Hole [char](2) = NULL,
           @PieceNo [char](2) = NULL,
           @Alloy [char](10) = NULL,
           @Temper [char](10) = NULL,
           @CustPart [char](30) = NULL,
           @UACPart [numeric](6,0) = NULL,
           @GageThickness [char](7) = NULL,
           @Orientation [char](4) = NULL,
           @Location1 [char](10) = NULL,
           @Location2 [char](6) = NULL,
           @Location3 [char](6) = NULL,
           @SpeciComment [char](60) = NULL,
           @TestType [char](35) = NULL,
           @SubTestType [char](35) = NULL,
           @Status [char](1) = NULL,
           @Selected [char](1) = NULL,
           @EntryDate [datetime] = NULL,
           @EntryBy [char](25) = NULL,
           @TestLab [char](15) = NULL,
           @Printed [char](1) = NULL,
           @Replica [char](2) = NULL,
          -- @RCS [char](1) = NULL,
		   @ReplicaCount int = NULL
AS
BEGIN
	DECLARE @CNT INT = 0;

	IF NOT EXISTS (SELECT * FROM [dbo].[RNDTestList]
				WHERE  [TestDesc]= @TestType)
	BEGIN
		declare @tabpos int;
		declare @tablename varchar(35)
	
		--set @tabpos = (select count (*) from [RNDTestList])+1
		set @tabpos = (select max (TabPos) from [RNDTestList])+1
		set @tablename = 'RND'+@TestType+'Results'

		INSERT [dbo].[RNDTestList] ([TestDesc],[TestTableName],[Active],[TabPos])
		VALUES (@TestType,@tablename,'1',@tabpos)

			DECLARE @RecId int
			SELECT @RecId = [RecID]
			FROM [dbo].[RNDTestList]
			WHERE @@ROWCOUNT > 0 AND [RecID] = scope_identity()
    
			SELECT t0.[RecID]
			FROM [dbo].[RNDTestList] AS t0
			WHERE @@ROWCOUNT > 0 AND t0.[RecID] = @RecId
	END
	IF NOT EXISTS (SELECT * FROM [dbo].[RNDTestListAndType]
				WHERE SubTestType = @SubTestType)
	BEGIN
		INSERT [dbo].[RNDTestListAndType] ([TestDesc],[SubTestType])
		VALUES (@TestType,@SubTestType)
	END

	--IF (@Location2 LIKE '%-1%')
	--BEGIN
	--	SET @Location2 = ''
	--END

	WHILE @CNT < @ReplicaCount
	BEGIN
		INSERT [dbo].[RNDTesting]
		(  [WorkStudyID], [LotID], [MillLotNo], [SoNum], [Hole], [PieceNo], [Alloy], [Temper], 
				[CustPart], [UACPart], [GageThickness], [Orientation], [Location1], [Location2], [Location3], [TestType], 
				[SubTestType], [Status], [Selected], [EntryDate], [EntryBy], [TestLab], [Printed], [Replica], [SpeciComment],
				Deleted 	
		)
		VALUES( @WorkStudyID, @LotID, @MillLotNo, @SoNum, @Hole, @PieceNo, @Alloy, @Temper, 
				@CustPart, @UACPart, @GageThickness, @Orientation, @Location1, @Location2, @Location3, @TestType, 
				@SubTestType, @Status, @Selected, @EntryDate, @EntryBy, @TestLab, @Printed, @Replica, @SpeciComment,
				0
		)
		DECLARE @TestingNo int
		SELECT @TestingNo = TestingNo
		FROM [dbo].[RNDTesting]
		WHERE @@ROWCOUNT > 0 AND [TestingNo] = scope_identity()
    
        SELECT t0.[TestingNo]
		FROM [dbo].[RNDTesting] AS t0
		WHERE @@ROWCOUNT > 0 AND t0.[TestingNo] = @TestingNo

		SET @CNT = @CNT + 1;
	END
END


GO
/****** Object:  StoredProcedure [dbo].[RNDTestingMaterial_Read]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDTestingMaterial_Read] 
	@CurrentPage INT, @NoOfRecords INT,@WorkStudyID VARCHAR(50) = NULL
	, @TestType varchar(35) = null
	--,@MillLotNo VARCHAR(50)=NULL
	--,@StudyType VARCHAR(10) = NULL,	@Plant VARCHAR(10) = NULL,@StudyStatus VARCHAR(10) = NULL
AS
	BEGIN
		DECLARE @total INT
		

		--DECLARE @Temp TABLE (TestType varchar(35))
		--INSERT INTO @Temp SELECT TestType FROM  [dbo].[fnSplitValues](@TestType,';')

		SELECT tm.TestingNo  AS TestingNo,RTRIM(tm.WorkStudyID) AS WorkStudyID,
		tm.LotID, tm.MillLotNo,tm.SoNum, tm.Hole,tm.PieceNo, tm.Alloy, tm.Temper, tm.CustPart, tm.UACPart,
		tm.GageThickness, tm.Orientation, tm.Location1, tm.Location2, tm.Location3, tm.SpeciComment,tm.TestType, 		
		tm.SubTestType, tm.Status, tm.Selected, CONVERT(VARCHAR,EntryDate,101) AS EntryDate, tm.EntryBy,
		tm.TestLab, tm.Printed, tm.Replica
		INTO #TempRNDTesting
		FROM [RNDTesting] tm 
		--LEFT JOIN RNDstudyscope scope ON RTRIM(ws.WorkStudyID) = RTRIM(scope.WorkStudyID)
		--LEFT JOIN RNDLot_ID lot ON RTRIM(tm.WorkStudyID) = RTRIM(lot.WorkStudyID)
		WHERE 1=1
		AND (@WorkStudyID IS NULL OR tm.WorkStudyID LIKE '%' + @WorkStudyID + '%')
		AND (@TestType IS NULL OR tm.TestType LIKE '%' + @TestType + '%')
		--AND (@MillLotNo IS NULL OR CONVERT(VARCHAR(20) NULL,ISNULL(PM.MillLotNo,'')) LIKE '%' + @MillLotNo + '%')
------------------------------------------------------------------------------------------------------------
--DELETE WITH FLAGS
		AND ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------

		SELECT @total = COUNT(*) FROM #TempRNDTesting WITH(NOLOCK)
		
		SELECT @total AS total, tm.TestingNo  AS TestingNo,RTRIM(tm.WorkStudyID) AS WorkStudyID,
		tm.LotID, tm.MillLotNo,tm.SoNum, tm.Hole,tm.PieceNo, tm.Alloy, tm.Temper, tm.CustPart, tm.UACPart,
		tm.GageThickness, tm.Orientation, tm.Location1, tm.Location2, tm.Location3, tm.SpeciComment,tm.TestType, 		
		tm.SubTestType, tm.Status, tm.Selected, CONVERT(VARCHAR,EntryDate,101) AS EntryDate, tm.EntryBy,
		tm.TestLab, tm.Printed, tm.Replica
		FROM #TempRNDTesting tm 
		ORDER BY TestingNo DESC
			OFFSET ((@CurrentPage)*@NoOfRecords) ROWS
			FETCH NEXT @NoOfRecords ROWS ONLY

		DROP TABLE #TempRNDTesting
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDTestingMaterial_ReadByTestingNo]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDTestingMaterial_ReadByTestingNo] @TestingNo INT
AS
	BEGIN
		SELECT @TestingNo as TestingNo,RTRIM(tm.WorkStudyID) AS WorkStudyID,
		tm.LotID, tm.MillLotNo,tm.SoNum, tm.Hole,tm.PieceNo, tm.Alloy, tm.Temper, tm.CustPart, tm.UACPart,
		tm.GageThickness, tm.Orientation, tm.Location1, tm.Location2, tm.Location3, tm.SpeciComment, tm.TestType, 
		tm.SubTestType, tm.Status, tm.Selected, CONVERT(VARCHAR,EntryDate,101) AS EntryDate, tm.EntryBy,
		tm.TestLab, tm.Printed, tm.Replica	
		FROM RNDTesting tm
		where tm.TestingNo = @TestingNo
	------------------------------------------------------------------------------------------------------------
--DELETE WITH FLAGS
		AND ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------

	END


GO
/****** Object:  StoredProcedure [dbo].[RNDTestingMaterial_Update]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
 [dbo].[RNDTestingMaterial_Update]
	@TestingNo [int],
   @WorkStudyID [char](10),
           @LotID [char](10) = NULL,
           @MillLotNo [int] = NULL,
           @SoNum [char](10) = NULL,
           @Hole [char](2) = NULL,
           @PieceNo [char](2) = NULL,
           @Alloy [char](10) = NULL,
           @Temper [char](10) = NULL,
           @CustPart [char](30) = NULL,
           @UACPart [numeric](6,0) = NULL,
           @GageThickness [char](7) = NULL,
           @Orientation [char](4) = NULL,
           @Location1 [char](10) = NULL,
           @Location2 [char](6) = NULL,
           @Location3 [char](6) = NULL,
           @SpeciComment [char](60) = NULL,
           @TestType [char](35) = NULL,
           @SubTestType [char](35) = NULL,
           @Status [char](1) = NULL,
           @Selected [char](1) = NULL,
           @EntryDate [datetime] = NULL,
           @EntryBy [char](25) = NULL,
           @TestLab [char](15) = NULL,
           @Printed [char](1) = NULL
          -- @Replica [char](2) = NULL
           --@RCS [char](1) = NULL
AS
BEGIN
    UPDATE [dbo].RNDTesting
    SET 
	      WorkStudyID = @WorkStudyID, LotID = @LotID, MillLotNo = @MillLotNo, SoNum = @SoNum, Hole = @Hole, PieceNo = @PieceNo,
		  Alloy = @Alloy, Temper = @Temper, CustPart = @CustPart, UACPart = @UACPart, GageThickness = @GageThickness, 
		  Orientation = @Orientation, Location1 = @Location1, Location2 = @Location2, Location3 = @Location3, 
		  SpeciComment = @SpeciComment, TestType = @TestType, SubTestType = @SubTestType, Status = @Status, 
		  Selected = @Selected, EntryDate = @EntryDate, EntryBy = @EntryBy, TestLab = @TestLab, Printed = @Printed
        --  Replica = @Replica

	WHERE [TestingNo] = @TestingNo  AND [WorkStudyID] = @WorkStudyID
END


GO
/****** Object:  StoredProcedure [dbo].[RNDTestType_READ]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDTestType_READ]
  (
@Active VARCHAR(MAX) = NULL
)
AS
	BEGIN
		IF (@Active='1')
			SELECT TestDesc  as TestDesc  FROM RNDTestList where Active != '1'
		ELSE
			SELECT TestDesc  as TestDesc  FROM RNDTestList
	END
GO
/****** Object:  StoredProcedure [dbo].[RNDTestTypes_READfromRNDTesting]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDTestTypes_READfromRNDTesting]
AS
BEGIN		
	SELECT distinct TestType FROM RNDTesting 
------------------------------------------------------------------------------------------------------------
--DELETE WITH FLAGS
	WHERE ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------

END;


GO
/****** Object:  StoredProcedure [dbo].[RNDTestWorkStudy_READ]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDTestWorkStudy_READ]
AS
BEGIN		
	SELECT distinct WorkStudyID FROM RNDTesting 
------------------------------------------------------------------------------------------------------------
--DELETE WITH FLAGS
	WHERE ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------
END;


GO
/****** Object:  StoredProcedure [dbo].[RNDUACPartList_Read]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDUACPartList_Read] @CurrentPage INT, @NoOfRecords INT,			 
				 @UACPart VARCHAR(50) = NULL
AS
	BEGIN
		DECLARE @total INT
	
	
		--IF OBJECT_ID('tempdb..#TempRNDAssignMaterial') IS NOT NULL
		--BEGIN
		--	DROP TABLE #TempRNDAssignMaterial
		--END

		IF OBJECT_ID('tempdb..#temptablewithRECID') IS NOT NULL
		BEGIN
			DROP TABLE #temptablewithRECID
		END

		IF OBJECT_ID('tempdb..#temptable') IS NOT NULL
		BEGIN
			DROP TABLE #temptable
		END
		---------------------CURSOR TO FIND THE LIST 
	
	    -- Create Temp Table #temptablewithRECID 
		SELECT distinct	ISNULL(AM.UACPart,0) UACPart, 
		AM.GageThickness, AM.Location2	,RecID = 0	
		into #temptablewithRECID
		FROM [dbo].[RNDMaterial] AS AM WITH(NOLOCK)
		WHERE 1 = 1 AND AM.RecId > 0
		AND uacpart = @UACPart
		AND ((Deleted != 1 )or(Deleted is null))  

		-- Create Temp Table #temptable - without RecID 
		SELECT distinct	ISNULL(AM.UACPart,0) UACPart, 
		AM.GageThickness, AM.Location2	
		into #temptable
		FROM [dbo].[RNDMaterial] AS AM WITH(NOLOCK)
		WHERE 1 = 1 AND AM.RecId > 0
		AND uacpart = @UACPart
		AND ((Deleted != 1 )or(Deleted is null))  
				
		DECLARE @tempRecID int 
		DECLARE @tempUACPart NUMERIC(5,0)
		DECLARE @tempGageThickness VARCHAR(7)
		DECLARE @tempLocation2 VARCHAR(6)

		-- Cursor to find the top RecID from RNDMaterial table for every 
		-- fetched  UACPart , GageThickness, Location2 from #temptable
		
		declare cur_RecID CURSOR STATIC FOR
		select UACPart , GageThickness, Location2 from #temptable

		OPEN cur_RecID
			IF @@CURSOR_ROWS > 0
				BEGIN
					FETCH NEXT FROM cur_RecID INTO @tempUACPart , @tempGageThickness, @tempLocation2
					WHILE  @@FETCH_STATUS = 0
					BEGIN
						declare  @tempRecId1 int 
						set @tempRecId1 = (SELECT TOP 1 RecID FROM RNDMaterial 
												WHERE UACPart= @tempUACPart AND GageThickness = @tempGageThickness AND Location2= @tempLocation2
												and RecID is not null 
												and UACPart is not null 
												and GageThickness is not null 
												and Location2 is not null )	
						if 	(@tempRecId1 is null)
							set @tempRecId1 = 0

						UPDATE #temptablewithRECID
						SET RecID = @tempRecId1
						WHERE UACPart= @tempUACPart AND GageThickness = @tempGageThickness AND Location2= @tempLocation2
												and RecID is not null 
												and UACPart is not null 
												and GageThickness is not null 
												and Location2 is not null 				
													
						FETCH NEXT FROM cur_RecID INTO @tempUACPart , @tempGageThickness, @tempLocation2
					END
				END
		CLOSE cur_RecID
		DEALLOCATE cur_RecID 


---------------- END CURSOR
		SELECT @total = COUNT(*) FROM #temptablewithRECID WITH(NOLOCK)

		SELECT @total AS total,  ISNULL(AM.UACPart,0) UACPart, 
		AM.GageThickness, AM.Location2, ISNULL(AM.RecID,0)RecID
		FROM #temptablewithRECID AS AM WITH(NOLOCK)
		ORDER BY RecID
			OFFSET ((@CurrentPage) * @NoOfRecords) ROWS
			FETCH NEXT @NoOfRecords ROWS ONLY
	
			DROP TABLE #temptablewithRECID		
			DROP TABLE #temptable
		END


GO
/****** Object:  StoredProcedure [dbo].[RNDUACPartListing_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDUACPartListing_Insert] 
@Ids VARCHAR(MAX),
@WorkStudyID CHAR(10) = null,
@SoNum CHAR(10) = null,
@MillLotNo INT = null,
@CustPart CHAR(30),
@UACPart [numeric](5, 0),
@Alloy char(10),
@Temper char(6),
@Hole char(2) = null,
@PieceNo char(2) = null,
@Comment char(40) = null,
@DBCntry char(3),
@EntryBy CHAR(25) = null
AS
	BEGIN
		DECLARE @Temp TABLE (pid int identity(1,1), materialId int)
		INSERT INTO @Temp SELECT ID FROM [dbo].[fnSplitValues](@Ids,';') WHERE ID > 0

		DECLARE @RowsToProcess  int
		DECLARE @CurrentRow     int
		DECLARE @SelectCol1     int
		SET @RowsToProcess=@@ROWCOUNT

		--DECLARE @CustPart CHAR(30)
		--DECLARE @UACPart [numeric](5, 0)
		DECLARE @GageThickness CHAR(7)
		DECLARE @Location2 CHAR(6)
				
		SET @CurrentRow=0
		WHILE @CurrentRow < @RowsToProcess
		BEGIN
			SET @CurrentRow = @CurrentRow+1
			SELECT @SelectCol1=materialId FROM @Temp WHERE pid=@CurrentRow
			SELECT @GageThickness=GageThickness, @Location2=Location2 FROM RNDMaterial 
			WHERE RecID = @SelectCol1
			--and @CustPart = CustPart
			--and @UACPart=UACPart
	--		SELECT @GageThickness=GageThickness,@Location2=Location2 FROM RNDMaterial WHERE RecID = @SelectCol1


------------------------------------------------------------------------------------------------------------
--DELETE WITHOUT FLAGS
			--INSERT INTO RNDMaterial(WorkStudyID,MillLotNo,CustPart,GageThickness,Location2,EntryBy,EntryDate,
			--						SoNum, 
			--						UACPart,
			--						Alloy, 
			--						Temper, 
			--						Hole, PieceNo, Comment)
			--				VALUES(@WorkStudyID,@MillLotNo,@CustPart,@GageThickness,@Location2,@EntryBy,GETDATE(),
			--						@SoNum,
			--						@UACPart,
			--						 @Alloy, 
			--						 @Temper, 
			--						 @Hole, @PieceNo, @Comment)


------------------------------------------------------------------------------------------------------------
--DELETE FLAGS
						INSERT INTO RNDMaterial(WorkStudyID,MillLotNo,CustPart,GageThickness,Location2,EntryBy,EntryDate,
									SoNum, 
									UACPart,
									Alloy, 
									Temper, 
									Hole, PieceNo, Comment,
									DBCntry,
									 Deleted)
							VALUES(@WorkStudyID,@MillLotNo,@CustPart,@GageThickness,@Location2,@EntryBy,GETDATE(),
									@SoNum,
									@UACPart,
									 @Alloy, 
									 @Temper, 
									 @Hole, @PieceNo, @Comment,
									 @DBCntry,
									  0)  	
 	
------------------------------------------------------------------------------------------------------------

			DECLARE @RecId int
			SELECT @RecId = [RecId]
			FROM [dbo].[RNDMaterial]
			WHERE @@ROWCOUNT > 0 AND [RecId] = scope_identity()

			SELECT t0.[RecId]
			FROM [dbo].[RNDMaterial] AS t0
			WHERE @@ROWCOUNT > 0 AND t0.[RecId] = @RecId
		END	
	END



GO
/****** Object:  StoredProcedure [dbo].[RNDUserPasswordReset]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDUserPasswordReset] 
(
@UserName VARCHAR(100), 
@RNDSecurityQuestionId INT, 
@SecurityAnswer VARCHAR(200),
@PasswordHash [varbinary](max),
@PasswordSalt [varbinary](max))
AS
	BEGIN
		DECLARE @UserId INT, @QuestionId INT,@result INT,@UserStatus VARCHAR(5);
		SET @result = 0
		SELECT @UserId = UserId FROM RNDLogin WHERE UserName = @UserName
		IF EXISTS(SELECT 'X' FROM RNDUserSecurityAnswers WHERE RNDLoginId = @UserId AND RNDSecurityQuestionId = @RNDSecurityQuestionId AND UPPER(SecurityAnswer) =  UPPER(@SecurityAnswer))
			BEGIN
					--UPDATE RNDLogin SET PasswordHash = @PasswordHash, PasswordSalt = @PasswordSalt WHERE UserId = @UserId
				
				UPDATE RNDUserSecurityAnswers 
				SET RNDSecurityQuestionId = @RNDSecurityQuestionId ,SecurityAnswer =  UPPER(@SecurityAnswer),[LastModifiedBy]= @UserId , 
				[LastModifiedOn] = GETDATE(),
				StatusCode=	CASE WHEN StatusCode='DR' THEN 'A' 
								ELSE StatusCode 
							END
				WHERE RNDLoginId = @UserId
				
			END		
		ELSE
			BEGIN
				INSERT INTO RNDUserSecurityAnswers (RNDLoginId, RNDSecurityQuestionId, SecurityAnswer, CreatedBy, CreatedOn, StatusCode)
				VALUES ( @UserId, @RNDSecurityQuestionId ,  UPPER(@SecurityAnswer), @UserId, GETDATE(), 'A')

				SELECT t0.[RNDUserSecurityAnswerId]
				FROM [dbo].RNDUserSecurityAnswers AS t0
				WHERE @@ROWCOUNT > 0 AND t0.RNDLoginId = @UserId					
			
			END
		
		UPDATE RNDLogin 
		SET PasswordHash = @PasswordHash,PasswordSalt = @PasswordSalt, 
			StatusCode=	CASE WHEN StatusCode='DR' THEN 'A' 
							 ELSE StatusCode 
						END
		WHERE UserId = @UserId;

		SELECT	@UserStatus=StatusCode FROM RNDLogin WHERE UserId = @UserId;
		SET @result = 1
		SELECT @result,@UserStatus
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDUserPermissionLevel_READ]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC RNDUserPermissionLevel_READ
CREATE PROCEDURE [dbo].[RNDUserPermissionLevel_READ]
AS
	BEGIN
		DECLARE @vtUserPermissionLevel AS TABLE (PermissionId INT PRIMARY KEY IDENTITY(1,1), PermissionLevel VARCHAR(50), PermissionLevelDescription VARCHAR(50) )
		
		INSERT INTO @vtUserPermissionLevel ([PermissionLevel])
		SELECT 'ReadOnly'

		INSERT INTO @vtUserPermissionLevel ([PermissionLevel])
		SELECT 'Admin'

		INSERT INTO @vtUserPermissionLevel ([PermissionLevel])
		SELECT 'SuperAdmin'		

		SELECT PermissionId, PermissionLevel FROM @vtUserPermissionLevel
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDUserSecurityAnswers_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDUserSecurityAnswers_Insert] 
(@RNDLoginId INT, @RNDSecurityQuestionId INT, @SecurityAnswer VARCHAR(200),@CreatedBy INT,
@PasswordHash [varbinary](max),@PasswordSalt [varbinary](max))
AS
	BEGIN
		UPDATE RNDLogin SET StatusCode = 'A',PasswordHash=@PasswordHash,PasswordSalt=@PasswordSalt WHERE UserId = @RNDLoginId
		INSERT INTO RNDUserSecurityAnswers VALUES(@RNDLoginId,@RNDSecurityQuestionId,@SecurityAnswer,@CreatedBy,GETDATE(),NULL,NULL,'A')
		SELECT t0.[RNDUserSecurityAnswerId]
		FROM [dbo].RNDUserSecurityAnswers AS t0
		WHERE @@ROWCOUNT > 0 AND t0.RNDLoginId = @RNDLoginId
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDUserSecurityAnswers_Read]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RNDUserSecurityAnswers_Read] (@UserName VARCHAR(100))
AS
	BEGIN
		DECLARE @UserId INT, @QuestionId INT
		SELECT @UserId = UserId FROM RNDLogin WHERE UserName = @UserName
		SELECT @QuestionId = RNDSecurityQuestionId FROM RNDUserSecurityAnswers WHERE RNDLoginId = @UserId
		SELECT RNDSecurityQuestionId,Question FROM RNDSecurityQuestions WHERE RNDSecurityQuestionId = @QuestionId
	END


GO
/****** Object:  StoredProcedure [dbo].[RNDWorkStudy_Delete]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDWorkStudy_Delete]
    @RecId [int]
AS
BEGIN

------------------------------------------------------------------------------------------------------------
----DELETE WITHOUT FLAGS
--	DECLARE @WorkStudyID char(10)

--	SELECT @WorkStudyID =  [WorkStudyID] FROM [dbo].[RNDWorkStudy] WITH(NOLOCK)
--	WHERE [RecId] = @RecId
	
--	INSERT [dbo].[RNDWorkStudyDeleted]([RecId], [WorkStudyID], [StudyType], [StudyDesc], [PlanOSCost], [AcctOSCost], [StudyStatus],
--	[StartDate], [DueDate], [CompleteDate], [Plant], [EntryBy], [EntryDate],[TempID], [Experimentation] , [FinalSummary], [Uncertainty])
--    SELECT [RecId], [WorkStudyID], [StudyType], [StudyDesc], [PlanOSCost], [AcctOSCost], [StudyStatus], [StartDate], [DueDate],
--	[CompleteDate], [Plant], [EntryBy], [EntryDate],[TempID],[Experimentation] , [FinalSummary] , [Uncertainty]
--	FROM [dbo].[RNDWorkStudy] WITH(NOLOCK)
--	WHERE [RecId] = @RecId

--	DELETE FROM [dbo].[RNDWorkStudy] WHERE ([RecId] = @RecId)
	
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
--DELETE FLAGS
	UPDATE [RNDWorkStudy] SET Deleted = 1 where ([RecId] = @RecId)
	
------------------------------------------------------------------------------------------------------------

END



GO
/****** Object:  StoredProcedure [dbo].[RNDWorkStudy_Insert]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDWorkStudy_Insert]
 	@WorkStudyID [char](10),
	@StudyType [char](2) = NULL,
	@StudyDesc [char](40) = NULL,
	@PlanOSCost [numeric](9, 2) ,
	@AcctOSCost [numeric](9, 2) ,
	@StudyStatus [char](2) ,
	@StartDate [datetime] = NULL,
	@DueDate [datetime] = NULL ,
	@CompleteDate [datetime] = NULL ,
	@Plant [char](2) ,
	@EntryDate [datetime] ,
	@EntryBy [char](25) ,
	@TempID [char](50) = NULL,
	@StudyScope [char](40) = NULL,	
	@Experimentation [varchar](900) = NULL, 
	@FinalSummary [varchar](900) = NULL,
	@Uncertainty [nvarchar](1000) = NULL
AS
BEGIN
	------------------------------------------------------------------------------------------------------------
----DELETE WITHOUT FLAGS
--    INSERT [dbo].[RNDWorkStudy]([WorkStudyID], [StudyType], [StudyDesc], [PlanOSCost], [AcctOSCost], [StudyStatus], [StartDate], [DueDate], [CompleteDate], [Plant], [EntryBy], [EntryDate],[TempID],[Experimentation], [FinalSummary],[Uncertainty])
--    VALUES (@WorkStudyID, @StudyType, @StudyDesc, @PlanOSCost, @AcctOSCost, @StudyStatus, @StartDate, @DueDate, @CompleteDate, @Plant,  @EntryBy, @EntryDate, @TempID, @Experimentation, @FinalSummary,@Uncertainty)
   	
------------------------------------------------------------------------------------------------------------
    
	------------------------------------------------------------------------------------------------------------
--DELETE FLAGS
  INSERT [dbo].[RNDWorkStudy]([WorkStudyID], [StudyType], [StudyDesc], [PlanOSCost], [AcctOSCost], [StudyStatus], [StartDate], [DueDate], [CompleteDate], [Plant], [EntryBy], [EntryDate],[TempID],[Experimentation], [FinalSummary],[Uncertainty], Deleted)
    VALUES (@WorkStudyID, @StudyType, @StudyDesc, @PlanOSCost, @AcctOSCost, @StudyStatus, @StartDate, @DueDate, @CompleteDate, @Plant,  @EntryBy, @EntryDate, @TempID, @Experimentation, @FinalSummary,@Uncertainty, 0 )
   	
------------------------------------------------------------------------------------------------------------

    DECLARE @RecId int
    SELECT @RecId = [RecId]
    FROM [dbo].[RNDWorkStudy]
    WHERE @@ROWCOUNT > 0 AND [RecId] = scope_identity()

	INSERT INTO RNDStudyScope VALUES(@WorkStudyID,NULL,@StudyScope)
    
    SELECT t0.[RecId]
    FROM [dbo].[RNDWorkStudy] AS t0
    WHERE @@ROWCOUNT > 0 AND t0.[RecId] = @RecId
END



GO
/****** Object:  StoredProcedure [dbo].[RNDWorkStudy_Read]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --exec RNDWorkStudy_Read 0,20
  
CREATE PROCEDURE 
[dbo].[RNDWorkStudy_Read] 
	@CurrentPage INT, @NoOfRecords INT,@WorkStudyID VARCHAR(50) = NULL,@StudyType VARCHAR(10) = NULL,
	@Plant VARCHAR(10) = NULL,@StudyStatus VARCHAR(10) = NULL, @searchFromDate VARCHAR(12) = NULL,
	@searchToDate VARCHAR(12) = NULL, @Experimentation varchar(900)= null, @FinalSummary varchar(900) = null,
	@Uncertainty [nvarchar](1000) = NULL
AS
	BEGIN
		DECLARE @total INT
		--SELECT @total = COUNT(*) FROM [dbo].[RNDWorkStudy]

		IF OBJECT_ID('tempdb..#TempRNDWorkStudy') IS NOT NULL
		BEGIN
			DROP TABLE #TempRNDWorkStudy
		END

------------------------------------------------------------------------------------------------------------
----DELETE WITHOUT FLAGS

--		SELECT RecId AS RecId,RTRIM(WorkStudyID) AS WorkStudyID,
--		StudyType, [dbo].[GetSelectValue]('RNDStudyType',NULL,StudyType) AS StudyTypeDesc,
--		RTRIM(StudyDesc) AS StudyDesc,PlanOSCost,AcctOSCost,
--		StudyStatus, [dbo].[GetSelectValue]('RNDStudyStatus',NULL,StudyStatus) AS StudyStatusDesc,
--		CONVERT(VARCHAR,StartDate,101) AS StartDate,CONVERT(VARCHAR,DueDate,101) AS DueDate,
--		CONVERT(VARCHAR,CompleteDate,101) AS CompleteDate,
--		Plant,[dbo].[GetSelectValue]('RNDLocation',NULL,Plant) AS PlantDesc,
--		TempID,EntryBy,EntryDate,
--		[dbo].GetStudyScope(WorkStudyID) AS StudyScope
--		, Experimentation, FinalSummary, Uncertainty
--		INTO #TempRNDWorkStudy
--		FROM [RNDWorkStudy]
--		WHERE 1=1
--		AND (@WorkStudyID IS NULL OR WorkStudyID LIKE '%' + @WorkStudyID + '%')
--		AND (@StudyType IS NULL OR StudyType = @StudyType)
--		AND (@Plant IS NULL OR Plant = @Plant)
--		AND (@StudyStatus IS NULL OR StudyStatus = @StudyStatus)
--		AND (@searchFromDate IS NULL OR CONVERT(VARCHAR(10),StartDate,120) = @searchFromDate)
--		AND (@searchToDate IS NULL OR CONVERT(VARCHAR(10),DueDate,120) = @searchToDate)

------------------------------------------------------------------------------------------------------------
--DELETE FLAGS
 		SELECT A.RecId AS RecId,
		RTRIM(WorkStudyID) AS WorkStudyID,
		StudyType, [dbo].[GetSelectValue]('RNDStudyType',NULL,StudyType) AS StudyTypeDesc,
		RTRIM(StudyDesc) AS StudyDesc,PlanOSCost,AcctOSCost,
		StudyStatus, [dbo].[GetSelectValue]('RNDStudyStatus',NULL,StudyStatus) AS StudyStatusDesc,
		CONVERT(VARCHAR,StartDate,101) AS StartDate,CONVERT(VARCHAR,DueDate,101) AS DueDate,
		CONVERT(VARCHAR,CompleteDate,101) AS CompleteDate,
		B.PlantDesc AS Plant,
		--[dbo].[GetSelectValue]('RNDLocation',NULL,Plant) AS PlantDesc,
		B.PlantDesc AS PlantDesc,
		TempID,EntryBy,EntryDate,
		[dbo].GetStudyScope(WorkStudyID) AS StudyScope
		, Experimentation, FinalSummary, Uncertainty
		INTO #TempRNDWorkStudy
		FROM [RNDWorkStudy] A
		LEFT JOIN RNDLocation B ON CAST(A.Plant AS VARCHAR)=CAST(B.Plant AS VARCHAR)
		WHERE 1=1
		AND (@WorkStudyID IS NULL OR WorkStudyID LIKE '%' + @WorkStudyID + '%')
		AND (@StudyType IS NULL OR StudyType = @StudyType)
		AND (@Plant IS NULL OR A.Plant = @Plant)
		AND (@StudyStatus IS NULL OR StudyStatus = @StudyStatus)
		AND (@searchFromDate IS NULL OR CONVERT(VARCHAR(10),StartDate,120) = @searchFromDate)
		AND (@searchToDate IS NULL OR CONVERT(VARCHAR(10),DueDate,120) = @searchToDate)
		AND ((Deleted != 1 )or(Deleted is null)) 
  	
------------------------------------------------------------------------------------------------------------

	
		SELECT @total = COUNT(*) FROM #TempRNDWorkStudy WITH(NOLOCK)

		SELECT @total AS [total], RecId AS RecId,RTRIM(WorkStudyID) AS WorkStudyID,
		StudyType, StudyTypeDesc, RTRIM(StudyDesc) AS StudyDesc, PlanOSCost, AcctOSCost,
		StudyStatus, StudyStatusDesc, CONVERT(VARCHAR,StartDate,101) AS StartDate,
		CONVERT(VARCHAR,DueDate,101) AS DueDate, CONVERT(VARCHAR,CompleteDate,101) AS CompleteDate,
		Plant, PlantDesc, TempID, EntryBy, EntryDate, StudyScope , Experimentation, FinalSummary, Uncertainty
		FROM #TempRNDWorkStudy WITH(NOLOCK)
		ORDER BY RecId DESC
			OFFSET ((@CurrentPage)*@NoOfRecords) ROWS
			FETCH NEXT @NoOfRecords ROWS ONLY

		DROP TABLE #TempRNDWorkStudy		
	END

 


GO
/****** Object:  StoredProcedure [dbo].[RNDWorkStudy_ReadByID]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDWorkStudy_ReadByID] @RecId INT
AS
	BEGIN
		SELECT @RecId AS RecId,RTRIM(ws.WorkStudyID) AS WorkStudyID,StudyType,StudyDesc,PlanOSCost,AcctOSCost,[TempID],
		StudyStatus,CONVERT(VARCHAR,StartDate,101) AS StartDate,CONVERT(VARCHAR,DueDate,101) AS DueDate,CONVERT(VARCHAR,CompleteDate,101) AS CompleteDate,
		Plant,TempID,EntryBy,EntryDate,RTRIM(scope.StudyScope) AS StudyScope
		, Experimentation, FinalSummary,Uncertainty
		FROM [RNDWorkStudy] ws JOIN RNDstudyscope scope ON RTRIM(ws.WorkStudyID) = RTRIM(scope.WorkStudyID)
		WHERE ws.RecId = @RecId

	END


GO
/****** Object:  StoredProcedure [dbo].[RNDWorkStudy_Update]    Script Date: 4/11/2018 10:01:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
[dbo].[RNDWorkStudy_Update]
    @RecId  [int],
	@WorkStudyID [char](10),
	@StudyType [char](2) = NULL,
	@StudyDesc [char](40) = NULL,
	@PlanOSCost [numeric](9, 2) ,
	@AcctOSCost [numeric](9, 2) ,
	@StudyStatus [char](2) ,
	@StartDate [datetime] = NULL,
	@DueDate [datetime] = NULL ,
	@CompleteDate [datetime] = NULL ,
	@Plant [char](2) ,
	@EntryDate [datetime] ,
	@EntryBy [char](25) ,
	@TempID [char](50) = NULL,
	@StudyScope [char](40) = NULL,
	@Experimentation [varchar](900) = NULL, 
	@FinalSummary [varchar](900) = NULL,
	@Uncertainty [nvarchar](1000) = NULL
AS
BEGIN
    UPDATE [dbo].[RNDWorkStudy]
    SET [WorkStudyID] = @WorkStudyID, [StudyType] = @StudyType, [StudyDesc] = @StudyDesc, [PlanOSCost] = @PlanOSCost, [AcctOSCost] = @AcctOSCost, [StudyStatus] = @StudyStatus, [StartDate] = @StartDate, [DueDate] = @DueDate, [CompleteDate] = @CompleteDate, [Plant] = @Plant, [TempID] = @TempID, [EntryBy] = @EntryBy, [EntryDate] = @EntryDate, 
	[Experimentation] = @Experimentation, [FinalSummary] = @FinalSummary, [Uncertainty]= @Uncertainty
    WHERE ([RecId] = @RecId)

	UPDATE RNDStudyScope SET StudyScope=@StudyScope WHERE WorkStudyID = @WorkStudyID
END


GO
---
--New added 
---

GO
/****** Object:  StoredProcedure [dbo].[RNDCheckTestType_READ]    Script Date: 4/11/2018 9:59:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
 [dbo].[RNDCheckTestType_READ]
 (          @SelectedTests varchar(max)
			--@Active	 
)       
AS
BEGIN

		IF (@SelectedTests IS NOT NULL)
		
		BEGIN
			DECLARE @x XML 
			SELECT 	@x = CAST('<A>'+ REPLACE(@SelectedTests,',','</A><A>')+ '</A>' AS XML);		

			SELECT TestingNo, TestType
			 , Active
			FROM RNDTesting t
			join RNDTestList tl
			on t.TestType = tl.TestDesc
			WHERE TestingNo IN (SELECT t.value('.', 'int') AS inVal FROM @x.nodes('/A') AS x(t))
		END
END

GO

/****** Object:  StoredProcedure [dbo].[RNDEXCOResults_Insert]    Script Date: 4/11/2018 9:59:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
 [dbo].[RNDEXCOResults_Insert]
 (         @SelectedTests varchar(max),
		   @ExcoRating char(4) = null,
           @StartWT char(8) = null,
           @FinalWT char(8) = null,
           @ExposedArea char(8) = null,
           @StartpH char(5) = null,
           @FinalpH char(5) = null,
           @SpeciComment char(50) = null,
           @Operator char(20) = null,
           @TestDate datetime,
           @TimeHrs char(2) = null,
           @TimeMns char(2) = null,
           @BatchNo char(4) = null,
           @EntryBy char(25),
           @EntryDate datetime
)       
AS
BEGIN	
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
			
			UPDATE  RNDTesting
				SET Status = '1' 
				WHERE TestingNo IN (SELECT t.value('.', 'int') AS inVal FROM @x.nodes('/A') AS x(t))
	
			IF EXISTS (SELECT COUNT(*) FROM [dbo].[RNDExcoResults])
			BEGIN
				SET @maxRecID = (SELECT MAX(RecID) FROM [dbo].[RNDExcoResults])
			END
			ELSE
			BEGIN
				SET @maxRecID = 0
			END

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
            [WorkStudyID]
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
           ,[Completed]
		   FROM #tempTestingNo

		select TestingNo 
		FROM [dbo].[RNDExcoResults]
		where RecID > @maxRecID
		
		DROP TABLE #tempTestingNo
	END
END

GO

/****** Object:  StoredProcedure [dbo].[RNDFatigueResults_Insert]    Script Date: 4/11/2018 9:59:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
 [dbo].[RNDFatigueResults_Insert]
 (         @SelectedTests varchar(max),		       
           @SpecimenDrawing char(50),
           @MinStress numeric(4,1),
           @MaxStress numeric(4,1),
           @MinLoad numeric(7,2),
           @MaxLoad numeric(7,2),
           @WidthOrDia numeric(8,5),
           @Thickness numeric(8,5),
           @HoleDia numeric(8,5),
           @AvgChamferDepth numeric(8,5),
           @Frequency char(5),
           @CyclesToFailure numeric(8,0),
           @Roughness numeric(5,2),
           @TestFrame char(5),
           @Comment char(50),
           @FractureLocation char(50),
           @Operator char(20),
           @TestDate datetime,
           @TestTime char(15),
           @EntryBy char(25),
           @EntryDate datetime		  
)       
AS
BEGIN			
		DECLARE @maxRecID INT	

		IF (@SelectedTests IS NOT NULL)
		BEGIN
			DECLARE @x XML 
			SELECT 	@x = CAST('<A>'+ REPLACE(@SelectedTests,',','</A><A>')+ '</A>' AS XML);		
			SELECT TestingNo, [WorkStudyID],[LotID],[MillLotNo],										
			SpecimenDrawing = @SpecimenDrawing
           ,MinStress = @MinStress
           ,MaxStress = @MaxStress
           ,MinLoad = @MinLoad
           ,MaxLoad = @MaxLoad
           ,WidthOrDia = @WidthOrDia
           ,Thickness = @Thickness
           ,HoleDia = @HoleDia
           ,AvgChamferDepth = @AvgChamferDepth
           ,Frequency = @Frequency
           ,CyclesToFailure = @CyclesToFailure
           ,Roughness = @Roughness
           ,TestFrame = @TestFrame
           ,Comment = @Comment
           ,FractureLocation = @FractureLocation
           ,Operator = @Operator
           ,TestDate = @TestDate
           ,TestTime = @TestTime
           ,EntryBy = @EntryBy
           ,EntryDate = @EntryDate
			,Completed = '1'
			INTO #tempTestingNo			
			FROM RNDTesting
			WHERE TestingNo IN (SELECT t.value('.', 'int') AS inVal FROM @x.nodes('/A') AS x(t))

			IF EXISTS (SELECT COUNT(*) FROM [dbo].[RNDFatigueTestingResults])
			BEGIN
				SET @maxRecID = (SELECT MAX(RecID) FROM [dbo].[RNDFatigueTestingResults])
			END
			ELSE
			BEGIN
				SET @maxRecID = 0
			END

			INSERT INTO [dbo].[RNDFatigueTestingResults]
          ([WorkStudyID]
           ,[TestNo]
           ,[SpecimenDrawing]
           ,[MinStress]
           ,[MaxStress]
           ,[MinLoad]
           ,[MaxLoad]
           ,[WidthOrDia]
           ,[Thickness]
           ,[HoleDia]
           ,[AvgChamferDepth]
           ,[Frequency]
           ,[CyclesToFailure]
           ,[Roughness]
           ,[TestFrame]
           ,[Comment]
           ,[FractureLocation]
           ,[Operator]
           ,[TestDate]
           ,[TestTime]
           ,[EntryBy]
           ,[EntryDate]
           ,[Completed])
			 SELECT 
            [WorkStudyID]
           ,TestingNo
           ,[SpecimenDrawing]
           ,[MinStress]
           ,[MaxStress]
           ,[MinLoad]
           ,[MaxLoad]
           ,[WidthOrDia]
           ,[Thickness]
           ,[HoleDia]
           ,[AvgChamferDepth]
           ,[Frequency]
           ,[CyclesToFailure]
           ,[Roughness]
           ,[TestFrame]
           ,[Comment]
           ,[FractureLocation]
           ,[Operator]
           ,[TestDate]
           ,[TestTime]
           ,[EntryBy]
           ,[EntryDate]
           ,[Completed]
		   FROM #tempTestingNo
		 
		select TestingNo as [TestNo]  
		FROM [dbo].[RNDHardnessResults]
		where RecID > @maxRecID
		
		DROP TABLE #tempTestingNo
	END
END
GO

/****** Object:  StoredProcedure [dbo].[RNDFatigueTesting_Insert]    Script Date: 4/11/2018 9:59:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDFatigueTesting_Insert]
		@WorkStudyID char(10),  
		@TestNo int,
        @SpecimenDrawing char(50),
        @MinStress numeric(4,1),
        @MaxStress numeric(4,1),
        @MinLoad numeric(7,2),
        @MaxLoad numeric(7,2),
        @WidthOrDia numeric(8,5),
        @Thickness numeric(8,5),
        @HoleDia numeric(8,5),
        @AvgChamferDepth numeric(8,5),
        @Frequency char(5),
        @CyclesToFailure numeric(8,0),
        @Roughness numeric(5,2),
        @TestFrame char(5),
        @Comment char(50),
        @FractureLocation char(50),
        @Operator char(20),
        @TestDate datetime,
        @TestTime char(15),
        @EntryBy char(25),
        @EntryDate datetime,
        @Completed char(1)
AS
BEGIN		
	INSERT INTO [dbo].[RNDFatigueTestingResults]	
     (
			[WorkStudyID]     
		   ,[TestNo]    
           ,[SpecimenDrawing]
           ,[MinStress]
           ,[MaxStress]
           ,[MinLoad]
           ,[MaxLoad]
           ,[WidthOrDia]
           ,[Thickness]
           ,[HoleDia]
           ,[AvgChamferDepth]
           ,[Frequency]
           ,[CyclesToFailure]
           ,[Roughness]
           ,[TestFrame]
           ,[Comment]
           ,[FractureLocation]
           ,[Operator]
           ,[TestDate]
           ,[TestTime]
           ,[EntryBy]
           ,[EntryDate]
           ,[Completed])
     VALUES
	 (
	 		@WorkStudyID          
		   ,@TestNo
           ,@SpecimenDrawing
           ,@MinStress
           ,@MaxStress
           ,@MinLoad
           ,@MaxLoad
           ,@WidthOrDia
           ,@Thickness
           ,@HoleDia
           ,@AvgChamferDepth
           ,@Frequency
           ,@CyclesToFailure
           ,@Roughness
           ,@TestFrame
           ,@Comment
           ,@FractureLocation
           ,@Operator
           ,@TestDate
           ,@TestTime
           ,@EntryBy
           ,@EntryDate
           ,@Completed)

    DECLARE @RecId int

	SELECT @RecId = [RecID]
	FROM [dbo].[RNDFatigueTestingResults]
	WHERE @@ROWCOUNT > 0 AND [RecID] = scope_identity()

	SELECT t0.[RecID]
	FROM [dbo].[RNDFatigueTestingResults] AS t0
	WHERE @@ROWCOUNT > 0 AND t0.[RecID] = @RecId
END


GO

/****** Object:  StoredProcedure [dbo].[RNDGetLocation2_ByMillLotIdAndWokStudyId]    Script Date: 4/11/2018 9:59:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDGetLocation2_ByMillLotIdAndWokStudyId]
@MillLotNo char(10),
@WorkStudyID VARCHAR(50) = NULL
AS
	BEGIN
		SELECT distinct Location2 FROM RNDMaterial where 
		@MillLotNo = MillLotNo	
		AND @WorkStudyID = WorkStudyID	
		AND Location2 is not NULL
		 
------------------------------------------------------------------------------------------------------------
--DELETE FLAGS
		AND ((Deleted != 1 )or(Deleted is null))
------------------------------------------------------------------------------------------------------------
	END

GO

/****** Object:  StoredProcedure [dbo].[RNDGetTestTypeFromTesting]    Script Date: 4/11/2018 9:59:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE 
 [dbo].[RNDGetTestTypeFromTesting]
AS
BEGIN		
	SELECT distinct TestType FROM RNDTesting 	
	WHERE ((Deleted != 1 )or(Deleted is null))
	AND (TestType IS NOT NULL)  
END;

GO

/****** Object:  StoredProcedure [dbo].[RNDHardnessResults_Insert]    Script Date: 4/11/2018 9:59:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
 [dbo].[RNDHardnessResults_Insert]
 (         @SelectedTests varchar(max),		       
           @SpeciComment char(50) = null,
           @Operator char(20) = null,
           @TestDate datetime,
           @TimeHrs char(2) = null,
           @TimeMns char(2) = null,         
           @EntryBy char(25),
           @EntryDate datetime,
		   @SubConduct char(4),
           @SurfConduct char(4),
           @Hardness char(5)
)       
AS
BEGIN			
		DECLARE @maxRecID INT	

		IF (@SelectedTests IS NOT NULL)
		BEGIN
			DECLARE @x XML 
			SELECT 	@x = CAST('<A>'+ REPLACE(@SelectedTests,',','</A><A>')+ '</A>' AS XML);		
			
			SELECT TestingNo, [WorkStudyID],[LotID],[MillLotNo],						
				SpeciComment =@SpeciComment,
				Operator =@Operator,
				TestDate =@TestDate,
				TimeHrs =@TimeHrs,
				TimeMns =@TimeMns,				
				EntryBy =@EntryBy,
				EntryDate =@EntryDate,
				SubConduct =@SubConduct,
				SurfConduct =@SurfConduct,
				Hardness =@Hardness,
				[Completed] = '1'
			INTO #tempTestingNo			
			FROM RNDTesting
			WHERE TestingNo IN (SELECT t.value('.', 'int') AS inVal FROM @x.nodes('/A') AS x(t))

			 UPDATE  RNDTesting
				SET Status = '1' 
				WHERE TestingNo IN (SELECT t.value('.', 'int') AS inVal FROM @x.nodes('/A') AS x(t))

			IF EXISTS (SELECT COUNT(*) FROM [dbo].[RNDHardnessResults])
			BEGIN
				SET @maxRecID = (SELECT MAX(RecID) FROM [dbo].[RNDHardnessResults])
			END
			ELSE
			BEGIN
				SET @maxRecID = 0
			END

			INSERT INTO [dbo].[RNDHardnessResults]
          ([WorkStudyID]
           ,[MillLotNo]
           ,[LotID]
           ,[TestingNo]
           ,[SubConduct]
           ,[SurfConduct]
           ,[Hardness]
           ,[SpeciComment]
           ,[Operator]
           ,[TestDate]
           ,[TimeHrs]
           ,[TimeMns]
           ,[EntryBy]
           ,[EntryDate]
           ,[Completed])
			 SELECT 
            [WorkStudyID]
           ,[MillLotNo]
           ,[LotID]
           ,[TestingNo]
           ,[SubConduct]
           ,[SurfConduct]
           ,[Hardness]
           ,[SpeciComment]
           ,[Operator]
           ,[TestDate]
           ,[TimeHrs]
           ,[TimeMns]
           ,[EntryBy]
           ,[EntryDate]
           ,[Completed]
		   FROM #tempTestingNo

		   

		select TestingNo 
		FROM [dbo].[RNDHardnessResults]
		where RecID > @maxRecID
		
		DROP TABLE #tempTestingNo
	END
END



GO

/****** Object:  StoredProcedure [dbo].[RNDIGCResults_Insert]    Script Date: 4/11/2018 9:59:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
 [dbo].[RNDIGCResults_Insert]
 (         @SelectedTests varchar(max) 
	      ,@SubConduct char(4) 
           ,@SurfConduct char(4) 
           ,@MinDepth char(7) 
           ,@MaxDepth char(7) 
           ,@AvgDepth char(7) 
           ,@SpeciComment char(50) 
           ,@Operator char(20) 
           ,@TestDate datetime 
           ,@TimeHrs char(2) 
           ,@TimeMns char(2) 
           ,@EntryBy char(25) 
           ,@EntryDate datetime 
)       
AS
BEGIN			
		DECLARE @maxRecID INT	

		IF (@SelectedTests IS NOT NULL)
		BEGIN
			DECLARE @x XML 
			SELECT 	@x = CAST('<A>'+ REPLACE(@SelectedTests,',','</A><A>')+ '</A>' AS XML);		
			SELECT TestingNo, [WorkStudyID],[LotID],[MillLotNo],										
			SelectedTests = @SelectedTests,
	        SubConduct = @SubConduct, 
			SurfConduct = @SurfConduct, 
			MinDepth = @MinDepth, 
			MaxDepth = @MaxDepth,
			AvgDepth = @AvgDepth, 
			SpeciComment = @SpeciComment,
			Operator = @Operator,
			TestDate = @TestDate, 
			TimeHrs = @TimeHrs, 
			TimeMns = @TimeMns,           
            EntryBy = @EntryBy,
            EntryDate = @EntryDate,
			Completed = '1'
			INTO #tempTestingNo			
			FROM RNDTesting
			WHERE TestingNo IN (SELECT t.value('.', 'int') AS inVal FROM @x.nodes('/A') AS x(t))

			UPDATE  RNDTesting
				SET Status = '1' 
				WHERE TestingNo IN (SELECT t.value('.', 'int') AS inVal FROM @x.nodes('/A') AS x(t))

			IF EXISTS (SELECT COUNT(*) FROM [dbo].[RNDIGCResults])
			BEGIN
				SET @maxRecID = (SELECT MAX(RecID) FROM [dbo].[RNDIGCResults])
			END
			ELSE
			BEGIN
				SET @maxRecID = 0
			END

			INSERT INTO [dbo].[RNDIGCResults]
            ([WorkStudyID]
           ,[MillLotNo]
           ,[LotID]
           ,[TestingNo]
           ,[SubConduct]
           ,[SurfConduct]
           ,[MinDepth]
           ,[MaxDepth]
           ,[AvgDepth]
           ,[SpeciComment]
           ,[Operator]
           ,[TestDate]
           ,[TimeHrs]
           ,[TimeMns]
           ,[EntryBy]
           ,[EntryDate]
           ,[Completed])
			 SELECT 
              [WorkStudyID]
           ,[MillLotNo]
           ,[LotID]
           ,[TestingNo]
           ,[SubConduct]
           ,[SurfConduct]
           ,[MinDepth]
           ,[MaxDepth]
           ,[AvgDepth]
           ,[SpeciComment]
           ,[Operator]
           ,[TestDate]
           ,[TimeHrs]
           ,[TimeMns]
           ,[EntryBy]
           ,[EntryDate]
           ,[Completed]
		   FROM #tempTestingNo
		 
		select TestingNo 
		FROM [dbo].[RNDIGCResults]
		where RecID > @maxRecID
		
		DROP TABLE #tempTestingNo
	END
END



GO
/****** Object:  StoredProcedure [dbo].[RNDImportTestList_READ]    Script Date: 4/11/2018 9:59:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
           
CREATE PROCEDURE 
[dbo].[RNDImportTestList_READ] 
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

/****** Object:  StoredProcedure [dbo].[RNDLocation_Update]    Script Date: 4/11/2018 9:59:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
 [dbo].[RNDLocation_Update]
	@RecID [int],  
    @PlantDesc char(20),
    @PlantState char(2),
    @PlantType tinyint        
AS
BEGIN	
	UPDATE [dbo].[RNDLocation]
	SET 
		[PlantDesc] = @PlantDesc
      ,[PlantState] =  @PlantState 
      ,[PlantType] =  @PlantType
	 WHERE RecID = @RecID   
END

GO

/****** Object:  StoredProcedure [dbo].[RNDMacroEtchResults_Insert]    Script Date: 4/11/2018 9:59:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
 [dbo].[RNDMacroEtchResults_Insert]
 (         @SelectedTests varchar(max),
		   @MaxRexGrainDepth char(50) = null,         
           @SpeciComment char(50) = null,
           @Operator char(20) = null,
           @TestDate datetime,
           @TimeHrs char(2) = null,
           @TimeMns char(2) = null,         
           @EntryBy char(25),
           @EntryDate datetime
)       
AS
BEGIN			
		DECLARE @maxRecID INT	

		IF (@SelectedTests IS NOT NULL)
		BEGIN
			DECLARE @x XML 
			SELECT 	@x = CAST('<A>'+ REPLACE(@SelectedTests,',','</A><A>')+ '</A>' AS XML);		
			SELECT TestingNo, [WorkStudyID],[LotID],[MillLotNo], 
				MaxRexGrainDepth =@MaxRexGrainDepth,				
				SpeciComment =@SpeciComment,
				Operator =@Operator,
				TestDate =@TestDate,
				TimeHrs =@TimeHrs,
				TimeMns =@TimeMns,				
				EntryBy =@EntryBy,
				EntryDate =@EntryDate,
				[Completed] = '1'
			INTO #tempTestingNo			
			FROM RNDTesting
			WHERE TestingNo IN (SELECT t.value('.', 'int') AS inVal FROM @x.nodes('/A') AS x(t))

			UPDATE  RNDTesting
				SET Status = '1' 
				WHERE TestingNo IN (SELECT t.value('.', 'int') AS inVal FROM @x.nodes('/A') AS x(t))

			IF EXISTS (SELECT COUNT(*) FROM [dbo].[RNDMacroEtchResults])
			BEGIN
				SET @maxRecID = (SELECT MAX(RecID) FROM [dbo].[RNDMacroEtchResults])
			END
			ELSE
			BEGIN
				SET @maxRecID = 0
			END

			INSERT INTO [dbo].[RNDMacroEtchResults]
          ([WorkStudyID]
           ,[MillLotNo]
           ,[LotID]
           ,[TestingNo]
           ,[MaxRexGrainDepth]           
           ,[SpeciComment]
           ,[Operator]
           ,[TestDate]
           ,[TimeHrs]
           ,[TimeMns]        
           ,[EntryBy]
           ,[EntryDate]
           ,[Completed])
			 SELECT 
            [WorkStudyID]
           ,[MillLotNo]
           ,[LotID]
           ,[TestingNo]
           ,[MaxRexGrainDepth]           
           ,[SpeciComment]
           ,[Operator]
           ,[TestDate]
           ,[TimeHrs]
           ,[TimeMns]        
           ,[EntryBy]
           ,[EntryDate]
           ,[Completed]
		   FROM #tempTestingNo

		select TestingNo 
		FROM [dbo].[RNDMacroEtchResults]
		where RecID > @maxRecID
		
		DROP TABLE #tempTestingNo
	END
END

GO

/****** Object:  StoredProcedure [dbo].[RNDOpticalMountResults_Insert]    Script Date: 4/11/2018 9:59:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
 [dbo].[RNDOpticalMountResults_Insert]
 (         @SelectedTests varchar(max),		       
           @SpeciComment char(50) = null,
           @Operator char(20) = null,
           @TestDate datetime,
           @TimeHrs char(2) = null,
           @TimeMns char(2) = null,         
           @EntryBy char(25),
           @EntryDate datetime
)       
AS
BEGIN			
		DECLARE @maxRecID INT	

		IF (@SelectedTests IS NOT NULL)
		BEGIN
			DECLARE @x XML 
			SELECT 	@x = CAST('<A>'+ REPLACE(@SelectedTests,',','</A><A>')+ '</A>' AS XML);		
			SELECT TestingNo, [WorkStudyID],[LotID],[MillLotNo],						
				SpeciComment =@SpeciComment,
				Operator =@Operator,
				TestDate =@TestDate,
				TimeHrs =@TimeHrs,
				TimeMns =@TimeMns,				
				EntryBy =@EntryBy,
				EntryDate =@EntryDate,
				[Completed] = '1'
			INTO #tempTestingNo			
			FROM RNDTesting
			WHERE TestingNo IN (SELECT t.value('.', 'int') AS inVal FROM @x.nodes('/A') AS x(t))

			UPDATE  RNDTesting
				SET Status = '1' 
				WHERE TestingNo IN (SELECT t.value('.', 'int') AS inVal FROM @x.nodes('/A') AS x(t))

			IF EXISTS (SELECT COUNT(*) FROM [dbo].[RNDOpticalMountResults])
			BEGIN
				SET @maxRecID = (SELECT MAX(RecID) FROM [dbo].[RNDOpticalMountResults])
			END
			ELSE
			BEGIN
				SET @maxRecID = 0
			END

			INSERT INTO [dbo].[RNDOpticalMountResults]
          ([WorkStudyID]
           ,[MillLotNo]
           ,[LotID]
           ,[TestingNo]
           ,[SpeciComment]
           ,[Operator]
           ,[TestDate]
           ,[TimeHrs]
           ,[TimeMns]        
           ,[EntryBy]
           ,[EntryDate]
           ,[Completed])
			 SELECT 
            [WorkStudyID]
           ,[MillLotNo]
           ,[LotID]
           ,[TestingNo]        
           ,[SpeciComment]
           ,[Operator]
           ,[TestDate]
           ,[TimeHrs]
           ,[TimeMns]        
           ,[EntryBy]
           ,[EntryDate]
           ,[Completed]
		   FROM #tempTestingNo

		select TestingNo 
		FROM [dbo].[RNDOpticalMountResults]
		where RecID > @maxRecID
		
		DROP TABLE #tempTestingNo
	END
END



GO

/****** Object:  StoredProcedure [dbo].[RNDSCCResults_Insert]    Script Date: 4/11/2018 9:59:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
 [dbo].[RNDSCCResults_Insert]
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

			UPDATE  RNDTesting
				SET Status = '1' 
				WHERE TestingNo IN (SELECT t.value('.', 'int') AS inVal FROM @x.nodes('/A') AS x(t))
			
			IF EXISTS (SELECT COUNT(*) FROM [dbo].[RNDSCCResults])
			BEGIN
				SET @maxRecID = (SELECT MAX(RecID) FROM [dbo].[RNDSCCResults])
			END
			ELSE
			BEGIN
				SET @maxRecID = 0
			END
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

GO
/****** Object:  StoredProcedure [dbo].[RNDStudyType_Update]    Script Date: 4/11/2018 9:59:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
 [dbo].[RNDStudyType_Update]
	@RecID [int],
   @TypeDesc [varchar](30)          
AS
BEGIN	
	UPDATE [dbo].[RNDStudyType]
	   SET [TypeDesc] = @TypeDesc 
	 WHERE RecID = @RecID   
END

GO
