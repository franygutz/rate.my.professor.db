USE RateMyProfessorDB;
GO

---------------------------------------------------------------
-- 16. PROCEDIMIENTO: INSERTAR EVALUACIÓN
-- Inserta una evaluación aplicando validaciones de negocio.
---------------------------------------------------------------

CREATE OR ALTER PROCEDURE dbo.sp_InsertarEvaluacion
    @EstudianteID INT,
    @AsignacionID INT,
    @CalidadGeneral DECIMAL(3,2),
    @Claridad DECIMAL(3,2),
    @Dificultad DECIMAL(3,2),
    @Utilidad DECIMAL(3,2),
    @Comentario NVARCHAR(1000) = NULL,
    @EsAnonima BIT = 1
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar que exista el estudiante y esté activo.
        IF NOT EXISTS (
            SELECT 1
            FROM dbo.Estudiantes
            WHERE EstudianteID = @EstudianteID
              AND Activo = 1
        )
        BEGIN
            THROW 50001, 'El estudiante no existe o se encuentra inactivo.', 1;
        END;

        -- Validar que exista la asignación y esté activa.
        IF NOT EXISTS (
            SELECT 1
            FROM dbo.AsignacionesProfesorCurso
            WHERE AsignacionID = @AsignacionID
              AND Activo = 1
        )
        BEGIN
            THROW 50002, 'La asignación profesor-curso no existe o se encuentra inactiva.', 1;
        END;

        -- Validar que el estudiante no haya evaluado antes la misma asignación.
        IF dbo.fn_YaEvaluo(@EstudianteID, @AsignacionID) = 1
        BEGIN
            THROW 50003, 'El estudiante ya evaluó esta asignación.', 1;
        END;

        -- Validar rangos de calificación antes del INSERT.
        IF @CalidadGeneral NOT BETWEEN 1.00 AND 5.00
           OR @Claridad NOT BETWEEN 1.00 AND 5.00
           OR @Dificultad NOT BETWEEN 1.00 AND 5.00
           OR @Utilidad NOT BETWEEN 1.00 AND 5.00
        BEGIN
            THROW 50004, 'Las calificaciones deben estar entre 1.00 y 5.00.', 1;
        END;

        -- Insertar la evaluación.
        INSERT INTO dbo.Evaluaciones
        (
            EstudianteID,
            AsignacionID,
            CalidadGeneral,
            Claridad,
            Dificultad,
            Utilidad,
            Comentario,
            EsAnonima
        )
        VALUES
        (
            @EstudianteID,
            @AsignacionID,
            @CalidadGeneral,
            @Claridad,
            @Dificultad,
            @Utilidad,
            @Comentario,
            @EsAnonima
        );

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;
GO
