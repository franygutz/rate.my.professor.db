USE RateMyProfessorDB;
GO

/* ============================================================
   PRUEBA 7: Validación de rangos en sp_InsertarEvaluacion
   Objetivo:
   Confirmar que el procedimiento rechaza calificaciones fuera
   del rango permitido.
   ============================================================ */

BEGIN TRY
    EXEC dbo.sp_InsertarEvaluacion
        @EstudianteID = 5,
        @AsignacionID = 3,
        @CalidadGeneral = 6.00,
        @Claridad = 4.00,
        @Dificultad = 3.00,
        @Utilidad = 4.00,
        @Comentario = N'Prueba con calificación fuera de rango.',
        @EsAnonima = 1;
END TRY
BEGIN CATCH
    SELECT
        ERROR_NUMBER() AS NumeroError,
        ERROR_MESSAGE() AS MensajeError;
END CATCH;
GO