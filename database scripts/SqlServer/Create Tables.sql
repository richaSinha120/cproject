/****** 
Before running this script, make the following changes

Database name:  Assumed to be "OpenSAMM". If you changed the name, change the USE statement below

Creant User [domain\username]   The domain\username values in the next 4 statements should be changed to 
something appropiate for the environment being used.  The domain\username format is typically used for 
Windows authentication.

******/
USE [OpenSAMM]
GO

CREATE USER [domain\username] FOR LOGIN [domain\username] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [domain\username]
GO
ALTER ROLE [db_datareader] ADD MEMBER [domain\username]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [domain\username]
GO
/****** Object:  Table [dbo].[Assessment]    Script Date: 8/27/2014 3:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Assessment](
	[AssessmentID] [int] IDENTITY(1,1) NOT NULL,
	[TemplateVersion] [int] NOT NULL,
	[OwnerID] [int] NOT NULL,
	[OrganizationName] [varchar](100) NULL,
	[ApplicationName] [varchar](50) NULL,
	[LastUpdated] [datetime2](7) NULL,
	[LastUpdateBy] [int] NULL,
	[CreateDate] [datetime2](7) NULL,
	[CreateBy] [int] NULL,
	[IndustryID] [int] NULL CONSTRAINT [DF_Assessment_IndustryID]  DEFAULT ((1)),
	BusinessUnit varchar(50) NULL,
	Finalized bit NULL,
 CONSTRAINT [PK_Assessment] PRIMARY KEY CLUSTERED 
(
	[AssessmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AssessmentTemplate]    Script Date: 8/27/2014 3:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssessmentTemplate](
	[TemplateID] [int] IDENTITY(1,1) NOT NULL,
	[TemplateVersion] [int] NOT NULL,
	[TemplateDate] [datetime2](7) NULL CONSTRAINT [DF_AssessmentTemplate_TemplateDate]  DEFAULT (getdate()),
	[DefaultTemplate] [bit] NULL,
 CONSTRAINT [PK_AssessmentTemplate] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Categories]    Script Date: 8/27/2014 3:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](50) NOT NULL,
	[CategoryColor] [varchar](50) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CategoryData]    Script Date: 8/27/2014 3:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryData](
	[CatID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[CategoryOrder] [int] NOT NULL,
	[AssessmentID] [int] NOT NULL,
 CONSTRAINT [PK_CategoryData] PRIMARY KEY CLUSTERED 
(
	[CatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GroupData]    Script Date: 8/27/2014 3:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupData](
	[GroID] [int] IDENTITY(1,1) NOT NULL,
	[GroupID] [int] NOT NULL,
	[GroupOrder] [int] NOT NULL,
	[SectionID] [int] NOT NULL,
	[GroupScore] [int] NULL CONSTRAINT [DF_GroupData_GroupScore]  DEFAULT ((0)),
 CONSTRAINT [PK_GroupData] PRIMARY KEY CLUSTERED 
(
	[GroID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Groups]    Script Date: 8/27/2014 3:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Groups](
	[GroupID] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Industry]    Script Date: 8/27/2014 3:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Industry](
	[IndustryID] [int] IDENTITY(1,1) NOT NULL,
	[IndustryName] [varchar](100) NOT NULL,
	[IndustryOrder] [int] NOT NULL,
 CONSTRAINT [PK_Industry] PRIMARY KEY CLUSTERED 
(
	[IndustryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[IndustryTarget]    Script Date: 8/27/2014 3:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IndustryTarget](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[SectionID] [int] NOT NULL,
	[IndustryID] [int] NOT NULL,
	[Score] [varchar](2) NULL,
 CONSTRAINT [PK_IndustrySectionDefault] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[IndustryTargetScoreValues]    Script Date: 8/27/2014 3:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IndustryTargetScoreValues](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Score] [varchar](2) NOT NULL,
 CONSTRAINT [PK_IndustryTargetScoreValues] PRIMARY KEY CLUSTERED 
(
	[Score] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[QuestionData]    Script Date: 8/27/2014 3:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionData](
	[QID] [int] IDENTITY(1,1) NOT NULL,
	[QuestionID] [int] NOT NULL,
	[QuestionOrder] [int] NOT NULL,
	[Answer] [bit] NULL CONSTRAINT [DF_QuestionData_Answer]  DEFAULT ((0)),
	[GroupID] [int] NOT NULL,
 CONSTRAINT [PK_QuestionData] PRIMARY KEY CLUSTERED 
(
	[QID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Questions]    Script Date: 8/27/2014 3:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Questions](
	[QuestionID] [int] IDENTITY(1,1) NOT NULL,
	[QuestionText] [varchar](400) NOT NULL,
 CONSTRAINT [PK_Questions] PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SectionData]    Script Date: 8/27/2014 3:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SectionData](
	[SecID] [int] IDENTITY(1,1) NOT NULL,
	[SectionID] [int] NOT NULL,
	[SectionOrder] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[SectionScore] [int] NULL,
	[SectionScorePartial] [int] NULL,
 CONSTRAINT [PK_SectionData] PRIMARY KEY CLUSTERED 
(
	[SecID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sections]    Script Date: 8/27/2014 3:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sections](
	[SectionID] [int] IDENTITY(1,1) NOT NULL,
	[SectionName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Sections] PRIMARY KEY CLUSTERED 
(
	[SectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TemplateCategories]    Script Date: 8/27/2014 3:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TemplateCategories](
	[CatID] [int] IDENTITY(1,1) NOT NULL,
	[TemplateID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[CategoryOrder] [int] NOT NULL,
 CONSTRAINT [PK_TemplateCategories] PRIMARY KEY CLUSTERED 
(
	[CatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TemplateGroups]    Script Date: 8/27/2014 3:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TemplateGroups](
	[GroID] [int] IDENTITY(1,1) NOT NULL,
	[GroupID] [int] NOT NULL,
	[GroupOrder] [int] NOT NULL,
	[SectionID] [int] NOT NULL,
 CONSTRAINT [PK_TemplateGroups] PRIMARY KEY CLUSTERED 
(
	[GroID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TemplateQuestions]    Script Date: 8/27/2014 3:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TemplateQuestions](
	[QueID] [int] IDENTITY(1,1) NOT NULL,
	[QuestionID] [int] NOT NULL,
	[QuestionOrder] [int] NOT NULL,
	[GroupID] [int] NOT NULL,
 CONSTRAINT [PK_TemplateQuestions] PRIMARY KEY CLUSTERED 
(
	[QueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TemplateSections]    Script Date: 8/27/2014 3:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TemplateSections](
	[SecID] [int] IDENTITY(1,1) NOT NULL,
	[SectionID] [int] NOT NULL,
	[SectionOrder] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_TemplateSections] PRIMARY KEY CLUSTERED 
(
	[SecID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserData]    Script Date: 8/27/2014 3:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserData](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserNTID] [varchar](50) NULL,
	[UserDomain] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[FirstName] [varchar](50) NULL,
	[ManagerID] [varchar](50) NULL,
	[MgrLastName] [varchar](50) NULL,
	[MgrFirstName] [varchar](50) NULL,
	[ManagerEID] [varchar](50) NULL,
	[OrgName] [varchar](50) NULL,
	[LastLoginDate] [datetime2](7) NULL,
	[Administrator] [bit] NULL,
	[Manager] [bit] NULL,
	BusinessUnit varchar(50) NULL,
	BUOwner bit null,

 CONSTRAINT [PK_UserData_1] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Assessment]  WITH CHECK ADD  CONSTRAINT [FK_Assessment_Industry] FOREIGN KEY([IndustryID])
REFERENCES [dbo].[Industry] ([IndustryID])
GO
ALTER TABLE [dbo].[Assessment] CHECK CONSTRAINT [FK_Assessment_Industry]
GO
ALTER TABLE [dbo].[Assessment]  WITH CHECK ADD  CONSTRAINT [FK_Assessment_UserData] FOREIGN KEY([LastUpdateBy])
REFERENCES [dbo].[UserData] ([UserID])
GO
ALTER TABLE [dbo].[Assessment] CHECK CONSTRAINT [FK_Assessment_UserData]
GO
ALTER TABLE [dbo].[Assessment]  WITH CHECK ADD  CONSTRAINT [FK_Assessment_UserData1] FOREIGN KEY([OwnerID])
REFERENCES [dbo].[UserData] ([UserID])
GO
ALTER TABLE [dbo].[Assessment] CHECK CONSTRAINT [FK_Assessment_UserData1]
GO
ALTER TABLE [dbo].[Assessment]  WITH CHECK ADD  CONSTRAINT [FK_Assessment_UserData2] FOREIGN KEY([CreateBy])
REFERENCES [dbo].[UserData] ([UserID])
GO
ALTER TABLE [dbo].[Assessment] CHECK CONSTRAINT [FK_Assessment_UserData2]
GO
ALTER TABLE [dbo].[CategoryData]  WITH CHECK ADD  CONSTRAINT [FK_CategoryData_Assessment] FOREIGN KEY([AssessmentID])
REFERENCES [dbo].[Assessment] ([AssessmentID])
GO
ALTER TABLE [dbo].[CategoryData] CHECK CONSTRAINT [FK_CategoryData_Assessment]
GO
ALTER TABLE [dbo].[CategoryData]  WITH CHECK ADD  CONSTRAINT [FK_CategoryData_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[CategoryData] CHECK CONSTRAINT [FK_CategoryData_Categories]
GO
ALTER TABLE [dbo].[GroupData]  WITH CHECK ADD  CONSTRAINT [FK_GroupData_Groups] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Groups] ([GroupID])
GO
ALTER TABLE [dbo].[GroupData] CHECK CONSTRAINT [FK_GroupData_Groups]
GO
ALTER TABLE [dbo].[GroupData]  WITH CHECK ADD  CONSTRAINT [FK_GroupData_SectionData] FOREIGN KEY([SectionID])
REFERENCES [dbo].[SectionData] ([SecID])
GO
ALTER TABLE [dbo].[GroupData] CHECK CONSTRAINT [FK_GroupData_SectionData]
GO
ALTER TABLE [dbo].[IndustryTarget]  WITH CHECK ADD  CONSTRAINT [FK_IndustrySectionDefault_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[IndustryTarget] CHECK CONSTRAINT [FK_IndustrySectionDefault_Categories]
GO
ALTER TABLE [dbo].[IndustryTarget]  WITH CHECK ADD  CONSTRAINT [FK_IndustrySectionDefault_Industry] FOREIGN KEY([IndustryID])
REFERENCES [dbo].[Industry] ([IndustryID])
GO
ALTER TABLE [dbo].[IndustryTarget] CHECK CONSTRAINT [FK_IndustrySectionDefault_Industry]
GO
ALTER TABLE [dbo].[IndustryTarget]  WITH CHECK ADD  CONSTRAINT [FK_IndustrySectionDefault_Sections] FOREIGN KEY([SectionID])
REFERENCES [dbo].[Sections] ([SectionID])
GO
ALTER TABLE [dbo].[IndustryTarget] CHECK CONSTRAINT [FK_IndustrySectionDefault_Sections]
GO
ALTER TABLE [dbo].[IndustryTarget]  WITH CHECK ADD  CONSTRAINT [FK_IndustryTarget_IndustryTargetScoreValues1] FOREIGN KEY([Score])
REFERENCES [dbo].[IndustryTargetScoreValues] ([Score])
GO
ALTER TABLE [dbo].[IndustryTarget] CHECK CONSTRAINT [FK_IndustryTarget_IndustryTargetScoreValues1]
GO
ALTER TABLE [dbo].[QuestionData]  WITH CHECK ADD  CONSTRAINT [FK_QuestionData_GroupData] FOREIGN KEY([GroupID])
REFERENCES [dbo].[GroupData] ([GroID])
GO
ALTER TABLE [dbo].[QuestionData] CHECK CONSTRAINT [FK_QuestionData_GroupData]
GO
ALTER TABLE [dbo].[QuestionData]  WITH CHECK ADD  CONSTRAINT [FK_QuestionData_Questions] FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Questions] ([QuestionID])
GO
ALTER TABLE [dbo].[QuestionData] CHECK CONSTRAINT [FK_QuestionData_Questions]
GO
ALTER TABLE [dbo].[SectionData]  WITH CHECK ADD  CONSTRAINT [FK_SectionData_CategoryData] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[CategoryData] ([CatID])
GO
ALTER TABLE [dbo].[SectionData] CHECK CONSTRAINT [FK_SectionData_CategoryData]
GO
ALTER TABLE [dbo].[SectionData]  WITH CHECK ADD  CONSTRAINT [FK_SectionData_Sections] FOREIGN KEY([SectionID])
REFERENCES [dbo].[Sections] ([SectionID])
GO
ALTER TABLE [dbo].[SectionData] CHECK CONSTRAINT [FK_SectionData_Sections]
GO
ALTER TABLE [dbo].[TemplateCategories]  WITH CHECK ADD  CONSTRAINT [FK_TemplateCategories_AssessmentTemplate] FOREIGN KEY([TemplateID])
REFERENCES [dbo].[AssessmentTemplate] ([TemplateID])
GO
ALTER TABLE [dbo].[TemplateCategories] CHECK CONSTRAINT [FK_TemplateCategories_AssessmentTemplate]
GO
ALTER TABLE [dbo].[TemplateCategories]  WITH CHECK ADD  CONSTRAINT [FK_TemplateCategories_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[TemplateCategories] CHECK CONSTRAINT [FK_TemplateCategories_Categories]
GO
ALTER TABLE [dbo].[TemplateGroups]  WITH CHECK ADD  CONSTRAINT [FK_TemplateGroups_Groups] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Groups] ([GroupID])
GO
ALTER TABLE [dbo].[TemplateGroups] CHECK CONSTRAINT [FK_TemplateGroups_Groups]
GO
ALTER TABLE [dbo].[TemplateGroups]  WITH CHECK ADD  CONSTRAINT [FK_TemplateGroups_TemplateSections] FOREIGN KEY([SectionID])
REFERENCES [dbo].[TemplateSections] ([SecID])
GO
ALTER TABLE [dbo].[TemplateGroups] CHECK CONSTRAINT [FK_TemplateGroups_TemplateSections]
GO
ALTER TABLE [dbo].[TemplateQuestions]  WITH CHECK ADD  CONSTRAINT [FK_TemplateQuestions_Questions] FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Questions] ([QuestionID])
GO
ALTER TABLE [dbo].[TemplateQuestions] CHECK CONSTRAINT [FK_TemplateQuestions_Questions]
GO
ALTER TABLE [dbo].[TemplateQuestions]  WITH CHECK ADD  CONSTRAINT [FK_TemplateQuestions_TemplateGroups] FOREIGN KEY([GroupID])
REFERENCES [dbo].[TemplateGroups] ([GroID])
GO
ALTER TABLE [dbo].[TemplateQuestions] CHECK CONSTRAINT [FK_TemplateQuestions_TemplateGroups]
GO
ALTER TABLE [dbo].[TemplateSections]  WITH CHECK ADD  CONSTRAINT [FK_TemplateSections_Sections] FOREIGN KEY([SectionID])
REFERENCES [dbo].[Sections] ([SectionID])
GO
ALTER TABLE [dbo].[TemplateSections] CHECK CONSTRAINT [FK_TemplateSections_Sections]
GO
ALTER TABLE [dbo].[TemplateSections]  WITH CHECK ADD  CONSTRAINT [FK_TemplateSections_TemplateCategories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[TemplateCategories] ([CatID])
GO
ALTER TABLE [dbo].[TemplateSections] CHECK CONSTRAINT [FK_TemplateSections_TemplateCategories]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID is primary key for this table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TemplateGroups', @level2type=N'COLUMN',@level2name=N'GroID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key into Groups table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TemplateGroups', @level2type=N'COLUMN',@level2name=N'GroupID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Integer sort order for this group within the template' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TemplateGroups', @level2type=N'COLUMN',@level2name=N'GroupOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key into Section table to where this group belongs' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TemplateGroups', @level2type=N'COLUMN',@level2name=N'SectionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID used as primary key for table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TemplateQuestions', @level2type=N'COLUMN',@level2name=N'QueID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key into Questions table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TemplateQuestions', @level2type=N'COLUMN',@level2name=N'QuestionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Specifies sort order for question within group' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TemplateQuestions', @level2type=N'COLUMN',@level2name=N'QuestionOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key to TemplateGroup which this question belongs to' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TemplateQuestions', @level2type=N'COLUMN',@level2name=N'GroupID'
GO
