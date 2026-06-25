USE msdb;
GO

/* ============================================================
   4. PRUEBA DE ENVÍO DE CORREO
   Esta prueba confirma que Database Mail quedó configurado.
   ============================================================ */

EXEC msdb.dbo.sp_send_dbmail
    @profile_name = N'Perfil_RateMyProfessorDB',
    @recipients = N'emeza923@gmail.com',
    @subject = N'Prueba de Database Mail - RateMyProfessorDB',
    @body = N'La configuración de Database Mail fue realizada correctamente para la base de datos RateMyProfessorDB.';
GO

USE msdb;
GO