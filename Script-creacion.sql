CREATE TABLE IF NOT EXISTS Material
(
 CODMT character varying(8) NOT NULL,
 NOMB character varying(40) NOT NULL,
 UNMED character varying(5) NOT NULL,
 CATE character varying(2) NOT NULL,
 PRIMARY KEY (CODMT),
 UNIQUE (NOMB)
);

CREATE INDEX idx_codmt_hash ON Material USING HASH (CODMT);

CREATE TABLE IF NOT EXISTS Asistente
(
 CODAS character varying(4) NOT NULL,
 NOMB character varying(40) NOT NULL,
 APEL character varying(40) NOT NULL,
 DNI character varying(8) NOT NULL,
 CELU character varying(9),
 PRIMARY KEY (CODAS),
 UNIQUE (CODAS),
 UNIQUE (DNI)
);

CREATE INDEX idx_codas_hash ON Asistente USING HASH (CODAS);
CREATE UNIQUE INDEX idx_dni_unique ON Asistente (DNI);

CREATE TABLE IF NOT EXISTS Laboratorio
(
 CODLB character varying(3) NOT NULL,
 PABEL character varying(2) NOT NULL,
 NRAUL character varying(3) NOT NULL,
 CODAS character varying(4) NOT NULL,
 PRIMARY KEY (CODLB)
);

CREATE TABLE IF NOT EXISTS Almacen
(
 CODAM character varying(3) NOT NULL,
 PABEL character varying(2) NOT NULL,
 NRAUL character varying(3) NOT NULL,
 CODEN character varying(4) NOT NULL,
 PRIMARY KEY (CODAM),
 UNIQUE (CODAM)
);

CREATE TABLE IF NOT EXISTS Requerimiento
(
 CODAS character varying(4) NOT NULL,
 CODAM character varying(3) NOT NULL,
 CODLB character varying(3) NOT NULL,
 FCHSO date NOT NULL,
 PRIMARY KEY (CODAS, CODAM, FCHSO)
);

CREATE TABLE IF NOT EXISTS Nota
(
 CODMV character varying(12) NOT NULL,
 CODAOR character varying(3) NOT NULL,
 COMACR character varying(3) NOT NULL,
 CODAS character varying(4) NOT NULL,
 FCEMI date NOT NULL,
 CODEN character varying(4) NOT NULL,
 PRIMARY KEY (CODMV),
 UNIQUE (CODMV)
);

CREATE INDEX idx_codmv_hash ON Nota USING HASH (CODMV);
CREATE INDEX idx_fcemi_btree ON Nota USING BTREE (FCEMI);

CREATE TABLE IF NOT EXISTS Encargado
(
 CODEN character varying(4) NOT NULL,
 NOMB character varying(40) NOT NULL,
 APEL character varying(40) NOT NULL,
 DNI character varying(8) NOT NULL,
 CELU character varying(9) NOT NULL,
 NOMBPO character varying(30) NOT NULL,
 PRIMARY KEY (CODEN),
 UNIQUE (CODEN),
UNIQUE (DNI)
);

CREATE TABLE IF NOT EXISTS Plan_Operativo
(
 NOMBPO character varying(30) NOT NULL,
 PRIMARY KEY (NOMBPO)
);

CREATE TABLE IF NOT EXISTS Guarda
(
 CODAM character varying(3) NOT NULL,
 CODMT character varying(8) NOT NULL,
 STCK integer NOT NULL,
 PRIMARY KEY (CODAM, CODMT),
 UNIQUE (CODMT)
);

CREATE TABLE IF NOT EXISTS Registra
(
 NOMBPO character varying(30) NOT NULL,
 CODMT character varying(8) NOT NULL,
 CANT integer NOT NULL,
 PRIMARY KEY (NOMBPO, CODMT)
);

CREATE TABLE IF NOT EXISTS Codigo_Laboratorio
(
 CODAS character varying(4) NOT NULL,
 CODLB character varying(3) NOT NULL,
 PRIMARY KEY (CODAS, CODLB)
);

CREATE TABLE IF NOT EXISTS Indicaciones
(
 CODMT character varying(8) NOT NULL,
 INDC text NOT NULL,
 PRIMARY KEY (CODMT, INDC)
);

