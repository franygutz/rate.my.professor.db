/* ============================================================
   PROYECTO FINAL - BASE DE DATOS
   Sistema: Rate My Professor
   Motor: Microsoft SQL Server
   Descripción:
   Script de creación de base de datos con tablas, relaciones,
   constraints, índices, vistas, funciones y procedimientos.
   ============================================================ */

---------------------------------------------------------------
-- 1. CREACIÓN DE LA BASE DE DATOS
---------------------------------------------------------------

IF DB_ID(N'RateMyProfessorDB') IS NULL
BEGIN
    CREATE DATABASE RateMyProfessorDB;
END
GO

USE RateMyProfessorDB;
GO

---------------------------------------------------------------
-- 2. LIMPIEZA DE OBJETOS EXISTENTES
-- Esto permite ejecutar el script varias veces sin errores.
---------------------------------------------------------------

DROP PROCEDURE IF EXISTS dbo.sp_InsertarEvaluacion;
DROP PROCEDURE IF EXISTS dbo.sp_ReporteTopProfesores;
DROP PROCEDURE IF EXISTS dbo.sp_ArchivarEvaluacionesAntiguas;
GO

DROP FUNCTION IF EXISTS dbo.fn_PromedioProfesor;
DROP FUNCTION IF EXISTS dbo.fn_YaEvaluo;
GO

DROP VIEW IF EXISTS dbo.vw_RankingProfesores;
DROP VIEW IF EXISTS dbo.vw_EvaluacionesRecientes;
GO

DROP TABLE IF EXISTS dbo.EvaluacionesArchivadas;
DROP TABLE IF EXISTS dbo.Evaluaciones;
DROP TABLE IF EXISTS dbo.AsignacionesProfesorCurso;
DROP TABLE IF EXISTS dbo.Cursos;
DROP TABLE IF EXISTS dbo.Estudiantes;
DROP TABLE IF EXISTS dbo.Profesores;
DROP TABLE IF EXISTS dbo.Semestres;
DROP TABLE IF EXISTS dbo.Departamentos;
GO

---------------------------------------------------------------
-- 3. TABLA: DEPARTAMENTOS
-- Catálogo de facultades o unidades académicas.
---------------------------------------------------------------

CREATE TABLE dbo.Departamentos
(
    DepartamentoID INT IDENTITY(1,1) NOT NULL,

    Nombre NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(250) NULL,

    Activo BIT NOT NULL
        CONSTRAINT DF_Departamentos_Activo DEFAULT (1),

    FechaCreacion DATETIME2(0) NOT NULL
        CONSTRAINT DF_Departamentos_FechaCreacion DEFAULT (SYSDATETIME()),

    CONSTRAINT PK_Departamentos
        PRIMARY KEY CLUSTERED (DepartamentoID),

    CONSTRAINT UQ_Departamentos_Nombre
        UNIQUE (Nombre),

    CONSTRAINT CK_Departamentos_Nombre_NoVacio
        CHECK (LEN(LTRIM(RTRIM(Nombre))) > 0)
);
GO

---------------------------------------------------------------
-- 4. TABLA: SEMESTRES
-- Se normaliza el semestre para evitar escribirlo repetido.
---------------------------------------------------------------

CREATE TABLE dbo.Semestres
(
    SemestreID INT IDENTITY(1,1) NOT NULL,

    Anio SMALLINT NOT NULL,
    Periodo NVARCHAR(30) NOT NULL,

    Activo BIT NOT NULL
        CONSTRAINT DF_Semestres_Activo DEFAULT (1),

    CONSTRAINT PK_Semestres
        PRIMARY KEY CLUSTERED (SemestreID),

    CONSTRAINT UQ_Semestres_Anio_Periodo
        UNIQUE (Anio, Periodo),

    CONSTRAINT CK_Semestres_Anio
        CHECK (Anio BETWEEN 2020 AND 2100),

    CONSTRAINT CK_Semestres_Periodo
        CHECK (Periodo IN (N'I Semestre', N'II Semestre', N'Verano'))
);
GO

---------------------------------------------------------------
-- 5. TABLA: PROFESORES
-- Contiene la información principal de los docentes.
---------------------------------------------------------------

CREATE TABLE dbo.Profesores
(
    ProfesorID INT IDENTITY(1,1) NOT NULL,

    DepartamentoID INT NOT NULL,

    Nombres NVARCHAR(80) NOT NULL,
    Apellidos NVARCHAR(80) NOT NULL,
    TituloAcademico NVARCHAR(80) NULL,
    Especialidad NVARCHAR(120) NULL,
    Email NVARCHAR(120) NULL,

    Activo BIT NOT NULL
        CONSTRAINT DF_Profesores_Activo DEFAULT (1),

    FechaRegistro DATETIME2(0) NOT NULL
        CONSTRAINT DF_Profesores_FechaRegistro DEFAULT (SYSDATETIME()),

    CONSTRAINT PK_Profesores
        PRIMARY KEY CLUSTERED (ProfesorID),

    CONSTRAINT FK_Profesores_Departamentos
        FOREIGN KEY (DepartamentoID)
        REFERENCES dbo.Departamentos(DepartamentoID),

    CONSTRAINT CK_Profesores_Nombres_NoVacio
        CHECK (LEN(LTRIM(RTRIM(Nombres))) > 0),

    CONSTRAINT CK_Profesores_Apellidos_NoVacio
        CHECK (LEN(LTRIM(RTRIM(Apellidos))) > 0),

    CONSTRAINT CK_Profesores_Email_Formato
        CHECK (Email IS NULL OR Email LIKE N'_%@_%._%')
);
GO

