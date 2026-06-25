USE RateMyProfessorDB;
GO

---------------------------------------------------------------
-- 13. VISTA: EVALUACIONES RECIENTES
-- Presenta evaluaciones con datos del profesor, curso y semestre.
---------------------------------------------------------------

CREATE OR ALTER VIEW dbo.vw_EvaluacionesRecientes
AS
SELECT
    e.EvaluacionID,
    e.FechaEvaluacion,

    CASE 
        WHEN e.EsAnonima = 1 THEN N'Anónimo'
        ELSE CONCAT(est.Nombres, N' ', est.Apellidos)
    END AS Estudiante,

    CONCAT(p.Nombres, N' ', p.Apellidos) AS Profesor,
    c.Nombre AS Curso,
    c.CodigoCurso,
    CONCAT(s.Periodo, N' ', s.Anio) AS Semestre,

    e.CalidadGeneral,
    e.Claridad,
    e.Dificultad,
    e.Utilidad,

    CAST(
        (e.CalidadGeneral + e.Claridad + e.Dificultad + e.Utilidad) / 4.0
        AS DECIMAL(4,2)
    ) AS PromedioEvaluacion,

    e.Comentario
FROM dbo.Evaluaciones e
INNER JOIN dbo.Estudiantes est
    ON e.EstudianteID = est.EstudianteID
INNER JOIN dbo.AsignacionesProfesorCurso apc
    ON e.AsignacionID = apc.AsignacionID
INNER JOIN dbo.Profesores p
    ON apc.ProfesorID = p.ProfesorID
INNER JOIN dbo.Cursos c
    ON apc.CursoID = c.CursoID
INNER JOIN dbo.Semestres s
    ON apc.SemestreID = s.SemestreID;
GO
