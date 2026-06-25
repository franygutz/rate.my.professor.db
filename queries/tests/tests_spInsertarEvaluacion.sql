USE RateMyProfessorDB;
GO

/* ============================================================
   PRUEBA 5: Ejecución del procedimiento sp_InsertarEvaluacion
   Objetivo:
   Insertar una nueva evaluación válida en la base de datos.
   Nota:
   Se recomienda usar una combinación de EstudianteID y AsignacionID
   que todavía no exista en la tabla Evaluaciones.
   ============================================================ */

EXEC dbo.sp_InsertarEvaluacion
    @EstudianteID = 4,
    @AsignacionID = 5,
    @CalidadGeneral = 4.60,
    @Claridad = 4.40,
    @Dificultad = 3.80,
    @Utilidad = 4.70,
    @Comentario = N'El docente explica con claridad y utiliza ejemplos prácticos.',
    @EsAnonima = 1;
GO

/* Verificación de la inserción realizada */

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
WHERE EstudianteID = 4
  AND AsignacionID = 5;
GO