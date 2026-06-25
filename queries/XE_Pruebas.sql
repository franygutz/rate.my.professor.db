USE RateMyProfessorDB;
GO

/* Generar error de prueba */
BEGIN TRY
    SELECT * FROM TablaQueNoExiste;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
GO

/* Consultar eventos capturados */
WITH Eventos AS
(
    SELECT
        CAST(st.target_data AS XML) AS TargetData
    FROM sys.dm_xe_session_targets st
    INNER JOIN sys.dm_xe_sessions s
        ON st.event_session_address = s.address
    WHERE s.name = 'XE_MonitoreoRateMyProfessor'
)
SELECT TargetData
FROM Eventos;
GO