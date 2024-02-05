/*1*/
DROP TABLE suscripcion CASCADE CONSTRAINT;
DROP TABLE produccion CASCADE CONSTRAINT;
DROP TABLE pelicula;
DROP TABLE serie;
DROP TABLE reproduccion CASCADE CONSTRAINT;
DROP TABLE usuario CASCADE CONSTRAINT;
DROP TABLE colaboradores CASCADE CONSTRAINT;
DROP TABLE actor;
DROP TABLE director;
DROP TABLE comentario;
DROP TABLE pro_col;

CREATE TABLE produccion(
titulo      VARCHAR(15),
f_estreno   DATE,
sinopsis    VARCHAR(250),
idioma      VARCHAR(2)    CONSTRAINT ck_idioma_pro CHECK(idioma='ES' OR idioma='EN' OR idioma='IT' OR idioma='FR'),
genero      VARCHAR(3)    CONSTRAINT ck_ge_pro     CHECK(genero='COM' OR genero='DRA' OR genero='TER' OR genero='ROM' OR genero='FIC'),
duracion    NUMBER(5),
CONSTRAINT pk_produccion PRIMARY KEY (titulo, f_estreno)
);

CREATE TABLE pelicula(
titulo      VARCHAR(15),
f_estreno   DATE,
n_sem       NUMBER(1),
CONSTRAINT pk_pelicula PRIMARY KEY(titulo, f_estreno),
CONSTRAINT fk_pelicula FOREIGN KEY (titulo, f_estreno) REFERENCES produccion
);

CREATE TABLE serie(
titulo      VARCHAR(15),
f_estreno   DATE,
n_tem       NUMBER(2),
n_cap       NUMBER(3),
CONSTRAINT pk_serie PRIMARY KEY(titulo, f_estreno),
CONSTRAINT fk_serie FOREIGN KEY (titulo, f_estreno) REFERENCES produccion
);

CREATE TABLE suscripcion(
cod_sus  NUMBER(3)    CONSTRAINT pk_suscripcion PRIMARY KEY,
tarifa   NUMBER(4,2)  CONSTRAINT nn_tarifa_su   NOT NULL,
f_ini    DATE         CONSTRAINT nn_f_ini_su    NOT NULL,
f_fin    DATE         CONSTRAINT nn_f_fin_su    NOT NULL
);

CREATE TABLE usuario(
email     VARCHAR(20)  CONSTRAINT pk_usuario PRIMARY KEY,
nombre    VARCHAR(10) CONSTRAINT nn_nom_us  NOT NULL,
apellidos VARCHAR(20) CONSTRAINT nn_ape_us  NOT NULL,
f_nac     DATE,
cod_sus   NUMBER(3)   CONSTRAINT fk_cod_sus_us REFERENCES suscripcion
);

CREATE TABLE reproduccion(
cod_rep     NUMBER(3)     CONSTRAINT pk_reproduccion PRIMARY KEY,
fecha       DATE,
email       VARCHAR(20)    CONSTRAINT fk_email_rep REFERENCES usuario,
titulo      VARCHAR(15),
f_estreno   DATE,
CONSTRAINT fk_reproduccion FOREIGN KEY (titulo, f_estreno) REFERENCES produccion
);

CREATE TABLE colaboradores(
id_colab    NUMBER(3)     CONSTRAINT pk_colaboradores PRIMARY KEY,
premios     NUMBER(2),
nombre      VARCHAR(10)   CONSTRAINT nn_nombre_col    NOT NULL,
apellidos   VARCHAR(20)   CONSTRAINT nn_apellidos_col NOT NULL
);

CREATE TABLE actor(
id_colab    NUMBER(3),
debut       NUMBER(4),
CONSTRAINT pk_actor PRIMARY KEY(id_colab),
CONSTRAINT fk_actor FOREIGN KEY(id_colab) REFERENCES colaboradores
);

