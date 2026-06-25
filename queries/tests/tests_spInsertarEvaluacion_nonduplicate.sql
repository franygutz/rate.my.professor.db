USE RateMyProfessorDB;
GO

/* ============================================================
   PRUEBA 6: Validación de duplicado en sp_InsertarEvaluacion
   Objetivo:
   Confirmar que el procedimiento impide registrar dos veces
   una evaluación para el mismo estudiante y la misma asignación.
   ============================================================ */

BEGIN TRY
    EXEC dbo.sp_InsertarEvaluacion
        @EstudianteID = 1,
        @AsignacionID = 1,
        @CalidadGeneral = 4.00,
        @Claridad = 4.00,
        @Dificultad = 3.50,
        @Utilidad = 4.20,
        @Comentario = N'Intento de evaluación duplicada.',
        @EsAnonima = 1;
END TRY
BEGIN CATCH
    SELECT
        ERROR_NUMBER() AS NumeroError,
        ERROR_MESSAGE() AS MensajeError;
END CATCH;
GO