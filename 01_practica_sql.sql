-- Sentencia Select 
--Obtener todos los registros y todos los campos de la tabla de productos
Select * from products;
-- Obtenerr una consulta con Productid, productname, supplierid, categoryId, UnistsinStock, UnitPrice
Select product_id, product_name, supplier_id, category_id, units_in_stock, unit_price from products;
--Crear una consulta para obtener el IdOrden, IdCustomer, Fecha de la orden de la tabla de ordenes.
Select order_id, customer_id, order_date from orders;
--Crear una consulta para obtener el OrderId, EmployeeId, Fecha de la orden.
Select order_id, employee_id, order_date from orders;


--Columnas calculadas 


--Obtener una consulta con Productid, productname y valor del inventario, valor inventrio (UnitsinStock * UnitPrice)
SELECT product_id, product_name, units_in_stock * unit_price AS "Valor del Inventario"FROM products;
-- Cuanto vale el punto de reorden 
Select product_id, UPPER(product_name) as "Products" from products;
-- Mostrar una consulta con Productid, productname y precio, el nombre del producto debe estar en mayuscula 
SELECT product_id, UPPER(product_name) AS "Productname", unit_price FROM products;
-- Mostrar una consulta con Productid, productname y precio, el nombre del producto debe contener unicamente 10 caracteres */
SELECT product_id, product_name, unit_price FROM products WHERE LENGTH (product_name) = 10;
--Obtenre una consulta que muestre la longitud del nombre del producto
SELECT LENGTH(product_name) AS "Longitud del nombre" FROM products;
--Obtener una consulta de la tabla de productos que muestre el nombre en minúscula
SELECT product_id, LOWER(product_name) AS product_name, unit_price FROM products;
-- Mostrar una consulta con Productid, productname y precio, el nombre del producto debe contener unicamente 10 caracteres y se deben mostrar en mayúscula */
SELECT product_id, UPPER(product_name) AS "Productname", unit_price FROM products WHERE LENGTH(product_name) = 10;


--Filtros


--Obtener de la tabla de Customers las columnas CustomerId, CompanyName, Pais Obtener los clientes cuyo pais sea Spain
SELECT customer_id, company_name, country FROM customers WHERE country = 'Spain';
--Obtener de la tabla de Customers las columnas CustomerId, CompanyName, Pais, Obtener los clientes cuyo pais comience con la letra U
SELECT customer_id, company_name, country FROM customers WHERE country LIKE 'U%';
--Obtener de la tabla de Customers las columnas CustomerId, CompanyName, Pais, Obtener los clientes cuyo pais comience con la letra U,S,A
SELECT customer_id, company_name, country FROM customers WHERE country LIKE 'U%' OR country LIKE 'S%' OR country LIKE 'A%';
--Obtener de la tabla de Productos las columnas productid, ProductName, UnitPrice cuyos precios esten entre 50 y 150
SELECT product_id, product_name, unit_price FROM products WHERE unit_price BETWEEN 50 AND 150;
--Obtener de la tabla de Productos las columnas productid, ProductName, UnitPrice, UnitsInStock cuyas existencias esten entre 50 y 100
SELECT product_id, product_name, unit_price, units_in_stock FROM products WHERE units_in_stock BETWEEN 50 AND 100;
--Obtener las columnas OrderId, CustomerId, employeeid de la tabla de ordenes cuyos empleados sean 1, 4, 9
SELECT order_id, customer_id, employee_id FROM orders WHERE employee_id IN (1, 4, 9);
-- ORDENAR EL RESULTADO DE LA QUERY POR ALGUNA COLUMNA Obtener la información de la tabla de Products, Ordenarlos por Nombre del Producto de forma ascendente
SELECT * FROM products ORDER BY product_name ASC;
-- Obtener la información de la tabla de Products, Ordenarlos por Categoria de forma ascendente y por precio unitario de forma descendente
SELECT * FROM products ORDER BY category_id ASC, unit_price DESC;
-- Obtener la información de la tabla de Clientes, Customerid, CompanyName, city, country ordenar por pais, ciudad de forma ascendente
SELECT customer_iD, company_name, city, country FROM customers ORDER BY country ASC, city ASC;
-- Obtener los productos productid, productname, categoryid, supplierid ordenar por categoryid y supplier únicamente mostrar aquellos cuyo precio esté entre 25 y 200
SELECT product_id, product_name, category_id, supplier_id FROM products WHERE unit_price BETWEEN 25 AND 200 ORDER BY category_id, supplier_id;


--Funciones agregación


--Cuantos productos hay en la tabla de productos
SELECT COUNT(*) AS "TotalProductos" FROM Products;
--de la tabla de productos Sumar las cantidades en existencia 
SELECT SUM(units_in_stock) AS TotalUnitsInStock FROM Products;
--Promedio de los precios de la tabla de productos
SELECT AVG(unit_price) AS AverageUnitPrice FROM Products;


--Ordenar


