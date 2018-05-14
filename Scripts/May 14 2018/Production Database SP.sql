USE [Production]
GO
/****** Object:  StoredProcedure [dbo].[RNDUACPART_READ]    Script Date: 5/14/2018 9:26:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE 
[dbo].[RNDUACPART_READ] ( @MillLotID INT )
AS
BEGIN
	 DECLARE @DefaultMillLotID INT 
	 SET @DefaultMillLotID = -1

	IF EXISTS 
		(
		SELECT W.WorkOrdID AS MillLotID
		FROM Salesord S WITH(NOLOCK)
		INNER JOIN Workord W WITH(NOLOCK) ON S.SO_Num = W.SO_num AND W.WorkOrdID = @MillLotID
		)
		SELECT LTRIM(RTRIM(S.ALLOY)) AS [ALLOY], LTRIM(RTRIM(S.Temper)) AS Temper, S.UACPART, CONCAT(S.SO_NUM,'-',W.WO_NUM) AS SoNum,
		S.SEARCHPART AS CustPartNo, W.WorkOrdID AS MillLotID
		FROM Salesord S WITH(NOLOCK)
		INNER JOIN Workord W WITH(NOLOCK) ON S.SO_Num = W.SO_num AND W.WorkOrdID = @MillLotID
	ELSE		
		SELECT @DefaultMillLotID
		
END


/****** Object:  StoredProcedure [dbo].[RNDUACPART_READ_RO]    Script Date: 5/14/2018 9:31:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE 
[dbo].[RNDUACPART_READ_RO] ( @MillLotID INT )
AS
BEGIN
	 DECLARE @DefaultMillLotID INT 
	 SET @DefaultMillLotID = -1

	IF EXISTS 
		(
		SELECT W.WorkOrdID AS MillLotID
		--FROM Salesord S WITH(NOLOCK)
		--INNER JOIN Workord W WITH(NOLOCK) ON S.SO_Num = W.SO_num AND W.WorkOrdID = @MillLotID
		FROM ROMSQL01.Production.dbo.Salesord S WITH(NOLOCK)
		INNER JOIN ROMSQL01.Production.dbo.Workord W WITH(NOLOCK) ON S.SO_Num = W.SO_num AND W.WorkOrdID = @MillLotID		
		)
		SELECT LTRIM(RTRIM(S.ALLOY)) AS [ALLOY], LTRIM(RTRIM(S.Temper)) AS Temper, S.UACPART, CONCAT(S.SO_NUM,'-',W.WO_NUM) AS SoNum,
		S.SEARCHPART AS CustPartNo, W.WorkOrdID AS MillLotID
		--FROM Salesord S WITH(NOLOCK)
		--INNER JOIN Workord W WITH(NOLOCK) ON S.SO_Num = W.SO_num AND W.WorkOrdID = @MillLotID
		FROM ROMSQL01.Production.dbo.Salesord S WITH(NOLOCK)
		INNER JOIN ROMSQL01.Production.dbo.Workord  W WITH(NOLOCK) ON S.SO_Num = W.SO_num AND W.WorkOrdID = @MillLotID
	ELSE		
		SELECT @DefaultMillLotID
		
END
