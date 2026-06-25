USE msdb;
GO

/* ============================================================
   3. CREAR PERFIL DE DATABASE MAIL
   El perfil agrupa una o varias cuentas de correo.
   ============================================================ */

EXEC msdb.dbo.sysmail_add_profile_sp
    @profile_name = N'Perfil_RateMyProfessorDB',
    @description = N'Perfil de correo para notificaciones y reportes de RateMyProfessorDB.';
GO

/* Asociar la cuenta creada al perfil */

EXEC msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = N'Perfil_RateMyProfessorDB',
    @account_name = N'Cuenta_RateMyProfessorDB',
    @sequence_number = 1;
GO

/* Permitir que el perfil pueda ser utilizado por procesos autorizados */

EXEC msdb.dbo.sysmail_add_principalprofile_sp
    @profile_name = N'Perfil_RateMyProfessorDB',
    @principal_name = N'public',
    @is_default = 1;
GO