/* ============================================================
   DATOS DE PRUEBA - RateMyProfessorDB 
   ============================================================ */
USE RateMyProfessorDB;
GO

---------------------------------------------------------------
-- 1. DEPARTAMENTOS
---------------------------------------------------------------
INSERT INTO dbo.Departamentos (Nombre, Descripcion, Activo) VALUES
('Ingeniería en Sistemas', 'Carreras de software, redes y bases de datos', 1),
('Medicina', 'Ciencias médicas y de la salud', 1),
('Derecho', 'Ciencias jurídicas y legislación', 1),
('Administración de Empresas', 'Gestión, finanzas y emprendimiento', 1),
('Psicología', 'Ciencias del comportamiento y salud mental', 1),
('Arquitectura', 'Diseño, construcción y urbanismo', 1),
('Contaduría Pública', 'Contabilidad, auditoría y finanzas', 1),
('Ingeniería Civil', 'Construcción e infraestructura', 1);
GO

---------------------------------------------------------------
-- 2. SEMESTRES
---------------------------------------------------------------
INSERT INTO dbo.Semestres (Anio, Periodo, Activo) VALUES
(2024, 'I Semestre', 0),
(2024, 'II Semestre', 0),
(2025, 'I Semestre', 0),
(2025, 'II Semestre', 0),
(2026, 'I Semestre', 1),
(2026, 'II Semestre', 1),
(2023, 'I Semestre', 0),
(2023, 'II Semestre', 0);
GO

---------------------------------------------------------------
-- 3. PROFESORES 
---------------------------------------------------------------
INSERT INTO dbo.Profesores (DepartamentoID, Nombres, Apellidos, TituloAcademico, Especialidad, Email, Activo) VALUES
(1, 'Carlos Alberto', 'Mendoza López', 'Dr.', 'Bases de Datos y Minería de Datos', 'carlos.mendoza@uan.edu.ni', 1),
(1, 'Ana María', 'Rodríguez Pérez', 'MSc.', 'Desarrollo de Software y Arquitectura', 'ana.rodriguez@uan.edu.ni', 1),
(1, 'Roberto', 'Calderón Gómez', 'Ing.', 'Inteligencia Artificial', 'roberto.calderon@uan.edu.ni', 1),
(2, 'Elena', 'Vargas Castillo', 'Dra.', 'Medicina Interna', 'elena.vargas@uan.edu.ni', 1),
(2, 'Miguel Ángel', 'Herrera Ruiz', 'Dr.', 'Cirugía General', 'miguel.herrera@uan.edu.ni', 1),
(3, 'Patricia', 'López Martínez', 'MSc.', 'Derecho Constitucional', 'patricia.lopez@uan.edu.ni', 1),
(3, 'José Luis', 'Martínez Sánchez', 'Lic.', 'Derecho Penal', 'jose.martinez@uan.edu.ni', 1),
(4, 'Lucía', 'Gutiérrez Ramos', 'Dra.', 'Finanzas Corporativas', 'lucia.gutierrez@uan.edu.ni', 1),
(4, 'Fernando', 'Rojas Delgado', 'MSc.', 'Marketing Digital', 'fernando.rojas@uan.edu.ni', 1),
(5, 'Daniela', 'Cruz Mendoza', 'Dra.', 'Psicología Clínica', 'daniela.cruz@uan.edu.ni', 1),
(5, 'Andrés', 'Pineda López', 'MSc.', 'Psicología Organizacional', 'andres.pineda@uan.edu.ni', 1),
(6, 'Camila', 'Torres Vega', 'Arq.', 'Diseño Arquitectónico', 'camila.torres@uan.edu.ni', 1),
(1, 'Ricardo', 'Navarro Flores', 'MSc.', 'Redes y Seguridad Informática', 'ricardo.navarro@uan.edu.ni', 1),
(2, 'Sofía', 'Mendoza Ruiz', 'Dra.', 'Pediatría', 'sofia.mendoza@uan.edu.ni', 1),
(3, 'Alejandro', 'Vega Castro', 'Lic.', 'Derecho Laboral', 'alejandro.vega@uan.edu.ni', 1),
(4, 'Valeria', 'Ramos Delgado', 'MSc.', 'Gestión de Recursos Humanos', 'valeria.ramos@uan.edu.ni', 1),
(1, 'Luis Fernando', 'García López', 'Dr.', 'Ingeniería de Software', 'luis.garcia@uan.edu.ni', 1),
(5, 'Mariana', 'Salazar Pineda', 'MSc.', 'Neuropsicología', 'mariana.salazar@uan.edu.ni', 1),
(6, 'Sebastián', 'Ortega Mendoza', 'Arq.', 'Urbanismo y Planificación', 'sebastian.ortega@uan.edu.ni', 1),
(2, 'Gabriela', 'Reyes Castillo', 'Dra.', 'Ginecología y Obstetricia', 'gabriela.reyes@uan.edu.ni', 1),
(3, 'Oscar', 'Molina Vargas', 'Lic.', 'Derecho Internacional', 'oscar.molina@uan.edu.ni', 1),
(4, 'Claudia', 'Benítez Ramos', 'MSc.', 'Contabilidad Gerencial', 'claudia.benitez@uan.edu.ni', 1),
(1, 'Jorge', 'Pérez Navarro', 'Ing.', 'Ciberseguridad', 'jorge.perez@uan.edu.ni', 1),
(5, 'Laura', 'Jiménez Salazar', 'Dra.', 'Psicología Educativa', 'laura.jimenez@uan.edu.ni', 1),
(6, 'Mateo', 'Castro Ortega', 'Arq.', 'Arquitectura Sostenible', 'mateo.castro@uan.edu.ni', 1);
GO

