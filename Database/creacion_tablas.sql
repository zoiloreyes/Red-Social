drop database RedSocial

--Transact SQL
CREATE DATABASE RedSocial
GO
USE RedSocial
GO


CREATE TABLE Usuario (idUsuario BIGINT NOT NULL IDENTITY(1,1), 
primerNombre VARCHAR(40) NOT NULL, 
segundoNombre VARCHAR(40), 
primerApellido VARCHAR(40) NULL, 
segundoApellido VARCHAR(40),
nombreUsuario VARCHAR(40) NOT NULL, 
fechaCreacion DATETIME NOT NULL DEFAULT GETDATE(), 
contraseña VARCHAR(100) NOT NULL,
--0 Online 1 offline
estado SMALLINT NOT NULL DEFAULT 0,
fechaNacimiento DATE NOT NULL,
CONSTRAINT pk_usuarios PRIMARY KEY (idUsuario),
CONSTRAINT uc_usuario UNIQUE(nombreUsuario, contraseña),
CONSTRAINT uc2_usuario UNIQUE(nombreUsuario),
CONSTRAINT chk_estado CHECK (estado IN (0,1)));
	
 
CREATE TABLE Telefono(idTelefono BIGINT NOT NULL IDENTITY(1,1),
telefono VARCHAR(12) NOT NULL,
idUsuario BIGINT NOT NULL,
CONSTRAINT pk_telefonos PRIMARY KEY (telefono, idUsuario),
CONSTRAINT fk_usuarioTelefono FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario),
CONSTRAINT uc_telefeno UNIQUE(telefono)
);


CREATE TABLE Amistades (idAmistad BIGINT NOT NULL IDENTITY(1,1), 
idUsuario1 BIGINT NOT NULL, 
idUsuario2 BIGINT NOT NULL,
CONSTRAINT pk_amistades PRIMARY KEY (idAmistad),
CONSTRAINT fk_amistad1 FOREIGN KEY (idUsuario1) REFERENCES usuario(idUsuario),
CONSTRAINT fk_amistad2 FOREIGN KEY (idUsuario2) REFERENCES usuario(idUsuario),
CONSTRAINT uc_amistades UNIQUE(idUsuario1, idUsuario2)
);


CREATE TABLE Foto (idFoto BIGINT NOT NULL IDENTITY(1,1), 
enlaceImagen VARCHAR(MAX) NOT NULL, 
fechaSubida DATETIME NOT NULL DEFAULT GETDATE(),
--Un trigger update actualizará este campo 
fechaModificacion DATETIME, 
descripcion VARCHAR(200),
idUsuario BIGINT NOT NULL,
CONSTRAINT pk_foto PRIMARY KEY (idFoto),
CONSTRAINT fk_fotoUsuario FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario));


CREATE TABLE Comentario (idComentario BIGINT NOT NULL IDENTITY(1,1), 
fecha DATETIME NOT NULL DEFAULT GETDATE(),          
texto VARCHAR(MAX) NOT NULL,
-- Privacidad puede ser 0(público) o 1(Privado)                        
privacidad SMALLINT NOT NULL DEFAULT 0,
idUsuario BIGINT NOT NULL, 
idFoto BIGINT NOT NULL,
CONSTRAINT pk_comentario PRIMARY KEY (idComentario),
CONSTRAINT fk_comentarioUsuario FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario),
CONSTRAINT fk_comentarioFoto FOREIGN KEY (idFoto) REFERENCES foto(idFoto),
CONSTRAINT chk_privacidad CHECK (privacidad IN (0,1))
);


CREATE TABLE Chat (idChat BIGINT NOT NULL IDENTITY(1,1), 
idUsuario1 BIGINT NOT NULL, 
idUsuario2 BIGINT NOT NULL,
CONSTRAINT pk_chat PRIMARY KEY (idChat),
CONSTRAINT fk_chatUsuario1 FOREIGN KEY (idUsuario1) REFERENCES usuario(idUsuario),
CONSTRAINT fk_chatUsuario2 FOREIGN KEY(idUsuario2) REFERENCES usuario(idUsuario),
CONSTRAINT uc_chat UNIQUE(idUsuario1, idUsuario2)
);