-- Índice único filtrado: permite varios NULL, pero no emails repetidos.
CREATE UNIQUE INDEX UX_Profesores_Email
ON dbo.Profesores(Email)
WHERE Email IS NOT NULL;
GO

---------------------------------------------------------------
-- 6. TABLA: ESTUDIANTES
-- Almacena los estudiantes que realizan evaluaciones.
---------------------------------------------------------------

CREATE TABLE dbo.Estudiantes
(
    EstudianteID INT IDENTITY(1,1) NOT NULL,

    CodigoEstudiante NVARCHAR(20) NOT NULL,
    Nombres NVARCHAR(80) NOT NULL,
    Apellidos NVARCHAR(80) NOT NULL,
    Carrera NVARCHAR(120) NOT NULL,
    EmailInstitucional NVARCHAR(120) NULL,

    Activo BIT NOT NULL
        CONSTRAINT DF_Estudiantes_Activo DEFAULT (1),

    FechaRegistro DATETIME2(0) NOT NULL
        CONSTRAINT DF_Estudiantes_FechaRegistro DEFAULT (SYSDATETIME()),

    CONSTRAINT PK_Estudiantes
        PRIMARY KEY CLUSTERED (EstudianteID),

    CONSTRAINT UQ_Estudiantes_CodigoEstudiante
        UNIQUE (CodigoEstudiante),

    CONSTRAINT CK_Estudiantes_Codigo_NoVacio
        CHECK (LEN(LTRIM(RTRIM(CodigoEstudiante))) > 0),

    CONSTRAINT CK_Estudiantes_Nombres_NoVacio
        CHECK (LEN(LTRIM(RTRIM(Nombres))) > 0),

    CONSTRAINT CK_Estudiantes_Apellidos_NoVacio
        CHECK (LEN(LTRIM(RTRIM(Apellidos))) > 0),

    CONSTRAINT CK_Estudiantes_Carrera_NoVacio
        CHECK (LEN(LTRIM(RTRIM(Carrera))) > 0),

    CONSTRAINT CK_Estudiantes_Email_Formato
        CHECK (EmailInstitucional IS NULL OR EmailInstitucional LIKE N'_%@_%._%')
);
GO

CREATE UNIQUE INDEX UX_Estudiantes_EmailInstitucional
ON dbo.Estudiantes(EmailInstitucional)
WHERE EmailInstitucional IS NOT NULL;
GO

---------------------------------------------------------------
-- 7. TABLA: CURSOS
-- Catálogo de asignaturas impartidas.
---------------------------------------------------------------

CREATE TABLE dbo.Cursos
(
    CursoID INT IDENTITY(1,1) NOT NULL,

    DepartamentoID INT NOT NULL,

    CodigoCurso NVARCHAR(20) NOT NULL,
    Nombre NVARCHAR(120) NOT NULL,
    Creditos TINYINT NOT NULL,

    Activo BIT NOT NULL
        CONSTRAINT DF_Cursos_Activo DEFAULT (1),

    CONSTRAINT PK_Cursos
        PRIMARY KEY CLUSTERED (CursoID),

    CONSTRAINT UQ_Cursos_CodigoCurso
        UNIQUE (CodigoCurso),

    CONSTRAINT FK_Cursos_Departamentos
        FOREIGN KEY (DepartamentoID)
        REFERENCES dbo.Departamentos(DepartamentoID),

    CONSTRAINT CK_Cursos_Codigo_NoVacio
        CHECK (LEN(LTRIM(RTRIM(CodigoCurso))) > 0),

    CONSTRAINT CK_Cursos_Nombre_NoVacio
        CHECK (LEN(LTRIM(RTRIM(Nombre))) > 0),

    CONSTRAINT CK_Cursos_Creditos
        CHECK (Creditos BETWEEN 1 AND 10)
);
GO

---------------------------------------------------------------
-- 8. TABLA: ASIGNACIONES PROFESOR-CURSO
-- Relaciona profesores con cursos en un semestre específico.
---------------------------------------------------------------