CREATE TABLE director(
id_colab    NUMBER(3),
n_direc     NUMBER(2),
CONSTRAINT pk_diretor PRIMARY KEY(id_colab),
CONSTRAINT fk_director FOREIGN KEY(id_colab) REFERENCES colaboradores
);

CREATE TABLE comentario(
cod_coment    NUMBER(3)      CONSTRAINT pk_comentario PRIMARY KEY,
calific       NUMBER(2)      CONSTRAINT ck_calific_co CHECK(calific >= 1 OR calific <= 10),
descrip        VARCHAR(100),
email         VARCHAR(20)     CONSTRAINT fk_email_co REFERENCES usuario,
titulo        VARCHAR(15), 
f_estreno     DATE,
CONSTRAINT fk_comentario FOREIGN KEY (titulo, f_estreno) REFERENCES produccion
);

CREATE TABLE pro_col(
titulo      VARCHAR(15),
f_estreno   DATE,
id_colab    NUMBER(4)     CONSTRAINT fk_id_colab_pro_col REFERENCES colaboradores,
CONSTRAINT pk_pro_col PRIMARY KEY(titulo, f_estreno, id_colab),
CONSTRAINT fk_pro_col FOREIGN KEY (titulo, f_estreno) REFERENCES produccion
);

/*2*/

INSERT INTO produccion VALUES('Cartas a Juliet','14-05-2010','Amor en viñedos','IT','DRA', 105);
INSERT INTO produccion VALUES('Toc Toc','06-10-2018','Basada en tocs','ES','COM', 96);
INSERT INTO produccion VALUES('Ouija','05-12-2014','Basado en demonios','EN','TER', 120);
INSERT INTO produccion VALUES('Velvet','21-11-2017','Amor en Marid','ES','ROM', 15400);
INSERT INTO produccion VALUES('Friends','22-09-1994','Vida de 6 amigos','EN','COM', 47200);
INSERT INTO produccion VALUES('Los 100','19-04-2014','Después del fin del mundo','EN','FIC', 19092);

INSERT INTO pelicula VALUES('Cartas a Juliet','14-05-2010',3);
INSERT INTO pelicula VALUES('Toc Toc','06-10-2018',2);
INSERT INTO pelicula VALUES('Ouija','05-12-2014',2);

INSERT INTO serie VALUES('Velvet','21-11-2017',4,55);
INSERT INTO serie VALUES('Friends','22-09-1994',10,236);
INSERT INTO serie VALUES('Los 100','19-04-2014',6,74);

INSERT INTO suscripcion VALUES(235, 12.99, '12-04-2019', '12-07-2019');
INSERT INTO suscripcion VALUES(754, 15.99, '17-05-2019', '17-08-2019');
INSERT INTO suscripcion VALUES(976, 18.99, '23-02-2018', '23-05-2019');
INSERT INTO suscripcion VALUES(134, 15.99, '06-05-2019', '06-07-2019');

INSERT INTO usuario VALUES('maria@gmail.com', 'María', 'García Gallardo', '03-12-1999', 235);
INSERT INTO usuario VALUES('roberto@gmail.com', 'Roberto', 'Torres Trujillo', '24-11-1998', 754);
INSERT INTO usuario VALUES('antonio@gmail.com', 'Antonio', 'Santos González', '12-06-1999', 976);
INSERT INTO usuario VALUES('ana@gmail.com', 'Ana', 'Basales Román', '30-03-2000', 134);

INSERT INTO reproduccion VALUES(025,'19-05-2019','roberto@gmail.com','Toc Toc','06-10-2018');
INSERT INTO reproduccion VALUES(018,'14-04-2019','maria@gmail.com','Velvet','21-11-2017');
INSERT INTO reproduccion VALUES(020,'09-05-2019','ana@gmail.com','Friends','22-09-1994');
INSERT INTO reproduccion VALUES(010,'28-08-2018','antonio@gmail.com','Los 100','19-04-2014');
INSERT INTO reproduccion VALUES(033,'29-05-2019','roberto@gmail.com','Ouija','05-12-2014');
INSERT INTO reproduccion VALUES(027,'22-05-2019','antonio@gmail.com','Cartas a Juliet','14-05-2010');
INSERT INTO reproduccion VALUES(012,'25-04-2019','maria@gmail.com','Toc Toc','06-10-2018');
INSERT INTO reproduccion VALUES(104,'16-08-2019','roberto@gmail.com','Friends','22-09-1994');

