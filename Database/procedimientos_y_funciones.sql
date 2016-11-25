CREATE FUNCTION [dbo].[Split] (@sep VARCHAR(32), @s VARCHAR(MAX))
RETURNS TABLE
AS
    RETURN
    (
        SELECT r.value('.','VARCHAR(MAX)') as Item
        FROM (SELECT CONVERT(XML, N'<root><r>' + REPLACE(REPLACE(REPLACE(@s,'& ','&amp; '),'<','&lt;'), @sep, '</r><r>') + '</r></root>') as valxml) x
        CROSS APPLY x.valxml.nodes('//root/r') AS RECORDS(r)
    )


--PROCEDURES
CREATE procedure prc_UserState(@estado SMALLINT)
AS
BEGIN
SELECT primerNombre, primerApellido, nombreUsuario FROM Usuario Where estado=@estado
END


CREATE procedure prc_UserFriendsStatus(@Usuario BIGINT, @estado SMALLINT)
AS
BEGIN
SELECT * FROM Usuario u INNER JOIN Amistades a ON u.idUsuario = a.idUsuario2
INNER JOIN Usuario ul ON a.idUsuario2 = ul.idUsuario
WHERE ul.estado=@estado
END
GO

CREATE procedure prc_instUsuario1(@primerNombre VARCHAR(40), @primerApellido VARCHAR(40),@nombreUsuario VARCHAR(40), @contraseña VARCHAR(100), @fechaNacimiento DATE)
AS
BEGIN
INSERT INTO Usuario(primerNombre, primerApellido, nombreUsuario, contraseña, fechaNacimiento) VALUES(@primerNombre, @primerApellido, @nombreUsuario, @contraseña, @fechaNacimiento)
END
GO

CREATE procedure prc_updtEstUsuario(@idUsuario BIGINT, @estado SMALLINT)
AS
BEGIN
UPDATE Usuario SET estado=@estado WHERE idUsuario=@idUsuario
END
GO

CREATE procedure prc_makeFriends(@idUsuario1 BIGINT, @idUsuario2 BIGINT)
AS
BEGIN
INSERT INTO Amistades(idUsuario1, idUsuario2) VALUES(@idUsuario1, @idUsuario2)
INSERT INTO Amistades(idUsuario1,idUsuario2) VALUES(@idUsuario2, @idUsuario1)
END
GO

CREATE procedure prc_addTel(@idUsuario BIGINT, @telefono VARCHAR(12))
AS
BEGIN
INSERT INTO Telefono(idUsuario, telefono) VALUES(@idUsuario, @telefono)
END
GO

CREATE procedure prc_addFoto(@enlaceImagen VARCHAR(MAX), @descripcion VARCHAR(200), @idUsuario BIGINT)
AS
BEGIN
INSERT INTO Foto(enlaceImagen, descripcion, idUsuario) VALUES(@enlaceImagen, @descripcion, @idUsuario)
END
GO

CREATE procedure prc_updDescFoto(@idFoto BIGINT,@descripcion Varchar(200))
AS
BEGIN
UPDATE Foto SET descripcion=@descripcion WHERE idFoto=@idFoto
END
GO

CREATE procedure prc_createComment(@texto VARCHAR(MAX), @privacidad SMALLINT, @idUsuario BIGINT, @idFoto BIGINT)
AS
BEGIN
INSERT INTO Comentario(texto, privacidad, idUsuario, idFoto) VALUES(@texto, @privacidad, @idUsuario, @idFoto)
END
GO

CREATE procedure prc_updComPriv(@idComentario BIGINT, @privacidad SMALLINT)
AS
BEGIN
UPDATE Comentario SET privacidad=@privacidad WHERE idComentario=@idComentario
END
GO

CREATE PROCEDURE prc_createChat(@idUsuario1 BIGINT, @idUsuario2 BIGINT)
AS
BEGIN
	SELECT * FROM Amistades WHERE idUsuario1 = @idUsuario1 AND idUsuario2=@idUsuario2
	IF @@ROWCOUNT > 0
		BEGIN
INSERT INTO Chat(idUsuario1, idUsuario2) VALUES(@idUsuario1, @idUsuario2)
END
END
GO

CREATE PROCEDURE prc_addProh (@palabra VARCHAR(50))
AS
BEGIN
INSERT INTO PalabraProhibida(palabra) VALUES(@palabra)
END
GO

