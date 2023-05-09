--Subconsultas


-- Obtener los productos cuyo precio unitario sea mayor al precio promedio de la tabla de productos
SELECT * FROM products WHERE unit_price > (SELECT AVG(unit_price) FROM products);
-- Obtener los productos cuya cantidad en stock sea menor al promedio de cantidad en stock de toda la tabla de productos.
SELECT * FROM products WHERE units_in_stock < (SELECT AVG(units_in_stock) FROM products);
-- Obtener los productos cuya cantidad en Inventario (units_in_stock) sea menor a la cantidad mínima del detalle de ordenes (order_details)
SELECT *
FROM products,
    (SELECT MIN(quantity) as min_qty FROM order_details) as sub
WHERE units_in_stock < sub.min_qty;

--OBTENER LOS PRODUCTOS CUYA CATEGORIA SEA IGUAL A LAS CATEGORIAS DE LOS PRODUCTOS CON PROVEEDOR 1.
SELECT * FROM products WHERE category_id IN (SELECT category_id FROM products WHERE supplier_id = 1);


-- Subconsultas correlacionadas 


--Obtener el número de empleado y el apellido para aquellos empleados que tengan menos de 100 ordenes.
SELECT employee_id, last_name FROM employees WHERE employee_id IN (SELECT employee_id FROM Orders GROUP BY employee_id HAVING COUNT(*) < 100);
--Obtener la clave de cliente y el nombre de la empresa para aquellos clientes que tengan más de 20 ordenes
SELECT customer_id, company_name FROM customers WHERE customer_id IN (SELECT customer_id FROM Orders GROUP BY customer_id HAVING COUNT(*) > 20);
--Obtener el productoid, el nombre del producto, el proveedor de la tabla de productos para aquellos productos que se hayan vendido menos de 100 unidades (Consultarlo en la tabla de Orders details).
SELECT product_id, product_name, supplier_id 
FROM products 
WHERE product_id IN (SELECT product_id FROM "order_details" GROUP BY product_id HAVING SUM(quantity) < 100);

--Obtener los datos del empleado IDEmpleado y nombre completo De aquellos que tengan mas de 100 ordenes
SELECT employee_id, first_name || ' ' || last_name AS FullName 
FROM employees 
WHERE employee_id IN (SELECT employee_id FROM orders GROUP BY employee_id HAVING COUNT(*) > 100);
--Obtener los datos de Producto product_id, product_name, units_in_stock, unit_price (Tabla products) de los productos que la sumatoria de la cantidad (quantity) de orders details sea mayor a 450
SELECT product_id, product_name, units_in_stock, unit_price 
FROM products 
WHERE product_id IN (SELECT product_id FROM "order_details" GROUP BY product_id HAVING SUM(quantity) > 450);
--Obtener la clave de cliente y el nombre de la empresa para aquellos clientes que tengan más de 20 ordenes
SELECT customer_id, company_name FROM customers WHERE customer_id IN (SELECT customer_id FROM Orders GROUP BY customer_id HAVING COUNT(*) > 20);


--insert

--Insertar un registro en la tabla de Categorias, únicamente se quiere insertar la información del CategoryName y la descripción los Papelería y papelería escolar
INSERT INTO categories (category_id,category_name, description) VALUES ('1006','Papelería ', 'Papelería escolar');
--Dar de alta un producto con product_name, supplier_id, CategoryId, unit_price, units_in_stock Como esta tabla tiene dos clave foraneas hay que ver los datos a dar de alta
INSERT INTO products (product_id,product_name, supplier_id, category_id, unit_price, units_in_stock, discontinued)
VALUES ('100','Nombre del producto', 2, 3, 10.99, 100,1);

--Dar de alta un empleado con last_name, FistName, title, BrithDate
INSERT INTO employees (employee_id,last_name, first_name, title, birth_date)
VALUES ('1007','García', 'Juan', 'Gerente', '1990-01-01');
--Dar de alta una orden, CustomerId, employee_id, Orderdate, ShipVia Como esta tabla tiene dos clave foraneas hay que ver los datos a dar de alta
INSERT INTO orders (order_id,customer_id, employee_id, order_date, ship_via)
VALUES ('1000','VINET', 5, '2023-05-09', 3);
--Dar de alta un order_details, con todos los datos

INSERT INTO order_details (order_id, product_id, unit_price, quantity, discount)
VALUES (10248, 4, 1, 1, 1.05);

--update

-- Cambiar el CategoryName a Verduras de la categoria 10
UPDATE categories
SET category_name = 'Verduras'
WHERE category_id = 10;
-- Actualizar los precios de la tabla de Productos para incrementarlos un 10%
UPDATE products
SET unit_price = unit_price * 1.1;

--ACTUALIZAR EL product_name DEL PRODUCTO 80 A ZANAHORIA ECOLOGICA
UPDATE products
SET product_name = 'Zanahoria ecológica'
WHERE product_id = 80;

--ACTUALIZAR EL first_name DEL EMPLOYEE 10 A ROSARIO 
UPDATE employees
SET first_name = 'ROSARIO'
WHERE employee_id = 10;

--ACTUALIZAR EL ORDERS DETAILS DE LA 11079 PARA QUE SU CANTIDAD SEA 10
UPDATE order_details
SET quantity = 10
WHERE order_id = 10248;

--Delete

--diferencia entre delete y truncate

--La diferencia principal entre DELETE y TRUNCATE es que DELETE elimina las filas una por una,
--lo que puede ser un proceso lento si hay muchas filas a eliminar, 
--mientras que TRUNCATE elimina todas las filas de la tabla de una sola vez, 
--lo que es mucho más rápido. Además, TRUNCATE también elimina todos los datos de la tabla, 
--mientras que DELETE puede ser utilizado para eliminar sólo ciertas filas.
--diferencia entre delete y truncate

--BORRAR EL EMPLEADO 10

DELETE FROM employees WHERE employee_id = 10;