---------------------------------------------------------------
-- 4. ESTUDIANTES 
---------------------------------------------------------------
INSERT INTO dbo.Estudiantes (CodigoEstudiante, Nombres, Apellidos, Carrera, EmailInstitucional, Activo) VALUES
('20241001', 'María Fernanda', 'López García', 'Ingeniería en Sistemas', 'maria.lopez@est.uan.edu.ni', 1),
('20241002', 'Juan Carlos', 'Pérez Mendoza', 'Medicina', 'juan.perez@est.uan.edu.ni', 1),
('20241003', 'Sofía Alejandra', 'Ramírez Cruz', 'Derecho', 'sofia.ramirez@est.uan.edu.ni', 1),
('20241004', 'Diego Armando', 'Torres Ruiz', 'Ingeniería en Sistemas', 'diego.torres@est.uan.edu.ni', 1),
('20241005', 'Valeria', 'Castro López', 'Administración de Empresas', 'valeria.castro@est.uan.edu.ni', 1),
('20241006', 'Andrés Felipe', 'Morales Vega', 'Ingeniería en Sistemas', 'andres.morales@est.uan.edu.ni', 1),
('20241007', 'Camila', 'Rojas Delgado', 'Psicología', 'camila.rojas@est.uan.edu.ni', 1),
('20241008', 'Luis Alberto', 'Navarro Pineda', 'Medicina', 'luis.navarro@est.uan.edu.ni', 1),
('20241009', 'Isabella', 'Cruz Mendoza', 'Derecho', 'isabella.cruz@est.uan.edu.ni', 1),
('20241010', 'Mateo', 'Vega Salazar', 'Arquitectura', 'mateo.vega@est.uan.edu.ni', 1),
('20241011', 'Laura Daniela', 'Gutiérrez Ramos', 'Ingeniería en Sistemas', 'laura.gutierrez@est.uan.edu.ni', 1),
('20241012', 'Sebastián', 'Mendoza Ruiz', 'Contaduría Pública', 'sebastian.mendoza@est.uan.edu.ni', 1),
('20241013', 'Ana Lucía', 'Pineda Castro', 'Psicología', 'ana.pineda@est.uan.edu.ni', 1),
('20241014', 'Carlos Eduardo', 'Ramos Delgado', 'Ingeniería Civil', 'carlos.ramos@est.uan.edu.ni', 1),
('20241015', 'Mariana', 'Salazar Vega', 'Medicina', 'mariana.salazar@est.uan.edu.ni', 1),
('20241016', 'José Miguel', 'Ortega López', 'Derecho', 'jose.ortega@est.uan.edu.ni', 1),
('20241017', 'Gabriela', 'Benítez Ramos', 'Administración de Empresas', 'gabriela.benitez@est.uan.edu.ni', 1),
('20241018', 'Alejandro', 'Jiménez Salazar', 'Ingeniería en Sistemas', 'alejandro.jimenez@est.uan.edu.ni', 1),
('20241019', 'Daniela', 'Castro Ortega', 'Arquitectura', 'daniela.castro@est.uan.edu.ni', 1),
('20241020', 'Ricardo', 'Navarro Flores', 'Contaduría Pública', 'ricardo.navarro@est.uan.edu.ni', 1),
('20241021', 'Paula Andrea', 'Molina Vargas', 'Psicología', 'paula.molina@est.uan.edu.ni', 1),
('20241022', 'Oscar David', 'Reyes Castillo', 'Ingeniería Civil', 'oscar.reyes@est.uan.edu.ni', 1),
('20241023', 'Claudia', 'Pérez Navarro', 'Derecho', 'claudia.perez@est.uan.edu.ni', 1),
('20241024', 'Fernando', 'García López', 'Ingeniería en Sistemas', 'fernando.garcia@est.uan.edu.ni', 1),
('20241025', 'Valentina', 'Ruiz Mendoza', 'Medicina', 'valentina.ruiz@est.uan.edu.ni', 1),
('20241026', 'Emilio', 'Salazar Pineda', 'Administración de Empresas', 'emilio.salazar@est.uan.edu.ni', 1),
('20241027', 'Renata', 'Vega Castro', 'Psicología', 'renata.vega@est.uan.edu.ni', 1),
('20241028', 'Tomás', 'Cruz Delgado', 'Ingeniería en Sistemas', 'tomas.cruz@est.uan.edu.ni', 1),
('20241029', 'Lucía', 'Mendoza Ruiz', 'Derecho', 'lucia.mendoza@est.uan.edu.ni', 1),
('20241030', 'Bruno', 'Torres Vega', 'Arquitectura', 'bruno.torres@est.uan.edu.ni', 1),
('20241031', 'Sara', 'Navarro Pineda', 'Contaduría Pública', 'sara.navarro@est.uan.edu.ni', 1),
('20241032', 'Iván', 'Ramos Salazar', 'Ingeniería Civil', 'ivan.ramos@est.uan.edu.ni', 1),
('20241033', 'Nicole', 'Castro López', 'Psicología', 'nicole.castro@est.uan.edu.ni', 1),
('20241034', 'Pablo', 'Gutiérrez Ramos', 'Ingeniería en Sistemas', 'pablo.gutierrez@est.uan.edu.ni', 1),
('20241035', 'Antonella', 'Vega Mendoza', 'Medicina', 'antonella.vega@est.uan.edu.ni', 1),
('20241036', 'Matías', 'Pineda Ortega', 'Derecho', 'matias.pineda@est.uan.edu.ni', 1),
('20241037', 'Regina', 'Salazar Delgado', 'Administración de Empresas', 'regina.salazar@est.uan.edu.ni', 1),
('20241038', 'Thiago', 'Molina Cruz', 'Ingeniería en Sistemas', 'thiago.molina@est.uan.edu.ni', 1),
('20241039', 'Julieta', 'Benítez Vega', 'Arquitectura', 'julieta.benitez@est.uan.edu.ni', 1),
('20241040', 'Liam', 'Ortega Ramos', 'Contaduría Pública', 'liam.ortega@est.uan.edu.ni', 1);
GO

