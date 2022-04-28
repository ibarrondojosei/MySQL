USE tienda;

/*1. Lista el nombre de todos los productos que hay en la tabla producto.*/

SELECT nombre FROM producto;

/*2. Lista los nombres y los precios de todos los productos de la tabla producto.*/

SELECT nombre, precio FROM producto ORDER BY nombre;

/*3. Lista todas las columnas de la tabla producto.*/

SELECT * FROM producto ORDER BY nombre;

/*4. Lista los nombres y los precios de todos los productos de la tabla producto,
redondeando el valor del precio.*/

SELECT nombre, round(precio) FROM producto ORDER BY nombre;

/*5. Lista el código de los fabricantes que tienen productos en la tabla producto.*/

SELECT DISTINCT producto.codigo_fabricante, fabricante.nombre FROM fabricante, producto WHERE fabricante.codigo = producto.codigo_fabricante ORDER BY producto.codigo_fabricante; 

/*10. Lista el código de los fabricantes que tienen productos en la tabla producto, sin
mostrar los repetidos.
11. Lista los nombres de los fabricantes ordenados de forma ascendente.
12. Lista los nombres de los productos ordenados en primer lugar por el nombre de
forma ascendente y en segundo lugar por el precio de forma descendente.*/




/*2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen
ningún producto asociado.*/
SELECT* FROM FABRICANTE F
left JOIN PRODUCTO P
ON P.CODIGO_FABRICANTE = F.CODIGO
where not exists (SELECT* FROM FABRICANTE F
WHERE P.CODIGO_FABRICANTE = F.CODIGO);


/*Subconsultas (En la cláusula WHERE)
4. Lista todos los productos del fabricante Asus que tienen un precio superior al precio
medio de todos sus productos.*/

SELECT P.NOMBRE,@PROM FROM PRODUCTO P, FABRICANTE f
WHERE P.CODIGO_FABRICANTE = F.CODIGO
AND P.PRECIO = (SELECT P.PRECIO FROM PRODUCTO P, FABRICANTE f
WHERE P.CODIGO_FABRICANTE = F.CODIGO AND F.NOMBRE = 'ASUS' AND P.PRECIO > 
(@PROM:=(SELECT avg(P.PRECIO)  FROM PRODUCTO P, FABRICANTE F
WHERE P.CODIGO_FABRICANTE = F.CODIGO
AND F.NOMBRE = 'ASUS'
 ))
ORDER BY P.PRECIO DESC LIMIT 1 );


/*Subconsultas con IN y NOT IN
1. Devuelve los nombres de los fabricantes que tienen productos asociados.
(Utilizando IN o NOT IN).*/
SELECT distinct F.NOMBRE
FROM FABRICANTE F, PRODUCTO P
WHERE F.CODIGO IN (select P.CODIGO_FABRICANTE FROM FABRICANTE F, PRODUCTO P WHERE F.CODIGO = P.CODIGO_FABRICANTE );


/*Subconsultas (En la cláusula HAVING)
1. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo
número de productos que el fabricante Lenovo.*/
select count(codigo_fabricante), f.nombre from producto p, fabricante f
WHERE F.CODIGO = P.CODIGO_FABRICANTE
group by codigo_fabricante having count(codigo_fabricante) =  (SELECT count(P.codigo_fabricante) 
FROM FABRICANTE f , PRODUCTO P 
WHERE P.CODIGO_FABRICANTE = F.CODIGO and F.NOMBRE = 'LENOVO');