INSERT INTO colaboradores VALUES(001,0,'Olivia','Cooke');
INSERT INTO colaboradores VALUES(002,2,'Daren','Kagasoff');
INSERT INTO colaboradores VALUES(003,12,'Paco','León');
INSERT INTO colaboradores VALUES(004,5,'Tom','Hopper');
INSERT INTO colaboradores VALUES(005,6,'Amanda','Seyfreid');
INSERT INTO colaboradores VALUES(006,3,'Bharat','Nallury');
INSERT INTO colaboradores VALUES(007,1,'Paula','Echevaría');
INSERT INTO colaboradores VALUES(008,12,'Jennifer','Anniston');

INSERT INTO actor VALUES(001,1998);
INSERT INTO actor VALUES(002,1989);
INSERT INTO actor VALUES(003,2000);
INSERT INTO actor VALUES(005,2001);
INSERT INTO actor VALUES(007,1999);
INSERT INTO actor VALUES(008,1996);

INSERT INTO director VALUES(003,3);
INSERT INTO director VALUES(004,7);
INSERT INTO director VALUES(006,3);

INSERT INTO comentario VALUES(025,8,'Muy graciosa','roberto@gmail.com','Toc Toc','06-10-2018');
INSERT INTO comentario VALUES(018,NULL,'Esta bien','maria@gmail.com','Velvet','21-11-2017');
INSERT INTO comentario VALUES(020,10,'Antigua pero de las mejores','ana@gmail.com','Friends','22-09-1994');
INSERT INTO comentario VALUES(010,3,'Aburrida','antonio@gmail.com','Los 100','19-04-2014');
INSERT INTO comentario VALUES(033,8,'No verla solo','roberto@gmail.com','Ouija','05-12-2014');
INSERT INTO comentario VALUES(027,6,'Muero de amor','antonio@gmail.com','Cartas a Juliet','14-05-2010');
INSERT INTO comentario VALUES(012,9,'No me esperaba el final','maria@gmail.com','Toc Toc','06-10-2018');
INSERT INTO comentario VALUES(104,10,'¿Cuándo la siguiente?','roberto@gmail.com','Friends','22-09-1994');

INSERT INTO pro_col VALUES('Ouija','05-12-2014',001);
INSERT INTO pro_col VALUES('Ouija','05-12-2014',002);
INSERT INTO pro_col VALUES('Toc Toc','06-10-2018',003);
INSERT INTO pro_col VALUES('Los 100','19-04-2014',004);
INSERT INTO pro_col VALUES('Cartas a Juliet','14-05-2010',005);
INSERT INTO pro_col VALUES('Los 100','19-04-2014',006);
INSERT INTO pro_col VALUES('Velvet','21-11-2017',007);
INSERT INTO pro_col VALUES('Friends','22-09-1994',008);
INSERT INTO pro_col VALUES('Cartas a Juliet','14-05-2010',002);
INSERT INTO pro_col VALUES('Velvet','21-11-2017',003);


/*VISTAS*/

CREATE OR REPLACE VIEW produccion_sin_com
AS SELECT *
    FROM produccion
    WHERE genero <> 'COM';
    
CREATE OR REPLACE VIEW comentario_calific_mas_5
AS SELECT *
    FROM comentario
    WHERE calific > 5;
       
CREATE OR REPLACE VIEW num_producciones_colabs    
AS SELECT nombre,apellidos,COUNT(titulo)"Num. producciones"
    FROM pro_col, colaboradores
    WHERE pro_col.id_colab=colaboradores.id_colab
    GROUP BY nombre,apellidos;

