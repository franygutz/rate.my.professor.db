/* ============================================================
   CRITERIO 6: DATABASE MAIL
   Base de datos: RateMyProfessorDB
   Objetivo:
   Configurar Database Mail para enviar notificaciones y reportes.
   ============================================================ */

USE master;
GO

---------------------------------------------------------------
-- 1. HABILITAR DATABASE MAIL XPs
---------------------------------------------------------------

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
GO

EXEC sp_configure 'Database Mail XPs', 1;
RECONFIGURE;
GO