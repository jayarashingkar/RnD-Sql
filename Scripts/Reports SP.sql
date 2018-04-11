--- RNDTensionReports_Read
use rdb 
go

ALTER PROCEDURE 
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
	
	--RNDCompressionReports_Read
CREATE PROCEDURE 
[dbo].RNDCompressionReports_Read 
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

		SELECT A.RecId AS RecId, RTRIM(A.WorkStudyID) AS WorkStudyID, A.TestNo, 
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
		RecId,  WorkStudyID, TestNo, 
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
	--------------------------------

	
/****** Object:  StoredProcedure [dbo].[RNDOpticalMountReports_Read]    Script Date: 4/9/2018 12:46:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
CREATE PROCEDURE 
[dbo].RNDOpticalMountReports_Read 
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