CREATE TABLE IF NOT EXISTS Incluye
(
 CODMV character varying(12) NOT NULL,
 CODMT character varying(8) NOT NULL,
 CANT integer NOT NULL,
 PRIMARY KEY (CODMV, CODMT)
);

CREATE TABLE IF NOT EXISTS Solicita
(
 CODAS character varying(4) NOT NULL,
 CODAM character varying(3) NOT NULL,
 FCHSO date NOT NULL,
 CODMT character varying(8) NOT NULL,
 CANT integer NOT NULL,
 PRIMARY KEY (CODAS, CODAM, FCHSO, CODMT)
);

ALTER TABLE IF EXISTS Laboratorio
 ADD FOREIGN KEY (CODAS)
 REFERENCES Asistente (CODAS) MATCH SIMPLE
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 NOT VALID;

ALTER TABLE IF EXISTS Almacen
 ADD FOREIGN KEY (CODEN)
 REFERENCES Encargado (CODEN) MATCH SIMPLE
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 NOT VALID;
 
ALTER TABLE IF EXISTS Requerimiento
 ADD FOREIGN KEY (CODAS)
 REFERENCES Asistente (CODAS) MATCH SIMPLE
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 NOT VALID;
 
ALTER TABLE IF EXISTS Requerimiento
 ADD FOREIGN KEY (CODAM)
 REFERENCES Almacen (CODAM) MATCH SIMPLE
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 NOT VALID;
 
ALTER TABLE IF EXISTS Nota
 ADD FOREIGN KEY (CODEN)
 REFERENCES Encargado (CODEN) MATCH SIMPLE
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 NOT VALID;
 
ALTER TABLE IF EXISTS Encargado
 ADD FOREIGN KEY (NOMBPO)
 REFERENCES Plan_Operativo (NOMBPO) MATCH SIMPLE
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 NOT VALID;
 
ALTER TABLE IF EXISTS Guarda
 ADD FOREIGN KEY (CODAM)
 REFERENCES Almacen (CODAM) MATCH SIMPLE
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 NOT VALID;
 
ALTER TABLE IF EXISTS Registra
 ADD FOREIGN KEY (NOMBPO)
 REFERENCES Plan_Operativo (NOMBPO) MATCH SIMPLE
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 NOT VALID;
 
ALTER TABLE IF EXISTS Registra
 ADD FOREIGN KEY (CODMT)
 REFERENCES Material (CODMT) MATCH SIMPLE
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 NOT VALID;
 
ALTER TABLE IF EXISTS Codigo_laboratorio
 ADD FOREIGN KEY (CODLB)
 REFERENCES Laboratorio (CODLB) MATCH SIMPLE
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 NOT VALID;
 
ALTER TABLE IF EXISTS Indicaciones
 ADD FOREIGN KEY (CODMT)
 REFERENCES Material (CODMT) MATCH SIMPLE
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 NOT VALID;
 
ALTER TABLE IF EXISTS Incluye
 ADD FOREIGN KEY (CODMV)
 REFERENCES Nota (CODMV) MATCH SIMPLE
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 NOT VALID;
 
ALTER TABLE IF EXISTS Incluye
 ADD FOREIGN KEY (CODMT)
 REFERENCES Material (CODMT) MATCH SIMPLE
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 NOT VALID;
 
ALTER TABLE IF EXISTS Solicita
 ADD FOREIGN KEY (CODMT)
 REFERENCES Material (CODMT) MATCH SIMPLE
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 NOT VALID;
 
ALTER TABLE IF EXISTS Solicita
 ADD FOREIGN KEY (CODAS, CODAM, FCHSO)
 REFERENCES Requerimiento (CODAS, CODAM, FCHSO)
MATCH SIMPLE
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 NOT VALID;

INSERT INTO Asistente (CODAS, NOMB, APEL, DNI) 
VALUES 
 ('1489', 'MARCIA JUANA', 'QUEQUEZANA BEDREGAL', '11111111'),
 ('3833', 'LEIDY JUDITH', 'POLA ROMERO', '22222222'),
 ('3347', 'KARIN ANDREA', 'CARNERO CHIRINOS', '33333333'),
 ('1051', 'JOSE ANTONIO', 'VILLANUEVA SALAS', '44444444'),
 ('3372', 'MARILY EUDES', 'PINO ALVAREZ', '55555555');

