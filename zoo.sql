
CREATE SEQUENCE  id_zoo_s;
create table if not exists zoo(
	id_zoo int default nextval ('id_zoo_s') not null,
	nombre character varying not null,
	ciudad character varying not null,
	pais character varying not null,
	tamano integer not null,
	Primary key  (id_zoo)
);


CREATE SEQUENCE  id_especie_s;
create table if not exists "especie"(
	id_especie int default nextval ('id_especie_s') not null,
	nombre_vulgar character varying not null,
	nombre_científico character varying not null,
	familia character varying not null,
	extinción boolean not null,
	Primary key  (id_especie)
);
CREATE SEQUENCE  id_animal_s;
create table if not exists "especie"(
	id_animal int default nextval ('id_animal_s') not null,
	id_especie integer not null,
	id_zoo integer not null,
	sexo char(1), check(genero in ('H','M')),
	continente character varying not null,
	pais character varying not null,
	anonacimiento date not null,
	Primary key  (id_animal),
	constraint fk_especie foreign key (id_zoo) references especie(id_especie),
	constraint fk_zoo foreign key (id_zoo) references zoo(id_zoo)
);