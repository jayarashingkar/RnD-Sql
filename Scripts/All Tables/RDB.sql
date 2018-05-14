USE [RDB]
GO
/****** Object:  Table [dbo].[age_specimen]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[age_specimen](
	[age_sample_id] [int] IDENTITY(1,1) NOT NULL,
	[rdstudy] [nvarchar](50) NULL,
	[alloy] [nvarchar](10) NULL,
	[temper] [varchar](10) NULL,
	[lot_id] [int] NULL,
	[thickness] [numeric](6, 3) NULL,
	[age_time_step_1] [nvarchar](50) NULL,
	[age_temp_step_1] [int] NULL,
	[age_time_step_2] [nvarchar](50) NULL,
	[age_temp_step_2] [int] NULL,
	[age_time_step_3] [nvarchar](50) NULL,
	[age_temp_step_3] [int] NULL,
	[age_count_tc] [int] NULL,
	[surf_EC_before] [numeric](4, 2) NULL,
	[surf_EC_after] [numeric](4, 2) NULL,
 CONSTRAINT [PK_age_specimen] PRIMARY KEY CLUSTERED 
(
	[age_sample_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Alloy]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alloy](
	[alloy] [nvarchar](10) NOT NULL,
	[uac_alloy] [nvarchar](10) NULL,
	[description] [nvarchar](250) NULL,
 CONSTRAINT [PK_Alloy] PRIMARY KEY CLUSTERED 
(
	[alloy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AppUsers]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AppUsers](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [char](20) NOT NULL,
	[Location] [tinyint] NOT NULL,
	[GroupName] [char](20) NOT NULL,
	[Granted] [tinyint] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[blank]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[blank](
	[operator_id] [int] NOT NULL,
	[specimen_ID] [nvarchar](50) NOT NULL,
	[blank_date] [datetime] NOT NULL,
 CONSTRAINT [PK_blank] PRIMARY KEY CLUSTERED 
(
	[specimen_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[blog]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[blog](
	[blog_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[date] [datetime] NULL,
	[comment] [nvarchar](300) NULL,
	[status] [nvarchar](50) NULL,
 CONSTRAINT [PK_blog] PRIMARY KEY CLUSTERED 
(
	[blog_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[equipment_list]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[equipment_list](
	[unique_id] [int] IDENTITY(1,1) NOT NULL,
	[equipment_name] [nvarchar](50) NULL,
	[description] [nvarchar](50) NULL,
	[serial_number] [nvarchar](50) NULL,
	[enter_date] [datetime] NULL,
	[exit_date] [datetime] NULL,
	[status_date] [datetime] NULL,
	[status] [nvarchar](50) NULL,
	[exit_reason] [nvarchar](200) NULL,
	[person_name] [nvarchar](50) NULL,
 CONSTRAINT [PK_equipment_list] PRIMARY KEY CLUSTERED 
(
	[unique_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[equipment_status]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[equipment_status](
	[status] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_equipment_status_1] PRIMARY KEY CLUSTERED 
(
	[status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EXCO_batch]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXCO_batch](
	[e_batch_id] [int] IDENTITY(1,1) NOT NULL,
	[start_date] [datetime] NULL,
	[end_date] [datetime] NULL,
	[exco_baseline] [nvarchar](50) NULL,
	[sol_temp] [numeric](5, 1) NULL,
	[sol_ph] [numeric](5, 1) NULL,
	[sol_bx] [numeric](5, 2) NULL,
	[operator_id] [int] NULL,
 CONSTRAINT [PK_EXCO_batch] PRIMARY KEY CLUSTERED 
(
	[e_batch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[exco_end_use]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[exco_end_use](
	[end_use] [varchar](50) NOT NULL,
 CONSTRAINT [PK_exco_end_use] PRIMARY KEY CLUSTERED 
(
	[end_use] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EXCO_sample]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EXCO_sample](
	[exco_id] [int] IDENTITY(1,1) NOT NULL,
	[end_use] [varchar](50) NULL,
	[rdstudy] [numeric](5, 0) NULL,
	[exco_baseline] [nvarchar](50) NULL,
	[specimen_id] [nvarchar](50) NULL,
	[lotID] [numeric](7, 0) NULL,
	[e_alloy] [nvarchar](10) NULL,
	[e_temper] [varchar](10) NULL,
	[e_loc] [varchar](10) NULL,
	[e_l] [numeric](8, 3) NULL,
	[e_w] [numeric](8, 3) NULL,
	[e_cond] [numeric](5, 3) NULL,
	[e_m_b] [numeric](8, 3) NULL,
	[e_m_a] [numeric](8, 3) NULL,
	[e_rate] [varchar](10) NULL,
	[e_comment] [varchar](250) NULL,
	[e_picture] [varchar](50) NULL,
 CONSTRAINT [PK_EXCO_test_1] PRIMARY KEY CLUSTERED 
(
	[exco_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[extensometer_cal]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[extensometer_cal](
	[cal_report_no] [int] IDENTITY(1,1) NOT NULL,
	[serial_no] [nvarchar](50) NOT NULL,
	[nodel_no] [nvarchar](50) NOT NULL,
	[gage_length] [decimal](18, 2) NOT NULL,
	[enter_use] [datetime] NOT NULL,
	[exit_use] [datetime] NULL,
	[frame_name] [nvarchar](50) NULL,
	[calib_due_date] [datetime] NULL,
	[class] [nvarchar](50) NULL,
 CONSTRAINT [PK_extensometer_cal] PRIMARY KEY CLUSTERED 
(
	[cal_report_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[igc]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[igc](
	[unique_id] [int] IDENTITY(1,1) NOT NULL,
	[rdstudy] [numeric](5, 0) NULL,
	[specimen_ID] [nvarchar](50) NULL,
	[preparation_date] [datetime] NULL,
	[prepared_by_name] [nvarchar](50) NULL,
	[month] [nvarchar](50) NULL,
	[so_no] [nvarchar](10) NULL,
	[lotID] [numeric](7, 0) NULL,
	[alloy] [nchar](4) NULL,
	[temper] [nvarchar](50) NULL,
	[gage] [numeric](5, 3) NULL,
	[loc1] [nvarchar](50) NULL,
	[no_of_sections] [int] NULL,
	[time] [numeric](2, 1) NULL,
	[time_unit] [varchar](3) NULL,
	[evalueted_by_name] [nvarchar](50) NULL,
	[eval_date] [datetime] NULL,
	[etched] [nvarchar](2) NULL,
	[mag] [nvarchar](5) NULL,
	[depth_max] [numeric](5, 3) NULL,
	[avg_depth] [numeric](5, 3) NULL,
	[accept_crit] [nvarchar](10) NULL,
	[unit] [nvarchar](10) NULL,
	[exception] [nvarchar](3) NULL,
	[comment] [nvarchar](250) NULL,
 CONSTRAINT [PK_LABFRM1011E_igc] PRIMARY KEY CLUSTERED 
(
	[unique_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Location]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Location](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[Plant] [smallint] NULL,
	[PlantDesc] [char](20) NULL,
	[PlantState] [char](2) NULL,
	[PlantType] [tinyint] NULL,
	[EmailAddress] [char](60) NULL,
	[LotHeader] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[machine]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[machine](
	[operator_id] [int] NOT NULL,
	[speicmen_ID] [nvarchar](50) NOT NULL,
	[date_machine] [datetime] NOT NULL,
 CONSTRAINT [PK_machine] PRIMARY KEY CLUSTERED 
(
	[speicmen_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[member]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member](
	[operator_id] [int] NOT NULL,
	[firstname] [nvarchar](50) NOT NULL,
	[lastname] [nvarchar](50) NOT NULL,
	[group_id] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Operator]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Operator](
	[operator_id] [int] NOT NULL,
	[firstname] [nvarchar](50) NOT NULL,
	[lastname] [nvarchar](50) NOT NULL,
	[rdgroup_id] [varchar](15) NULL,
	[prodgroup_id] [nvarchar](50) NULL,
	[last_mod_date] [datetime] NOT NULL,
	[saw] [nchar](1) NULL,
	[m_tension_f] [nchar](1) NULL,
	[m_tension_r] [nchar](1) NULL,
	[m_compression_f] [nchar](1) NULL,
	[m_compression_r] [nchar](1) NULL,
	[m_bearing] [nchar](1) NULL,
	[m_shear] [nchar](1) NULL,
	[m_fracture] [nchar](1) NULL,
	[m_fatigue] [nchar](1) NULL,
	[m_residual] [nchar](1) NULL,
	[m_notch] [nchar](1) NULL,
	[m_exco] [nchar](1) NULL,
	[m_scc] [nchar](1) NULL,
	[m_hardness] [nchar](1) NULL,
	[m_optical] [nchar](1) NULL,
	[m_etchslice] [nchar](1) NULL,
	[m_cond] [nchar](1) NULL,
	[t_tension] [nchar](1) NULL,
	[t_compression] [nchar](1) NULL,
	[t_bearing] [nchar](1) NULL,
	[t_shear] [nchar](1) NULL,
	[t_fracture] [nchar](1) NULL,
	[t_fatigue] [nchar](1) NULL,
	[t_residual] [nchar](1) NULL,
	[t_notch] [nchar](1) NULL,
	[t_exco] [nchar](1) NULL,
	[t_scc] [nchar](1) NULL,
	[t_hardness] [nchar](1) NULL,
	[t_optical] [nchar](1) NULL,
	[t_etchslice] [nchar](1) NULL,
	[t_igc] [nchar](1) NULL,
	[t_hto] [nchar](1) NULL,
	[heat_treat] [nchar](1) NULL,
	[age] [nchar](1) NULL,
	[t_cond] [nchar](1) NULL,
 CONSTRAINT [PK_Operator] PRIMARY KEY CLUSTERED 
(
	[operator_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Oven_Log]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Oven_Log](
	[load_id] [int] IDENTITY(1,1) NOT NULL,
	[operator_id] [int] NULL,
	[oven_no] [int] NULL,
	[tc1_id] [int] NULL,
	[zone_tc1] [int] NULL,
	[tc2_id] [int] NULL,
	[zone_tc2] [int] NULL,
	[tc3_id] [int] NULL,
	[zone_tc3] [int] NULL,
	[tc4_id] [int] NULL,
	[zone_tc4] [int] NULL,
	[tc5_id] [int] NULL,
	[zone_tc5] [int] NULL,
	[tc6_id] [int] NULL,
	[zone_tc6] [int] NULL,
	[tc7_id] [int] NULL,
	[zone_tc7] [int] NULL,
	[tc8_id] [int] NULL,
	[zone_tc8] [int] NULL,
	[time_inn] [datetime] NULL,
	[data_file] [varchar](50) NULL,
 CONSTRAINT [PK_Oven_Log] PRIMARY KEY CLUSTERED 
(
	[load_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[rd_action]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rd_action](
	[actionID] [int] IDENTITY(1,1) NOT NULL,
	[startdate] [datetime] NULL,
	[duedate] [datetime] NULL,
	[assignedto] [nvarchar](50) NULL,
	[description] [nvarchar](1000) NULL,
	[priority] [nvarchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[rdstudy] [int] NULL,
	[completiondate] [datetime] NULL,
	[statusdate] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[rd_action_priority]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rd_action_priority](
	[priority] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_rd_action_priority] PRIMARY KEY CLUSTERED 
(
	[priority] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[rd_action_status]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rd_action_status](
	[status] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_rd_action_status] PRIMARY KEY CLUSTERED 
(
	[status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[rd_orders]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rd_orders](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[lotID] [int] NULL,
	[so_num] [nvarchar](50) NULL,
	[due_date] [datetime] NULL,
	[customer_po] [nvarchar](50) NULL,
	[enter_date] [datetime] NULL,
	[rdstudy] [int] NULL,
	[rd_po] [nvarchar](50) NULL,
	[alloy] [nchar](4) NULL,
	[temper] [nvarchar](50) NULL,
	[material_spec] [nvarchar](50) NULL,
	[ultrasonic_spec] [nvarchar](50) NULL,
	[pieces] [int] NULL,
	[lenght] [numeric](18, 1) NULL,
	[uac_part] [nvarchar](50) NULL,
	[cust_part] [nvarchar](50) NULL,
	[part_detail] [nvarchar](150) NULL,
	[notes] [nvarchar](200) NULL,
	[status] [nvarchar](15) NULL,
	[plant] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RD_Study]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RD_Study](
	[study_ID] [int] IDENTITY(1,1) NOT NULL,
	[rdstudy] [int] NOT NULL,
	[description] [nvarchar](500) NULL,
	[alloy1] [nchar](4) NULL,
	[alloy2] [nchar](4) NULL,
	[alloy3] [nchar](4) NULL,
	[alloy4] [nchar](4) NULL,
	[alloy5] [nchar](4) NULL,
	[temper1] [varchar](10) NULL,
	[temper2] [varchar](10) NULL,
	[temper3] [varchar](10) NULL,
	[temper4] [varchar](10) NULL,
	[temper5] [varchar](10) NULL,
	[date_created] [datetime] NULL,
	[study_status] [varchar](10) NULL,
 CONSTRAINT [PK_RD_Study] PRIMARY KEY CLUSTERED 
(
	[study_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RD_Study_List]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RD_Study_List](
	[WorkStudyID] [nvarchar](10) NULL,
	[StudyDesc] [nvarchar](40) NULL,
	[PlanOSCost] [decimal](9, 2) NULL,
	[TypeDesc] [nvarchar](30) NULL,
	[AcctOSCost] [decimal](9, 2) NULL,
	[StartDate] [datetime] NULL,
	[StatusDesc] [nvarchar](20) NULL,
	[DueDate] [datetime] NULL,
	[StudyScope] [ntext] NULL,
	[CompleteDate] [datetime] NULL,
	[Plant] [nvarchar](2) NULL,
	[EntryDate] [datetime] NULL,
	[EntryBy] [nvarchar](25) NULL,
	[TempID] [nvarchar](40) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RNDAdminUsers]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDAdminUsers](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[FName] [char](15) NULL,
	[LName] [char](15) NULL,
	[PassID] [char](10) NULL,
	[EmpLNo] [char](10) NULL,
	[UserLevel] [char](1) NULL,
	[Plant] [char](2) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDAttachDocs]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDAttachDocs](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[DocTestNo] [int] NULL,
	[DocType] [char](15) NULL,
	[DocNewName] [char](13) NULL,
	[DocOrgName] [char](25) NULL,
	[DocVersion] [int] NULL,
	[DocDescrip] [char](35) NULL,
	[DocActive] [int] NULL,
	[AttachBy] [char](25) NULL,
	[AttachDate] [datetime] NULL,
	[AttPlant] [char](2) NULL,
	[DetachBy] [char](25) NULL,
	[DetachDate] [datetime] NULL,
	[DetPlant] [char](2) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDBearingResults]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDBearingResults](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[TestNo] [int] NULL,
	[SubConduct] [numeric](4, 1) NULL,
	[SurfConduct] [numeric](4, 1) NULL,
	[eDCalc] [numeric](4, 1) NULL,
	[FbruKsi] [numeric](4, 1) NULL,
	[FbryKsi] [numeric](4, 1) NULL,
	[SpeciComment] [char](50) NULL,
	[Operator] [char](20) NULL,
	[TestDate] [datetime] NULL,
	[TestTime] [char](15) NULL,
	[EntryBy] [char](25) NULL,
	[EntryDate] [datetime] NULL,
	[Completed] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDCompressionResults]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDCompressionResults](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[TestNo] [int] NULL,
	[SubConduct] [numeric](4, 1) NULL,
	[SurfConduct] [numeric](4, 1) NULL,
	[FcyKsi] [numeric](4, 1) NULL,
	[EcModulusMpsi] [numeric](4, 1) NULL,
	[SpeciComment] [char](50) NULL,
	[Operator] [char](20) NULL,
	[TestDate] [datetime] NULL,
	[TestTime] [char](15) NULL,
	[EntryBy] [char](25) NULL,
	[EntryDate] [datetime] NULL,
	[Completed] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDCounter]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RNDCounter](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[HTLogNo] [int] NULL,
	[AgeLotNo] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RNDDocCounter]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RNDDocCounter](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[DocUniqueNo] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RNDExcoResults]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDExcoResults](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[MillLotNo] [int] NULL,
	[LotID] [char](10) NULL,
	[TestingNo] [int] NULL,
	[ExcoRating] [char](4) NULL,
	[StartWT] [char](8) NULL,
	[FinalWT] [char](8) NULL,
	[ExposedArea] [char](8) NULL,
	[StartpH] [char](5) NULL,
	[FinalpH] [char](5) NULL,
	[SpeciComment] [char](50) NULL,
	[Operator] [char](20) NULL,
	[TestDate] [datetime] NULL,
	[TimeHrs] [char](2) NULL,
	[TimeMns] [char](2) NULL,
	[BatchNo] [char](4) NULL,
	[EntryBy] [char](25) NULL,
	[EntryDate] [datetime] NULL,
	[Completed] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDFatigueTestingResults]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDFatigueTestingResults](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[TestNo] [int] NULL,
	[SpecimenDrawing] [char](50) NULL,
	[MinStress] [numeric](4, 1) NULL,
	[MaxStress] [numeric](4, 1) NULL,
	[MinLoad] [numeric](7, 2) NULL,
	[MaxLoad] [numeric](7, 2) NULL,
	[WidthOrDia] [numeric](8, 5) NULL,
	[Thickness] [numeric](8, 5) NULL,
	[HoleDia] [numeric](8, 5) NULL,
	[AvgChamferDepth] [numeric](8, 5) NULL,
	[Frequency] [char](5) NULL,
	[CyclesToFailure] [numeric](8, 0) NULL,
	[Roughness] [numeric](5, 2) NULL,
	[TestFrame] [char](5) NULL,
	[Comment] [char](50) NULL,
	[FractureLocation] [char](50) NULL,
	[Operator] [char](20) NULL,
	[TestDate] [datetime] NULL,
	[TestTime] [char](15) NULL,
	[EntryBy] [char](25) NULL,
	[EntryDate] [datetime] NULL,
	[Completed] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDFractureToughnessResults]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDFractureToughnessResults](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[TestNo] [int] NULL,
	[SubConduct] [numeric](4, 1) NULL,
	[SurfConduct] [numeric](4, 1) NULL,
	[Validity] [char](10) NULL,
	[KKsiIn] [numeric](4, 1) NULL,
	[KmaxKsiIn] [numeric](4, 1) NULL,
	[PqLBS] [numeric](7, 0) NULL,
	[PmaxLBS] [numeric](7, 0) NULL,
	[aOIn] [numeric](7, 4) NULL,
	[WIn] [numeric](7, 4) NULL,
	[BIn] [numeric](7, 4) NULL,
	[BnIn] [numeric](7, 4) NULL,
	[AvgFinalPreCrack] [numeric](7, 4) NULL,
	[SpeciComment] [char](50) NULL,
	[Operator] [char](20) NULL,
	[TestDate] [datetime] NULL,
	[TestTime] [char](15) NULL,
	[EntryBy] [char](25) NULL,
	[EntryDate] [datetime] NULL,
	[Completed] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDHardnessResults]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDHardnessResults](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[MillLotNo] [int] NULL,
	[LotID] [char](10) NULL,
	[TestingNo] [int] NULL,
	[SubConduct] [char](4) NULL,
	[SurfConduct] [char](4) NULL,
	[Hardness] [char](5) NULL,
	[SpeciComment] [char](50) NULL,
	[Operator] [char](20) NULL,
	[TestDate] [datetime] NULL,
	[TimeHrs] [char](2) NULL,
	[TimeMns] [char](2) NULL,
	[EntryBy] [char](25) NULL,
	[EntryDate] [datetime] NULL,
	[Completed] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDIGCResults]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDIGCResults](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[MillLotNo] [int] NULL,
	[LotID] [char](10) NULL,
	[TestingNo] [int] NULL,
	[SubConduct] [char](4) NULL,
	[SurfConduct] [char](4) NULL,
	[MinDepth] [char](7) NULL,
	[MaxDepth] [char](7) NULL,
	[AvgDepth] [char](7) NULL,
	[SpeciComment] [char](50) NULL,
	[Operator] [char](20) NULL,
	[TestDate] [datetime] NULL,
	[TimeHrs] [char](2) NULL,
	[TimeMns] [char](2) NULL,
	[EntryBy] [char](25) NULL,
	[EntryDate] [datetime] NULL,
	[Completed] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDLocation]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDLocation](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[Plant] [smallint] NULL,
	[PlantDesc] [char](20) NULL,
	[PlantState] [char](2) NULL,
	[PlantType] [tinyint] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDLogin]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDLot_ID]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDLot_ID](
	[RNDLotID] [varchar](10) NULL,
	[Hole] [char](2) NULL,
	[PieceNo] [char](2) NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[MillLotNo] [int] NULL,
	[RCS] [char](1) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDLotID]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDLotID](
	[RNDLotID] [varchar](10) NULL,
	[Hole] [char](2) NULL,
	[PieceNo] [char](2) NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[MillLotNo] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDMacroEtchResults]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDMacroEtchResults](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[MillLotNo] [int] NULL,
	[LotID] [char](10) NULL,
	[TestingNo] [int] NULL,
	[MaxRexGrainDepth] [char](50) NULL,
	[SpeciComment] [char](50) NULL,
	[Operator] [char](20) NULL,
	[TestDate] [datetime] NULL,
	[TimeHrs] [char](2) NULL,
	[TimeMns] [char](2) NULL,
	[EntryBy] [char](25) NULL,
	[EntryDate] [datetime] NULL,
	[Completed] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDMaterial]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDMaterial](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[SoNum] [char](10) NULL,
	[MillLotNo] [int] NULL,
	[CustPart] [char](30) NULL,
	[UACPart] [numeric](5, 0) NULL,
	[Alloy] [char](10) NULL,
	[Temper] [char](6) NULL,
	[GageThickness] [char](7) NULL,
	[Location2] [char](6) NULL,
	[Hole] [char](2) NULL,
	[PieceNo] [char](2) NULL,
	[Comment] [char](40) NULL,
	[EntryDate] [datetime] NULL,
	[EntryBy] [char](25) NULL,
	[DBCntry] [char](3) NULL,
	[RCS] [char](1) NULL,
	[Deleted] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDModulusCompressionResults]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDModulusCompressionResults](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[TestNo] [int] NULL,
	[SubConduct] [numeric](4, 1) NULL,
	[SurfConduct] [numeric](4, 1) NULL,
	[EModulusCompression] [numeric](4, 1) NULL,
	[SpeciComment] [char](50) NULL,
	[Operator] [char](20) NULL,
	[TestDate] [datetime] NULL,
	[TestTime] [char](15) NULL,
	[EntryBy] [char](25) NULL,
	[EntryDate] [datetime] NULL,
	[Completed] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDModulusTensionResults]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDModulusTensionResults](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[TestNo] [int] NULL,
	[SubConduct] [numeric](4, 1) NULL,
	[SurfConduct] [numeric](4, 1) NULL,
	[EModulusTension] [numeric](4, 1) NULL,
	[SpeciComment] [char](50) NULL,
	[Operator] [char](20) NULL,
	[TestDate] [datetime] NULL,
	[TestTime] [char](15) NULL,
	[EntryBy] [char](25) NULL,
	[EntryDate] [datetime] NULL,
	[Completed] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDNotchYieldResults]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDNotchYieldResults](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[TestNo] [int] NULL,
	[SubConduct] [numeric](4, 1) NULL,
	[SurfConduct] [numeric](4, 1) NULL,
	[NotchStrengthKsi] [numeric](4, 1) NULL,
	[YieldStrengthKsi] [numeric](3, 0) NULL,
	[NotchYieldRatio] [numeric](5, 3) NULL,
	[SpeciComment] [char](50) NULL,
	[Operator] [char](20) NULL,
	[TestDate] [datetime] NULL,
	[TestTime] [char](15) NULL,
	[EntryBy] [char](25) NULL,
	[EntryDate] [datetime] NULL,
	[Completed] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDOpticalMountResults]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDOpticalMountResults](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[MillLotNo] [int] NULL,
	[LotID] [char](10) NULL,
	[TestingNo] [int] NULL,
	[SpeciComment] [char](50) NULL,
	[Operator] [char](20) NULL,
	[TestDate] [datetime] NULL,
	[TimeHrs] [char](2) NULL,
	[TimeMns] [char](2) NULL,
	[EntryBy] [char](25) NULL,
	[EntryDate] [datetime] NULL,
	[Completed] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDProcessing]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDProcessing](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[MillLotNo] [int] NULL,
	[Sonum] [char](10) NULL,
	[ProcessNo] [tinyint] NULL,
	[ProcessID] [char](10) NULL,
	[HTLogNo] [int] NULL,
	[HTLogID] [char](10) NULL,
	[AgeLotNo] [int] NULL,
	[AgeLotID] [char](10) NULL,
	[Hole] [char](2) NULL,
	[PieceNo] [char](2) NULL,
	[SHTTemp] [char](5) NULL,
	[SHSoakHrs] [char](2) NULL,
	[SHSoakMns] [char](2) NULL,
	[SHTStartHrs] [char](2) NULL,
	[SHTStartMns] [char](2) NULL,
	[SHTDate] [datetime] NULL,
	[StretchPct] [char](5) NULL,
	[AfterSHTHrs] [char](2) NULL,
	[AfterSHTMns] [char](2) NULL,
	[NatAgingHrs] [char](2) NULL,
	[NatAgingMns] [char](2) NULL,
	[ArtStartHrs] [char](2) NULL,
	[ArtStartMns] [char](2) NULL,
	[ArtAgeDate] [datetime] NULL,
	[ArtAgeTemp1] [char](5) NULL,
	[ArtAgeHrs1] [char](2) NULL,
	[ArtAgeMns1] [char](2) NULL,
	[ArtAgeTemp2] [char](5) NULL,
	[ArtAgeHrs2] [char](2) NULL,
	[ArtAgeMns2] [char](2) NULL,
	[ArtAgeTemp3] [char](5) NULL,
	[ArtAgeHrs3] [char](2) NULL,
	[ArtAgeMns3] [char](2) NULL,
	[FinalTemper] [char](10) NULL,
	[TargetCount] [char](10) NULL,
	[ActualCount] [char](10) NULL,
	[RCS] [char](1) NULL,
	[Deleted] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDQueueLabel]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDQueueLabel](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[TestingNo] [int] NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[LotID] [char](10) NULL,
	[MillLotNo] [int] NULL,
	[SoNum] [char](10) NULL,
	[Hole] [char](2) NULL,
	[PieceNo] [char](2) NULL,
	[Alloy] [char](10) NULL,
	[Temper] [char](10) NULL,
	[CustPart] [char](30) NULL,
	[UACPart] [numeric](6, 0) NULL,
	[GageThickness] [char](7) NULL,
	[Orientation] [char](4) NULL,
	[Location1] [char](10) NULL,
	[Location2] [char](6) NULL,
	[Location3] [char](6) NULL,
	[SpeciComment] [char](40) NULL,
	[TestType] [char](35) NULL,
	[SubTestType] [char](35) NULL,
	[Status] [char](1) NULL,
	[Selected] [char](1) NULL,
	[EntryDate] [datetime] NULL,
	[EntryBy] [char](25) NULL,
	[TestLab] [char](15) NULL,
	[Replica] [char](2) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDRCurveResults]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDRCurveResults](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[TestNo] [int] NULL,
	[SubConduct] [numeric](4, 1) NULL,
	[SurfConduct] [numeric](4, 1) NULL,
	[KCKsiIn] [numeric](4, 1) NULL,
	[KAPPKsiIn] [numeric](4, 1) NULL,
	[PmaxLBS] [numeric](7, 0) NULL,
	[aOIn] [numeric](7, 4) NULL,
	[afIn] [numeric](7, 4) NULL,
	[WIn] [numeric](7, 4) NULL,
	[BIn] [numeric](7, 4) NULL,
	[BnIn] [numeric](7, 4) NULL,
	[AvgFinalPreCrack] [numeric](7, 4) NULL,
	[SpeciComment] [char](50) NULL,
	[Operator] [char](20) NULL,
	[TestDate] [datetime] NULL,
	[TestTime] [char](15) NULL,
	[EntryBy] [char](25) NULL,
	[EntryDate] [datetime] NULL,
	[Completed] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDResidualStrengthResults]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDResidualStrengthResults](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[TestNo] [int] NULL,
	[SubConduct] [numeric](4, 1) NULL,
	[SurfConduct] [numeric](4, 1) NULL,
	[Validity] [char](5) NULL,
	[ResidualStrength] [numeric](4, 1) NULL,
	[PmaxLBS] [numeric](7, 0) NULL,
	[WIn] [numeric](7, 4) NULL,
	[BIn] [numeric](7, 4) NULL,
	[AvgFinalPreCrack] [numeric](7, 4) NULL,
	[SpeciComment] [char](50) NULL,
	[Operator] [char](20) NULL,
	[TestDate] [datetime] NULL,
	[TestTime] [char](15) NULL,
	[EntryBy] [char](25) NULL,
	[EntryDate] [datetime] NULL,
	[Completed] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDSCCResults]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDSCCResults](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[MillLotNo] [int] NULL,
	[LotID] [char](10) NULL,
	[TestingNo] [int] NULL,
	[StressKsi] [char](5) NULL,
	[TimeDays] [char](2) NULL,
	[TestStatus] [char](5) NULL,
	[SpeciComment] [char](50) NULL,
	[Operator] [char](20) NULL,
	[TestStartDate] [datetime] NULL,
	[TestEndDate] [datetime] NULL,
	[EntryBy] [char](25) NULL,
	[EntryDate] [datetime] NULL,
	[Completed] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDSecurityQuestions]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[RNDSecurityTokens]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDSecurityTokens](
	[SecurityTokenId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[Token] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[SecurityTokenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDShearResults]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDShearResults](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[TestNo] [int] NULL,
	[SubConduct] [numeric](4, 1) NULL,
	[SurfConduct] [numeric](4, 1) NULL,
	[FsuKsi] [numeric](4, 1) NULL,
	[SpeciComment] [char](50) NULL,
	[Operator] [char](20) NULL,
	[TestDate] [datetime] NULL,
	[TestTime] [char](15) NULL,
	[EntryBy] [char](25) NULL,
	[EntryDate] [datetime] NULL,
	[Completed] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDStudyCheckOut]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDStudyCheckOut](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[FName] [char](15) NULL,
	[LName] [char](15) NULL,
	[PassID] [char](10) NULL,
	[EmpLNo] [char](10) NULL,
	[UserRecID] [int] NULL,
	[CheckOut] [char](1) NULL,
	[CODate] [datetime] NULL,
	[CIDate] [datetime] NULL,
	[SName] [char](15) NULL,
	[Reason] [char](40) NULL,
	[Plant] [char](2) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDStudyScope]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDStudyScope](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[ScopeType] [char](2) NULL,
	[StudyScope] [char](900) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDStudyStatus]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDStudyStatus](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[StudyStatus] [char](2) NOT NULL,
	[StatusDesc] [char](20) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDStudyType]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDStudyType](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[TypeStudy] [char](2) NOT NULL,
	[TypeDesc] [char](30) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDSubTestType]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDSubTestType](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[SubTestType] [char](35) NULL,
	[SubTestCode] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDTensionResults]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDTensionResults](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[TestNo] [int] NULL,
	[SubConduct] [numeric](4, 1) NULL,
	[SurfConduct] [numeric](4, 1) NULL,
	[FtuKsi] [numeric](4, 1) NULL,
	[FtyKsi] [numeric](4, 1) NULL,
	[eElongation] [numeric](4, 1) NULL,
	[EModulusMpsi] [numeric](4, 1) NULL,
	[SpeciComment] [char](50) NULL,
	[Operator] [char](20) NULL,
	[TestDate] [datetime] NULL,
	[TestTime] [char](15) NULL,
	[EntryBy] [char](25) NULL,
	[EntryDate] [datetime] NULL,
	[Completed] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDTesting]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDTesting](
	[TestingNo] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[LotID] [char](10) NULL,
	[MillLotNo] [int] NULL,
	[SoNum] [char](10) NULL,
	[Hole] [char](2) NULL,
	[PieceNo] [char](2) NULL,
	[Alloy] [char](10) NULL,
	[Temper] [char](10) NULL,
	[CustPart] [char](30) NULL,
	[UACPart] [numeric](6, 0) NULL,
	[GageThickness] [char](7) NULL,
	[Orientation] [char](4) NULL,
	[Location1] [char](10) NULL,
	[Location2] [char](6) NULL,
	[Location3] [char](6) NULL,
	[SpeciComment] [char](60) NULL,
	[TestType] [char](35) NULL,
	[SubTestType] [char](35) NULL,
	[Status] [char](1) NULL,
	[Selected] [char](1) NULL,
	[EntryDate] [datetime] NULL,
	[EntryBy] [char](25) NULL,
	[TestLab] [char](15) NULL,
	[Printed] [char](1) NULL,
	[Replica] [char](2) NULL,
	[RCS] [char](1) NULL,
	[Deleted] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDTestList]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDTestList](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[TestDesc] [char](35) NOT NULL,
	[TestTableName] [char](35) NOT NULL,
	[Active] [char](1) NOT NULL,
	[TabPos] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDTestListAndType]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDTestListAndType](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[TestDesc] [char](35) NOT NULL,
	[SubTestType] [char](35) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDTestListInStudy]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDTestListInStudy](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NULL,
	[TestDesc] [char](35) NOT NULL,
	[TabPos] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDTestListNotInStudy]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDTestListNotInStudy](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[TestDesc] [char](35) NOT NULL,
	[TabPos] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RNDUserSecurityAnswers]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RNDUserSecurityAnswers](
	[RNDUserSecurityAnswerId] [int] IDENTITY(1,1) NOT NULL,
	[RNDLoginId] [int] NOT NULL,
	[RNDSecurityQuestionId] [int] NOT NULL,
	[SecurityAnswer] [nvarchar](500) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastModifiedBy] [int] NULL,
	[LastModifiedOn] [datetime] NULL,
	[StatusCode] [nvarchar](16) NULL,
PRIMARY KEY CLUSTERED 
(
	[RNDUserSecurityAnswerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RNDWorkStudy]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RNDWorkStudy](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[WorkStudyID] [char](10) NOT NULL,
	[StudyType] [char](2) NULL,
	[StudyDesc] [char](40) NULL,
	[PlanOSCost] [numeric](9, 2) NULL,
	[AcctOSCost] [numeric](9, 2) NULL,
	[StudyStatus] [char](2) NULL,
	[StartDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[CompleteDate] [datetime] NULL,
	[Plant] [char](2) NULL,
	[EntryDate] [datetime] NULL,
	[EntryBy] [char](25) NULL,
	[TempID] [char](50) NULL,
	[Experimentation] [varchar](900) NULL,
	[FinalSummary] [varchar](900) NULL,
	[Uncertainty] [nvarchar](1000) NULL,
	[Deleted] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Shipping]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Shipping](
	[ship_id] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](250) NOT NULL,
	[operator_id] [int] NOT NULL,
	[carrier] [nvarchar](50) NOT NULL,
	[tracking_no] [nvarchar](50) NOT NULL,
	[ship_date] [datetime] NOT NULL,
	[company] [nvarchar](50) NULL,
	[destination_name] [nvarchar](50) NOT NULL,
	[destination_address] [nvarchar](250) NOT NULL,
	[destination_phone] [nvarchar](50) NULL,
	[rdstudy] [int] NULL,
	[data_file] [varchar](50) NULL,
 CONSTRAINT [PK_Shipping] PRIMARY KEY CLUSTERED 
(
	[ship_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Specimen_log]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Specimen_log](
	[specimen_seq] [int] IDENTITY(1,1) NOT NULL,
	[rdstudy] [numeric](5, 0) NULL,
	[cust_part] [nvarchar](50) NULL,
	[uac_part] [int] NULL,
	[lotID] [numeric](7, 0) NULL,
	[alloy] [nchar](4) NULL,
	[temper] [nvarchar](10) NULL,
	[testtype] [nvarchar](50) NULL,
	[subtesttype] [nvarchar](50) NULL,
	[gage] [numeric](5, 3) NULL,
	[orientation] [nchar](2) NULL,
	[replica] [numeric](5, 0) NULL,
	[loc1] [nvarchar](50) NULL,
	[loc2] [nvarchar](50) NULL,
	[loc3] [nvarchar](50) NULL,
	[specimen_ID] [nvarchar](50) NULL,
	[description] [nvarchar](200) NULL,
	[date] [datetime] NULL,
 CONSTRAINT [PK_Specimen_log] PRIMARY KEY CLUSTERED 
(
	[specimen_seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StudyStatus]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StudyStatus](
	[study_status] [varchar](10) NOT NULL,
 CONSTRAINT [PK_StudyStatus] PRIMARY KEY CLUSTERED 
(
	[study_status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Temper]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Temper](
	[temper] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Temper] PRIMARY KEY CLUSTERED 
(
	[temper] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserGroups]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserGroups](
	[GroupID] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [char](20) NOT NULL,
	[GroupDesc] [char](30) NOT NULL,
	[GroupPwd] [char](15) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ValidAlloy]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ValidAlloy](
	[Alloy] [char](6) NOT NULL,
	[AlloyDescription] [char](30) NOT NULL,
	[Multiplier] [numeric](6, 5) NULL,
	[AlloyType] [char](1) NULL,
	[PriceCategory] [int] NULL,
	[SoakTemp] [int] NULL,
	[PIMulti] [numeric](5, 3) NULL,
	[MinSoak] [int] NULL,
	[HighLimit] [int] NULL,
 CONSTRAINT [PK__ValidAlloy__7814D14C] PRIMARY KEY CLUSTERED 
(
	[Alloy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[validalloytemper]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[validalloytemper](
	[alloy] [char](30) NOT NULL,
	[temper] [char](6) NOT NULL,
	[Spec] [char](30) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[webreport_style]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[webreport_style](
	[report_style_id] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](6) NOT NULL,
	[field] [int] NOT NULL,
	[group] [int] NOT NULL,
	[style_str] [text] NOT NULL,
	[uniq] [int] NULL,
	[repname] [nvarchar](255) NOT NULL,
	[styletype] [nvarchar](40) NOT NULL,
 CONSTRAINT [PK_webreport_style] PRIMARY KEY CLUSTERED 
(
	[report_style_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[webreports]    Script Date: 5/14/2018 10:38:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[webreports](
	[rpt_id] [int] IDENTITY(1,1) NOT NULL,
	[rpt_name] [nvarchar](100) NOT NULL,
	[rpt_title] [nvarchar](500) NULL,
	[rpt_cdate] [datetime] NOT NULL,
	[rpt_mdate] [datetime] NULL,
	[rpt_content] [text] NOT NULL,
	[rpt_owner] [varchar](100) NOT NULL,
	[rpt_status] [varchar](10) NOT NULL,
	[rpt_type] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[rpt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[AppUsers] ADD  CONSTRAINT [dfltGranted]  DEFAULT ((0)) FOR [Granted]
GO
ALTER TABLE [dbo].[ValidAlloy] ADD  CONSTRAINT [DF_ValidAlloy_PIMulti]  DEFAULT ((0)) FOR [PIMulti]
GO
ALTER TABLE [dbo].[EXCO_sample]  WITH CHECK ADD  CONSTRAINT [FK_EXCO_test_Alloy] FOREIGN KEY([e_alloy])
REFERENCES [dbo].[Alloy] ([alloy])
GO
ALTER TABLE [dbo].[EXCO_sample] CHECK CONSTRAINT [FK_EXCO_test_Alloy]
GO
ALTER TABLE [dbo].[EXCO_sample]  WITH CHECK ADD  CONSTRAINT [FK_EXCO_test_exco_end_use] FOREIGN KEY([end_use])
REFERENCES [dbo].[exco_end_use] ([end_use])
GO
ALTER TABLE [dbo].[EXCO_sample] CHECK CONSTRAINT [FK_EXCO_test_exco_end_use]
GO
ALTER TABLE [dbo].[EXCO_sample]  WITH CHECK ADD  CONSTRAINT [FK_EXCO_test_Temper] FOREIGN KEY([e_temper])
REFERENCES [dbo].[Temper] ([temper])
GO
ALTER TABLE [dbo].[EXCO_sample] CHECK CONSTRAINT [FK_EXCO_test_Temper]
GO
ALTER TABLE [dbo].[machine]  WITH CHECK ADD  CONSTRAINT [FK_machine_Operator] FOREIGN KEY([operator_id])
REFERENCES [dbo].[Operator] ([operator_id])
GO
ALTER TABLE [dbo].[machine] CHECK CONSTRAINT [FK_machine_Operator]
GO
ALTER TABLE [dbo].[AppUsers]  WITH CHECK ADD  CONSTRAINT [chkGranted] CHECK  (([Granted]=(1) OR [Granted]=(0)))
GO
ALTER TABLE [dbo].[AppUsers] CHECK CONSTRAINT [chkGranted]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'RD study' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'age_specimen', @level2type=N'COLUMN',@level2name=N'rdstudy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Final temper desired to be achieved' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'age_specimen', @level2type=N'COLUMN',@level2name=N'temper'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UAC lot number' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'age_specimen', @level2type=N'COLUMN',@level2name=N'lot_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Soak time during first aging step' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'age_specimen', @level2type=N'COLUMN',@level2name=N'age_time_step_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'First age step soak temp' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'age_specimen', @level2type=N'COLUMN',@level2name=N'age_temp_step_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Second age step soak time' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'age_specimen', @level2type=N'COLUMN',@level2name=N'age_time_step_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Second age step soak temp' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'age_specimen', @level2type=N'COLUMN',@level2name=N'age_temp_step_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Third age step soak time' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'age_specimen', @level2type=N'COLUMN',@level2name=N'age_time_step_3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Third age step soak temp' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'age_specimen', @level2type=N'COLUMN',@level2name=N'age_temp_step_3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Age counts calculated for this sample' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'age_specimen', @level2type=N'COLUMN',@level2name=N'age_count_tc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Surface electrical cond of sample before aging' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'age_specimen', @level2type=N'COLUMN',@level2name=N'surf_EC_before'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Surface electrical cond after aging' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'age_specimen', @level2type=N'COLUMN',@level2name=N'surf_EC_after'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of samples being aged' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'age_specimen'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Equipment name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'equipment_list', @level2type=N'COLUMN',@level2name=N'equipment_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Equipment description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'equipment_list', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Equipment serial number' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'equipment_list', @level2type=N'COLUMN',@level2name=N'serial_number'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date when entered service' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'equipment_list', @level2type=N'COLUMN',@level2name=N'enter_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date when taken out of service' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'equipment_list', @level2type=N'COLUMN',@level2name=N'exit_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date when status updated by "person_name"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'equipment_list', @level2type=N'COLUMN',@level2name=N'status_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Equipment status' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'equipment_list', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Reason for taking the equipment out of service' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'equipment_list', @level2type=N'COLUMN',@level2name=N'exit_reason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of person reporting status' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'equipment_list', @level2type=N'COLUMN',@level2name=N'person_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Equipment status' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'equipment_status', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time when test started' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_batch', @level2type=N'COLUMN',@level2name=N'start_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time when test ended' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_batch', @level2type=N'COLUMN',@level2name=N'end_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sample ID for sample 8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_batch', @level2type=N'COLUMN',@level2name=N'exco_baseline'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Solution temperature' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_batch', @level2type=N'COLUMN',@level2name=N'sol_temp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Solution pH' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_batch', @level2type=N'COLUMN',@level2name=N'sol_ph'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Solids content evaluate with the refractometer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_batch', @level2type=N'COLUMN',@level2name=N'sol_bx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'EXCO batch' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_batch'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is it used for R&D or lot release or preriodic testing or capability' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'exco_end_use', @level2type=N'COLUMN',@level2name=N'end_use'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Defines the options for end_use variable in EXCO_test table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'exco_end_use'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is it used for R&D or lot release or preriodic testing or capability' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_sample', @level2type=N'COLUMN',@level2name=N'end_use'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'RD Study looked up in tavle RD_Study' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_sample', @level2type=N'COLUMN',@level2name=N'rdstudy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sample ID for sample 8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_sample', @level2type=N'COLUMN',@level2name=N'exco_baseline'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Alloy used' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_sample', @level2type=N'COLUMN',@level2name=N'e_alloy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Temper' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_sample', @level2type=N'COLUMN',@level2name=N'e_temper'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Specimen location (surface, t/10, t/2)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_sample', @level2type=N'COLUMN',@level2name=N'e_loc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Specimen length in mm' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_sample', @level2type=N'COLUMN',@level2name=N'e_l'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Specimen width in mm' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_sample', @level2type=N'COLUMN',@level2name=N'e_w'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Specimen electrical cond measured on the exposed surface in IACS' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_sample', @level2type=N'COLUMN',@level2name=N'e_cond'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Specimen mass in grams before test' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_sample', @level2type=N'COLUMN',@level2name=N'e_m_b'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Specimen mass in grams after test' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_sample', @level2type=N'COLUMN',@level2name=N'e_m_a'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'EXCO rating: Pitting, EA, EB, EC, ED' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_sample', @level2type=N'COLUMN',@level2name=N'e_rate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Specimen comment' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_sample', @level2type=N'COLUMN',@level2name=N'e_comment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'File name for the picture associated with the sample' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_sample', @level2type=N'COLUMN',@level2name=N'e_picture'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of EXCO specimen' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EXCO_sample'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Calibration report number' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'extensometer_cal', @level2type=N'COLUMN',@level2name=N'cal_report_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Extensometer serial number' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'extensometer_cal', @level2type=N'COLUMN',@level2name=N'serial_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Extensometer model number' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'extensometer_cal', @level2type=N'COLUMN',@level2name=N'nodel_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Gage length of the extensometer' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'extensometer_cal', @level2type=N'COLUMN',@level2name=N'gage_length'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date when calibrated to this particular machine' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'extensometer_cal', @level2type=N'COLUMN',@level2name=N'enter_use'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date when current calibration report became invalid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'extensometer_cal', @level2type=N'COLUMN',@level2name=N'exit_use'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Frame that the extensometer is calibrated to' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'extensometer_cal', @level2type=N'COLUMN',@level2name=N'frame_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Next calibration due date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'extensometer_cal', @level2type=N'COLUMN',@level2name=N'calib_due_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Extensometer class based on calibration data' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'extensometer_cal', @level2type=N'COLUMN',@level2name=N'class'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lists which extensometer is calibrated to which frame' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'extensometer_cal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sample Preparation Date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc', @level2type=N'COLUMN',@level2name=N'preparation_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of operator preparing the sample' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc', @level2type=N'COLUMN',@level2name=N'prepared_by_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sales order number' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc', @level2type=N'COLUMN',@level2name=N'so_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lot number' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc', @level2type=N'COLUMN',@level2name=N'lotID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Alloy' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc', @level2type=N'COLUMN',@level2name=N'alloy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Temper' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc', @level2type=N'COLUMN',@level2name=N'temper'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Section thickness' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc', @level2type=N'COLUMN',@level2name=N'gage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sample location as in front, middle, or rear' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc', @level2type=N'COLUMN',@level2name=N'loc1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of sections' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc', @level2type=N'COLUMN',@level2name=N'no_of_sections'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Exposure time in hours' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc', @level2type=N'COLUMN',@level2name=N'time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Time measurement units' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc', @level2type=N'COLUMN',@level2name=N'time_unit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of person evaluating the sample' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc', @level2type=N'COLUMN',@level2name=N'evalueted_by_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Has the sample been etched Yes/No' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc', @level2type=N'COLUMN',@level2name=N'etched'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Magnification used in the evaluation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc', @level2type=N'COLUMN',@level2name=N'mag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Average depth of attack' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc', @level2type=N'COLUMN',@level2name=N'avg_depth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Depth used for acceptance criteria' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc', @level2type=N'COLUMN',@level2name=N'accept_crit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unit of measurement used to report depth_max, avg_depth and accept_crit' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc', @level2type=N'COLUMN',@level2name=N'unit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Exception to procedure Yes/No' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc', @level2type=N'COLUMN',@level2name=N'exception'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Comments' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IGC testing lab log form' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'igc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Table listing the members of the R&D group and their access level to the web data' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Operator ID that is the same number used for the time clock' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'operator_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Operator first name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'firstname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Operator last name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'lastname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lists the people having access to the R&D side of the web site and their access level' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'rdgroup_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lists the people having access to the production side of the web site and their access level' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'prodgroup_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last modification date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'last_mod_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to saw samples?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'saw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to machine tension flat samples?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'm_tension_f'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to machine tension round samples?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'm_tension_r'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to machine compression flat samples?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'm_compression_f'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to machine compression round samples?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'm_compression_r'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to machine bearing samples?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'm_bearing'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to machine shear samples?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'm_shear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to machine facture samples?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'm_fracture'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to machine fatigue samples?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'm_fatigue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to machine residual samples?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'm_residual'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to machine notch samples?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'm_notch'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to machine EXCO samples?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'm_exco'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to machine SCC samples?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'm_scc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to machine hardness samples?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'm_hardness'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to prepare optical mount?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'm_optical'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to machine etch slice?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'm_etchslice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to machine samples for electrical cond?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'm_cond'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to test tension?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N't_tension'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to test compression?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N't_compression'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to test bearing?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N't_bearing'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to test shear?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N't_shear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to test fracture?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N't_fracture'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to test fatigue?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N't_fatigue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to test residual?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N't_residual'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to test notch-yield?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N't_notch'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to evaluate EXCO?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N't_exco'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to evaluate SCC?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N't_scc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to measure hardness?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N't_hardness'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to evaluate optical microstructures?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N't_optical'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to etch slice?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N't_etchslice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to IGC?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N't_igc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to evaluate high temperature oxidation?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N't_hto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to heat treat material?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'heat_treat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to age material?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N'age'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Is operator certified to test electrical conductivity' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Operator', @level2type=N'COLUMN',@level2name=N't_cond'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Oven number based on UAC numbering' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log', @level2type=N'COLUMN',@level2name=N'oven_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sample ID associated with thermocouple 1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log', @level2type=N'COLUMN',@level2name=N'tc1_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Oven zone where sample 1 is placed.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log', @level2type=N'COLUMN',@level2name=N'zone_tc1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sample ID associated with thermocouple 2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log', @level2type=N'COLUMN',@level2name=N'tc2_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Oven zone where sample 2  is placed.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log', @level2type=N'COLUMN',@level2name=N'zone_tc2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sample ID associated with thermocouple 3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log', @level2type=N'COLUMN',@level2name=N'tc3_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Oven zone where sample 3  is placed.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log', @level2type=N'COLUMN',@level2name=N'zone_tc3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sample ID associated with thermocouple 4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log', @level2type=N'COLUMN',@level2name=N'tc4_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Oven zone where sample 4  is placed.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log', @level2type=N'COLUMN',@level2name=N'zone_tc4'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sample ID associated with thermocouple 5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log', @level2type=N'COLUMN',@level2name=N'tc5_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Oven zone where sample 5  is placed.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log', @level2type=N'COLUMN',@level2name=N'zone_tc5'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sample ID associated with thermocouple 6' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log', @level2type=N'COLUMN',@level2name=N'tc6_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Oven zone where sample 6  is placed.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log', @level2type=N'COLUMN',@level2name=N'zone_tc6'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sample ID associated with thermocouple 7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log', @level2type=N'COLUMN',@level2name=N'tc7_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Oven zone where sample 7  is placed.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log', @level2type=N'COLUMN',@level2name=N'zone_tc7'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sample ID associated with thermocouple 8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log', @level2type=N'COLUMN',@level2name=N'tc8_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Oven zone where sample 8  is placed.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log', @level2type=N'COLUMN',@level2name=N'zone_tc8'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Time when age cycle started' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log', @level2type=N'COLUMN',@level2name=N'time_inn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'File name of the time-temperature curve that is being saved on \\usctrd01\ASPFILES\Ageload directory' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log', @level2type=N'COLUMN',@level2name=N'data_file'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of age loads used in RD' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Oven_Log'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Task assign date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'rd_action', @level2type=N'COLUMN',@level2name=N'startdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Task due date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'rd_action', @level2type=N'COLUMN',@level2name=N'duedate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Task assigned to' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'rd_action', @level2type=N'COLUMN',@level2name=N'assignedto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Task desription' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'rd_action', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Task status' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'rd_action', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Completion date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'rd_action', @level2type=N'COLUMN',@level2name=N'completiondate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date status updated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'rd_action', @level2type=N'COLUMN',@level2name=N'statusdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Provides status options for "status" variable in table "rd_action"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'rd_action_status', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Provides status options for "status" variable in table "rd_action"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'rd_action_status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'File name of the shipping info that is being saved on \\usctrd01\ASPFILES\Shipping' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shipping', @level2type=N'COLUMN',@level2name=N'data_file'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of shipments made by RD' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Shipping'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Thickness in inch of as extruded product fro where sample taken' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Specimen_log', @level2type=N'COLUMN',@level2name=N'gage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check machined dimensions needed (Yes/No)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Specimen_log', @level2type=N'COLUMN',@level2name=N'date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique specimen ID given sequentially by SQL' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Specimen_log'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'RD Study status: open, closed or deferred' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StudyStatus', @level2type=N'COLUMN',@level2name=N'study_status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Details the status of a speciffic study (open, closed, deferred)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StudyStatus'
GO
