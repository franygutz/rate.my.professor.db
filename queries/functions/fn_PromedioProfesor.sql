---------------------------------------------------------------
-- 14. FUNCIÓN: PROMEDIO DE UN PROFESOR
-- Devuelve el promedio general de calificaciones de un profesor.
---------------------------------------------------------------

CREATE OR ALTER FUNCTION dbo.fn_PromedioProfesor
(
    @ProfesorID INT
)
RETURNS DECIMAL(4,2)
AS
BEGIN
    DECLARE @Promedio DECIMAL(4,2);

    SELECT
        @Promedio = CAST(
            AVG(
                CAST(
                    (e.CalidadGeneral + e.Claridad + e.Dificultad + e.Utilidad) / 4.0
                    AS DECIMAL(5,2)
                )
            )
            AS DECIMAL(4,2)
        )
    FROM dbo.Evaluaciones e
    INNER JOIN dbo.AsignacionesProfesorCurso apc
        ON e.AsignacionID = apc.AsignacionID
    WHERE apc.ProfesorID = @ProfesorID;

    RETURN ISNULL(@Promedio, 0.00);
END;
GO