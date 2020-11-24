CREATE TABLE IF NOT EXISTS dbo."PwdPolicyBeta"
(
    "OwnerId"        INTEGER                                   NOT NULL,
    "OwnerTypeId"        INTEGER                                   NOT NULL,
    "AuditId"            UUID                                      NULL,
    "AuditActionType"    CHAR(2)      COLLATE dbo.case_insensitive NOT NULL,                            
    "AuditSequenceNo"    INTEGER      GENERATED ALWAYS AS IDENTITY NOT NULL,
    "LoginName"          VARCHAR(256) COLLATE dbo.case_insensitive NULL,
    "HostName"           VARCHAR(256) COLLATE dbo.case_insensitive NULL,
    "ActionTime"         TIMESTAMP                                 NULL,
     CONSTRAINT "PK_PwdPolicyBeta"    PRIMARY KEY
     (
	    "AuditSequenceNo"
     )
);

CREATE UNIQUE INDEX IF  NOT EXISTS "INDEX IX_PwdPolicyBeta_NC01"
ON dbo."PwdPolicyBeta"
    (
     "AuditId" ASC NULLS FIRST
    );
GRANT INSERT  ON dbo."PwdPolicyBeta" TO PUBLIC; 
