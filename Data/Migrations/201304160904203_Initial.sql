/*Applying code-based migration: 201304160904203_Initial*/


CREATE TABLE [dbo].[UserProfile] (
    [UserId] [int] NOT NULL IDENTITY,
    [UserName] [nvarchar](max),
    CONSTRAINT [PK_dbo.UserProfile] PRIMARY KEY ([UserId])
)
CREATE TABLE [dbo].[Company] (
    [CompanyId] [int] NOT NULL IDENTITY,
    [CompanyApprovedFlag] [bit] NOT NULL,
    [CompanyName] [nvarchar](50),
    [CharityNumber] [nvarchar](10),
    [OrganisationTypeId] [int] NOT NULL,
    [CompanyContactName] [nvarchar](50),
    [CompanyContactPhone] [nvarchar](50),
    [CompanyContactEmail] [nvarchar](100),
    [CompanyDetails] [nvarchar](1000),
    [CompanyAddress] [nvarchar](200),
    [CompanyPostcode] [nvarchar](8),
    [OptOutOfReminderEmails] [bit] NOT NULL,
    CONSTRAINT [PK_dbo.Company] PRIMARY KEY ([CompanyId])
)
CREATE INDEX [IX_OrganisationTypeId] ON [dbo].[Company]([OrganisationTypeId])
CREATE TABLE [dbo].[OrganisationType] (
    [OrganisationTypeId] [int] NOT NULL IDENTITY,
    [OrganisationTypeName] [nvarchar](50),
    CONSTRAINT [PK_dbo.OrganisationType] PRIMARY KEY ([OrganisationTypeId])
)
CREATE TABLE [dbo].[CompanyUserProfileMap] (
    [UserId] [int] NOT NULL,
    [CompanyUserProfileMapId] [int] NOT NULL IDENTITY,
    [CompanyId] [int] NOT NULL,
    CONSTRAINT [PK_dbo.CompanyUserProfileMap] PRIMARY KEY ([CompanyUserProfileMapId])
)
CREATE INDEX [IX_CompanyId] ON [dbo].[CompanyUserProfileMap]([CompanyId])
CREATE INDEX [IX_UserId] ON [dbo].[CompanyUserProfileMap]([UserId])
CREATE TABLE [dbo].[Opportunity] (
    [CompanyId] [int] NOT NULL,
    [OpportunityId] [int] NOT NULL IDENTITY,
    [OpportunityTitle] [nvarchar](200),
    [OpportunityDescription] [nvarchar](1000) NOT NULL,
    [OpportunityAdditionalInformation] [nvarchar](1000),
    [OpportunityLocationName] [nvarchar](max),
    [OpportunityPostcode] [nvarchar](max),
    [MinNumberofVolunteers] [int] NOT NULL,
    [MaxNumberofVolunteers] [int] NOT NULL,
    [OpportunityDate] [nvarchar](max),
    [OpportunityCreatedDate] [datetime] NOT NULL,
    [OpportunityStatusId] [int] NOT NULL,
    [RiskAssessmentCompleteFlag] [bit] NOT NULL,
    [RiskAssessmentDocLink] [int] NOT NULL,
    [SEARSNumber] [nvarchar](max),
    [ContactMadeFlag] [bit] NOT NULL,
    [Notes] [ntext],
    [RecurringEventFlag] [bit] NOT NULL,
    [NetPromoterScore] [int] NOT NULL,
    CONSTRAINT [PK_dbo.Opportunity] PRIMARY KEY ([OpportunityId])
)
CREATE INDEX [IX_OpportunityStatusId] ON [dbo].[Opportunity]([OpportunityStatusId])
CREATE INDEX [IX_CompanyId] ON [dbo].[Opportunity]([CompanyId])
CREATE TABLE [dbo].[OpportunityStatus] (
    [OpportunityStatusId] [int] NOT NULL IDENTITY,
    [OpportunityStatusDescription] [nvarchar](200),
    CONSTRAINT [PK_dbo.OpportunityStatus] PRIMARY KEY ([OpportunityStatusId])
)
CREATE TABLE [dbo].[OpportunityEmployeeMap] (
    [OpportunityId] [int] NOT NULL,
    [OpportunityEmployeeMapId] [int] NOT NULL IDENTITY,
    [EmployeeId] [int] NOT NULL,
    [EmployeeRoleId] [int] NOT NULL,
    [AuthorisedFlag] [bit] NOT NULL,
    [NetPromoterScore] [int] NOT NULL,
    CONSTRAINT [PK_dbo.OpportunityEmployeeMap] PRIMARY KEY ([OpportunityEmployeeMapId])
)
CREATE INDEX [IX_OpportunityId] ON [dbo].[OpportunityEmployeeMap]([OpportunityId])
CREATE INDEX [IX_EmployeeId] ON [dbo].[OpportunityEmployeeMap]([EmployeeId])
CREATE INDEX [IX_EmployeeRoleId] ON [dbo].[OpportunityEmployeeMap]([EmployeeRoleId])
CREATE TABLE [dbo].[Employee] (
    [EmployeeId] [int] NOT NULL IDENTITY,
    [NTLogin] [nvarchar](max),
    [EmployeeFirstName] [nvarchar](max),
    [EmployeeLastName] [nvarchar](max),
    [EmployeeContactNumber] [nvarchar](max),
    [EmployeeEmail] [nvarchar](max),
    [EmployeePayrollNumber] [nvarchar](max),
    [ManagerEmail] [nvarchar](max),
    [ManagerFirstName] [nvarchar](max),
    [ManagerLastName] [nvarchar](max),
    [SendNewProjectEmailFlag] [bit] NOT NULL,
    [NewProjectDistance] [int] NOT NULL,
    [CountryId] [int] NOT NULL,
    [LocationId] [int] NOT NULL,
    [DirectorateId] [int] NOT NULL,
    [DepartmentId] [int] NOT NULL,
    [CostCentre] [nvarchar](max),
    CONSTRAINT [PK_dbo.Employee] PRIMARY KEY ([EmployeeId])
)
CREATE INDEX [IX_CountryId] ON [dbo].[Employee]([CountryId])
CREATE INDEX [IX_LocationId] ON [dbo].[Employee]([LocationId])
CREATE INDEX [IX_DirectorateId] ON [dbo].[Employee]([DirectorateId])
CREATE INDEX [IX_DepartmentId] ON [dbo].[Employee]([DepartmentId])
CREATE TABLE [dbo].[Country] (
    [CountryId] [int] NOT NULL IDENTITY,
    [CountryName] [nvarchar](50),
    CONSTRAINT [PK_dbo.Country] PRIMARY KEY ([CountryId])
)
CREATE TABLE [dbo].[Location] (
    [LocationId] [int] NOT NULL IDENTITY,
    [LocationName] [nvarchar](50),
    [Postcode] [nvarchar](8),
    [CountryId] [int] NOT NULL,
    CONSTRAINT [PK_dbo.Location] PRIMARY KEY ([LocationId])
)
CREATE INDEX [IX_CountryId] ON [dbo].[Location]([CountryId])
CREATE TABLE [dbo].[Directorate] (
    [DirectorateId] [int] NOT NULL IDENTITY,
    [DirectorateName] [nvarchar](50),
    [Director] [nvarchar](50),
    CONSTRAINT [PK_dbo.Directorate] PRIMARY KEY ([DirectorateId])
)
CREATE TABLE [dbo].[Department] (
    [DepartmentId] [int] NOT NULL IDENTITY,
    [DepartmentName] [nvarchar](50),
    [DirectorateId] [int] NOT NULL,
    CONSTRAINT [PK_dbo.Department] PRIMARY KEY ([DepartmentId])
)
CREATE INDEX [IX_DirectorateId] ON [dbo].[Department]([DirectorateId])
CREATE TABLE [dbo].[EmployeeRole] (
    [OpportunityRoleId] [int] NOT NULL IDENTITY,
    [OpportunityRoleDescription] [nvarchar](200),
    CONSTRAINT [PK_dbo.EmployeeRole] PRIMARY KEY ([OpportunityRoleId])
)
ALTER TABLE [dbo].[Company] ADD CONSTRAINT [FK_dbo.Company_dbo.OrganisationType_OrganisationTypeId] FOREIGN KEY ([OrganisationTypeId]) REFERENCES [dbo].[OrganisationType] ([OrganisationTypeId]) ON DELETE CASCADE
ALTER TABLE [dbo].[CompanyUserProfileMap] ADD CONSTRAINT [FK_dbo.CompanyUserProfileMap_dbo.Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Company] ([CompanyId]) ON DELETE CASCADE
ALTER TABLE [dbo].[CompanyUserProfileMap] ADD CONSTRAINT [FK_dbo.CompanyUserProfileMap_dbo.UserProfile_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[UserProfile] ([UserId]) ON DELETE CASCADE
ALTER TABLE [dbo].[Opportunity] ADD CONSTRAINT [FK_dbo.Opportunity_dbo.OpportunityStatus_OpportunityStatusId] FOREIGN KEY ([OpportunityStatusId]) REFERENCES [dbo].[OpportunityStatus] ([OpportunityStatusId]) ON DELETE CASCADE
ALTER TABLE [dbo].[Opportunity] ADD CONSTRAINT [FK_dbo.Opportunity_dbo.Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Company] ([CompanyId]) ON DELETE CASCADE
ALTER TABLE [dbo].[OpportunityEmployeeMap] ADD CONSTRAINT [FK_dbo.OpportunityEmployeeMap_dbo.Opportunity_OpportunityId] FOREIGN KEY ([OpportunityId]) REFERENCES [dbo].[Opportunity] ([OpportunityId]) ON DELETE CASCADE
ALTER TABLE [dbo].[OpportunityEmployeeMap] ADD CONSTRAINT [FK_dbo.OpportunityEmployeeMap_dbo.Employee_EmployeeId] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([EmployeeId]) ON DELETE CASCADE
ALTER TABLE [dbo].[OpportunityEmployeeMap] ADD CONSTRAINT [FK_dbo.OpportunityEmployeeMap_dbo.EmployeeRole_EmployeeRoleId] FOREIGN KEY ([EmployeeRoleId]) REFERENCES [dbo].[EmployeeRole] ([OpportunityRoleId]) ON DELETE CASCADE
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [FK_dbo.Employee_dbo.Country_CountryId] FOREIGN KEY ([CountryId]) REFERENCES [dbo].[Country] ([CountryId])
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [FK_dbo.Employee_dbo.Location_LocationId] FOREIGN KEY ([LocationId]) REFERENCES [dbo].[Location] ([LocationId])
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [FK_dbo.Employee_dbo.Directorate_DirectorateId] FOREIGN KEY ([DirectorateId]) REFERENCES [dbo].[Directorate] ([DirectorateId])
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [FK_dbo.Employee_dbo.Department_DepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [dbo].[Department] ([DepartmentId])
ALTER TABLE [dbo].[Location] ADD CONSTRAINT [FK_dbo.Location_dbo.Country_CountryId] FOREIGN KEY ([CountryId]) REFERENCES [dbo].[Country] ([CountryId]) ON DELETE CASCADE
ALTER TABLE [dbo].[Department] ADD CONSTRAINT [FK_dbo.Department_dbo.Directorate_DirectorateId] FOREIGN KEY ([DirectorateId]) REFERENCES [dbo].[Directorate] ([DirectorateId]) ON DELETE CASCADE
CREATE TABLE [dbo].[__MigrationHistory] (
    [MigrationId] [nvarchar](255) NOT NULL,
    [Model] [varbinary](max) NOT NULL,
    [ProductVersion] [nvarchar](32) NOT NULL,
    CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId])
)
BEGIN TRY
    EXEC sp_MS_marksystemobject 'dbo.__MigrationHistory'
END TRY
BEGIN CATCH
END CATCH