---------------------------------------------------------------
-- 5. CURSOS 
---------------------------------------------------------------
INSERT INTO dbo.Cursos (DepartamentoID, CodigoCurso, Nombre, Creditos, Activo) VALUES
(1, 'IS-301', 'Administración y Gestión de Bases de Datos', 4, 1),
(1, 'IS-205', 'Programación Orientada a Objetos II', 3, 1),
(1, 'IS-450', 'Inteligencia Artificial Aplicada', 4, 1),
(1, 'IS-320', 'Redes y Comunicaciones', 3, 1),
(2, 'ME-401', 'Fisiología Humana', 5, 1),
(2, 'ME-310', 'Anatomía', 4, 1),
(2, 'ME-520', 'Medicina Interna', 4, 1),
(3, 'DE-220', 'Derecho Constitucional', 3, 1),
(3, 'DE-350', 'Derecho Penal', 3, 1),
(3, 'DE-410', 'Derecho Laboral', 3, 1),
(4, 'AE-110', 'Finanzas Corporativas', 3, 1),
(4, 'AE-250', 'Marketing Estratégico', 3, 1),
(4, 'AE-380', 'Gestión de Recursos Humanos', 3, 1),
(5, 'PS-201', 'Psicología General', 3, 1),
(5, 'PS-340', 'Psicología Clínica', 4, 1),
(6, 'AR-150', 'Diseño Arquitectónico I', 4, 1),
(6, 'AR-280', 'Urbanismo', 3, 1),
(7, 'CP-120', 'Contabilidad General', 3, 1),
(7, 'CP-310', 'Auditoría', 3, 1),
(8, 'IC-210', 'Mecánica de Suelos', 3, 1),
(1, 'IS-380', 'Ingeniería de Software', 4, 1),
(2, 'ME-450', 'Farmacología', 3, 1),
(3, 'DE-480', 'Derecho Internacional', 3, 1),
(4, 'AE-420', 'Emprendimiento', 3, 1),
(5, 'PS-410', 'Psicología Organizacional', 3, 1),
(6, 'AR-320', 'Arquitectura Sostenible', 3, 1),
(1, 'IS-290', 'Estructuras de Datos', 3, 1),
(2, 'ME-380', 'Patología', 4, 1),
(3, 'DE-305', 'Derecho Civil', 3, 1),
(4, 'AE-305', 'Contabilidad de Costos', 3, 1);
GO

