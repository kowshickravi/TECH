CREATE TABLE IF NOT EXISTS dbo."ReportType"
(	
    "ReportTypeId"	 INTEGER				   NOT NULL,
    "ReportGroupId"      INTEGER			           NOT NULL,
    "ReportTypeName"	 VARCHAR(50)  COLLATE dbo.case_insensitive NOT NULL,
    "UIVisible"		 CHAR(1)      COLLATE dbo.case_insensitive NOT NULL,
    "UIOrder"		 INTEGER				   NOT NULL,
    "AuditId"		 UUID	                                   NULL,
    "AuditActionType"    CHAR(2)      COLLATE dbo.case_insensitive NOT NULL,
    "AuditSequenceNo"    INTEGER      GENERATED ALWAYS AS IDENTITY NOT NULL ,
    "LoginName"		 VARCHAR(256) COLLATE dbo.case_insensitive NULL,
    "HostName"		 VARCHAR(256) COLLATE dbo.case_insensitive NULL,
    "ActionTime"	 TIMESTAMP			           NULL,
    CONSTRAINT PK_ReportType PRIMARY KEY  
    (
        "AuditSequenceNo"
    )  
);

CREATE UNIQUE INDEX IF NOT EXISTS "IX_ReportType_NC01" 
ON dbo."ReportType"
   (
	    "AuditId" ASC NULLS FIRST
   );

GRANT  INSERT  ON dbo."ReportType"  TO PUBLIC;