INSERT INTO Laboratorio (CODLB, PABEL, NRAUL, CODAS) 
VALUES
 ('004', 'H', '404', '1489'),
 ('019', 'H', '103', '3833'),
 ('042', 'F', '202', '3347'),
 ('016', 'H', '202', '1051'),
 ('053', 'O', '301', '3372');

INSERT INTO Plan_Operativo(NOMBPO) 
VALUES 
('PO 2024');

INSERT INTO Encargado (CODEN, NOMB, APEL, DNI, CELU, NOMBPO) 
VALUES 
 ('2691', 'KUKULI', 'MEDINA HUAMAN', '40756493', '959128836', 'PO 2024');

INSERT INTO Almacen (CODAM, PABEL, NRAUL, CODEN) 
VALUES
 ('003', 'H', '102', '2691');

INSERT INTO Material (CODMT, NOMB, UNMED, CATE) 
VALUES
 ('26MT0410', 'Frascos vidrio Ambar B/ANCHA 200ML', 'U', 'MT'),
 ('33EL9835', 'ELECTRODO DE PLATA MARCA-FISHER', 'U', 'EL'),
 ('26RQ0381', 'Potasio Clorato', 'Mg', 'RQ'),
 ('26RQ0223', 'Cloroformo', 'Ml', 'RQ'),
 ('26RQ0131', 'Acido Etilendiamino Tetra Acetico', 'Mg', 'RQ'),
 ('26MT4431', 'FRASCO DE POLIETILENO BLANCO 100 ML', 'U', 'MT');

INSERT INTO Material (CODMT, NOMB, UNMED, CATE) 
VALUES
 ('26MT0011', 'FRASCO DE VIDRIO TRANSPARENTE 500ML', 'U', 'MT'),
 ('33EL2145', 'ELECTRODO DE PH MARCA-HANNA', 'U', 'EL'),
 ('26RQ0456', 'Ácido Sulfúrico', 'Ml', 'RQ'),
 ('26RQ0789', 'Sodio Hidróxido', 'Mg', 'RQ'),
 ('26MT1210', 'BOTELLA DE PLÁSTICO AMBAR 250ML', 'U', 'MT'),
 ('33EL5478', 'SENSOR DE TEMPERATURA TIPO K', 'U', 'EL'),
 ('26RQ0334', 'Ácido Nítrico', 'Ml', 'RQ'),
 ('26RQ0987', 'Etil Alcohol Absoluto', 'Ml', 'RQ'),
 ('26MT6710', 'FRASCO DE POLIPROPILENO 1L', 'U', 'MT'),
 ('33EL6632', 'ELECTRODO SELECTIVO DE IONES', 'U', 'EL');



INSERT INTO Nota (CODMV, CODAOR, COMACR, CODAS, FCEMI, CODEN) 
VALUES
 ('TXLA20241330', '003', '003', '1489', '2024-10-23', '2691'),
 ('TXLA20241331', '003', '003', '3833', '2024-10-23', '2691'),
 ('TXLA20241332', '003', '003', '3347', '2024-10-26', '2691'),
 ('TXLA20241333', '003', '003', '1051', '2024-10-24', '2691'),
 ('TXLA20241335', '003', '003', '3372', '2024-10-26', '2691'),
 ('TXLA20241336', '003', '003', '3372', '2024-10-24', '2691'),
 ('TXLA20241337', '003', '003', '3833', '2024-10-25', '2691');

INSERT INTO Incluye (CODMV, CODMT, CANT) 
VALUES
 ('TXLA20241330', '26MT0410', 2),
 ('TXLA20241331', '33EL9835', 1),
 ('TXLA20241332', '26RQ0381', 250),
 ('TXLA20241333', '26RQ0223', 1),
 ('TXLA20241335', '26RQ0131', 90),
 ('TXLA20241336', '26MT4431', 1),
 ('TXLA20241337', '26RQ0131', 90);

INSERT INTO Guarda (CODAM, CODMT, STCK) 
VALUES
 ('003', '26MT0410', 50),
 ('003', '33EL9835', 20),
 ('003', '26RQ0381', 4000),
 ('003', '26RQ0223', 80),
 ('003', '26RQ0131', 700),
 ('003', '26MT4431', 100),
 ('003', '26MT0011', 120),
 ('003', '33EL2145', 15),
 ('003', '26RQ0456', 150),
 ('003', '26RQ0789', 300),
 ('003', '26MT1210', 200),
 ('003', '33EL5478', 10),
 ('003', '26RQ0334', 200),
 ('003', '26RQ0987', 2000),
 ('003', '26MT6710', 55),
 ('003', '33EL6632', 12);


