CREATE TABLE Users (
    id INT PRIMARY KEY IDENTITY(1,1),
    [user] VARCHAR(100)
);

SELECT * FROM Users;

DELETE FROM USERS WHERE ID = 2;

CREATE TABLE UserLogs (
	id int primary key identity(1,1),
	[action] varchar(100),
	[user] varchar(100),
	[date] datetime
);

DELETE FROM UserLogs WHERE id = 1;

/*PARA QUE FUNCIONE*/
SELECT * FROM UserLogs;


CREATE TRIGGER trigger_delete_users ON Users
AFTER 
	DELETE
AS
BEGIN
	INSERT INTO UserLogs ([action], [user], [date])
	VALUES ('DELETE', SUSER_NAME(), SYSDATETIME())
END;

/* CREAR UN TRIGGER PARA LA TABLA USERS CUANDO SE ACTUALICE UN REGISTRO */

CREATE TABLE Sky (
	id int primary key identity(1,1),
	[action] varchar(100),
	[user] varchar(100),
	[date] datetime
);

DELETE FROM Sky WHERE id = 1;

/* CODIGO PARA QUE MUESTRE */
SELECT * FROM Sky;

ALTER TRIGGER trigger_update_user ON Sky
AFTER 
	UPDATE
AS
	INSERT INTO Sky ([action], [user], [date])
	VALUES ('UPDATE', SUSER_NAME(), SYSDATETIME())
GO

UPDATE Sky SET [user] = ' Maria' WHERE id = 1;


/*OTRO TEMA*/

	declare @numero1 int = 30
	declare @numero2 int = 20

	declare @suma int = @numero1 + @numero2

	print 'la suma es: '
	print @suma

/* sql*/

DECLARE @sql VARCHAR(200) = 
'INSERT INTO UserLogs([action], [user], [date])
 VALUES(''UPDATE'', SUSER_NAME(), SYSDATETIME())';

PRINT @sql;
GO

SELECT 
    id,
    [action],
    [user],
    [date],
    CASE 
        WHEN [action] = 'DELETE' THEN 'Se eliminó un usuario'
        WHEN [action] = 'UPDATE' THEN 'Se actualizó un usuario'
        WHEN [action] = 'INSERT' THEN 'Se insertó un usuario'
        ELSE 'Acción desconocida'
    END AS DescripcionAccion
FROM Sky;

SELECT * FROM Sky;

/* EJERCICIO DE ELEGIR DELETE O UPDATE  */

CREATE TABLE Usuarioss (
    id INT PRIMARY KEY IDENTITY(1,1),
    [user] VARCHAR(100)
);

INSERT INTO Usuarioss([user]) VALUES ('Jheremy'), ('Andres'), ('Cielo');
SELECT * FROM Usuarioss;

CREATE TABLE AccionesLogs (
	id INT PRIMARY KEY IDENTITY(1,1),
	[action] VARCHAR(100),
	[user] VARCHAR(100),
	[date] DATETIME
);
SELECT * FROM AccionesLogs;

CREATE TRIGGER trigger_update_delete_users  
ON Usuarioss
AFTER UPDATE, DELETE
AS
BEGIN
    DECLARE @accion VARCHAR(10);

    IF EXISTS (SELECT 1 FROM deleted) AND EXISTS (SELECT 1 FROM inserted)
        SET @accion = 'UPDATE';
    ELSE IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
        SET @accion = 'DELETE';

    INSERT INTO AccionesLogs ([action], [user], [date])
    VALUES (@accion, SUSER_NAME(), SYSDATETIME());
END;
GO

UPDATE Usuarioss SET [user] = 'Maria Actualizada' WHERE id = 3;

DELETE FROM Usuarioss WHERE id = 2;

SELECT 
    id,
    [action],
    [user],
    [date],
    CASE 
        WHEN [action] = 'DELETE' THEN 'Se eliminó un usuario'
        WHEN [action] = 'UPDATE' THEN 'Se actualizó un usuario'
        ELSE 'Acción desconocida'
    END AS DescripcionAccion
FROM AccionesLogs;

SELECT * FROM AccionesLogs;
