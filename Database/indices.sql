CREATE INDEX idx1_usuario ON Usuario(primerNombre);
CREATE INDEX idx2_usuario ON Usuario(primerApellido);
CREATE INDEX idx3_usuario ON Usuario(primerNombre, primerApellido);
CREATE INDEX idx4_usuario ON Usuario(nombreUsuario);


CREATE INDEX idx1_telefono ON Telefono(idUsuario);
CREATE UNIQUE INDEX idx2_telefono ON Telefono(telefono);


CREATE INDEX idx1_Amistades ON Amistades(idUsuario1);
CREATE INDEX idx2_Amistades ON Amistades(idUsuario2);


CREATE INDEX idx1_Foto ON Foto(idUsuario);


CREATE INDEX idx1_Comentario ON Comentario(idUsuario);
CREATE INDEX idx2_Comentario ON Comentario(idFoto);


CREATE INDEX idx1_Chat ON Chat(idUsuario1);
CREATE INDEX idx2_Chat ON Chat(idUsuario2);


CREATE INDEX idx1_Palabras ON PalabraProhibida(palabra);


CREATE INDEX idx1_LineaChat ON LineaChat(idChat);
CREATE INDEX idx2_LineaChat ON LineaChat(idUsuario);


CREATE INDEX idx1_Publicacion ON Publicacion(idUsuario);


CREATE INDEX idx1_ChatHis ON Chat_Historico(idUsuario);


CREATE INDEX idx1_PubHis ON Publicacion_Historico(idUsuario);


CREATE INDEX idx1_ComHis ON Comentario_Historico(idUsuario);


CREATE INDEX idx1_Faltas ON Faltas(idUsuario);