-- CRUD MATERIAL

CREATE FUNCTION insert_material(
    p_codmt character varying,
    p_nomb character varying,
    p_unmed character varying,
    p_cate character varying
) RETURNS void AS $$
BEGIN
    INSERT INTO Material (CODMT, NOMB, UNMED, CATE)
    VALUES (p_codmt, p_nomb, p_unmed, p_cate);
EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE 'El material con código o nombre ya existe.';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_materiales()
RETURNS TABLE(CODMT character varying, NOMB character varying, UNMED character varying, CATE character varying) AS $$
BEGIN
    RETURN QUERY SELECT m.CODMT, m.NOMB, m.UNMED, m.CATE FROM Material m;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_material(
    p_codmt character varying,
    p_nomb character varying,
    p_unmed character varying,
    p_cate character varying
) RETURNS void AS $$
BEGIN
    UPDATE Material
    SET NOMB = p_nomb,
        UNMED = p_unmed,
        CATE = p_cate
    WHERE CODMT = p_codmt;

    IF NOT FOUND THEN
        RAISE NOTICE 'No se encontró un material con el código %', p_codmt;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION delete_material(
    p_codmt character varying
) RETURNS void AS $$
BEGIN
    DELETE FROM Material
    WHERE CODMT = p_codmt;

    IF NOT FOUND THEN
        RAISE NOTICE 'No se encontró un material con el código %', p_codmt;
    END IF;
END;
$$ LANGUAGE plpgsql;
SELECT n.CODMV, n.CODAOR, n.FCEMI, ma.NOMB, i.CANT FROM Nota n
JOIN Incluye i
ON n.CODMV = i.CODMV
JOIN Material ma
ON i.CODMT = ma.CODMT;


-- CRUD ASISTENTE

CREATE FUNCTION insertar_asistente(
    p_codas character varying,
    p_nomb character varying,
    p_apel character varying,
	p_dni character varying,
	p_celu character varying
)  RETURNS void AS $$
BEGIN
    INSERT INTO Asistente (CODAS, NOMB, APEL, DNI, CELU)
    VALUES (p_codas, p_nomb, p_apel, p_dni, p_celu);
EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE 'El asistente con código o nombre ya existe.';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_asistentes()
RETURNS TABLE(CODAS character varying, NOMB character varying, APEL character varying, DNI character varying, CELU character varying) AS $$
BEGIN
    RETURN QUERY SELECT a.CODAS, a.NOMB, a.APEL, a.DNI, a.CELU FROM Asistente a;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_asistente(
    p_codas character varying,
    p_nomb character varying,
    p_apel character varying,
	p_dni character varying,
	p_celu character varying
) RETURNS void AS $$
BEGIN
    UPDATE Asistente
    SET NOMB = p_nomb,
        APEL = p_apel,
        DNI = p_dni,
		CELU = p_celu
    WHERE CODAS = p_codas;

    IF NOT FOUND THEN
        RAISE NOTICE 'No se encontró un asistente con el código %', p_codas;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION delete_asistente(
    p_codas character varying
) RETURNS void AS $$
BEGIN
    DELETE FROM Asistente
    WHERE CODAS = p_codas;

    IF NOT FOUND THEN
        RAISE NOTICE 'No se encontró un asistente con el código %', p_codmt;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- CRUD LABORATORIO

CREATE OR REPLACE FUNCTION insertar_laboratorio(
    p_codlb character varying,
    p_pabel character varying,
    p_nraul character varying,
	p_codas character varying
)  RETURNS void AS $$
BEGIN
    INSERT INTO Laboratorio (CODLB, PABEL, NRAUL, CODAS)
    VALUES (p_codlb, p_pabel, p_nraul, p_codas);
EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE 'El pabellón con código o nombre ya existe.';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_laboratorios()
RETURNS TABLE(CODLB character varying, PABEL character varying, NRAUL character varying, CODAS character varying) AS $$
BEGIN
    RETURN QUERY SELECT l.CODLB, l.PABEL, l.NRAUL, l.CODAS FROM Laboratorio l;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_laboratorio(
    p_codlb character varying,
    p_pabel character varying,
    p_nraul character varying
) RETURNS void AS $$
BEGIN
    UPDATE Laboratorio
    SET PABEL = p_pabel,
        NRAUL = p_nraul
    WHERE CODLB = p_codlb;

    IF NOT FOUND THEN
        RAISE NOTICE 'No se encontró un laboratorio con el código %', p_codlb;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION delete_laboratorio(
    p_codlb character varying
) RETURNS void AS $$
BEGIN
    DELETE FROM Laboratorio
    WHERE CODLB = p_codlb;

    IF NOT FOUND THEN
        RAISE NOTICE 'No se encontró un laboratorio con el código %', p_codlb;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- CRUD NOTA

CREATE FUNCTION insert_nota(
    p_codmv character varying,
    p_codaor character varying,
    p_comacr character varying,
    p_codas character varying,
    p_fcemi date,
    p_coden character varying
) RETURNS void AS $$
BEGIN
    INSERT INTO Nota (CODMV, CODAOR, COMACR, CODAS, FCEMI, CODEN)
    VALUES (p_codmv, p_codaor, p_comacr, p_codas, p_fcemi, p_coden);
EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE 'La nota con el código % ya existe.', p_codmv;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_notas()
RETURNS TABLE(
    CODMV character varying,
    CODAOR character varying,
    COMACR character varying,
    CODAS character varying,
    FCEMI date,
    CODEN character varying
) AS $$
BEGIN
    RETURN QUERY 
    SELECT n.CODMV, n.CODAOR, n.COMACR, n.CODAS, n.FCEMI, n.CODEN 
    FROM Nota n;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_nota(
    p_codmv character varying,
    p_codaor character varying,
    p_comacr character varying,
    p_codas character varying,
    p_fcemi date,
    p_coden character varying
) RETURNS void AS $$
BEGIN
    UPDATE Nota
    SET CODAOR = p_codaor,
        COMACR = p_comacr,
        CODAS = p_codas,
        FCEMI = p_fcemi,
        CODEN = p_coden
    WHERE CODMV = p_codmv;

    IF NOT FOUND THEN
        RAISE NOTICE 'No se encontró una nota con el código %', p_codmv;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION delete_nota(
    p_codmv character varying
) RETURNS void AS $$
BEGIN
    DELETE FROM Nota
    WHERE CODMV = p_codmv;

    IF NOT FOUND THEN
        RAISE NOTICE 'No se encontró una nota con el código %', p_codmv;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- CRUD ENCARGADO

CREATE OR REPLACE FUNCTION insert_encargado(
    p_coden character varying,
    p_nomb character varying,
    p_apel character varying,
    p_dni character varying,
    p_celu character varying,
    p_nombpo character varying
) RETURNS void AS $$
BEGIN
    INSERT INTO Encargado (CODEN, NOMB, APEL, DNI, CELU, NOMBPO)
    VALUES (p_coden, p_nomb, p_apel, p_dni, p_celu, p_nombpo);
EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE 'El encargado con código % o DNI % ya existe.', p_coden, p_dni;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_encargados()
RETURNS TABLE(
    CODEN character varying,
    NOMB character varying,
    APEL character varying,
    DNI character varying,
    CELU character varying,
    NOMBPO character varying
) AS $$
BEGIN
    RETURN QUERY 
    SELECT e.CODEN, e.NOMB, e.APEL, e.DNI, e.CELU, e.NOMBPO
    FROM Encargado e;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_encargado(
    p_coden character varying,
    p_nomb character varying,
    p_apel character varying,
    p_dni character varying,
    p_celu character varying,
    p_nombpo character varying
) RETURNS void AS $$
BEGIN
    UPDATE Encargado
    SET NOMB = p_nomb,
        APEL = p_apel,
        DNI = p_dni,
        CELU = p_celu,
        NOMBPO = p_nombpo
    WHERE CODEN = p_coden;

    IF NOT FOUND THEN
        RAISE NOTICE 'No se encontró un encargado con el código %.', p_coden;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_encargado(
    p_coden character varying
) RETURNS void AS $$
BEGIN
    DELETE FROM Encargado
    WHERE CODEN = p_coden;

    IF NOT FOUND THEN
        RAISE NOTICE 'No se encontró un encargado con el código %.', p_coden;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- CRUD INCLUYE

