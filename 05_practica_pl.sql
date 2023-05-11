--función sin parametro de entrada para devolver el precio máximo
CREATE FUNCTION preciomaximo()
RETURNS numeric
AS $$
DECLARE
    precio numeric;
BEGIN
    SELECT MAX(unit_price) INTO precio FROM public.products;
    RETURN precio;
END;
$$ LANGUAGE plpgsql;

select preciomaximo()
--parametro de entrada

--Obtener el numero de ordenes por empleado
CREATE FUNCTION numordene(eid numeric)
RETURNS numeric
AS $$
DECLARE
    ordenes numeric;
BEGIN
    SELECT count(order_id) INTO ordenes FROM public.orders where employee_id = eid;
    RETURN ordenes;
END;
$$ LANGUAGE plpgsql;

select numordene(1)
--Obtener la venta de un empleado con un determinado producto
CREATE OR REPLACE FUNCTION ventai(eid numeric, pid numeric)
RETURNS numeric
AS $$
DECLARE
    ventas numeric;
BEGIN
    SELECT sum(od.quantity) INTO ventas 
	FROM public.order_details od
	INNER JOIN public.orders o on od.order_id = o.order_id
	and od.product_id = pid
	and o.employee_id = eid;
    RETURN ventas;
END;
$$ LANGUAGE plpgsql;

select ventai(1, 1)

--Crear una funcion para devolver una tabla con producto_id, nombre, precio y unidades en strock, debe obtener los productos terminados en n
CREATE OR REPLACE FUNCTION terminados()
RETURNS TABLE(producto_id smallint, nombre character varying(40), precio real, unidades_en_stock smallint)
AS $$
BEGIN
    RETURN QUERY
        SELECT producto_id, product_name, unit_price, units_in_stock
        FROM public.products
        WHERE product_name like '%n';
END;
$$ LANGUAGE plpgsql;

select terminados()

-- Creamos la función contador_ordenes_anio()--QUE CUENTE LAS ORDENES POR AÑO devuelve una tabla con año y contador
CREATE OR REPLACE FUNCTION contador_ordenes_anox()
RETURNS TABLE(anio NUMERIC, contador bigint)
AS $$
BEGIN
    RETURN QUERY
        SELECT EXTRACT(year from order_date), COUNT(*) 
        FROM public.orders
        GROUP BY EXTRACT (year from order_date)
        ORDER BY EXTRACT (year from order_date);
END;
$$ LANGUAGE plpgsql;

SELECT * FROM contador_ordenes_anox();

--3. Lo mismo que el ejemplo anterior pero con un parametro de entrada que sea el año
CREATE OR REPLACE FUNCTION buscarano(anno numeric)
RETURNS TABLE(anio NUMERIC, contador bigint)
AS $$
BEGIN
    RETURN QUERY
        SELECT EXTRACT(year from order_date), COUNT(*) 
        FROM public.orders
		WHERE EXTRACT(YEAR FROM order_date) = anno
        GROUP BY EXTRACT (year from order_date)
        ORDER BY EXTRACT (year from order_date);
END;
$$ LANGUAGE plpgsql;

SELECT * FROM buscarano(1996);
 --PROCEDIMIENTO ALMACENADO PARA OBTENER PRECIO PROMEDIO Y SUMA DE 
--UNIDADES EN STOCK POR CATEGORIA
