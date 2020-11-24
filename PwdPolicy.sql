CREATE TABLE IF NOT EXISTS dbo."PwdPolicy"
(
    "PwdPolicyId"                     UUID                                      NOT NULL,
    "ChangePwdOnFirstLogin"           CHAR(1)     COLLATE dbo.case_insensitive  NOT NULL,
    "MinPwdLength"                    SMALLINT                                  NOT NULL,
    "AllowAlpha"                      CHAR(1)     COLLATE dbo.case_insensitive  NOT NULL,
    "AllowNumeric"                    CHAR(1)     COLLATE dbo.case_insensitive  NOT NULL,
    "AllowSymbol"                     CHAR(1)     COLLATE dbo.case_insensitive  NOT NULL,
    "MaxRepeatedChars"                SMALLINT                                  NOT NULL,
    "MaximumOrderedChars"             SMALLINT                                  NOT NULL,
    "AllowDictionaryWords"            CHAR(1)     COLLATE dbo.case_insensitive  NOT NULL,
    "AllowPartialEmail"               CHAR(1)     COLLATE dbo.case_insensitive  NOT NULL,
    "ResetsBeforeReUse"               SMALLINT                                  NOT NULL,
    "MaxChangesInPeriod"              SMALLINT                                  NOT NULL,
    "ChangeCountPeriodHours"          SMALLINT                                  NOT NULL,
    "AdminLockoutCountPeriodHours"    SMALLINT                                  NOT NULL,
    "UserLockoutCountPeriodHours"     SMALLINT                                  NOT NULL,
    "PwdExpiryTime"                   SMALLINT                                  NOT NULL,
    "PwdChangeNotificationPeriodDays" SMALLINT                                  NOT NULL,
    "TriesBeforeUserLockout"          SMALLINT                                  NOT NULL,
    "AdminLockoutPeriodMins"          INTEGER                                   NOT NULL,
    "TriesBeforeAdminLockout"         SMALLINT                                  NOT NULL,
    "UserLockoutPeriodMins"           INTEGER                                   NOT NULL,
    "DateCreated"                     TIMESTAMP                                 NOT NULL,
    "DateAmended"                     TIMESTAMP                                 NOT NULL,
    "WhoAmended_NT_Username"          VARCHAR(255) COLLATE dbo.case_insensitive NOT NULL,
    "WhoAmended_Hostname"             VARCHAR(255) COLLATE dbo.case_insensitive NOT NULL,
    "AuditId"                         UUID                                      NULL,
    "AuditActionType"                 CHAR(2)      COLLATE dbo.case_insensitive NOT NULL,
    "AuditSequenceNo"                 INTEGER      GENERATED ALWAYS AS IDENTITY NOT NULL
    "LoginName"                       VARCHAR(256) COLLATE dbo.case_insensitive NULL,
    "HostName"                        VARCHAR(256) COLLATE dbo.case_insensitive NULL,
    "ActionTime"                      TIMESTAMP                                 NULL,
    CONSTRAINT "PK_PwdPolicy" PRIMARY KEY
    (
	    "AuditSequenceNo"
    )
);
CREATE UNIQUE INDEX IF NOT EXISTS "INDEX IX_PwdPolicy_NC01"
ON dbo."PwdPolicy"
    (
        "AuditId"   
    );

GRANT INSERT ON dbo."PwdPolicy" TO PUBLIC;