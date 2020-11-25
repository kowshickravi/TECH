CREATE TABLE dbo.PublicBlacklist
(
    "PublicBlacklistId"          INTEGER                                   NOT NULL,
    "CodeId"                     INTEGER                                   NOT NULL,
    "Status"                     CHAR(1)      COLLATE dbo.case_insensitive NOT NULL,
    "RetiredDate"                TIMESTAMP                                 NULL,
    "ActiveList"                 SMALLINT                                  NOT NULL,
    "HomePageURL"                VARCHAR(100) COLLATE dbo.case_insensitive NOT NULL,
    "SpamDNSUserName"            VARCHAR(64)  COLLATE dbo.case_insensitive NULL,
    "SpamDNSLookupURL"           VARCHAR(256) COLLATE dbo.case_insensitive NOT NULL,
    "SpamDNSErrorText"           VARCHAR(512) COLLATE dbo.case_insensitive NOT NULL,
    "DateCreated"                TIMESTAMP                                 NOT NULL,
    "DateAmended"                TIMESTAMP                                 NOT NULL,
    "DateDeleted"                TIMESTAMP                                 NOT NULL,
    "WhoAmended_NT_UserName"     VARCHAR(255) COLLATE dbo.case_insensitive NOT NULL,
    "WhoAmended_HostName"        VARCHAR(255) COLLATE dbo.case_insensitive NOT NULL,
    "AuditId"                    UUID                                      NULL,
    "AuditActionType"            CHAR(2)      COLLATE dbo.case_insensitive NOT NULL,
    "AuditSequenceNo"            INTEGER      GENERATED ALWAYS AS IDENTITY NOT NULL ,
    "LoginName"                  VARCHAR(256) COLLATE dbo.case_insensitive NULL,
    "HostName"                   VARCHAR(256) COLLATE dbo.case_insensitive NULL,
    "ActionTime"                 TIMESTAMP                                 NULL,
    CONSTRAINT "PK_PublicBlacklist" PRIMARY KEY   
    (
        "AuditSequenceNo"
    )  
);

CREATE  INDEX "IX_PublicBlacklist_NC01 ON dbo."PublicBlacklist"
    (
        "AuditId" ASC NULLS FIRST
    );

GRANT  INSERT  ON dbo."PublicBlacklist" TO PUBLIC;

