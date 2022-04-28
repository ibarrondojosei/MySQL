USE personal;
/*22. Hallar el salario más alto, el más bajo y la diferencia entre ellos.*/
SELECT max(sal_emp), min(sal_emp), (max(sal_emp)-min(sal_emp)) AS diferencia FROM empleados; 

/*23. Hallar el salario promedio por departamento.*/
SELECT empleados.id_depto, departamentos.nombre_depto, departamentos.ciudad, ROUND(AVG (sal_emp)) AS salario_promedio FROM empleados, departamentos WHERE empleados.id_depto = departamentos.id_depto GROUP BY empleados.id_depto;

/*Consultas con Having
24. Hallar los departamentos que tienen más de tres empleados. Mostrar el número
de empleados de esos departamentos.*/

SELECT departamentos.nombre_depto, departamentos.id_depto, count(*) AS N_TRAB FROM departamentos, empleados  WHERE  empleados.id_depto = departamentos.id_depto GROUP BY empleados.id_depto HAVING count(*) > 3; 

/*25. Mostrar el código y nombre de cada jefe, junto al número de empleados que
dirige. Solo los que tengan más de dos empleados (2 incluido).*/

/*SELECT departamentos.nombre_depto, empleados.id_deptos, count(*) AS n_trab FROM departamentos, empleados WHERE  empleados.id_depto = departamentos.id_depto LIKE empleados.cargo_emp ('%jefe%') GROUP BY empleados.id_depto HAVING count(*) >= 2;*/

/*26. Hallar los departamentos que no tienen empleados*/

SELECT departamentos.id_depto, departamentos.nombre_depto, departamentos.ciudad , count(*) AS cant_emp FROM departamentos LEFT JOIN empleados ON departamentos.id_depto = empleados.id_depto GROUP BY departamentos.id_depto HAVING count(*) = 0;

/*27. Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio
de la empresa. Ordenarlo por departamento.*/

SELECT id_depto, nombre, sal_emp as salario, @prom FROM empleados  WHERE sal_emp >  (@prom:= (select avg(sal_emp)  from empleados )) order by empleados.sal_emp asc; -- 26
/* Se pone @prom:= para quemuestre el resultado de la subconsulta en la tabla*/

SELECT nombre, sal_emp FROM empleados WHERE sal_emp >= (SELECT avg(sal_emp) FROM empleados)   ORDER BY id_depto ASC;
SELECT round(avg(sal_emp)) FROM empleados;
SELECT  id_depto, nombre  FROM empleados;