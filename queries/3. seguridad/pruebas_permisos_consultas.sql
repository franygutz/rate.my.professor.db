-- Pruebas realizadas a cada uno de los logins
-- =============================
-- OJO: este script NO está hecho para ser ejecutado de una, se debe acceder
-- a cada login distinto para probar si los permisos son correctos.


-- ==========================================
-- dba
-- ==========================================
EXECUTE AS USER = 'usr_dba';

-- Debe FUNCIONAR todo
USE RateMyProfessorDB
SELECT * FROM dbo.Evaluaciones;
INSERT INTO dbo.Departamentos (Nombre, Descripcion) VALUES ('Prueba DBA', 'Departamento de prueba');
UPDATE dbo.Profesores SET Activo = 0 WHERE ProfesorID = 25;
DELETE FROM dbo.Departamentos WHERE Nombre = 'Prueba DBA';

-- También puede crear objetos, hacer backups, etc.
USE RateMyProfessorDB
BACKUP DATABASE RateMyProfessorDB 
TO DISK = 'C:\Backups\RateMyProfessorDB_Prueba.bak' 
WITH INIT;

REVERT;
GO

-- ==========================================
-- operador
-- ==========================================
EXECUTE AS USER = 'usr_operador';

-- Debe FUNCIONAR
USE RateMyProfessorDB
SELECT * FROM dbo.Evaluaciones;
SELECT * FROM dbo.Profesores;
SELECT * FROM dbo.Estudiantes;
SELECT * FROM dbo.Cursos;

-- Ejecutar procedimientos de reporte 
EXEC dbo.sp_ReporteTopProfesores;
EXEC dbo.sp_ArchivarEvaluacionesAntiguas;   

-- Debe FALLAR (no tiene permisos de modificación en la mayoría de tablas
USE RateMyProfessorDB
DELETE FROM dbo.Evaluaciones WHERE EvaluacionID = 2;

REVERT;
GO

-- ==========================================
-- registro
-- ==========================================

EXECUTE AS USER = 'usr_registro';

-- Debe FUNCIONAR (ejecutar el procedimiento)
USE RateMyProfessorDB
EXEC dbo.sp_InsertarEvaluacion 
    @EstudianteID = 5,
    @AsignacionID = 12,
    @CalidadGeneral = 4.5,
    @Claridad = 4.7,
    @Dificultad = 3.8,
    @Utilidad = 4.6,
    @Comentario = 'Prueba de permisos desde rol_registro',
    @EsAnonima = 1;

-- Debe FALLAR (no puede insertar directamente)
USE RateMyProfessorDB
INSERT INTO dbo.Evaluaciones (EstudianteID, AsignacionID, CalidadGeneral, Claridad, Dificultad, Utilidad)
VALUES (5, 11, 4.0, 4.0, 4.0, 4.0);

-- Debe FALLAR (no puede hacer SELECT ni UPDATE en Evaluaciones)
USE RateMyProfessorDB
SELECT * FROM dbo.Evaluaciones;
UPDATE dbo.Evaluaciones SET Comentario = 'Hackeado' WHERE EvaluacionID = 1;

REVERT;
GO
