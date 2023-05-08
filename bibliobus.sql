CREATE SEQUENCE  id_poblacion_s;
create table if not exists Poblacion(
	id_poblacion int default nextval (' id_poblacion_s') not null,
	nombre_poblacion character varying not null,
	n_habitantes integer not null,
	
	constraint pk_poblacion Primary key (id_poblacion)
	);



CREATE SEQUENCE  id_libro_s;
create table if not exists Libro(
	id_libro int default nextval ('id_libro_s') not null,
	editorial character varying not null,
	autor character varying not null,
	titulo character varying not null,
	cantidad numeric not null,
	
	constraint pk_libro Primary key (id_libro)
	);



CREATE SEQUENCE id_coleccion_s;
CREATE TABLE IF NOT EXISTS Coleccion (
  id_coleccion INT DEFAULT NEXTVAL('id_coleccion_s') NOT NULL,
  cantidad NUMERIC NOT NULL,
  CONSTRAINT pk_coleccion PRIMARY KEY (id_coleccion)
);


CREATE SEQUENCE  id_libroalmacen_s;
create table if not exists Libroalmacen(
	id_libroalmacen int default nextval (' id_libroalmacen_s') not null,
	id_libro integer not null,
	id_almacen integer not null,
	stock numeric not null,
	
	constraint pk_libroalmacen Primary key ( id_libroalmacen)
	);

CREATE SEQUENCE  id_almacen_s;
create table if not exists Almacen(
	id_almacen int default nextval (' id_almacen_s') not null,
	fecha_apertura date not null,
	nombre_almacen character varying not null,
	direccion character varying not null,
	constraint pk_almacen Primary key ( id_almacen)
);


CREATE SEQUENCE  id_provincia_s;
create table if not exists Provincia(
	id_provincia int default nextval (' id_provincia_s') not null,
	nombre_provincia character varying not null,
	extensión integer not null,
	constraint pk_provincia Primary key ( id_provincia)
	);


CREATE SEQUENCE  id_socio_s;
create table if not exists Socio(
	id_socio int default nextval ('id_socio_s') not null,
	id_poblacion integer not null,
	nombre character varying not null,
	apellido character varying not null,
	dni character varying unique not null,
	avalista character varying not null,
	telefono character varying not null,
	poblacion character varying not null,
	constraint pk_socio Primary key (id_socio)
	);

CREATE SEQUENCE  id_pedido_s;
create table if not exists Pedido(
	id_pedido int default nextval ('id_pedido_s') not null,
	id_socio integer not null,
	forma_envio character varying not null,
	forma_pago character varying not null,
	constraint pk_pedido Primary key (id_pedido)
);

CREATE SEQUENCE  id_detalle_s;
create table if not exists Detalle(
	id_detalle int default nextval ('id_detalle_s') not null,
	id_coleccion integer not null,
	id_pedido integer not null,
	id_libro integer not null,
	
	cantidad numeric not null,
	constraint pk_detalle Primary key (id_detalle)
);


ALTER TABLE IF EXISTS public. Socio
ADD CONSTRAINT fk_socio_pobacion FOREIGN KEY (id_poblacion)
REFERENCES Poblacion (id_poblacion) MATCH SIMPLE
ON UPDATE NO ACTION
ON DELETE NO ACTION
NOT VALID;

ALTER TABLE IF EXISTS public. Detalle
ADD CONSTRAINT fk_detalle_coleccion  FOREIGN KEY (id_coleccion)
REFERENCES public. Coleccion (id_coleccion) MATCH SIMPLE
ON UPDATE NO ACTION
ON DELETE NO ACTION
NOT VALID;
ALTER TABLE IF EXISTS public. Libroalmacen
ADD CONSTRAINT fk_id_libroalmacen_libro  FOREIGN KEY (id_libro) 
REFERENCES public. Libro (id_libro) MATCH SIMPLE
ON UPDATE NO ACTION
ON DELETE NO ACTION
NOT VALID;
ALTER TABLE IF EXISTS public. Libroalmacen
ADD CONSTRAINT fk_id_libroalmacen_almacen  FOREIGN KEY (id_almacen) 
REFERENCES public. Almacen (id_almacen) MATCH SIMPLE
ON UPDATE NO ACTION
ON DELETE NO ACTION
NOT VALID;
ALTER TABLE IF EXISTS public. Pedido
ADD CONSTRAINT fk_pedido_socio  FOREIGN KEY (id_socio)
REFERENCES public. Socio (id_socio) MATCH SIMPLE
ON UPDATE NO ACTION
ON DELETE NO ACTION
NOT VALID;
ALTER TABLE IF EXISTS public. Detalle
ADD CONSTRAINT fk_detalle_pedido  FOREIGN KEY (id_pedido) 
REFERENCES public. Pedido (id_pedido) MATCH SIMPLE
ON UPDATE NO ACTION
ON DELETE NO ACTION
NOT VALID;
ALTER TABLE IF EXISTS public. Detalle
ADD CONSTRAINT fk_detalle_libro  FOREIGN KEY (id_libro) 
REFERENCES public. libro (id_libro) MATCH SIMPLE
ON UPDATE NO ACTION
ON DELETE NO ACTION
NOT VALID;












