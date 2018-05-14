USE RDB 
GO


--------------------------------RNDLogin--------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'RNDLogin'))
BEGIN
	CREATE TABLE [dbo].[RNDLogin](
		[UserId] [int] IDENTITY(1,1) NOT NULL,
		[UserName] [nvarchar](100) NULL,
		[FirstName] [nvarchar](100) NULL,
		[LastName] [nvarchar](100) NULL,
		[UserType] [nvarchar](16) NULL,
		[PasswordHash] [varbinary](max) NULL,
		[PasswordSalt] [varbinary](max) NULL,
		[PermissionLevel] [nvarchar](max) NULL,
		[IssueDate] [datetime] NULL,
		[CreatedBy] [int] NULL,
		[CreatedOn] [datetime] NULL,
		[StatusCode] [nvarchar](16) NULL,
	PRIMARY KEY CLUSTERED 
	(
		[UserId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

END
GO

SET ANSI_PADDING OFF
GO
--------------------------------RNDSecurityTokens--------------------------------

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'RNDSecurityTokens'))
BEGIN
	
	CREATE TABLE [dbo].[RNDSecurityTokens](
		[SecurityTokenId] [int] IDENTITY(1,1) NOT NULL,
		[UserId] [int] NULL,
		[Token] [varchar](100) NULL,
	PRIMARY KEY CLUSTERED 
	(
		[SecurityTokenId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

END
GO
SET ANSI_PADDING OFF
GO



--------------------------------RNDSecurityQuestions--------------------------------
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'RNDSecurityQuestions'))
BEGIN
	CREATE TABLE [dbo].[RNDSecurityQuestions](
		[RNDSecurityQuestionId] [int] IDENTITY(1,1) NOT NULL,
		[Question] [nvarchar](4000) NULL,
		[CreatedBy] [int] NULL,
		[CreatedOn] [datetime] NULL,
		[LastModifiedBy] [int] NULL,
		[LastModifiedOn] [datetime] NULL,
		[StatusCode] [nvarchar](16) NULL,
	PRIMARY KEY CLUSTERED 
	(
		[RNDSecurityQuestionId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

END
GO



--------------------------------RNDUserSecurityAnswers--------------------------------

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'RNDUserSecurityAnswers'))
BEGIN
CREATE TABLE [dbo].[RNDUserSecurityAnswers](
	[RNDUserSecurityAnswerId] [int] IDENTITY(1,1) PRIMARY KEY,
	[RNDLoginId] [int] NOT NULL,
	[RNDSecurityQuestionId] [int] NOT NULL,
	[SecurityAnswer] [nvarchar](500) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedOn] [datetime] NULL,
	[StatusCode] [nvarchar](16) NULL,
)
END
GO

--DROP TABLE RNDSecurityQuestions
IF NOT EXISTS(SELECT 'X' FROM RNDSecurityQuestions)
	BEGIN
		INSERT INTO RNDSecurityQuestions VALUES('In what city did you meet your spouse/significant other?',1,GETDATE(),NULL,NULL,'A')
		INSERT INTO RNDSecurityQuestions VALUES('What was your childhood nickname?',1,GETDATE(),NULL,NULL,'A')
		INSERT INTO RNDSecurityQuestions VALUES('What is the name of your favorite childhood friend?',1,GETDATE(),NULL,NULL,'A')
		INSERT INTO RNDSecurityQuestions VALUES('What street did you live on in third grade?',1,GETDATE(),NULL,NULL,'A')
		INSERT INTO RNDSecurityQuestions VALUES('What is your oldest sibling’s birthday month and year? (e.g., January 1900)',1,GETDATE(),NULL,NULL,'A')
		INSERT INTO RNDSecurityQuestions VALUES('What is the middle name of your oldest child?',1,GETDATE(),NULL,NULL,'A')
		INSERT INTO RNDSecurityQuestions VALUES('What is your oldest sibling’s middle name?',1,GETDATE(),NULL,NULL,'A')
		INSERT INTO RNDSecurityQuestions VALUES('What school did you attend for sixth grade?',1,GETDATE(),NULL,NULL,'A')
		INSERT INTO RNDSecurityQuestions VALUES('What was your childhood phone number including area code? (e.g., 000-000-0000)',1,GETDATE(),NULL,NULL,'A')
		INSERT INTO RNDSecurityQuestions VALUES('What was the name of your first stuffed animal?',1,GETDATE(),NULL,NULL,'A')
		INSERT INTO RNDSecurityQuestions VALUES('What is your maternal grandmother’s maiden name?',1,GETDATE(),NULL,NULL,'A')
		INSERT INTO RNDSecurityQuestions VALUES('In what town was your first job?',1,GETDATE(),NULL,NULL,'A')
	END
GO