CREATE TABLE dbo.AsignacionesProfesorCurso
(
    AsignacionID INT IDENTITY(1,1) NOT NULL,

    ProfesorID INT NOT NULL,
    CursoID INT NOT NULL,
    SemestreID INT NOT NULL,

    Seccion NVARCHAR(10) NOT NULL
        CONSTRAINT DF_Asignaciones_Seccion DEFAULT (N'A'),

    Activo BIT NOT NULL
        CONSTRAINT DF_Asignaciones_Activo DEFAULT (1),

    FechaAsignacion DATETIME2(0) NOT NULL
        CONSTRAINT DF_Asignaciones_FechaAsignacion DEFAULT (SYSDATETIME()),

    CONSTRAINT PK_AsignacionesProfesorCurso
        PRIMARY KEY CLUSTERED (AsignacionID),

    CONSTRAINT FK_Asignaciones_Profesores
        FOREIGN KEY (ProfesorID)
        REFERENCES dbo.Profesores(ProfesorID),

    CONSTRAINT FK_Asignaciones_Cursos
        FOREIGN KEY (CursoID)
        REFERENCES dbo.Cursos(CursoID),

    CONSTRAINT FK_Asignaciones_Semestres
        FOREIGN KEY (SemestreID)
        REFERENCES dbo.Semestres(SemestreID),

    -- Evita asignar dos veces al mismo profesor al mismo curso,
    -- en el mismo semestre y sección.
    CONSTRAINT UQ_Asignaciones_Profesor_Curso_Semestre_Seccion
        UNIQUE (ProfesorID, CursoID, SemestreID, Seccion),

    CONSTRAINT CK_Asignaciones_Seccion_NoVacia
        CHECK (LEN(LTRIM(RTRIM(Seccion))) > 0)
);
GO

---------------------------------------------------------------
-- 9. TABLA: EVALUACIONES
-- Registra las evaluaciones realizadas por estudiantes.
---------------------------------------------------------------

CREATE TABLE dbo.Evaluaciones
(
    EvaluacionID INT IDENTITY(1,1) NOT NULL,

    EstudianteID INT NOT NULL,
    AsignacionID INT NOT NULL,

    CalidadGeneral DECIMAL(3,2) NOT NULL,
    Claridad DECIMAL(3,2) NOT NULL,
    Dificultad DECIMAL(3,2) NOT NULL,
    Utilidad DECIMAL(3,2) NOT NULL,

    Comentario NVARCHAR(1000) NULL,

    EsAnonima BIT NOT NULL
        CONSTRAINT DF_Evaluaciones_EsAnonima DEFAULT (1),

    FechaEvaluacion DATETIME2(0) NOT NULL
        CONSTRAINT DF_Evaluaciones_FechaEvaluacion DEFAULT (SYSDATETIME()),

    CONSTRAINT PK_Evaluaciones
        PRIMARY KEY CLUSTERED (EvaluacionID),

    CONSTRAINT FK_Evaluaciones_Estudiantes
        FOREIGN KEY (EstudianteID)
        REFERENCES dbo.Estudiantes(EstudianteID),

    CONSTRAINT FK_Evaluaciones_Asignaciones
        FOREIGN KEY (AsignacionID)
        REFERENCES dbo.AsignacionesProfesorCurso(AsignacionID),

    -- Regla de negocio principal:
    -- un estudiante solo puede evaluar una vez una misma asignación.
    CONSTRAINT UQ_Evaluaciones_Estudiante_Asignacion
        UNIQUE (EstudianteID, AsignacionID),

    -- Validaciones de rango: todas las calificaciones deben ir de 1.00 a 5.00.
    CONSTRAINT CK_Evaluaciones_CalidadGeneral
        CHECK (CalidadGeneral BETWEEN 1.00 AND 5.00),

    CONSTRAINT CK_Evaluaciones_Claridad
        CHECK (Claridad BETWEEN 1.00 AND 5.00),

    CONSTRAINT CK_Evaluaciones_Dificultad
        CHECK (Dificultad BETWEEN 1.00 AND 5.00),

    CONSTRAINT CK_Evaluaciones_Utilidad
        CHECK (Utilidad BETWEEN 1.00 AND 5.00),

    CONSTRAINT CK_Evaluaciones_Comentario_NoVacio
        CHECK (Comentario IS NULL OR LEN(LTRIM(RTRIM(Comentario))) > 0)
);
GO

---------------------------------------------------------------
-- 10. TABLA: EVALUACIONES ARCHIVADAS
-- Tabla de soporte para guardar evaluaciones antiguas.
---------------------------------------------------------------

CREATE TABLE dbo.EvaluacionesArchivadas
(
    ArchivoID INT IDENTITY(1,1) NOT NULL,

    EvaluacionIDOriginal INT NOT NULL,
    EstudianteID INT NOT NULL,
    AsignacionID INT NOT NULL,

    CalidadGeneral DECIMAL(3,2) NOT NULL,
    Claridad DECIMAL(3,2) NOT NULL,
    Dificultad DECIMAL(3,2) NOT NULL,
    Utilidad DECIMAL(3,2) NOT NULL,

    Comentario NVARCHAR(1000) NULL,
    EsAnonima BIT NOT NULL,
    FechaEvaluacion DATETIME2(0) NOT NULL,

    FechaArchivado DATETIME2(0) NOT NULL
        CONSTRAINT DF_EvaluacionesArchivadas_FechaArchivado DEFAULT (SYSDATETIME()),

    CONSTRAINT PK_EvaluacionesArchivadas
        PRIMARY KEY CLUSTERED (ArchivoID)
);
GO