--Obtener los datos de productos ordenados descendentemente por precio unitario de la categoría 1
SELECT product_id, product_name, unit_price FROM products WHERE category_id = 1 ORDER BY unit_price DESC;
--Obtener los datos de los clientes(Customers) ordenados descendentemente por nombre(CompanyName) que se encuentren en la ciudad(city) de barcelona, Lisboa
SELECT customer_id, company_name, city, country FROM customers WHERE city = 'Lisboa' ORDER BY company_name DESC;
--Obtener los datos de las ordenes, ordenados descendentemente por la fecha de la orden cuyo cliente(CustomerId) sea ALFKI
SELECT order_id, customer_id, order_date FROM orders WHERE customer_id = 'ALFKI' ORDER BY order_date DESC;
--Obtener los datos del detalle de ordenes, ordenados ascendentemente por precio cuyo producto sea 1, 5 o 20
SELECT order_id, product_id, unit_price, quantity FROM order_details WHERE product_id IN (1, 5, 20) ORDER BY unit_price ASC;
--Obtener los datos de las ordenes ordenados ascendentemente por la fecha de la orden cuyo empleado sea 2 o 4
SELECT * from orders where employee_id IN (2,4) order by order_date;
--Obtener los productos cuyo precio están entre 30 y 60 ordenado por nombre
SELECT product_id, product_name, unit_price FROM products WHERE unit_price BETWEEN 30 AND 60 ORDER BY product_name;


--funciones de agrupacion


--OBTENER EL MAXIMO, MINIMO Y PROMEDIO DE PRECIO UNITARIO DE LA TABLA DE PRODUCTOS UTILIZANDO ALIAS
SELECT MAX(unit_price) AS max_price, MIN(unit_price) AS min_price, AVG(unit_price) AS avg_price FROM products;


--Agrupacion


--Numero de productos por categoria
SELECT category_id, COUNT(*) as NumeroProductos FROM products GROUP BY category_id;
--Obtener el precio promedio por proveedor de la tabla de productos
SELECT supplier_id, AVG(unit_price) AS AvgPrice FROM products GROUP BY supplier_id;
--Obtener la suma de inventario (UnitsInStock) por SupplierID De la tabla de productos (Products)
SELECT supplier_id, SUM(units_in_stock) as TotalInventario FROM products GROUP BY supplier_id;
--Contar las ordenes por cliente de la tabla de orders
SELECT customer_id, COUNT(order_id) AS NumOrders FROM orders GROUP BY customer_id;
--Contar las ordenes por empleado de la tabla de ordenes unicamente del empleado 1,3,5,6
SELECT employee_id, COUNT(order_id) AS NumOrders FROM orders where employee_id in (1,3,5,6) GROUP BY employee_id ;
--Obtener la suma del envío (freight) por cliente
SELECT customer_id, SUM(freight) AS TotalFreight FROM orders GROUP BY customer_id;
--De la tabla de ordenes únicamente de los registros cuya ShipCity sea Madrid, Sevilla, Barcelona, Lisboa, LondonOrdenado por el campo de suma del envío
SELECT customer_id, SUM(freight) as TotalFreight FROM orders
WHERE ship_city IN ('Madrid', 'Sevilla', 'Barcelona', 'Lisboa', 'London')
GROUP BY customer_id
ORDER BY TotalFreight;
--Obtener el precio promedio de los productos por categoria sin contar con los productos descontinuados (Discontinued)
SELECT categories.category_name, AVG(products.unit_price) AS AvgPrice
FROM categories 
JOIN products ON categories.category_id = products.category_id
WHERE products.discontinued = 0
GROUP BY categories.category_name;
--Obtener la cantidad de productos por categoria,  aquellos cuyo precio se encuentre entre 10 y 60 que tengan más de 12 productos
SELECT categories.category_name, COUNT(*) as Cantidad_Productos
FROM products
INNER JOIN categories ON products.category_id = categories.category_id
WHERE products.Discontinued = 0 AND products.unit_price BETWEEN 10 AND 60 AND products.units_in_stock > 12
GROUP BY categories.category_name;
--OBTENER LA SUMA DE LAS UNIDADES EN EXISTENCIA (UnitsInStock) POR CATEGORIA, Y TOMANDO EN CUENTA UNICAMENTE LOS PRODUCTOS CUYO PROVEEDOR (SupplierID) SEA IGUAL A 17, 19, 16.
SELECT  categories.category_name, SUM(products.units_in_stock) as TotalUnitsInStock
FROM products
INNER JOIN categories ON products.category_id = categories.category_id
WHERE products.supplier_id IN (16, 17, 19)
GROUP BY  categories.category_name;
--cuya categoria tenga menos de 100 unidades ordenado por unidades
SELECT categories.category_name, SUM(products.units_in_stock) as TotalUnitsInStock
FROM products
INNER JOIN categories ON products.category_id = categories.category_id
WHERE products.supplier_id IN (16, 17, 19)
  AND categories.category_name IN (
    SELECT category_name  FROM products
    JOIN categories ON products.category_id = categories.category_id
    GROUP BY category_name
    HAVING SUM(units_in_stock) < 100
  )
GROUP BY categories.category_name
ORDER BY categories.category_name ASC;




