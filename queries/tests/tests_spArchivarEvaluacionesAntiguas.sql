USE RateMyProfessorDB;
GO

/* ============================================================
   PRUEBA 10: Ejecución del procedimiento sp_ArchivarEvaluacionesAntiguas
   Objetivo:
   Verificar que el procedimiento archive evaluaciones antiguas.
   Importante:
   Se ejecuta dentro de una transacción de prueba y se revierte
   con ROLLBACK para no modificar permanentemente los datos.
   ============================================================ */

BEGIN TRANSACTION;

    EXEC dbo.sp_ArchivarEvaluacionesAntiguas
        @FechaLimite = '2030-01-01';

    /* Verificar evaluaciones archivadas durante la prueba */
    SELECT
        ArchivoID,
        EvaluacionIDOriginal,
        EstudianteID,
        AsignacionID,
        CalidadGeneral,
        Claridad,
        Dificultad,
        Utilidad,
        FechaEvaluacion,
        FechaArchivado
    FROM dbo.EvaluacionesArchivadas
    ORDER BY FechaArchivado DESC;

    /* Verificar que las evaluaciones fueron removidas temporalmente
       de la tabla principal dentro de la transacción */
    SELECT
        EvaluacionID,
        EstudianteID,
        AsignacionID,
        FechaEvaluacion
    FROM dbo.Evaluaciones;

ROLLBACK TRANSACTION;
GO