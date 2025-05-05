DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda;
Use tienda;
CREATE TABLE fabricante (
  id INT IDENTITY(1,1) PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  id INT IDENTITY(1,1) PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio FLOAT NOT NULL,
  id_fabricante INT  NOT NULL,
  FOREIGN KEY (id_fabricante) REFERENCES fabricante(id)
);

INSERT INTO fabricante VALUES('Asus');
INSERT INTO fabricante VALUES('Lenovo');
INSERT INTO fabricante VALUES('Hewlett-Packard');
INSERT INTO fabricante VALUES('Samsung');
INSERT INTO fabricante VALUES('Seagate');
INSERT INTO fabricante VALUES('Crucial');
INSERT INTO fabricante VALUES('Gigabyte');
INSERT INTO fabricante VALUES('Huawei');
INSERT INTO fabricante VALUES('Xiaomi');

INSERT INTO producto VALUES('Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES('Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES( 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES( 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES( 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES( 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES( 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES( 'Port til Yoga 520', 559, 2);
INSERT INTO producto VALUES( 'Port til Ideapd 320', 444, 2);
INSERT INTO producto VALUES( 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES( 'Impresora HP Laserjet Pro M26nw', 180, 3);

select * from fabricante;
select * from producto;

/*Consultas multitablas Inner Join*/

/*1-Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos 
los productos de la base de datos. */
SELECT 
    producto.nombre AS producto,
    producto.precio,
    fabricante.nombre AS fabricante
FROM 
    producto
JOIN 
    fabricante ON producto.id_fabricante = fabricante.id;

/*2-Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos 
los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por 
orden alfab tico. */
SELECT 
    producto.nombre AS producto,
    producto.precio,
    fabricante.nombre AS fabricante
FROM 
    producto
JOIN 
    fabricante ON producto.id_fabricante = fabricante.id
ORDER BY 
    fabricante.nombre ASC;

/*3-Devuelve una lista con el identificador del producto, nombre del producto, identificador 
del fabricante y nombre del fabricante, de todos los productos de la base de datos. */
SELECT 
    producto.id AS ID,
    producto.nombre AS producto,
    fabricante.id AS codigo,
    fabricante.nombre AS nombre_fabricante
FROM 
    producto
JOIN 
    fabricante ON producto.id_fabricante = fabricante.id;

/*4-Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto m s barato.*/
SELECT 
    producto.nombre AS producto,
    producto.precio,
    fabricante.nombre AS fabricante
FROM 
    producto
JOIN 
    fabricante ON producto.id_fabricante = fabricante.id
WHERE 
    producto.precio = (SELECT MIN(precio) FROM producto);

/*5-Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto m s caro.*/
SELECT 
    producto.nombre AS producto,
    producto.precio,
    fabricante.nombre AS fabricante
FROM 
    producto
JOIN 
    fabricante ON producto.id_fabricante = fabricante.id
WHERE 
    producto.precio = (SELECT MAX(precio) FROM producto);

/*6-Devuelve una lista de todos los productos del fabricante Lenovo.*/
SELECT 
    producto.nombre AS producto,
    producto.precio,
    fabricante.nombre AS fabricante
FROM 
    producto
JOIN 
    fabricante ON producto.id_fabricante = fabricante.id
WHERE 
    fabricante.nombre = 'Lenovo';

/*7-Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200 .*/
SELECT 
    producto.nombre AS producto,
    producto.precio,
    fabricante.nombre AS fabricante
FROM 
    producto
JOIN 
    fabricante ON producto.id_fabricante = fabricante.id
WHERE 
    fabricante.nombre = 'Crucial'
    AND producto.precio > 200;

/*8-Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Sin utilizar el operador IN.*/
SELECT 
    producto.nombre AS producto,
    producto.precio,
    fabricante.nombre AS fabricante
FROM 
    producto
JOIN 
    fabricante ON producto.id_fabricante = fabricante.id
WHERE 
    fabricante.nombre = 'Asus'
    OR fabricante.nombre = 'Hewlett-Packard'
    OR fabricante.nombre = 'Seagate';

/*9-Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.*/
SELECT 
    producto.nombre AS producto,
    producto.precio,
    fabricante.nombre AS fabricante
FROM 
    producto
JOIN 
    fabricante ON producto.id_fabricante = fabricante.id
WHERE 
    fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

/*10-Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.*/
SELECT 
    producto.nombre AS producto,
    producto.precio, fabricante.nombre as fabricante
FROM 
    producto
JOIN 
    fabricante ON producto.id_fabricante = fabricante.id
WHERE 
    fabricante.nombre LIKE '%e';

/*11-Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el car cter w en su nombre.*/
SELECT 
    producto.nombre AS producto,
    producto.precio, fabricante.nombre as fabricante
FROM 
    producto
JOIN 
    fabricante ON producto.id_fabricante = fabricante.id
WHERE 
    fabricante.nombre LIKE '%w%';

/*12-Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan 
un precio mayor o igual a 180 . Ordene el resultado en primer lugar por el precio (en orden descendente) 
y en segundo lugar por el nombre (en orden ascendente)*/
SELECT 
    producto.nombre AS producto,
    producto.precio,
    fabricante.nombre AS fabricante
FROM 
    producto
JOIN 
    fabricante ON producto.id_fabricante = fabricante.id
WHERE 
    producto.precio >= 180
ORDER BY 
    producto.precio DESC,
    producto.nombre ASC;

/*13-Devuelve un listado con el identificador y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos 
asociados en la base de datos.*/
SELECT 
    fabricante.id,
    fabricante.nombre
FROM 
    fabricante
WHERE 
    EXISTS (SELECT 1
			FROM producto
			WHERE producto.id_fabricante = fabricante.id);

/*Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los 
productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos 
fabricantes que no tienen productos asociados.*/
SELECT 
	fabricante.id AS Codigo,
	fabricante.nombre as Fabricante,
	producto.nombre as Producto,
	producto.precio
FROM
	fabricante
LEFT JOIN
	producto ON fabricante.id=producto.id_fabricante

/*Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún 
producto asociado. */
SELECT
	fabricante.id,
	fabricante.nombre, fabricante.nombre
FROM
	fabricante
LEFT JOIN
	producto ON fabricante.id=producto.id_fabricante
WHERE
	producto.id_fabricante IS NULL;




