namespace Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Initial : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.UserProfile",
                c => new
                    {
                        UserId = c.Int(nullable: false, identity: true),
                        UserName = c.String(),
                    })
                .PrimaryKey(t => t.UserId);
            
            CreateTable(
                "dbo.Company",
                c => new
                    {
                        CompanyId = c.Int(nullable: false, identity: true),
                        CompanyApprovedFlag = c.Boolean(nullable: false),
                        CompanyName = c.String(maxLength: 50),
                        CharityNumber = c.String(maxLength: 10),
                        OrganisationTypeId = c.Int(nullable: false),
                        CompanyContactName = c.String(maxLength: 50),
                        CompanyContactPhone = c.String(maxLength: 50),
                        CompanyContactEmail = c.String(maxLength: 100),
                        CompanyDetails = c.String(maxLength: 1000),
                        CompanyAddress = c.String(maxLength: 200),
                        CompanyPostcode = c.String(maxLength: 8),
                        OptOutOfReminderEmails = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.CompanyId)
                .ForeignKey("dbo.OrganisationType", t => t.OrganisationTypeId, cascadeDelete: true)
                .Index(t => t.OrganisationTypeId);
            
            CreateTable(
                "dbo.OrganisationType",
                c => new
                    {
                        OrganisationTypeId = c.Int(nullable: false, identity: true),
                        OrganisationTypeName = c.String(maxLength: 50),
                    })
                .PrimaryKey(t => t.OrganisationTypeId);
            
            CreateTable(
                "dbo.CompanyUserProfileMap",
                c => new
                    {
                        UserId = c.Int(nullable: false),
                        CompanyUserProfileMapId = c.Int(nullable: false, identity: true),
                        CompanyId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.CompanyUserProfileMapId)
                .ForeignKey("dbo.Company", t => t.CompanyId, cascadeDelete: true)
                .ForeignKey("dbo.UserProfile", t => t.UserId, cascadeDelete: true)
                .Index(t => t.CompanyId)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.Opportunity",
                c => new
                    {
                        CompanyId = c.Int(nullable: false),
                        OpportunityId = c.Int(nullable: false, identity: true),
                        OpportunityTitle = c.String(maxLength: 200),
                        OpportunityDescription = c.String(nullable: false, maxLength: 1000),
                        OpportunityAdditionalInformation = c.String(maxLength: 1000),
                        OpportunityLocationName = c.String(),
                        OpportunityPostcode = c.String(),
                        MinNumberofVolunteers = c.Int(nullable: false),
                        MaxNumberofVolunteers = c.Int(nullable: false),
                        OpportunityDate = c.String(),
                        OpportunityCreatedDate = c.DateTime(nullable: false),
                        OpportunityStatusId = c.Int(nullable: false),
                        RiskAssessmentCompleteFlag = c.Boolean(nullable: false),
                        RiskAssessmentDocLink = c.Int(nullable: false),
                        SEARSNumber = c.String(),
                        ContactMadeFlag = c.Boolean(nullable: false),
                        Notes = c.String(storeType: "ntext"),
                        RecurringEventFlag = c.Boolean(nullable: false),
                        NetPromoterScore = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.OpportunityId)
                .ForeignKey("dbo.OpportunityStatus", t => t.OpportunityStatusId, cascadeDelete: true)
                .ForeignKey("dbo.Company", t => t.CompanyId, cascadeDelete: true)
                .Index(t => t.OpportunityStatusId)
                .Index(t => t.CompanyId);
            
            CreateTable(
                "dbo.OpportunityStatus",
                c => new
                    {
                        OpportunityStatusId = c.Int(nullable: false, identity: true),
                        OpportunityStatusDescription = c.String(maxLength: 200),
                    })
                .PrimaryKey(t => t.OpportunityStatusId);
            
            CreateTable(
                "dbo.OpportunityEmployeeMap",
                c => new
                    {
                        OpportunityId = c.Int(nullable: false),
                        OpportunityEmployeeMapId = c.Int(nullable: false, identity: true),
                        EmployeeId = c.Int(nullable: false),
                        EmployeeRoleId = c.Int(nullable: false),
                        AuthorisedFlag = c.Boolean(nullable: false),
                        NetPromoterScore = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.OpportunityEmployeeMapId)
                .ForeignKey("dbo.Opportunity", t => t.OpportunityId, cascadeDelete: true)
                .ForeignKey("dbo.Employee", t => t.EmployeeId, cascadeDelete: true)
                .ForeignKey("dbo.EmployeeRole", t => t.EmployeeRoleId, cascadeDelete: true)
                .Index(t => t.OpportunityId)
                .Index(t => t.EmployeeId)
                .Index(t => t.EmployeeRoleId);
            
            CreateTable(
                "dbo.Employee",
                c => new
                    {
                        EmployeeId = c.Int(nullable: false, identity: true),
                        NTLogin = c.String(),
                        EmployeeFirstName = c.String(),
                        EmployeeLastName = c.String(),
                        EmployeeContactNumber = c.String(),
                        EmployeeEmail = c.String(),
                        EmployeePayrollNumber = c.String(),
                        ManagerEmail = c.String(),
                        ManagerFirstName = c.String(),
                        ManagerLastName = c.String(),
                        SendNewProjectEmailFlag = c.Boolean(nullable: false),
                        NewProjectDistance = c.Int(nullable: false),
                        CountryId = c.Int(nullable: false),
                        LocationId = c.Int(nullable: false),
                        DirectorateId = c.Int(nullable: false),
                        DepartmentId = c.Int(nullable: false),
                        CostCentre = c.String(),
                    })
                .PrimaryKey(t => t.EmployeeId)
                .ForeignKey("dbo.Country", t => t.CountryId, cascadeDelete: false)
                .ForeignKey("dbo.Location", t => t.LocationId, cascadeDelete: false)
                .ForeignKey("dbo.Directorate", t => t.DirectorateId, cascadeDelete: false)
                .ForeignKey("dbo.Department", t => t.DepartmentId, cascadeDelete: false)
                .Index(t => t.CountryId)
                .Index(t => t.LocationId)
                .Index(t => t.DirectorateId)
                .Index(t => t.DepartmentId);
            
            CreateTable(
                "dbo.Country",
                c => new
                    {
                        CountryId = c.Int(nullable: false, identity: true),
                        CountryName = c.String(maxLength: 50),
                    })
                .PrimaryKey(t => t.CountryId);
            
            CreateTable(
                "dbo.Location",
                c => new
                    {
                        LocationId = c.Int(nullable: false, identity: true),
                        LocationName = c.String(maxLength: 50),
                        Postcode = c.String(maxLength: 8),
                        CountryId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.LocationId)
                .ForeignKey("dbo.Country", t => t.CountryId, cascadeDelete: true)
                .Index(t => t.CountryId);
            
            CreateTable(
                "dbo.Directorate",
                c => new
                    {
                        DirectorateId = c.Int(nullable: false, identity: true),
                        DirectorateName = c.String(maxLength: 50),
                        Director = c.String(maxLength: 50),
                    })
                .PrimaryKey(t => t.DirectorateId);
            
            CreateTable(
                "dbo.Department",
                c => new
                    {
                        DepartmentId = c.Int(nullable: false, identity: true),
                        DepartmentName = c.String(maxLength: 50),
                        DirectorateId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.DepartmentId)
                .ForeignKey("dbo.Directorate", t => t.DirectorateId, cascadeDelete: true)
                .Index(t => t.DirectorateId);
            
            CreateTable(
                "dbo.EmployeeRole",
                c => new
                    {
                        OpportunityRoleId = c.Int(nullable: false, identity: true),
                        OpportunityRoleDescription = c.String(maxLength: 200),
                    })
                .PrimaryKey(t => t.OpportunityRoleId);
            
        }
        
        public override void Down()
        {
            DropIndex("dbo.Department", new[] { "DirectorateId" });
            DropIndex("dbo.Location", new[] { "CountryId" });
            DropIndex("dbo.Employee", new[] { "DepartmentId" });
            DropIndex("dbo.Employee", new[] { "DirectorateId" });
            DropIndex("dbo.Employee", new[] { "LocationId" });
            DropIndex("dbo.Employee", new[] { "CountryId" });
            DropIndex("dbo.OpportunityEmployeeMap", new[] { "EmployeeRoleId" });
            DropIndex("dbo.OpportunityEmployeeMap", new[] { "EmployeeId" });
            DropIndex("dbo.OpportunityEmployeeMap", new[] { "OpportunityId" });
            DropIndex("dbo.Opportunity", new[] { "CompanyId" });
            DropIndex("dbo.Opportunity", new[] { "OpportunityStatusId" });
            DropIndex("dbo.CompanyUserProfileMap", new[] { "UserId" });
            DropIndex("dbo.CompanyUserProfileMap", new[] { "CompanyId" });
            DropIndex("dbo.Company", new[] { "OrganisationTypeId" });
            DropForeignKey("dbo.Department", "DirectorateId", "dbo.Directorate");
            DropForeignKey("dbo.Location", "CountryId", "dbo.Country");
            DropForeignKey("dbo.Employee", "DepartmentId", "dbo.Department");
            DropForeignKey("dbo.Employee", "DirectorateId", "dbo.Directorate");
            DropForeignKey("dbo.Employee", "LocationId", "dbo.Location");
            DropForeignKey("dbo.Employee", "CountryId", "dbo.Country");
            DropForeignKey("dbo.OpportunityEmployeeMap", "EmployeeRoleId", "dbo.EmployeeRole");
            DropForeignKey("dbo.OpportunityEmployeeMap", "EmployeeId", "dbo.Employee");
            DropForeignKey("dbo.OpportunityEmployeeMap", "OpportunityId", "dbo.Opportunity");
            DropForeignKey("dbo.Opportunity", "CompanyId", "dbo.Company");
            DropForeignKey("dbo.Opportunity", "OpportunityStatusId", "dbo.OpportunityStatus");
            DropForeignKey("dbo.CompanyUserProfileMap", "UserId", "dbo.UserProfile");
            DropForeignKey("dbo.CompanyUserProfileMap", "CompanyId", "dbo.Company");
            DropForeignKey("dbo.Company", "OrganisationTypeId", "dbo.OrganisationType");
            DropTable("dbo.EmployeeRole");
            DropTable("dbo.Department");
            DropTable("dbo.Directorate");
            DropTable("dbo.Location");
            DropTable("dbo.Country");
            DropTable("dbo.Employee");
            DropTable("dbo.OpportunityEmployeeMap");
            DropTable("dbo.OpportunityStatus");
            DropTable("dbo.Opportunity");
            DropTable("dbo.CompanyUserProfileMap");
            DropTable("dbo.OrganisationType");
            DropTable("dbo.Company");
            DropTable("dbo.UserProfile");
        }
    }
}