---------------------------------------------------------------
-- 6. ASIGNACIONES PROFESOR-CURSO
---------------------------------------------------------------
INSERT INTO dbo.AsignacionesProfesorCurso (ProfesorID, CursoID, SemestreID, Seccion) VALUES
(1, 1, 5, 'A'), (1, 21, 5, 'A'),
(2, 2, 5, 'A'), (2, 27, 5, 'B'),
(3, 3, 5, 'A'),
(4, 5, 5, 'A'), (4, 22, 5, 'A'),
(5, 6, 5, 'A'),
(6, 8, 5, 'A'), (6, 23, 5, 'B'),
(7, 9, 5, 'A'),
(8, 11, 5, 'A'), (8, 24, 5, 'A'),
(9, 12, 5, 'A'),
(10, 14, 5, 'A'),
(11, 15, 5, 'A'),
(12, 16, 5, 'A'),
(13, 4, 5, 'A'),
(14, 7, 5, 'A'),
(15, 10, 5, 'A'),
(16, 13, 5, 'A'),
(17, 20, 5, 'A'),
(18, 25, 5, 'A'),
(19, 26, 5, 'A'),
(20, 28, 5, 'A'),
(21, 29, 5, 'A'),
(22, 30, 5, 'A'),
(23, 19, 5, 'A'),
(24, 17, 5, 'A'),
(25, 18, 5, 'A');

INSERT INTO dbo.AsignacionesProfesorCurso (ProfesorID, CursoID, SemestreID, Seccion) VALUES
(1, 1, 4, 'A'), (2, 2, 4, 'A'), (3, 3, 4, 'A'),
(4, 5, 4, 'A'), (5, 6, 4, 'A'), (6, 8, 4, 'A'),
(7, 9, 4, 'A'), (8, 11, 4, 'A'), (9, 12, 4, 'A'),
(10, 14, 3, 'A'), (11, 15, 3, 'A'), (12, 16, 3, 'A'),
(13, 4, 3, 'A'), (14, 7, 3, 'A'), (15, 10, 3, 'A'),
(16, 13, 2, 'A'), (17, 20, 2, 'A'), (18, 25, 2, 'A'),
(19, 26, 1, 'A'), (20, 28, 1, 'A'), (21, 29, 1, 'A'),
(1, 21, 6, 'A'), (2, 27, 6, 'A'), (3, 3, 6, 'A'),
(4, 22, 6, 'A'), (5, 6, 6, 'A'), (6, 23, 6, 'A');
GO

---------------------------------------------------------------
-- 7. EVALUACIONES
---------------------------------------------------------------

INSERT INTO dbo.Evaluaciones 
    (EstudianteID, AsignacionID, CalidadGeneral, Claridad, Dificultad, Utilidad, Comentario, EsAnonima)
