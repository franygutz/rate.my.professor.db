USE RateMyProfessorDB;
GO

---------------------------------------------------------------
-- 12. VISTA: RANKING DE PROFESORES
-- Muestra promedios por profesor y cantidad de evaluaciones.
---------------------------------------------------------------

CREATE OR ALTER VIEW dbo.vw_RankingProfesores
AS
SELECT
    p.ProfesorID,
    CONCAT(p.Nombres, N' ', p.Apellidos) AS Profesor,
    d.Nombre AS Departamento,

    COUNT(e.EvaluacionID) AS CantidadEvaluaciones,

    CAST(AVG(CAST(e.CalidadGeneral AS DECIMAL(5,2))) AS DECIMAL(4,2)) AS PromedioCalidadGeneral,
    CAST(AVG(CAST(e.Claridad AS DECIMAL(5,2))) AS DECIMAL(4,2)) AS PromedioClaridad,
    CAST(AVG(CAST(e.Dificultad AS DECIMAL(5,2))) AS DECIMAL(4,2)) AS PromedioDificultad,
    CAST(AVG(CAST(e.Utilidad AS DECIMAL(5,2))) AS DECIMAL(4,2)) AS PromedioUtilidad,

    CAST(
        AVG(
            CAST(
                (e.CalidadGeneral + e.Claridad + e.Dificultad + e.Utilidad) / 4.0
                AS DECIMAL(5,2)
            )
        )
        AS DECIMAL(4,2)
    ) AS PromedioGeneral
FROM dbo.Profesores p
INNER JOIN dbo.Departamentos d
    ON p.DepartamentoID = d.DepartamentoID
LEFT JOIN dbo.AsignacionesProfesorCurso apc
    ON p.ProfesorID = apc.ProfesorID
LEFT JOIN dbo.Evaluaciones e
    ON apc.AsignacionID = e.AsignacionID
GROUP BY
    p.ProfesorID,
    p.Nombres,
    p.Apellidos,
    d.Nombre;
GO
