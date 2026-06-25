---------------------------------------------------------------
-- 18. PROCEDIMIENTO: ARCHIVAR EVALUACIONES ANTIGUAS
-- Mueve evaluaciones antiguas a una tabla histórica.
---------------------------------------------------------------

CREATE OR ALTER PROCEDURE dbo.sp_ArchivarEvaluacionesAntiguas
    @FechaLimite DATETIME2(0)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Copiar evaluaciones antiguas hacia la tabla de archivo.
        INSERT INTO dbo.EvaluacionesArchivadas
        (
            EvaluacionIDOriginal,
            EstudianteID,
            AsignacionID,
            CalidadGeneral,
            Claridad,
            Dificultad,
            Utilidad,
            Comentario,
            EsAnonima,
            FechaEvaluacion
        )
        SELECT
            EvaluacionID,
            EstudianteID,
            AsignacionID,
            CalidadGeneral,
            Claridad,
            Dificultad,
            Utilidad,
            Comentario,
            EsAnonima,
            FechaEvaluacion
        FROM dbo.Evaluaciones
        WHERE FechaEvaluacion < @FechaLimite;

        -- Eliminar de la tabla principal las evaluaciones ya archivadas.
        DELETE FROM dbo.Evaluaciones
        WHERE FechaEvaluacion < @FechaLimite;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;
GO