CREATE OR REPLACE VIEW colabs_de_produc_españolas
AS SELECT co.id_colab, co.nombre, co.apellidos, pr.titulo
    FROM pro_col pc, produccion pr, colaboradores co
    WHERE co.id_colab = pc.id_colab AND pc.titulo = pr.titulo AND pr.idioma = 'ES';


/*3*/

/*3.1*/
SELECT nombre||' '||apellidos "Nombre y Apellidos",f_fin
FROM usuario, suscripcion
WHERE email ='ana@gmail.com' AND usuario.cod_sus = suscripcion.cod_sus;

/*3.2*/
SELECT descrip, pro.titulo
FROM  comentario, produccion pro
WHERE comentario.email = 'roberto@gmail.com' AND comentario.titulo = pro.titulo;

/*3.3*/
SELECT pr.*
FROM produccion pr, pro_col
WHERE id_colab=002 AND pro_col.titulo=pr.titulo;

/*3.4*/
SELECT titulo, AVG(calific)"Calificacion media"
FROM comentario 
WHERE titulo='Toc Toc'
GROUP BY titulo;

/*3.5*/
SELECT nombre||' '||apellidos "Nombre y Apellidos", f_ini
FROM usuario, suscripcion
WHERE usuario.cod_sus=suscripcion.cod_sus AND f_ini=(SELECT MIN(f_ini)
                                                      FROM suscripcion);

/*3.6*/
SELECT nombre||' '||apellidos "Nombre y Apellidos", f_fin - f_ini "Dias de suscripcion"
FROM suscripcion, usuario
WHERE usuario.email = 'maria@gmail.com' AND suscripcion.cod_sus=usuario.cod_sus;

/*3.7*/
SELECT nombre||' '||apellidos "Nombre y Apellidos", TO_CHAR(SYSDATE,'YYYY')-TO_CHAR(debut)"Años actuando"
FROM actor, colaboradores
WHERE actor.id_colab = colaboradores.id_colab AND colaboradores.nombre='Jennifer'; 

/*3.8*/
SELECT *
FROM produccion
WHERE genero <> 'ROM';
                  
/*3.9*/
SELECT *
FROM comentario
WHERE titulo='Toc Toc';

/*3.10*/
SELECT co.id_colab, premios, nombre, apellidos
FROM actor, colaboradores co
WHERE premios >2 AND actor.id_colab = co.id_colab;

/*3.11*/
SELECT SUM(premios)"Total de premios"
FROM colaboradores co, actor ac
WHERE co.id_colab = ac.id_colab;

/*3.12*/
SELECT co.id_colab, co.nombre, apellidos
FROM pro_col pc, produccion pr, colaboradores co
WHERE co.id_colab = pc.id_colab AND pc.titulo = pr.titulo AND pr.idioma = 'EN';

/*3.13*/
SELECT *
FROM produccion
WHERE genero = 'COM';

/*3.14*/
SELECT *
FROM produccion
WHERE f_estreno > '01-01-2000' AND f_estreno < '31-12-2015' AND idioma = 'EN';


/*3.15*/
SELECT s.cod_sus, tarifa, f_ini, u.email
FROM suscripcion s, usuario u
WHERE s.cod_sus = u.cod_sus AND f_ini > '31/12/2017' AND f_ini < '01/01/2019';

/*3.16*/
SELECT co.descrip, co.email, co.titulo
FROM comentario co, produccion pr
WHERE co.email = 'antonio@gmail.com' AND pr.titulo = co.titulo;

/*3.17*/
SELECT c.nombre, c.apellidos, pc.titulo
FROM colaboradores c, pro_col pc
WHERE c.id_colab IN (SELECT id_colab 
                    FROM actor
                    WHERE id_colab IN (SELECT id_colab 
                                        FROM director)) AND c.id_colab = pc.id_colab;                                       

/*3.18*/
SELECT co.calific "Calificación mínima", co.titulo, pr.sinopsis
FROM  comentario co, produccion pr
WHERE pr.titulo = co.titulo AND calific = (SELECT MIN(calific)
                                           FROM  comentario);

