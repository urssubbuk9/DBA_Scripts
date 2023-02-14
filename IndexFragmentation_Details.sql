--Check SQL Server a specified database index fragmentation percentage (SQL)
DECLARE @DBID INT
 SELECT @DBID = DB_ID()
 SELECT OBJECT_NAME([OBJECT_ID]) 'TABLE NAME',INDEX_TYPE_DESC 'INDEX TYPE',IND.[NAME],record_count 'record_count',CASE WHEN AVG_FRAGMENTATION_IN_PERCENT <30 THEN 'To Be Re-Organized' ELSE 'To Be Rebuilt' END 'ACTION TO BE TAKEN' ,AVG_FRAGMENTATION_IN_PERCENT '% FRAGMENTED'
FROM sys.dm_db_index_physical_stats(@DBID, NULL, NULL, NULL,'detailed') JOIN sys.sysindexes IND
 ON (IND.ID =[OBJECT_ID] AND IND.INDID = INDEX_ID)
 WHERE AVG_FRAGMENTATION_IN_PERCENT > 0
 AND DATABASE_ID = @DBID
 AND IND.FIRST IS NOT NULL
 AND IND.[NAME] IS NOT NULL
 ORDER BY 5 DESC

