CREATE TABLE IF NOT EXISTS cuentas (
  cuenta serial PRIMARY KEY,
  saldo numeric
);

CREATE TABLE IF NOT EXISTS movimientos (
  id serial PRIMARY KEY,
  id_cuenta INT,
  tipo_movimiento varchar(20),
  monto numeric(10,2)
);

CREATE OR REPLACE FUNCTION registrar_movimiento (id_cuenta INT, tipo_movimiento VARCHAR(50), monto DECIMAL(10,2))
RETURNS INT
AS $$
DECLARE 
    movimiento_id INT;
    saldo_actual numeric;
BEGIN
    BEGIN
        SELECT saldo INTO saldo_actual FROM cuentas WHERE cuenta = id_cuenta;
        IF tipo_movimiento = 'Retiro' AND saldo_actual < monto THEN
            RAISE EXCEPTION 'Saldo insuficiente';
        END IF;
        
        INSERT INTO movimientos (id_cuenta, tipo_movimiento, monto) 
        VALUES (id_cuenta, tipo_movimiento, monto)
        RETURNING id INTO movimiento_id; 
        
        IF tipo_movimiento = 'Depósito' THEN
            UPDATE cuentas SET saldo = saldo + monto WHERE cuenta = id_cuenta;
        ELSIF tipo_movimiento = 'Retiro' THEN
            UPDATE cuentas SET saldo = saldo - monto WHERE cuenta = id_cuenta;
        END IF;
        
        RETURN movimiento_id;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RETURN -1;
    END;
END;
$$ LANGUAGE plpgsql;
