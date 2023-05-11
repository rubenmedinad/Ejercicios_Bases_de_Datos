--Subconsultas

-- Obtener los productos cuyo precio unitario sea mayor al precio promedio de la tabla de productos
SELECT * FROM Products 
WHERE unit_price > (SELECT AVG(unit_price) FROM Products);


-- Obtener los productos cuya cantidad en stock sea menor al promedio de cantidad en stock de toda la tabla de productos.
SELECT * FROM Products 
WHERE units_in_stock < (SELECT AVG(units_in_stock) FROM Products);


-- Obtener los productos cuya cantidad en Inventario (units_in _stock) sea menor a la cantidad mínima del detalle de ordenes (Order Details)
SELECT * FROM Products 
WHERE units_in_stock < (SELECT MIN(quantity) FROM order_details);


--OBTENER LOS PRODUCTOS CUYA CATEGORIA SEA IGUAL A LAS CATEGORIAS DE LOS PRODUCTOS CON PROVEEDOR 1.
SELECT * FROM Products 
WHERE category_id IN (SELECT category_id FROM Products WHERE supplier_id = 1);


-- Subconsultas correlacionadas 

--Obtener el número de empleado y el apellido para aquellos empleados que tengan menos de 100 ordenes.
SELECT employee_id, last_name FROM Employees 
WHERE employee_id IN (SELECT employee_id FROM Orders 
GROUP BY employee_id 
HAVING COUNT(order_id) < 100);

SELECT employee_id,last_name FROM employees e
where 100 >(select COUNT(order_id) from orders o where e.employee_id = o.employee_id);

--Obtener la clave de cliente y el nombre de la empresa para aquellos clientes que tengan más de 20 ordenes
SELECT customer_id, company_name FROM Customers 
WHERE customer_id IN (SELECT customer_id FROM Orders 
GROUP BY customer_id 
HAVING COUNT(*) > 20);

SELECT customer_id, company_name FROM Customers c
WHERE 20 < (select count(*) from orders o where c.customer_id = o.customer_id );

--Obtener el productoid, el nombre del producto, el proveedor de la tabla de productos para aquellos productos que se hayan vendido menos de 100 unidades (Consultarlo en la tabla de Orders details).
SELECT product_id, product_name, supplier_id FROM Products 
WHERE product_id IN (SELECT product_id FROM order_details 
WHERE quantity < 100);

SELECT product_id, product_name, supplier_id FROM products p
WHERE 100 < (select count(product_id) from order_details o where p.units_on_order = o.quantity)

select * from order_details where quantity<100

--Obtener los datos del empleado IDEmpleado y nombre completo De aquellos que tengan mas de 100 ordenes
SELECT employee_id, first_name || ' ' || last_name AS FullName FROM Employees 
WHERE employee_id IN (SELECT employee_id FROM Orders 
GROUP BY employee_id 
HAVING COUNT(*) > 100);

SELECT employee_id, first_name || ' ' || last_name AS FullName FROM Employees e
WHERE 100 < (select count(*) from orders o where e.employee_id = o.employee_id)

--Obtener los datos de Producto product_id, product_name, units_in _stock, unit_price (Tabla Products) de los productos que la sumatoria de la cantidad (quantity) de orders details sea mayor a 450
SELECT product_id, product_name, units_in_stock, unit_price FROM Products 
WHERE product_id IN (SELECT product_id FROM  order_details
GROUP BY product_id 
HAVING SUM(quantity) > 450);

SELECT product_id, product_name, units_in_stock, unit_price FROM Products 
WHERE product_id IN

--Obtener la clave de cliente y el nombre de la empresa para aquellos clientes que tengan más de 20 ordenes.
SELECT customer_id, company_name FROM Customers 
WHERE customer_id IN (SELECT customer_id FROM Orders 
                     GROUP BY customer_id 
                     HAVING COUNT(*) > 20);



--insert

--Insertar un registro en la tabla de Categorias, únicamente se quiere insertar la información del CategoryName y la descripción los Papelería y papelería escolar
INSERT INTO Categories (category_id,category_name, description)
VALUES ('10','Papelería', 'Descripción de la categoría de papelería escolar');


--Dar de alta un producto con product_name, siupplier_id, category_id, unit_price, units_in _stock Como esta tabla tiene dos clave foraneas hay que ver los datos a dar de alta
INSERT INTO Products (product_id,product_name, supplier_id, category_id, unit_price, units_in_stock,discontinued)
VALUES ('100','Nombre del producto', 1, 2, 10.5, 100,1);


--Dar de alta un empleado con LastName, FistName, Title, BrithDate
INSERT INTO Employees (employee_id,last_name, first_name, title, birth_date)
VALUES ('100','Apellido', 'Nombre', 'Título del empleado', '1990-01-01');

--Dar de alta una orden, customer_id, employee_id, Orderdate, ShipVia Como esta tabla tiene dos clave foraneas hay que ver los datos a dar de alta
INSERT INTO Orders (order_id,customer_id, employee_id, order_date, ship_via)
VALUES ('100','VINET', 2, '2023-05-09', 3);

--Dar de alta un Order details, con todos los datos
INSERT INTO order_details (order_id, product_id, unit_price, quantity, discount)
VALUES ('10248', '4', '1', '1', '1');


--update

-- Cambiar el CategoryName a Verduras de la categoria 10
UPDATE Categories
SET category_name = 'Verduras'
WHERE category_id = 10;

select* from categories
-- Actualizar los precios de la tabla de Productos para incrementarlos un 10%
UPDATE Products
SET unit_price = unit_price * 1.1;


--ACTUALIZAR EL product_name DEL PRODUCTO 80 A ZANAHORIA ECOLOGICA
UPDATE Products
SET product_name = 'ZANAHORIA ECOLOGICA'
WHERE product_id = 80;

--ACTUALIZAR EL FIRSTNAME DEL EMPLOYEE 10 A ROSARIO 
UPDATE Employees
SET first_name = 'ROSARIO'
WHERE employee_id = 10;

--ACTUALIZAR EL ORDERS DETAILS DE LA 11079 PARA QUE SU CANTIDAD SEA 10
UPDATE order_details
SET quantity = 10
WHERE order_id = 11079;

--Delete

--diferencia entre delete y truncate


--BORRAR EL EMPLEADO 10
DELETE FROM Employees WHERE employee_id = 10;