USE RateMyProfessorDB;
GO

---------------------------------------------------------------
-- 17. PROCEDIMIENTO: REPORTE TOP PROFESORES
-- Devuelve los mejores profesores según promedio general.
---------------------------------------------------------------

CREATE OR ALTER PROCEDURE dbo.sp_ReporteTopProfesores
    @Top INT = 5
AS
BEGIN
    SET NOCOUNT ON;

    IF @Top <= 0
    BEGIN
        THROW 50005, 'El parámetro @Top debe ser mayor que cero.', 1;
    END;

    SELECT TOP (@Top)
        ProfesorID,
        Profesor,
        Departamento,
        CantidadEvaluaciones,
        PromedioCalidadGeneral,
        PromedioClaridad,
        PromedioDificultad,
        PromedioUtilidad,
        PromedioGeneral
    FROM dbo.vw_RankingProfesores
    WHERE CantidadEvaluaciones > 0
    ORDER BY
        PromedioGeneral DESC,
        CantidadEvaluaciones DESC;
END;
GO
