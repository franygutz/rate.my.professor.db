USE RateMyProfessorDB;
GO

/* ============================================================
   PRUEBA 9: Validación del parámetro @Top
   Objetivo:
   Confirmar que el procedimiento no acepta valores menores
   o iguales a cero.
   ============================================================ */

BEGIN TRY
    EXEC dbo.sp_ReporteTopProfesores
        @Top = 0;
END TRY
BEGIN CATCH
    SELECT
        ERROR_NUMBER() AS NumeroError,
        ERROR_MESSAGE() AS MensajeError;
END CATCH;
GO