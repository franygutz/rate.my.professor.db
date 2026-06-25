USE RateMyProfessorDB;
GO

/* ============================================================
   PRUEBA 4: Ejecución de la función fn_YaEvaluo
   Objetivo:
   Comprobar si un estudiante ya evaluó una asignación específica.
   La función debe retornar:
   1 = Ya evaluó
   0 = No ha evaluado
   ============================================================ */

SELECT
    dbo.fn_YaEvaluo(1, 1) AS YaEvaluo;
GO