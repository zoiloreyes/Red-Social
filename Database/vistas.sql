--Vistas
CREATE VIEW vw_amistades AS
SELECT u1.primerNombre + ' ' + u1.primerApellido AS 'Amigo 1', u2.primerNombre + ' ' + u2.primerApellido AS 'Amigo 2'
FROM Amistades a
LEFT JOIN Usuario u1 ON a.idUsuario1 = u1.idUsuario 
LEFT JOIN Usuario u2 ON a.idUsuario2 = u2.idUsuario 


CREATE VIEW vw_usuariosDosMeses AS
SELECT * 
FROM Usuario
WHERE fechaCreacion >= DATEADD(mm, -2, GETDATE())


CREATE VIEW vw_auditoriaFaltas AS
SELECT nombreUsuario, primerNombre, primerApellido, COUNT(*) AS 'Faltas cometidas'
FROM Faltas f
JOIN Usuario u ON f.idUsuario = u.idUsuario
GROUP BY u.nombreUsuario, primerNombre, primerApellido