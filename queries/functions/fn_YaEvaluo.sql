USE RateMyProfessorDB;
GO

---------------------------------------------------------------
-- 15. FUNCIÓN: VALIDAR SI YA EVALUÓ
-- Retorna 1 si el estudiante ya evaluó la asignación.
---------------------------------------------------------------

CREATE OR ALTER FUNCTION dbo.fn_YaEvaluo
(
    @EstudianteID INT,
    @AsignacionID INT
)
RETURNS BIT
AS
BEGIN
    DECLARE @Resultado BIT = 0;

    IF EXISTS (
        SELECT 1
        FROM dbo.Evaluaciones
        WHERE EstudianteID = @EstudianteID
          AND AsignacionID = @AsignacionID
    )
    BEGIN
        SET @Resultado = 1;
    END

    RETURN @Resultado;
END;
GO
