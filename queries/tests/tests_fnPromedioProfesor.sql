USE RateMyProfessorDB;
GO

/* ============================================================
   PRUEBA 3: Ejecución de la función fn_PromedioProfesor
   Objetivo:
   Validar que la función retorne el promedio general de un
   profesor específico.
   ============================================================ */

SELECT
    p.ProfesorID,
    CONCAT(p.Nombres, ' ', p.Apellidos) AS Profesor,
    dbo.fn_PromedioProfesor(p.ProfesorID) AS PromedioGeneral
FROM dbo.Profesores p
WHERE p.ProfesorID = 1;
GO