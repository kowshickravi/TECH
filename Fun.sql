CREATE OR REPLACE FUNCTION dbo.FN_ViewStatsForAllAVDomains(
  IN pi_UserId      INTEGER,
  IN pi_CustomerId  INTEGER
)
RETURNS BOOLEAN 
LANGUAGE plpgsql
AS 
$BODY$
-- ========================================================================================================
-- Description : 
--             :
-- Author      : 
-- --------------------------------------------------------------------------------------------------------
-- [COPYIGHT NOTICE]
-- ------------------------------------------------------------------------------------------------------------
-- Copyright © 2020 Broadcom. All rights reserved.
-- The term “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.
--
-- This software and all information contained therein is confidential and proprietary and shall not be
-- duplicated, used, disclosed or disseminated in any way except as authorized by the applicable license agreement,
-- without the express written permission of Broadcom. All authorized reproductions must be marked with this language.
--
-- EXCEPT AS SET FORTH IN THE APPLICABLE LICENSE AGREEMENT, TO THE EXTENT PERMITTED BY APPLICABLE LAW OR
-- AS AGREED BY BROADCOM IN ITS APPLICABLE LICENSE AGREEMENT, BROADCOM PROVIDES THIS DOCUMENTATION “AS IS”
-- WITHOUT WARRANTY OF ANY KIND, INCLUDING WITHOUT LIMITATION, ANY IMPLIED WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE, OR NONINFRINGEMENT. IN NO EVENT WILL BROADCOM BE LIABLE TO THE END USER OR
-- ANY THIRD PARTY FOR ANY LOSS OR DAMAGE, DIRECT OR INDIRECT, FROM THE USE OF THIS DOCUMENTATION,
-- INCLUDING WITHOUT LIMITATION, LOST PROFITS, LOST INVESTMENT, BUSINESS INTERRUPTION, GOODWILL, OR LOST DATA,
-- EVEN IF BROADCOM IS EXPRESSLY ADVISED IN ADVANCE OF THE POSSIBILITY OF SUCH LOSS OR DAMAGE
-- ========================================================================================================
DECLARE
     v_AllDomains          BOOLEAN,
     v_AVDomainCount       INTEGER,
     v_UserAVDomainCount   INTEGER
DECLARE v_tabDomains  TABLE
     (DomainId) INTEGER
DECLARE v_tabRoleServiceDomains  TABLE
      (DomainId) INTEGER
BEGIN
SET  pi_AllDomains = FALSE
INSERT INTO pi_tabDomains
       (DomainId) INTEGER
SELECT AD.DomainId FROM dbo.AllDomains  AD
INNER JOIN
     dbo.CustomerConfig  CC
ON AD.DomainId            = CC.DomainId
AND CC.CheckUs_CheckVirus = 'Y'
WHERE AD.CustomerId = pi_CustomerId
AND   AD.DateDeleted  IS NULL
SET pi_AVDomainCount = pi_ROWCOUNT
INSERT INTO pi_tabRoleServiceDomains
     (DomainId)
SELECT DomainId FROM (SELECT AD.DomainId,
					 MAX (CASE   WHEN RSD.CustomerServiceTypeId   IS NOT NULL   AND DomainInclusionState = FALSE  THEN 4  
						         WHEN RSD.CustomerServiceTypeId   IS NOT NULL   AND DomainInclusionState = TRUE   THEN 3
						         WHEN RSD.CustomerServiceTypeId   IS NULL           AND DomainInclusionState = FALSE  THEN 2
						         WHEN RSD.CustomerServiceTypeId   IS NULL           AND DomainInclusionState = TRUE   THEN 1
                         END) RANK
			FROM dbo.AllDomains     AD
		    INNER JOIN
				 dbo.CustomerConfig  CC
			ON   AD.DomainId            =CC.DomainId
		    AND  CC.CheckUs_CheckVirus  ='Y'
			INNER JOIN
					  dbo.AuthorisedUserRoleServiceDomain  RSD
			ON   AD.CustomerId            = pi_CustomerId
			AND  RSD.UserId               = pi_UserId
			AND  RSD.RoleId               = pi_RoleId
			AND (RSD.DomainId             =ad.DomainId
			OR   RSD.DomainId             IS NULL)
			AND  (RSD.CustomerServiceTypeId = 2
			OR RSD.CustomerServiceTypeId  IS NULL)
			AND AD.DateDeleted            IS NULL
			GROUP BY AD.DomainID AS A
	WHERE A.Rank  IN (1,3)
		   SET  pi_UserAVDomainCount =  pi_ROWCOUNT
			IF pi_UserAVDomainCount  =  pi_AVDomainCount
		AND  pi_AVDomainCount > 0
		BEGIN
					  SET pi_AllDomains = TRUE
	    END 
					  RETURN pi_AllDomains;
END;
$BODY$;
					 

     
     