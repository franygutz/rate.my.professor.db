USE RateMyProfessorDB;
GO

IF EXISTS (
    SELECT *
    FROM sys.server_event_sessions
    WHERE name = 'XE_MonitoreoRateMyProfessor'
)
DROP EVENT SESSION XE_MonitoreoRateMyProfessor
ON SERVER;
GO

CREATE EVENT SESSION XE_MonitoreoRateMyProfessor
ON SERVER

ADD EVENT sqlserver.error_reported
(
    ACTION
    (
        sqlserver.sql_text,
        sqlserver.username,
        sqlserver.database_name
    )
    WHERE ([severity] >= 11)
)

ADD TARGET package0.ring_buffer;
GO

ALTER EVENT SESSION XE_MonitoreoRateMyProfessor
ON SERVER
STATE = START;
GO