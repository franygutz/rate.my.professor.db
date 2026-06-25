-- ============================================================
-- BACKUP COMPLETO - RateMyProfessorDB
-- ============================================================
BACKUP DATABASE [RateMyProfessorDB]
TO DISK = 'C:\Respaldos\RateMyProfessorDB_Full.bak'
WITH 
    INIT,                                    
    COMPRESSION,                             
    CHECKSUM,                                
    DESCRIPTION = 'Backup Completo Semanal - RateMyProfessorDB',
    NAME = 'RateMyProfessorDB-FullBackup';
GO
