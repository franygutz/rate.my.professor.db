-- 1. Comando para la verificación de consistencia física y lógica
DBCC CHECKDB ([RateMyProfessorDB]) WITH NO_INFOMSGS, ALL_ERRORMSGS;

-- 2. Estructura base para la reconstrucción total de índices (Aplicada a cada tabla)
ALTER INDEX ALL ON dbo.Evaluaciones REBUILD;
ALTER INDEX ALL ON dbo.Profesores REBUILD;

-- 3. Comando del sistema para la actualización global de estadísticas
EXEC sp_updatestats;
