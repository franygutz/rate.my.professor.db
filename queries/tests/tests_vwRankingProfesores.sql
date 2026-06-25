USE RateMyProfessorDB;
GO

/* ============================================================
   PRUEBA 1: Ejecución de la vista vw_RankingProfesores
   Objetivo:
   Validar que la vista muestre el ranking de profesores con sus
   promedios de evaluación y cantidad total de evaluaciones.
   ============================================================ */

SELECT
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
ORDER BY PromedioGeneral DESC;
GO