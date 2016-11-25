--Triggers
CREATE TRIGGER tr_delChat 
ON LineaChat
AFTER DELETE
AS
BEGIN
INSERT INTO Chat_Historico(fecha, idUsuario, texto)
VALUES((SELECT fecha from DELETED), (SELECT idUsuario FROM deleted), (SELECT texto FROM deleted))
END


CREATE TRIGGER tr_delCom
ON Comentario
AFTER DELETE AS
BEGIN
	INSERT INTO Comentario_Historico(fecha, idUsuario, texto)
	VALUES((SELECT fecha from DELETED), (SELECT idUsuario FROM deleted), (SELECT texto FROM deleted))
END


CREATE TRIGGER tr_delPub
ON Publicacion
AFTER DELETE
AS
BEGIN
	INSERT INTO Publicacion_Historico(fecha, idUsuario, texto)
	VALUES((SELECT fecha from DELETED), (SELECT idUsuario FROM deleted), (SELECT texto FROM deleted))
END




--Auditoría de publicaciones
CREATE TRIGGER tr_palabrasPublicacion
ON Publicacion
AFTER INSERT AS 
BEGIN
DECLARE @palabras VARCHAR(50)
SET @palabras = null
DECLARE c_datos CURSOR FOR
(SELECT palabra 
FROM PalabraProhibida)
OPEN c_datos
WHILE 1=1	
BEGIN
	FETCH NEXT FROM c_datos INTO @palabras
	IF @palabras IN (SELECT * FROM dbo.Split(' ', (SELECT texto FROM inserted)))
	BEGIN
		INSERT INTO Faltas
		VALUES(getdate(), (SELECT idUsuario FROM inserted))	
		INSERT INTO Publicacion_Historico
		VALUES((SELECT fecha FROM inserted), (SELECT idUsuario FROM inserted), (SELECT texto FROM inserted))
		print @palabras
	END	
	IF @@FETCH_STATUS != 0
	BEGIN
		BREAK
	END
END
CLOSE c_datos
DEALLOCATE c_datos
END


CREATE TRIGGER tr_palabrasPublicacion2
ON Publicacion
AFTER UPDATE AS 
BEGIN
DECLARE @palabras VARCHAR(50)
SET @palabras = null
DECLARE c_datos CURSOR FOR
(SELECT palabra 
FROM PalabraProhibida)
OPEN c_datos
WHILE 1=1
BEGIN
	FETCH NEXT FROM c_datos INTO @palabras
	IF @palabras IN (SELECT * FROM dbo.Split(' ', (SELECT texto FROM inserted)))
	BEGIN
		INSERT INTO Faltas
		VALUES(getdate(), (SELECT idUsuario FROM inserted))	
		INSERT INTO Publicacion_Historico
		VALUES((SELECT fecha FROM inserted), (SELECT idUsuario FROM inserted), (SELECT texto FROM inserted))
		print @palabras
	END	
	IF @@FETCH_STATUS != 0
	BEGIN
		BREAK
	END
END
CLOSE c_datos
DEALLOCATE c_datos
END




--Auditoria de comentarios de fotos
CREATE TRIGGER tr_palabrasComentario
ON Comentario
AFTER INSERT AS 
BEGIN
DECLARE @palabras VARCHAR(50)
SET @palabras = null
DECLARE c_datos CURSOR FOR
(SELECT palabra 
FROM PalabraProhibida)
OPEN c_datos
WHILE 1=1	
BEGIN
	FETCH NEXT FROM c_datos INTO @palabras
	IF @palabras IN (SELECT * FROM dbo.Split(' ', (SELECT texto FROM inserted)))
	BEGIN
		INSERT INTO Faltas
		VALUES(getdate(), (SELECT idUsuario FROM inserted))	
		INSERT INTO Comentario_Historico
		VALUES((SELECT fecha FROM inserted), (SELECT idUsuario FROM inserted), (SELECT texto FROM inserted))
		print @palabras
	END	
	IF @@FETCH_STATUS != 0
	BEGIN
		BREAK
	END
END
CLOSE c_datos
DEALLOCATE c_datos
END

--Chat historico luego de 3 meses
CREATE PROCEDURE prc_storeOldChat
AS
DECLARE @texto VARCHAR(200),
	      @fecha DATETIME,
	      @idUsuario BIGINT,
	      @idChat BIGINT
DECLARE cursChat cursor for
	SELECT fecha, idUsuario, texto, idChat FROM LineaChat
OPEN cursChat
FETCH NEXT FROM cursChat into @fecha, @idUsuario, @texto, @idChat
WHILE @@Fetch_Status = 0 BEGIN
IF @fecha	<= DATEADD(mm, -3, GETDATE())
	BEGIN
		INSERT INTO Chat_Historico(fecha, idUsuario, texto, idChat) Values(@fecha, @idUsuario, @texto, @idChat)
	END
FETCH NEXT FROM cursChat into @fecha, @idUsuario, @texto, @idChat
CLOSE cursChat
Deallocate cursChat
END
GO


--Trigger de conexiones
CREATE TRIGGER tr_conexion
ON usuario
AFTER UPDATE AS
BEGIN
	DECLARE @idUsuario BIGINT
	DECLARE @estado SMALLINT


	SET @idUsuario = (SELECT idUsuario FROM inserted)
	SET @estado = (SELECT estado FROM inserted)
	IF @estado = 1
	BEGIN
		INSERT INTO conexion
		VALUES(@idUsuario, GETDATE())
	END


END