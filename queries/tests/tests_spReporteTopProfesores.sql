USE RateMyProfessorDB;
GO

/* ============================================================
   PRUEBA 8: Ejecución del procedimiento sp_ReporteTopProfesores
   Objetivo:
   Generar un reporte con los profesores mejor calificados.
   ============================================================ */

EXEC dbo.sp_ReporteTopProfesores
    @Top = 5;
GO