CREATE TABLE PalabraProhibida (idPalabraProhibida BIGINT NOT NULL IDENTITY(1,1), 
palabra VARCHAR(50) NOT NULL,
CONSTRAINT pk_palabras PRIMARY KEY (idPalabraProhibida),
CONSTRAINT uc_palabraproh UNIQUE (palabra)
);




CREATE TABLE LineaChat (idLineaChat BIGINT NOT NULL IDENTITY(1,1),  
texto VARCHAR(200) NOT NULL, 
fecha DATETIME NOT NULL DEFAULT GETDATE(), 
idChat BIGINT NOT NULL, 
idUsuario BIGINT NOT NULL,
CONSTRAINT pk_lineaChat PRIMARY KEY (idLineaChat),
CONSTRAINT fk_chatLinea FOREIGN KEY (idChat) REFERENCES chat(idChat),
CONSTRAINT fk_chatUsuario FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario),
);


CREATE TABLE Publicacion (idPublicacion BIGINT NOT NULL IDENTITY(1,1), 
texto VARCHAR(MAX) NOT NULL,
-- Privacidad puede ser 0(público) o 1(Privado)      
privacidad SMALLINT NOT NULL, 
idUsuario BIGINT NOT NULL,
fecha DATETIME NOT NULL DEFAULT GETDATE(),
CONSTRAINT pk_publicacion PRIMARY KEY (idPublicacion),
CONSTRAINT fk_publicacionUsuario FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario),
CONSTRAINT chk_privacidadPub CHECK (privacidad IN (0,1)));


CREATE TABLE Chat_Historico (idChatHistorico BIGINT NOT NULL IDENTITY(1,1), 
fecha DATETIME NOT NULL DEFAULT GETDATE(), 
idUsuario BIGINT NOT NULL, 
texto VARCHAR(200) NOT NULL,
idChat BIGINT,
CONSTRAINT pk_chatHistorico PRIMARY KEY (idChatHistorico),
CONSTRAINT fk_chatHisUsuario FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario));


CREATE TABLE Publicacion_Historico (idPublicacionHistorico BIGINT NOT NULL IDENTITY(1,1), 
fecha DATETIME NOT NULL DEFAULT GETDATE(), 
idUsuario BIGINT NOT NULL, 
texto VARCHAR(MAX) NOT NULL,
CONSTRAINT pk_PublicacionHistorico PRIMARY KEY (idPublicacionHistorico),
CONSTRAINT fk_publicacionHisUsuario FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario) );


CREATE TABLE Comentario_Historico (idComentarioHistorico BIGINT NOT NULL IDENTITY(1,1), 
fecha DATETIME NOT NULL DEFAULT GETDATE(), 
idUsuario BIGINT NOT NULL, 
texto VARCHAR(MAX) NOT NULL,
CONSTRAINT pk_ComentarioHistorico PRIMARY KEY (idComentarioHistorico),
CONSTRAINT fk_ComentarioHisUsuario FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario)
);


CREATE TABLE Faltas(idFalta BIGINT NOT NULL IDENTITY(1,1), 
fecha DATETIME NOT NULL DEFAULT GETDATE(), 
idUsuario BIGINT NOT NULL,
CONSTRAINT pk_faltas PRIMARY KEY (idFalta),
CONSTRAINT fk_faltasUsuario FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario));


CREATE TABLE conexion(
	idConexion BIGINT IDENTITY(1,1),
	idUsuario BIGINT, 
	fecha DATETIME,
	CONSTRAINT pk_conexion PRIMARY KEY (idConexion),
	CONSTRAINT fk_conexionUsuario FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario)

);
