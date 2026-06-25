USE msdb;
GO

-- 1. LIMPIAR EL JOB SI YA EXISTÍA PARA EVITAR CONFLICTOS DE ENRUTAMIENTO
IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs WHERE name = N'Job_Mantenimiento_RateMyProfessor')
    EXEC dbo.sp_delete_job @job_name = N'Job_Mantenimiento_RateMyProfessor', @delete_unused_schedule=1;
GO

-- 2. CREAR EL CONTENEDOR GENERAL DEL JOB DENTRO DE MSDB
EXEC dbo.sp_add_job
    @job_name = N'Job_Mantenimiento_RateMyProfessor',
    @enabled = 1,
    @description = N'Mantenimiento semanal automatizado y Backup Completo para RateMyProfessorDB.';
GO

-- 3. EMBEBER EL SCRIPT MULTITAREA (Paso 1: Mantenimiento Secuencial + BACKUP COMPLETO)
EXEC dbo.sp_add_jobstep
    @job_name = N'Job_Mantenimiento_RateMyProfessor',
    @step_name = N'Optimizar y Respaldar Base de Datos',
    @subsystem = N'TSQL',
    @command = N'
        USE RateMyProfessorDB;
       
        -- Paso A: Verificación de Integridad Física
        DBCC CHECKDB ([RateMyProfessorDB]) WITH NO_INFOMSGS, ALL_ERRORMSGS;
       
        -- Paso B: Reconstrucción Dinámica de Índices por Cursor
        DECLARE @TableName NVARCHAR(255);
        DECLARE @SqlCommand NVARCHAR(MAX);
        DECLARE TableCursor CURSOR FOR SELECT ''['' + SCHEMA_NAME(schema_id) + ''].['' + name + '']'' FROM sys.tables;
        OPEN TableCursor;
        FETCH NEXT FROM TableCursor INTO @TableName;
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @SqlCommand = ''ALTER INDEX ALL ON '' + @TableName + '' REBUILD;'';
            EXEC sp_executesql @SqlCommand;
            FETCH NEXT FROM TableCursor INTO @TableName;
        END;
        CLOSE TableCursor; DEALLOCATE TableCursor;
       
        -- Paso C: Actualización de Histogramas Estadísticos
        EXEC sp_updatestats;
       
        -- Paso D: RESPALDO COMPLETO (BACKUP) EN LA CARPETA FÍSICA ASIGNADA
        BACKUP DATABASE [RateMyProfessorDB]
        TO DISK = ''C:\Respaldos\RateMyProfessorDB.bak''
        WITH INIT,
             DESCRIPTION = ''Copia de Seguridad Semanal Automatizada'',
             NAME = ''RateMyProfessorDB-Full Backup'';',
    @retry_attempts = 1,
    @retry_interval = 5;
GO

-- 4. CONFIGURAR CALENDARIO RECURRENTE (Cada Domingo a las 02:00:00 AM)
EXEC dbo.sp_add_jobschedule
    @job_name = N'Job_Mantenimiento_RateMyProfessor',
    @name = N'Horario_Semanal_Domingos_2AM',
    @enabled = 1,
    @freq_type = 8,                  -- Tipo de frecuencia: 8 = Semanal
    @freq_interval = 1,              -- Día asignado: 1 = Domingo
    @freq_recurrence_factor = 1,     -- Factor de repetición: Cada 1 semana
    @freq_subday_type = 1,
    @active_start_time = 020000;     -- Formato de hora militar HHMMSS (02:00:00 AM)
GO

-- 5. VINCULAR EL JOB AL SERVIDOR DE BASE DE DATOS LOCAL (TARGET SERVER)
EXEC dbo.sp_add_jobserver
    @job_name = N'Job_Mantenimiento_RateMyProfessor',
    @server_name = N'(local)';
GO
