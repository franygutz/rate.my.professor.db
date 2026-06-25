USE msdb;
GO

-- 1. Eliminar el Job si ya existe (para evitar errores de duplicado en pruebas)
IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs WHERE name = N'Job_Purga_Y_Archivado_Historico')
    EXEC msdb.dbo.sp_delete_job @job_name = N'Job_Purga_Y_Archivado_Historico';
GO

-- 2. Crear el Job Principal
EXEC msdb.dbo.sp_add_job
    @job_name = N'Job_Purga_Y_Archivado_Historico',
    @enabled = 1,
    @description = N'Ejecuta la purga y archivado de evaluaciones antiguas.',
    @owner_login_name = N'sa';
GO

-- 3. Crear el Paso 1: Ejecutar el Procedimiento Almacenado
EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Job_Purga_Y_Archivado_Historico',
    @step_name = N'Paso 1: Archivar Evaluaciones',
    @subsystem = N'TSQL',
    @command = N'EXEC dbo.sp_ArchivarEvaluacionesAntiguas @FechaLimite = ''2026-01-01'';',
    @database_name = N'RateMyProfessorDB',
    @on_success_action = 1, -- Finalizar con éxito si termina bien
    @on_fail_action = 2;    -- Finalizar con error si falla
GO

-- 4. Crear el Calendario (Mensual, el día 1 de cada mes a las 3:00 AM)
EXEC msdb.dbo.sp_add_schedule
    @schedule_name = N'Mensual_Archivado',
    @freq_type = 16,        -- 16 = Mensual
    @freq_interval = 1,     -- Día 1
    @freq_recurrence_factor = 1,
    @active_start_time = 030000; -- 03:00:00
GO

-- 5. Vincular el Calendario al Job
EXEC msdb.dbo.sp_attach_schedule
    @job_name = N'Job_Purga_Y_Archivado_Historico',
    @schedule_name = N'Mensual_Archivado';
GO

-- 6. Asignar el Job al Servidor Local
EXEC msdb.dbo.sp_add_jobserver
    @job_name = N'Job_Purga_Y_Archivado_Historico',
    @server_name = @@SERVERNAME;
GO