VALUES
(1, 1, 4.8, 4.9, 3.5, 4.7, 'Excelente profesor, explica muy claro los conceptos de bases de datos.', 1),
(1, 2, 4.5, 4.2, 4.0, 4.6, 'Muy buen dominio del tema. Las prácticas son útiles.', 0),
(2, 3, 4.2, 3.8, 4.5, 4.0, 'El curso es desafiante pero se aprende mucho.', 1),
(2, 4, 3.8, 4.1, 3.0, 3.5, 'El contenido es bueno pero a veces va muy rápido.', 1),
(3, 5, 4.9, 4.8, 4.2, 4.9, 'La profesora es excepcional. Clases muy bien preparadas.', 0),
(3, 6, 4.7, 4.6, 3.8, 4.8, 'Fascinante el tema de IA. Proyectos interesantes.', 1),
(4, 1, 5.0, 5.0, 3.0, 5.0, 'El mejor profesor de la carrera. Aprendí muchísimo.', 1),
(4, 7, 4.3, 4.4, 3.5, 4.1, 'Muy buena profesora, temario actualizado.', 0),
(5, 2, 3.5, 3.2, 4.8, 3.8, 'Difícil pero justo. Hay que estudiar mucho.', 1),
(5, 8, 4.6, 4.5, 3.2, 4.4, 'Excelente en finanzas, casos reales muy buenos.', 1),
(6, 3, 4.1, 4.0, 4.3, 4.2, 'Buen profesor, explica bien los conceptos.', 0),
(6, 9, 4.8, 4.7, 3.5, 4.6, 'Muy claro y organizado. Recomendado.', 1),
(7, 4, 3.9, 3.7, 4.1, 3.8, 'El curso es pesado pero necesario.', 1),
(7, 10, 4.4, 4.3, 3.8, 4.2, 'Buena metodología de enseñanza.', 0),
(8, 5, 4.7, 4.8, 3.9, 4.5, 'Excelente profesora. Muy dedicada.', 1),
(8, 11, 4.2, 4.0, 4.5, 4.1, 'El tema es complejo pero lo explica bien.', 1),
(9, 6, 4.5, 4.4, 4.0, 4.3, 'Muy interesante el curso de IA.', 0),
(9, 12, 3.8, 3.5, 4.2, 3.7, 'A veces las explicaciones son confusas.', 1),
(10, 7, 4.6, 4.5, 3.7, 4.4, 'Buen profesor, clases dinámicas.', 1),
(10, 13, 4.3, 4.2, 3.9, 4.1, 'Contenido actualizado y relevante.', 0),
(11, 14, 4.3, 4.2, 3.9, 4.1, 'Buena metodología.', 0),
(12, 15, 4.8, 4.7, 3.5, 4.6, 'Excelente profesora.', 1),
(13, 16, 4.1, 4.0, 4.2, 3.9, 'El curso es interesante.', 1),
(14, 17, 4.6, 4.5, 3.8, 4.4, 'Muy buen profesor.', 0),
(15, 18, 3.8, 3.6, 4.5, 3.7, 'Difícil pero justo.', 1),
(16, 19, 4.4, 4.3, 3.7, 4.2, 'Clases muy dinámicas.', 1),
(17, 20, 4.7, 4.6, 3.4, 4.5, 'Excelente en su área.', 0),
(18, 21, 4.2, 4.1, 3.9, 4.0, 'Buen contenido.', 1),
(19, 22, 4.5, 4.4, 3.6, 4.3, 'Profesor muy claro.', 1),
(20, 23, 3.9, 3.7, 4.4, 3.8, 'Requiere dedicación.', 0);

-- ============================================================
-- INSERCIÓN DINÁMICA SEGURA 
-- ============================================================

;WITH CombinacionesUnicas AS (
    SELECT 
        e.EstudianteID,
        a.AsignacionID
    FROM dbo.Estudiantes e
    CROSS JOIN dbo.AsignacionesProfesorCurso a
)
INSERT INTO dbo.Evaluaciones 
    (EstudianteID, AsignacionID, CalidadGeneral, Claridad, Dificultad, Utilidad, Comentario, EsAnonima)
SELECT TOP (150)
    c.EstudianteID,
    c.AsignacionID,
    ROUND(RAND(CHECKSUM(NEWID())) * 1.5 + 3.5, 2),   -- CalidadGeneral
    ROUND(RAND(CHECKSUM(NEWID())) * 1.5 + 3.5, 2),   -- Claridad
    ROUND(RAND(CHECKSUM(NEWID())) * 1.5 + 3.5, 2),   -- Dificultad
    ROUND(RAND(CHECKSUM(NEWID())) * 1.5 + 3.5, 2),   -- Utilidad
    CASE WHEN RAND(CHECKSUM(NEWID())) > 0.35 
         THEN 'Buen profesor, contenido interesante y bien explicado.' 
         ELSE NULL END,                               -- Comentario
    CASE WHEN RAND(CHECKSUM(NEWID())) > 0.45 THEN 1 ELSE 0 END   -- EsAnonima
FROM CombinacionesUnicas c
WHERE NOT EXISTS (
    SELECT 1 
    FROM dbo.Evaluaciones ev 
    WHERE ev.EstudianteID = c.EstudianteID 
      AND ev.AsignacionID = c.AsignacionID
)
ORDER BY NEWID();
GO

PRINT 'Datos de prueba insertados correctamente.';
GO
