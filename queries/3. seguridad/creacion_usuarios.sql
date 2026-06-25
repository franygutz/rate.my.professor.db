/* ============================================================
   CRITERIO 1: SEGURIDAD
   Base de Datos: RateMyProfessorDB
   Microsoft SQL Server
   ============================================================ */

USE master;
GO

/* ============================================================
   1. CREACIÓN DE LOGINS
   ============================================================ */

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'login_dba')
    CREATE LOGIN login_dba
    WITH PASSWORD = 'DBA@RateMyProfessor2026!';
GO

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'login_operador')
    CREATE LOGIN login_operador
    WITH PASSWORD = 'Operador@2026!';
GO

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'login_consulta')
    CREATE LOGIN login_consulta
    WITH PASSWORD = 'Consulta@2026!';
GO

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'login_registro')
    CREATE LOGIN login_registro
    WITH PASSWORD = 'Registro@2026!';
GO


/* ============================================================
   2. CREACIÓN DE USUARIOS
   ============================================================ */

USE RateMyProfessorDB;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usr_dba')
    CREATE USER usr_dba FOR LOGIN login_dba;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usr_operador')
    CREATE USER usr_operador FOR LOGIN login_operador;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usr_consulta')
    CREATE USER usr_consulta FOR LOGIN login_consulta;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usr_registro')
    CREATE USER usr_registro FOR LOGIN login_registro;
GO


/* ============================================================
   3. CREACIÓN DE ROLES
   ============================================================ */

IF NOT EXISTS (SELECT * FROM sys.database_principals
               WHERE name = 'rol_administrador')
    CREATE ROLE rol_administrador;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals
               WHERE name = 'rol_operador')
    CREATE ROLE rol_operador;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals
               WHERE name = 'rol_consulta')
    CREATE ROLE rol_consulta;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals
               WHERE name = 'rol_registro')
    CREATE ROLE rol_registro;
GO


/* ============================================================
   4. ASIGNACIÓN DE USUARIOS A ROLES
   ============================================================ */

ALTER ROLE rol_administrador ADD MEMBER usr_dba;
GO

ALTER ROLE rol_operador ADD MEMBER usr_operador;
GO

ALTER ROLE rol_consulta ADD MEMBER usr_consulta;
GO

ALTER ROLE rol_registro ADD MEMBER usr_registro;
GO


/* ============================================================
   5. PERMISOS DEL ROL ADMINISTRADOR
   Acceso total sobre la base de datos.
   ============================================================ */

ALTER ROLE db_owner ADD MEMBER usr_dba;
GO


/* ============================================================
   6. PERMISOS DEL ROL CONSULTA
   SOLO LECTURA
   ============================================================ */

GRANT SELECT ON dbo.Departamentos TO rol_consulta;
GRANT SELECT ON dbo.Profesores TO rol_consulta;
GRANT SELECT ON dbo.Cursos TO rol_consulta;
GRANT SELECT ON dbo.Semestres TO rol_consulta;
GO

/* Si existen las vistas del proyecto */

IF OBJECT_ID('dbo.vw_RankingProfesores') IS NOT NULL
    GRANT SELECT ON dbo.vw_RankingProfesores TO rol_consulta;
GO

IF OBJECT_ID('dbo.vw_EvaluacionesRecientes') IS NOT NULL
    GRANT SELECT ON dbo.vw_EvaluacionesRecientes TO rol_consulta;
GO


/* ============================================================
   7. PERMISOS DEL ROL REGISTRO
   SOLO EJECUCIÓN DEL PROCEDIMIENTO DE INSERCIÓN
   ============================================================ */

IF OBJECT_ID('dbo.sp_InsertarEvaluacion') IS NOT NULL
    GRANT EXECUTE ON dbo.sp_InsertarEvaluacion
    TO rol_registro;
GO

/* Bloquea acceso directo a tablas */

DENY INSERT, UPDATE, DELETE
ON dbo.Evaluaciones
TO rol_registro;
GO


/* ============================================================
   8. PERMISOS DEL ROL OPERADOR
   Consultas y ejecución de reportes.
   ============================================================ */

GRANT SELECT ON dbo.Evaluaciones TO rol_operador;
GRANT SELECT ON dbo.Profesores TO rol_operador;
GRANT SELECT ON dbo.Cursos TO rol_operador;
GRANT SELECT ON dbo.Estudiantes TO rol_operador;
GO

IF OBJECT_ID('dbo.sp_ReporteTopProfesores') IS NOT NULL
    GRANT EXECUTE ON dbo.sp_ReporteTopProfesores
    TO rol_operador;
GO

IF OBJECT_ID('dbo.sp_ArchivarEvaluacionesAntiguas') IS NOT NULL
    GRANT EXECUTE ON dbo.sp_ArchivarEvaluacionesAntiguas
    TO rol_operador;
GO


/* ============================================================
   9. DENEGACIONES EXPLÍCITAS
   Aplicación del principio de menor privilegio.
   ============================================================ */

DENY INSERT, UPDATE, DELETE
ON dbo.Profesores
TO rol_consulta;

DENY INSERT, UPDATE, DELETE
ON dbo.Cursos
TO rol_consulta;

DENY INSERT, UPDATE, DELETE
ON dbo.Departamentos
TO rol_consulta;
GO


/* ============================================================
   10. CONSULTAS DE VERIFICACIÓN
   ============================================================ */

-- Usuarios creados
SELECT name, type_desc
FROM sys.database_principals
WHERE principal_id > 4;

-- Roles creados
SELECT name, type_desc
FROM sys.database_principals
WHERE type = 'R';

-- Miembros de roles
SELECT
    DP1.name AS Rol,
    DP2.name AS Usuario
FROM sys.database_role_members DRM
INNER JOIN sys.database_principals DP1
    ON DRM.role_principal_id = DP1.principal_id
INNER JOIN sys.database_principals DP2
    ON DRM.member_principal_id = DP2.principal_id;
GO
