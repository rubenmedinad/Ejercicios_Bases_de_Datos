CREATE TABLE cuentas (
  	idcuentas serial PRIMARY KEY,
  	saldo numeric,
);

CREATE TABLE movimientos (
  	idmovientos serial PRIMARY KEY,
  	tipo_movimiento VARCHAR(10),
	id_cuenta numeric,
  	monto numeric
);

INSERT INTO cuentas (saldo) VALUES (1000.00);
INSERT INTO cuentas (saldo) VALUES (2500.00);

CREATE OR REPLACE PROCEDURE insertareo(
  	IN id_cuenta integer,
  	IN tipo_movimiento varchar(10),
  	IN monto numeric
)
LANGUAGE plpgsql
AS $$
BEGIN
	IF (tipo_movimiento = 'ingreso') THEN 
		UPDATE cuentas
    	SET saldo = saldo + monto
   		WHERE idcuentas = id_cuenta;
		
	ELSIF (tipo_movimiento = 'retirada') THEN
		IF (SELECT saldo FROM cuentas WHERE idcuentas = id_cuenta) < monto THEN
			RAISE EXCEPTION 'No tiene suficiente saldo';
	 	ELSE
			UPDATE cuentas
    		SET saldo = saldo - monto
    		WHERE idcuentas = id_cuenta;
    	END IF;
	END IF;
	
	INSERT INTO movimientos (tipo_movimiento, monto)
    VALUES (tipo_movimiento, monto);
	
	EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
	COMMIT;
END;
$$;
--  ejercicio 2 trigguer
CREATE TABLE cuentas (
  	idcuentas serial PRIMARY KEY,
  	saldo numeric
);

CREATE TABLE movimientos (
  	idmovientos serial PRIMARY KEY,
  	tipo_movimiento VARCHAR(10),
	id_cuenta numeric,
  	monto numeric
);

CREATE OR REPLACE FUNCTION actualizar()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipo_movimiento = 'ingreso' THEN 
        UPDATE cuentas
        SET saldo = saldo + NEW.monto
        WHERE idcuentas = NEW.id_cuenta;
    ELSIF NEW.tipo_movimiento = 'retirada' THEN
        IF (SELECT saldo FROM cuentas WHERE idcuentas = NEW.id_cuenta) < NEW.monto THEN
            RAISE EXCEPTION 'No tiene suficiente saldo';
        ELSE
            UPDATE cuentas
            SET saldo = saldo - NEW.monto
            WHERE idcuentas = NEW.id_cuenta;
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insertar_movimiento
AFTER INSERT ON movimientos
FOR EACH ROW
EXECUTE FUNCTION actualizar();

INSERT INTO movimientos (tipo_movimiento,id_cuenta, monto) VALUES ('ingreso',1, 200);

SELECT * FROM cuentas;

--ejercicio 3

CREATE OR REPLACE FUNCTION actualizar()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipo_movimiento = 'ingreso' THEN 
        UPDATE cuentas
        SET saldo = saldo + NEW.monto
        WHERE idcuentas = NEW.id_cuenta;
    ELSIF NEW.tipo_movimiento = 'retirada' THEN
        IF (SELECT saldo FROM cuentas WHERE idcuentas = NEW.id_cuenta) < NEW.monto THEN
            RAISE EXCEPTION 'No tiene suficiente saldo';
        ELSE
            UPDATE cuentas
            SET saldo = saldo - NEW.monto
            WHERE idcuentas = NEW.id_cuenta;
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER actualizar_cuenta_despues_insertar
AFTER INSERT ON movimientos
FOR EACH ROW
EXECUTE FUNCTION actualizar();

INSERT INTO cuentas (saldo) VALUES (500);
SELECT * FROM movimientos;
