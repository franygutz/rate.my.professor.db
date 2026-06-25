SELECT
    event_time AS [Fecha del Evento],
    action_id AS [ID de Acción],
    succeeded AS [Éxito],
    server_principal_name AS [Usuario],
    database_name AS [Base de Datos],
    object_name AS [Objeto Afectado],
    statement AS [Sentencia Ejecutada]
FROM sys.fn_get_audit_file('C:\SQLAudit\*', DEFAULT, DEFAULT)
ORDER BY event_time DESC;