CREATE OR REPLACE FUNCTION insert_incluye(
    p_codmv character varying,
    p_codmt character varying,
    p_cant integer
) RETURNS void AS $$
BEGIN
    INSERT INTO Incluye (CODMV, CODMT, CANT)
    VALUES (p_codmv, p_codmt, p_cant);
EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE 'El registro con CODMV % y CODMT % ya existe.', p_codmv, p_codmt;
    WHEN foreign_key_violation THEN
        RAISE NOTICE 'El CODMV o CODMT proporcionado no existe en sus respectivas tablas.';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_incluye()
RETURNS TABLE(CODMV character varying, CODMT character varying, CANT integer) AS $$
BEGIN
    RETURN QUERY SELECT i.CODMV, i.CODMT, i.CANT FROM Incluye i;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_incluye(
    p_codmv character varying,
    p_codmt character varying,
    p_cant integer
) RETURNS void AS $$
BEGIN
    UPDATE Incluye
    SET CANT = p_cant
    WHERE CODMV = p_codmv AND CODMT = p_codmt;

    IF NOT FOUND THEN
        RAISE NOTICE 'No se encontró un registro con CODMV % y CODMT %.', p_codmv, p_codmt;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_incluye(
    p_codmv character varying,
    p_codmt character varying
) RETURNS void AS $$
BEGIN
    DELETE FROM Incluye
    WHERE CODMV = p_codmv AND CODMT = p_codmt;

    IF NOT FOUND THEN
        RAISE NOTICE 'No se encontró un registro con CODMV % y CODMT %.', p_codmv, p_codmt;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- CONSULTAS EN PROCED

CREATE OR REPLACE FUNCTION obtener_notas_con_material()
RETURNS TABLE(
    CODMV character varying,
    CODAOR character varying,
    FCEMI date,
    NOMB character varying,
    CANT integer
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        n.CODMV,
        n.CODAOR,
        n.FCEMI,
        ma.NOMB,
        i.CANT
    FROM Nota n
    JOIN Incluye i
    ON n.CODMV = i.CODMV
    JOIN Material ma
    ON i.CODMT = ma.CODMT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_incluye_por_categoria(
    p_categoria character varying
)
RETURNS TABLE(
    CODMV character varying,
    NOMB character varying,
    CATE character varying,
    CANT integer
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        i.CODMV,
        ma.NOMB,
        ma.CATE,
        i.CANT
    FROM Incluye i
    INNER JOIN Material ma ON i.CODMT = ma.CODMT
    WHERE ma.CATE = p_categoria;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION obtener_notas_por_fecha(
    p_fecha date
)
RETURNS TABLE(
    CODMV character varying,
    FCEMI date,
    NOMB character varying,
    CANT integer
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        n.CODMV,
        n.FCEMI,
        ma.NOMB,
        i.CANT
    FROM Nota n
    JOIN Incluye i ON n.CODMV = i.CODMV
    JOIN Material ma ON i.CODMT = ma.CODMT
    WHERE n.FCEMI = p_fecha;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION mostrarAsistentePabellon(pab varchar(2))RETURNS TABLE(PABEL varchar(2),NRAUL varchar(3),NOMB varchar(40), APEL varchar(40)) AS $$
BEGIN
RETURN QUERY
SELECT l.PABEL, l.NRAUL, a.NOMB, a.APEL
FROM Laboratorio l INNER JOIN Asistente a ON l.CODAS = a.CODAS
WHERE l.PABEL = pab;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION mostrarEncargadoPabellon(pab varchar(2))
RETURNS TABLE(
    PABEL varchar(2),
    NRAUL varchar(3),
    NOMB varchar(40),
    APEL varchar(40)
) AS $$
BEGIN
    RETURN QUERY
    SELECT al.PABEL, al.NRAUL, en.NOMB, en.APEL
    FROM Almacen al
    INNER JOIN Encargado en ON al.CODEN = en.CODEN
    WHERE al.PABEL = pab;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION buscar_materiales_por_nombre(
    p_patron character varying
)
RETURNS TABLE(
    CODMT character varying,
    NOMB character varying,
    UNMED character varying,
    CATE character varying
) AS $$
BEGIN
    RETURN QUERY
    SELECT ma.CODMT, ma.NOMB, ma.UNMED, ma.CATE
    FROM Material ma
    WHERE ma.NOMB ILIKE '%' || p_patron || '%';
END;
$$ LANGUAGE plpgsql;

