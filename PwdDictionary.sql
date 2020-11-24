CREATE TABLE IF NOT EXISTS dbo."PwdDictionary"
(
    "WordId"                    INTEGER                                   NOT NULL,
    "DictionaryWord"            VARCHAR(400) COLLATE dbo.case_insensitive NULL,
    "DictionarySource"          VARCHAR(255) COLLATE dbo.case_insensitive NOT NULL,
    "DateCreated"               TIMESTAMP                                 NOT NULL,
    "DateAmended"               TIMESTAMP                                 NOT NULL,
    "WhoAmended_Nt_Username"    VARCHAR(255) COLLATE dbo.case_insensitive NOT NULL,
    "WhoAmended_Hostname"       VARCHAR(255) COLLATE dbo.case_insensitive NOT NULL,
    "AuditId"                   UUID                                      NULL,
    "AuditActionType"           CHAR(2)      COLLATE dbo.case_insensitive NOT NULL,
    "AuditSequenceNo"           INTEGER      GENERATED ALWAYS AS IDENTITY NOT NULL,
    "LoginName"                 VARCHAR(255) COLLATE dbo.case_insensitive NULL,
    "HostName"                  VARCHAR(255) COLLATE dbo.case_insensitive NULL,
    "ActionTime"                TIMESTAMP                                 NULL,
    CONSTRAINT "PK_PwdDictionary " PRIMARY KEY
    (
	 "AuditSequenceNo"
    )
);	
CREATE UNIQUE INDEX IF NOT EXISTS "IX_PwdDictionary_NC01" 
ON dbo."PwdDictionary"
(
       "AuditId" ASC NULLS FIRST
)
	
	
	
	

