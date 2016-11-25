--Introduccion de datos
--Usuarios (don't judge me)


SELECT * FROM usuario
INSERT INTO Usuario
VALUES('Jason', null, 'Zimmerman', null, 'mew2king', getdate(), 'imainluigi', 0, CAST('2/5/2011' AS DATETIME))
INSERT INTO Usuario
VALUES('Adam', null, 'Lindgren', null, 'armada', getdate(), 'evo', 0, CAST('3/28/1993' AS DATETIME))
INSERT INTO Usuario
VALUES('Juan', 'Manuel', 'Debiedma', null, 'hungrybox', getdate(), '666xx', 0, CAST('6/21/1993' AS DATETIME))
INSERT INTO Usuario
VALUES('William', null, 'Hjelte', null, 'leffen', getdate(), 'respectyourelders', 0, CAST('10/16/1994' AS DATETIME))
INSERT INTO Usuario
VALUES('Joseph', null, 'Marquez', null, 'mang0', getdate(), 'buster', 0, CAST('12/10/1991' AS DATETIME))
INSERT INTO Usuario
VALUES('Kevin', null, 'Nanney', null, 'ppmd', getdate(), 'drpeepee', 0, CAST('9/25/1990' AS DATETIME))
INSERT INTO Usuario
VALUES('Weston', null, 'Dennis', null, 'westballz', getdate(), 'popcorn', 0, CAST('12/8/1991' AS DATETIME))
INSERT INTO Usuario
VALUES('Ken', null, 'Hoang', null, 'sephirothKen', getdate(), 'utterlyraped', 0, CAST('10/10/1985' AS DATETIME))
INSERT INTO Usuario
VALUES('Joel', 'Isai', 'Alvarado', null, 'ISAI', getdate(), 'malva', 0, CAST('3/17/1985' AS DATETIME))
INSERT INTO Usuario
VALUES('Kashan', null, 'Khan', null, 'chillindude829', getdate(), 'myb', 0, CAST('8/29/1989' AS DATETIME))
INSERT INTO Usuario
VALUES('Justin', null, 'Hallett', null, 'wizzrobe', getdate(), 'bestfalcon', 0, CAST('1/10/1998' AS DATETIME))
INSERT INTO Usuario
VALUES('Aziz', null, 'Al-Yami', null, 'HAX_FUCKING_MONEY', getdate(), 'bestfox', 0, CAST('5/7/1994' AS DATETIME))
INSERT INTO Usuario
VALUES('Johnny', null, 'Kim', null, 'smoke2jointz', getdate(), 'captainblowjob', 0, CAST('4/21/2011' AS DATETIME))
INSERT INTO Usuario
VALUES('Bobby', null, 'Scarnewman', null, 'scar', getdate(), 'ikilledmufasa', 0, CAST('1/7/1987' AS DATETIME))
INSERT INTO Usuario
VALUES('Brandon', null, 'Collier', null, 'HomeMadeWaffles', getdate(), 'wombocombo', 0, CAST('2/5/2011' AS DATETIME))
INSERT INTO Usuario
VALUES('Henryk', null, 'Boss', null, 'henrykboss', getdate(), 'melee', 0, CAST('2/5/1995' AS DATETIME))




--Amistades
INSERT INTO amistades
VALUES((SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'mang0'),(SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'HomeMadeWaffles'))
INSERT INTO amistades
VALUES((SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'mang0'),(SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'smoke2jointz'))
INSERT INTO amistades
VALUES((SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'mang0'),(SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'armada'))
INSERT INTO amistades
VALUES((SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'mew2king'),(SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'wizzrobe'))
INSERT INTO amistades
VALUES((SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'mew2king'),(SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'HAX_FUCKING_MONEY'))
INSERT INTO amistades
VALUES((SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'mang0'),(SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'scar'))
INSERT INTO amistades
VALUES((SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'mang0'),(SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'ppmd'))
INSERT INTO amistades
VALUES((SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'sephirothKen'),(SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'ISAI'))
INSERT INTO amistades
VALUES((SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'sephirothKen'),(SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'chillindude829'))
INSERT INTO amistades
VALUES((SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'sephirothKen'),(SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'scar'))
INSERT INTO amistades
VALUES((SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'armada'),(SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'scar'))
INSERT INTO amistades
VALUES((SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'armada'),(SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'leffen'))
INSERT INTO amistades
VALUES((SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'armada'),(SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'hungrybox'))
INSERT INTO amistades
VALUES((SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'ppmd'),(SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'HAX_FUCKING_MONEY'))
INSERT INTO amistades
VALUES((SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'mang0'),(SELECT idUsuario FROM usuario WHERE nombreUsuario  = 'westballz'))


--Palabras Prohibidas
INSERT INTO PalabraProhibida
VALUES('pepe')
INSERT INTO PalabraProhibida
VALUES('fuck')
INSERT INTO PalabraProhibida
VALUES('shit')
INSERT INTO PalabraProhibida
VALUES('blowjob')
INSERT INTO PalabraProhibida
VALUES('pokefloats')


SELECT * FROM Publicacion_Historico
SELECT * FROM Faltas

INSERT INTO Publicacion
VALUES('Fuck Alex19!', 0, (SELECT idUsuario FROM usuario WHERE nombreUsuario = 'smoke2jointz'), getdate())