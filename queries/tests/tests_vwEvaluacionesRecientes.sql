USE RateMyProfessorDB;
GO

/* ============================================================
   PRUEBA 2: Ejecución de la vista vw_EvaluacionesRecientes
   Objetivo:
   Verificar que la vista muestre las evaluaciones más recientes,
   incluyendo profesor, curso, semestre, calificaciones y comentario.
   ============================================================ */

SELECT
    EvaluacionID,
    FechaEvaluacion,
    Estudiante,
    Profesor,
    Curso,
    CodigoCurso,
    Semestre,
    CalidadGeneral,
    Claridad,
    Dificultad,
    Utilidad,
    PromedioEvaluacion,
    Comentario
FROM dbo.vw_EvaluacionesRecientes
ORDER BY FechaEvaluacion DESC;
GO