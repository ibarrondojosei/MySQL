USE nba;

/*CANDADO A
Posición: El candado A está ubicado en la posición calculada a partir del número obtenido
en la/s siguiente/s consulta/s:
Muestre cuántas veces los jugadores lograron tener más o la misma cantidad de
asistencias por partido, que el máximo de asistencias por partido.*/

SELECT count(jugadores.codigo) AS 'POSICION CANDADO A' FROM jugadores 
INNER JOIN estadisticas ON jugadores.codigo = estadisticas.jugador WHERE
estadisticas.asistencias_por_partido >= (SELECT max(estadisticas.asistencias_por_partido) FROM estadisticas); 
/*RESULTADO = 2*/

/*Clave: La clave del candado A estará con formada por la/s siguientes consulta/s a la base
de datos:
Muestre la suma total del peso de los jugadores, donde la conferencia sea Este y la posición
sea centro o esté comprendida en otras posiciones.*/

SELECT sum(jugadores.peso) AS 'CLAVE CANDADO A' FROM jugadores
INNER JOIN equipos ON jugadores.nombre_equipo = equipos.nombre
WHERE equipos.conferencia = 'east' AND  jugadores.posicion LIKE '%C%'; /*RESULTADO=14043*/

/*CANDADO B
Posición: El candado B está ubicado en la posición calculada a partir del número obtenido
en la/s siguiente/s consulta/s:
Muestre la cantidad de jugadores que poseen más asistencias por partidos, que el numero
de jugadores que tiene el equipo Heat.*/

SELECT count(jugadores.codigo) AS 'POSICION CANDADO B' FROM jugadores 
INNER JOIN estadisticas ON jugadores.codigo = estadisticas.jugador
WHERE estadisticas.asistencias_por_partido > (SELECT count(jugadores.codigo) FROM jugadores 
WHERE jugadores.nombre_equipo = 'heat'); /*RESULTADO=3*/

/*Clave: La clave del candado B estará con formada por la/s siguientes consulta/s a la base
de datos:
La clave será igual al conteo de partidos jugados durante las temporadas del año 1999.*/

SELECT count(partidos.codigo) AS 'CLAVE CANDADO B' FROM partidos WHERE partidos.temporada LIKE '%99%';
 /*RESULTADO=3480*/
 
 SELECT distinct partidos.temporada FROM partidos;
 
 
 /*CANDADO C
Posición: El candado C está ubicado en la posición calculada a partir del número obtenido
en la/s siguiente/s consulta/s:
La posición del código será igual a la cantidad de jugadores que proceden de Michigan y
forman parte de equipos de la conferencia oeste.
Al resultado obtenido lo dividiremos por la cantidad de jugadores cuyo peso es mayor o igual
a 195, y a eso le vamos a sumar 0.9945.*/

SELECT ((count(jugadores.codigo)/(SELECT count(jugadores.codigo) 
FROM jugadores WHERE jugadores.peso >= 195)))+0.9945 AS 'POSICION CANDADO C'
FROM jugadores 
INNER JOIN equipos ON jugadores.Nombre_equipo = equipos.Nombre 
WHERE jugadores.Procedencia = 'michigan' AND equipos.Conferencia = 'west';/*RESULTADO=1*/

/*Clave: La clave del candado C estará con formada por la/s siguientes consulta/s a la base
de datos:
Para obtener el siguiente código deberás redondear hacia abajo el resultado que se
devuelve de sumar: el promedio de puntos por partido, el conteo de asistencias por partido,
y la suma de tapones por partido. Además, este resultado debe ser, donde la división sea
central.*/

SELECT floor((avg(estadisticas.puntos_por_partido)) + count(estadisticas.asistencias_por_partido) +
sum(estadisticas.tapones_por_partido)) AS 'CLAVE CANDADO C' FROM estadisticas 
INNER JOIN jugadores ON jugadores.codigo = estadisticas.jugador
INNER JOIN equipos ON jugadores.nombre_equipo = equipos.nombre 
WHERE equipos.division = 'central' ;/*RESULTADO = 631*/

/*CANDADO D
Posición: El candado D está ubicado en la posición calculada a partir del número obtenido
en la/s siguiente/s consulta/s:
Muestre los tapones por partido del jugador Corey Maggette durante la temporada 00/01.
Este resultado debe ser redondeado. Nota: el resultado debe estar redondeado*/

SELECT round(estadisticas.tapones_por_partido) AS 'POSICION CANDADO D' FROM estadisticas 
INNER JOIN jugadores ON estadisticas.jugador = jugadores.codigo
WHERE jugadores.nombre = 'Corey Maggette'AND estadisticas.temporada = '00/01'; /*RESULTADO = 4*/

/*Clave: La clave del candado D estará con formada por la/s siguientes consulta/s a la base
de datos:
Para obtener el siguiente código deberás redondear hacia abajo, la suma de puntos por
partido de todos los jugadores de procedencia argentina.*/

SELECT distinct procedencia FROM jugadores;

SELECT floor(sum(estadisticas.puntos_por_partido)) AS 'CLAVE CANDADO D' FROM estadisticas

INNER JOIN jugadores ON estadisticas.jugador = jugadores.codigo
WHERE jugadores.Procedencia = 'Argentina'; /*RESULTADO = 191*/


