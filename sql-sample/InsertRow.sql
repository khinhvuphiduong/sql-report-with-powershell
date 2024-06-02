CREATE TABLE dbo.DatabaseStatus (
    ServerName nvarchar(255),
    DatabaseName nvarchar(255),
    State nvarchar(50),
    RecoveryMode nvarchar(50),
    LastFullBackup datetime,
    DaysSinceLastFull float,
    DaysSinceLastDiff float
);

INSERT INTO dbo.DatabaseStatus (ServerName, DatabaseName, State, RecoveryMode, LastFullBackup, DaysSinceLastFull, DaysSinceLastDiff)
VALUES ('Server1', 'DB1', 'ONLINE', 'FULL', '2024-05-01 12:00:00', 1.0, 0.5);

INSERT INTO dbo.DatabaseStatus (ServerName, DatabaseName, State, RecoveryMode, LastFullBackup, DaysSinceLastFull, DaysSinceLastDiff)
VALUES ('Server2', 'DB2', 'OFFLINE', 'SIMPLE', '2024-04-25 12:00:00', 7.0, 3.0);

INSERT INTO dbo.DatabaseStatus (ServerName, DatabaseName, State, RecoveryMode, LastFullBackup, DaysSinceLastFull, DaysSinceLastDiff)
VALUES ('Server3', 'DB3', 'ONLINE', 'BULK_LOGGED', '2024-05-10 12:00:00', 0.0, 0.0);