CREATE PROCEDURE prc_addLineaChat (@texto VARCHAR(200), @idChat BIGINT, @idUsuario BIGINT)
AS
BEGIN
INSERT INTO LineaChat(texto, idChat, idUsuario) VALUES(@texto, @idChat, @idUsuario)
END
GO



CREATE PROCEDURE prc_addPublicacion(@texto VARCHAR(MAX), @privacidad SMALLINT, @idUsuario BIGINT)
AS
BEGIN
INSERT INTO Publicacion(texto, privacidad, idUsuario) VALUES(@texto, @privacidad, @idUsuario)
END
GO

CREATE PROCEDURE prc_addChatHist(@fecha DATETIME, @idUsuario BIGINT, @texto VARCHAR(200), @idChat BIGINT)
AS
BEGIN
INSERT INTO Chat_Historico(fecha, idUsuario, texto, idChat) VALUES(@fecha, @idUsuario, @texto, @idChat)
END
GO


CREATE PROCEDURE prc_addComHist(@fecha DATETIME, @idUsuario BIGINT, @texto VARCHAR(MAX))
AS
BEGIN
INSERT INTO Comentario_Historico(fecha,idUsuario, texto) VALUES (@fecha, @idUsuario, @texto)
END
GO

CREATE PROCEDURE prc_addPubHis(@fecha DATETIME, @idUsuario BIGINT, @texto VARCHAR(MAX))
AS
BEGIN
INSERT INTO Publicacion_Historico(fecha,idUsuario, texto) VALUES(@fecha, @idUsuario, @texto)
END
GO

CREATE PROCEDURE prc_viewPub(@idUsuario BIGINT)
AS
BEGIN
	SELECT texto, fecha FROM Publicacion WHERE privacidad=1 AND idUsuario=@idUsuario
	UNION
	SELECT texto, fecha FROM Publicacion WHERE privacidad=0
END
GO



CREATE PROCEDURE spl_noContactos (@id INT) AS
BEGIN
SELECT *
FROM usuario
where idUsuario not in(
SELECT idUsuario2
FROM Amistades a
LEFT JOIN Usuario u1 ON a.idUsuario1 = u1.idUsuario 
LEFT JOIN Usuario u2 ON a.idUsuario2 = u2.idUsuario 
WHERE idUsuario1 = @id)
END
GO

CREATE PROCEDURE spl_mensajesEnviados (@nombreUsuario VARCHAR(200)) AS
BEGIN
SELECT * 
FROM LineaChat
WHERE idChat IN(
SELECT idChat 
FROM Chat 
WHERE idUsuario1 IN(
SELECT idUsuario 
FROM Usuario
WHERE nombreUsuario = @nombreUsuario)
OR idUsuario2 IN(
SELECT idUsuario 
FROM Usuario
WHERE nombreUsuario = @nombreUsuario))
AND idUsuario NOT IN (SELECT idUsuario 
FROM Usuario
WHERE nombreUsuario = @nombreUsuario)
END
GO



CREATE PROCEDURE spl_contactosConectados (@idUsuario BIGINT) AS
DECLARE @primerNombre VARCHAR(50)
DECLARE @primerApellido VARCHAR(50)
DECLARE @estado SMALLINT
DECLARE @conexion VARCHAR(40)
SET @primerNombre = NULL
SET @primerApellido = NULL
SET @estado = NULL
SET @conexion = 'desconectado'
DECLARE c_datos CURSOR FOR
	SELECT u2.primerNombre, u2.primerApellido, u2.estado
	FROM Amistades a
	LEFT JOIN Usuario u1 ON a.idUsuario1 = u1.idUsuario 
	LEFT JOIN Usuario u2 ON a.idUsuario2 = u2.idUsuario 
	WHERE idUsuario1 = @idUsuario
OPEN c_datos
WHILE 1=1
BEGIN
	FETCH NEXT FROM c_datos INTO @primerNombre, @primerApellido, @estado
	IF @estado = 1
	BEGIN
		SET @conexion = 'conectado'
	END
	IF @@FETCH_STATUS != 0
	BEGIN
		BREAK
	END
	PRINT @primerNombre + ' ' + @primerApellido + ' esta ' + @conexion
END
CLOSE c_datos
DEALLOCATE c_datos
GO