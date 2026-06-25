USE msdb;
GO

/* ============================================================
   2. CREAR CUENTA DE DATABASE MAIL
   Esta cuenta representa el correo desde donde SQL Server enviará
   las notificaciones.
   ============================================================ */

EXEC msdb.dbo.sysmail_add_account_sp
    @account_name = N'Cuenta_RateMyProfessorDB',
    @description = N'Cuenta utilizada para enviar notificaciones administrativas de RateMyProfessorDB.',
    @email_address = N'uamratemyprofessor@gmail.com',
    @display_name = N'RateMyProfessorDB - Notificaciones',
    @replyto_address = N'uamratemyprofessor@gmail.com',
    @mailserver_name = N'smtp.gmail.com',
    @port = 587,
    @enable_ssl = 1,
    @username = N'uamratemyprofessor@gmail.com',
    @password = N'nhrq iiac xrwn ksjy';
GO