/*3.19*/
SELECT AVG(calific) "Calific Media", titulo
FROM comentario
GROUP BY titulo
HAVING AVG(calific)>8;

/*3.20*/
SELECT calific, titulo
FROM comentario
WHERE calific IS NOT NULL
ORDER BY 1 DESC;

/*3.21*/

SELECT cod_coment, calific, descrip, email, titulo, LENGTH(descrip) "Caracteres"
FROM comentario
WHERE LENGTH(descrip) = (SELECT MAX(LENGTH(descrip))
                        FROM comentario);

/*3.22*/
SELECT pc1.titulo, co1.nombre "Nombre 1", co2.nombre "Nombre 2"
FROM pro_col pc1, pro_col pc2, colaboradores co1, colaboradores co2
WHERE pc1.titulo=pc2.titulo AND pc1.id_colab < pc2.id_colab AND pc1.id_colab = co1.id_colab AND pc2.id_colab = co2.id_colab AND pc1.titulo = pc2.titulo;                               

/*3.23*/
SELECT tarifa, email
FROM usuario, suscripcion
WHERE tarifa > 15 AND usuario.cod_sus=suscripcion.cod_sus;

/*3.24*/
SELECT nombre,apellidos,COUNT(titulo)"Num. producciones"
FROM pro_col, colaboradores
WHERE pro_col.id_colab=colaboradores.id_colab
GROUP BY nombre,apellidos;

/*3.25*/
SELECT email,COUNT(*)"Num. producciones visualizadas"
FROM reproduccion 
GROUP BY email
HAVING COUNT(*)>1 ;



/*4*/

/*4.1.1*/
INSERT INTO comentario (SELECT 015, 5, 'Regulera', email, 'Cartas a Juliet', '14-05-2010'
                        FROM comentario
                        WHERE email = 'ana@gmail.com');

/*4.1.2*/
INSERT INTO colaboradores (SELECT 009, premios, 'Borja', 'Lopez'
                            FROM colaboradores
                            WHERE nombre = 'Tom');

/*4.1.3*/
INSERT INTO produccion (SELECT 'Los Miserables', '12-03-1999','Basada en la antigua Francia','FR','DRA',NULL
                        FROM produccion
                        WHERE duracion = 96);

/*4.1.4*/
INSERT INTO usuario (SELECT 'ramon@gmail.com', 'Ramón', apellidos, NULL, NULL
                    FROM usuario
                    WHERE apellidos = 'Santos González');
                    
/*4.2.1*/
UPDATE suscripcion s SET f_fin = '12-11-2019'
WHERE s.cod_sus = (SELECT su.cod_sus
                    FROM suscripcion su, usuario u
                    WHERE u.nombre = 'María' AND u.cod_sus = su.cod_sus);

/*4.2.2*/
UPDATE colaboradores c SET premios = premios +1
WHERE c.id_colab IN (SELECT id_colab
                    FROM pro_col
                    WHERE titulo = 'Los 100' AND f_estreno = '19/04/2014');
                    
/*4.2.3*/
UPDATE comentario c SET calific = 6
WHERE c.email = (SELECT u.email
                FROM usuario u
                WHERE u.nombre = 'María') AND c.titulo = 'Velvet' AND c.f_estreno = '21/11/2017';
                
/*4.3.1*/
DELETE FROM comentario c
WHERE c.email = (SELECT email
                FROM usuario
                WHERE nombre = 'Ana' AND apellidos = 'Basales Román');

/*4.3.2*/
DELETE FROM actor
WHERE id_colab IN (SELECT id_colab
                    FROM colaboradores
                    WHERE premios = (SELECT MIN(premios)
                                    FROM colaboradores));
                                    
/*4.3.3*/
DELETE FROM reproduccion
WHERE email = (SELECT email
                FROM usuario
                WHERE nombre = 'Ana' AND apellidos = 'Basales Román');





