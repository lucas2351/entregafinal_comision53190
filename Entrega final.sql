-- Crear base de datos Sistemas 

DROP SCHEMA if exists Sistema;
CREATE SCHEMA IF NOT EXISTS Sistema;
-- Tabla categoría
use Sistema;

create table if not exists categoria(
	idcategoria integer auto_increment,
	nombre varchar(50) not null ,
	descripcion varchar(256) null,
    condicion tinyint(1),
    unique (idcategoria),
    unique (nombre),
    primary key (idcategoria)
);
-- Solo hago una prueba para ver si se insertan los datos 




use Sistema;

-- Tabla artículo
create table if not exists  articulo(
	idarticulo integer  auto_increment,
	idcategoria integer not null,
	codigo varchar(50) null,
	nombre varchar(100) not null,
	precio_venta decimal(11,2) not null,
	stock integer not null,
	descripcion varchar(256) null,
	condicion tinyint(1),
    primary key (idarticulo),
    unique (nombre),
	FOREIGN KEY (idcategoria) REFERENCES categoria(idcategoria)
    
);

use Sistema;
-- Tabla persona
create table if not exists  persona(
	idpersona integer  auto_increment,
	tipo_persona varchar(20) not null,
	nombre varchar(100) not null,
	tipo_documento varchar(20) null,
	num_documento varchar(20) null,
	direccion varchar(70) null,
	telefono varchar(20) null,
	email varchar(50) null,
    primary key (idpersona)
);
 use Sistema;
-- Tabla rol
create table if not exists  rol(
	idrol integer  auto_increment,
	nombre varchar(30) not null,
	descripcion varchar(100) null,
	condicion bit default(1),
    primary key (idrol)
);
use Sistema;
-- Tabla usuario
create table if not exists  usuario(
	idusuario integer auto_increment,
	idrol integer not null,
	nombre varchar(100) not null,
	tipo_documento varchar(20) null,
	num_documento varchar(20) null,
	direccion varchar(70) null,
	telefono varchar(20) null,
	email varchar(50) not null,
	password_hash char(64) not null,
	condicion tinyint(1),
    primary key (idusuario),
	FOREIGN KEY (idrol) REFERENCES rol (idrol)
);
use Sistema;
-- Tabla iegreso
create table if not exists ingreso(
	idingreso integer  auto_increment,
	idproveedor integer not null,
	idusuario integer not null,
	tipo_comprobante varchar(20) not null,
	serie_comprobante varchar(7) null,
	num_comprobante varchar (10) not null,
	fecha_hora datetime not null,
	impuesto decimal (4,2) not null,
	total decimal (11,2) not null,
	estado varchar(20) not null,
    primary key (idingreso),
	FOREIGN KEY (idproveedor) REFERENCES persona (idpersona),
	FOREIGN KEY (idusuario) REFERENCES usuario (idusuario)
);
  use Sistema;
-- Tabla detalle_ingreso
create table if not exists  detalle_ingreso(
	iddetalle_ingreso integer  auto_increment,
	idingreso integer not null,
	idarticulo integer not null,
	cantidad integer not null,
	precio decimal(11,2) not null,
    primary key (iddetalle_ingreso),
	FOREIGN KEY (idingreso) REFERENCES ingreso (idingreso) ON DELETE CASCADE,
	FOREIGN KEY (idarticulo) REFERENCES articulo (idarticulo)
);


-- Tabla venta
create table if not exists  venta(
	idventa integer  auto_increment,
	idcliente integer not null,
	idusuario integer not null,
	tipo_comprobante varchar(20) not null,
	serie_comprobante varchar(7) null,
	num_comprobante varchar (10) not null,
	fecha_hora datetime not null,
	impuesto decimal (4,2) not null,
	total decimal (11,2) not null,
	estado varchar(20) not null,
    primary key (idventa),
	FOREIGN KEY (idcliente) REFERENCES persona (idpersona),
	FOREIGN KEY (idusuario) REFERENCES usuario (idusuario)
);

-- Tabla detalle_venta
create table if not exists  detalle_venta(
	iddetalle_venta integer  auto_increment,
	idventa integer not null,
	idarticulo integer not null,
	cantidad integer not null,
	precio decimal(11,2) not null,
	descuento decimal(11,2) not null,
    primary key (iddetalle_venta),
	FOREIGN KEY (idventa) REFERENCES venta (idventa) ON DELETE CASCADE,
	FOREIGN KEY (idarticulo) REFERENCES articulo (idarticulo)
);


-- insertar datos
use sistema; 

INSERT INTO categoria (idcategoria, nombre, descripcion, condicion)
VALUES
(1, 'Categoria 1', 'Descripcion de Categoria 1', 1),
(2, 'Categoria 2', 'Descripcion de Categoria 2', 1),
(3, 'Categoria 3', 'Descripcion de Categoria 3', 1),
(4, 'Categoria 4', 'Descripcion de Categoria 4', 1),
(5, 'Categoria 5', 'Descripcion de Categoria 5', 1);


-- Articulos 

use sistema;

INSERT INTO articulo (idcategoria, codigo, nombre, precio_venta, stock, descripcion, condicion)
VALUES 
(1, 'A001', 'Articulo 1', 10.00, 100, 'Descripcion 1', 1),
(1, 'A002', 'Articulo 2', 20.00, 200, 'Descripcion 2', 1),
(1, 'A003', 'Articulo 3', 30.00, 300, 'Descripcion 3', 1),
(1, 'A004', 'Articulo 4', 40.00, 400, 'Descripcion 4', 1),
(1, 'A005', 'Articulo 5', 50.00, 500, 'Descripcion 5', 1);

-- rol 

use sistema;

INSERT INTO rol (nombre, descripcion, condicion)
VALUES 
('Administrador', 'Rol de administrador', 1),
('Vendedor', 'Rol de vendedor', 1),
('Almacenero', 'Rol de almacenero', 1),
('Usuario', 'Rol de usuario', 1),
('Invitado', 'Rol de invitado', 1);


-- usuario 
use sistema; 
INSERT INTO usuario (idrol, nombre, tipo_documento, num_documento, direccion, telefono, email, password_hash, condicion)
VALUES 
(1, 'Usuario 1', 'DNI', '12345678', 'Direccion 1', '123456789', 'user1@example.com', SHA2('password1', 256), 1),
(2, 'Usuario 2', 'DNI', '23456789', 'Direccion 2', '234567890', 'user2@example.com', SHA2('password2', 256), 1),
(3, 'Usuario 3', 'DNI', '34567890', 'Direccion 3', '345678901', 'user3@example.com', SHA2('password3', 256), 1);



-- Crear  vistas 
use sistema;

CREATE VIEW vista_venta AS
SELECT 
    v.idventa, 
    v.idcliente, 
    v.idusuario, 
    v.tipo_comprobante, 
    v.serie_comprobante, 
    v.num_comprobante, 
    v.fecha_hora, 
    v.impuesto, 
    v.total, 
    v.estado,
    a.nombre AS nombre_articulo, 
    a.precio_venta AS precio_articulo, 
    c.nombre AS nombre_categoria
FROM 
    venta v
JOIN 
    detalle_venta dv ON v.idventa = dv.idventa
JOIN 
    articulo a ON dv.idarticulo = a.idarticulo
JOIN 
    categoria c ON a.idcategoria = c.idcategoria
ORDER BY 
    v.fecha_hora;


show create view vista_venta;

use sistema; 
CREATE VIEW detalle_ingreso_articulo AS
SELECT 
    di.iddetalle_ingreso,
    di.idingreso,
    di.idarticulo,
    di.cantidad,
    di.precio,
    a.codigo,
    a.nombre AS nombre_articulo,
    a.precio_venta,
    a.stock,
    a.descripcion AS descripcion_articulo,
    a.condicion AS condicion_articulo
FROM 
    detalle_ingreso di
JOIN 
    articulo a ON di.idarticulo = a.idarticulo
ORDER BY 
    di.iddetalle_ingreso;
    
    use sistema;
    
    CREATE VIEW vista_detalle_venta_usuario AS
SELECT 
    dv.iddetalle_venta,
    dv.idventa,
    dv.idarticulo,
    dv.cantidad,
    dv.precio,
    dv.descuento,
    a.codigo AS codigo_articulo,
    a.nombre AS nombre_articulo,
    a.precio_venta AS precio_venta_articulo,
    a.stock,
    a.descripcion AS descripcion_articulo,
    u.idusuario,
    u.nombre AS nombre_usuario,
    u.tipo_documento AS tipo_documento_usuario,
    u.num_documento AS num_documento_usuario,
    u.direccion AS direccion_usuario,
    u.telefono AS telefono_usuario,
    u.email AS email_usuario,
    u.condicion AS condicion_usuario
FROM 
    detalle_venta dv
JOIN 
    articulo a ON dv.idarticulo = a.idarticulo
JOIN 
    venta v ON dv.idventa = v.idventa
JOIN 
    usuario u ON v.idusuario = u.idusuario
ORDER BY 
    dv.iddetalle_venta;
    
    
    
    use sistema;
    CREATE VIEW vista_articulos_categorias AS
SELECT 
    a.idarticulo,
    a.idcategoria,
    a.codigo,
    a.nombre AS nombre_articulo,
    a.precio_venta,
    a.stock,
    a.descripcion AS descripcion_articulo,
    a.condicion AS condicion_articulo,
    c.nombre AS nombre_categoria,
    c.descripcion AS descripcion_categoria,
    c.condicion AS condicion_categoria
FROM 
    articulo a
JOIN 
    categoria c ON a.idcategoria = c.idcategoria
ORDER BY 
    a.nombre;  -- Ordenar por el nombre del artículo
    
    
    use sistema;
    
    CREATE VIEW vista_articulos_detalle_venta AS
SELECT 
    dv.iddetalle_venta,
    dv.idventa,
    dv.idarticulo,
    dv.cantidad,
    dv.precio,
    dv.descuento,
    a.codigo AS codigo_articulo,
    a.nombre AS nombre_articulo,
    a.precio_venta AS precio_venta_articulo,
    a.stock,
    a.descripcion AS descripcion_articulo,
    a.condicion AS condicion_articulo,
    r.idrol,
    r.nombre AS nombre_rol,
    r.descripcion AS descripcion_rol,
    r.condicion AS condicion_rol
FROM 
    detalle_venta dv
JOIN 
    articulo a ON dv.idarticulo = a.idarticulo
JOIN 
    rol r ON a.idcategoria = r.idrol  -- Aquí asumo una posible relación; ajústala según sea necesario
ORDER BY 
    a.nombre;  -- Ordenar por el nombre del artículo
    
   -- Funciones  
   
   -- Calcular el stock de articulos 
   
  use sistema; 


-- Procesos almacenados 

use sistema;
DELIMITER //
CREATE PROCEDURE calcular_precio_total(
    IN p_idarticulo INT,  -- Parámetro de entrada: ID del artículo
    OUT p_precio_venta DECIMAL(11,2),  -- Parámetro de salida: Precio de venta del artículo
    OUT p_iva DECIMAL(11,2),  -- Parámetro de salida: IVA calculado
    OUT p_precio_total DECIMAL(11,2)  -- Parámetro de salida: Precio total (precio de venta + IVA)
)
BEGIN
    -- Declarar variables locales
    DECLARE precio DECIMAL(11,2);


   -- Funciones  
   
   -- Calcular el stock de articulos 
	DELIMITER //

CREATE FUNCTION calcular_stock()
RETURNS INT
BEGIN
    DECLARE total_stock INT;
    
    SELECT SUM(stock) INTO total_stock FROM articulo;
    
    RETURN total_stock;
    
END //
SELECT calcular_stock() AS stock_total;



    -- Obtener el precio de venta del artículo
    SELECT precio_venta INTO precio FROM articulo WHERE idarticulo = p_idarticulo;
calcular_precio_totalregistrar_venta
    -- Calcular el IVA (suponiendo una tasa de IVA del 16%)
    SET p_iva = precio * 0.21;

    -- Asignar el precio de venta al parámetro de salida
    SET p_precio_venta = precio;

    -- Calcular el precio total
    SET p_precio_total = precio + p_iva;
END //



-- Registrar Ventas 
use sistema
DELIMITER //


CREATE PROCEDURE registrar_venta(
    IN p_idcliente INT,
    IN p_idusuario INT,
    IN p_tipo_comprobante VARCHAR(20),
    IN p_serie_comprobante VARCHAR(7),
    IN p_num_comprobante VARCHAR(10),
    IN p_fecha_hora DATETIME,
    IN p_impuesto DECIMAL(4,2),
    IN p_total DECIMAL(11,2),
    IN p_estado VARCHAR(20)
)
BEGIN
    -- Iniciar una transacción
    START TRANSACTION;
    
    -- Insertar en la tabla venta
    INSERT INTO venta (
        idcliente, idusuario, tipo_comprobante, serie_comprobante,
        num_comprobante, fecha_hora, impuesto, total, estado
    ) VALUES (
        p_idcliente, p_idusuario, p_tipo_comprobante, p_serie_comprobante,
        p_num_comprobante, p_fecha_hora, p_impuesto, p_total, p_estadodetalle_venta
    );

    -- Confirmar la transacción
    COMMIT;
END //

-- Disparadores 
use sistema;

DELIMITER //

CREATE TRIGGER after_detalle_venta_insert
AFTER INSERT ON detalle_venta
FOR EACH ROW
BEGIN
    UPDATE articulo
    SET stock = stock - NEW.cantidad
    WHERE idarticulo = NEW.idarticulo;
END//

DELIMITER ;

use sistema;

DELIMITER //

CREATE TRIGGER before_detalle_ingreso_insert
BEFORE INSERT ON detalle_ingreso
FOR EACH ROW
BEGIN
    IF NEW.cantidad <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cantidad de artículos debe ser mayor a cero';
    END IF;
END//

DELIMITER ;

-- DCL
use sistema;

-- Otorgar todos los permisos en la tabla `articulo` al usuario `usuario1`
GRANT SELECT, INSERT, UPDATE, DELETE ON sistema.articulo TO 'usuario 1'@'localhost';

-- Aplicar los cambios de permisos
FLUSH PRIVILEGES;

-- (Opcional) Revocar todos los permisos en la tabla `articulo` del usuario `usuario 1`
REVOKE SELECT, INSERT, UPDATE, DELETE ON sistema.articulo FROM 'usuario 1'@'localhost';

-- Aplicar los cambios de permisos
FLUSH PRIVILEGES;


-- Otorgar todos los permisos en la tabla `ventas` al usuario `usuario 2`
GRANT SELECT, INSERT, UPDATE, DELETE ON sistema.ventas TO 'usuario 2'@'localhost';

-- Aplicar los cambios de permisos
FLUSH PRIVILEGES;

-- (Opcional) Revocar todos los permisos en la tabla `ventas` del usuario `usuario2`
REVOKE SELECT, INSERT, UPDATE, DELETE ON sistema.ventas FROM 'usuario 2'@'localhost';

-- Aplicar los cambios de permisos
FLUSH PRIVILEGES;



-- Crear el usuario (si no existe)
CREATE USER 'usuario 3'@'localhost' IDENTIFIED BY 'password';

-- Otorgar todos los permisos en la tabla `categoria` al usuario `usuario 3`
GRANT SELECT, INSERT, UPDATE, DELETE ON sistema.categoria TO 'usuario 3'@'localhost';

-- Aplicar los cambios de permisos
FLUSH PRIVILEGES;

-- (Opcional) Revocar todos los permisos en la tabla `categoria` del usuario `usuario3`
REVOKE SELECT, INSERT, UPDATE, DELETE ON sistema.categoria FROM 'usuario 3'@'localhost';

-- Aplicar los cambios de permisos
FLUSH PRIVILEGES;


-- TCL 
use sistema;
-- Iniciar una transacción
START TRANSACTION;

-- Insertar un nuevo artículo
INSERT INTO articulo (idarticulo, idcategoria, codigo, nombre, precio_venta, stock, descripcion, condicion)
VALUES (100, 1, 'A006', 'Articulo 6', 100.00, 10, 'Descripción del Artículo 6', 1);

-- Confirmar la transacción
COMMIT;

-- Iniciar una transacción
START TRANSACTION;

-- Insertar un nuevo artículo
INSERT INTO articulo (idarticulo, idcategoria, codigo, nombre, precio_venta, stock, descripcion, condicion)
VALUES (101, 1, 'A007', 'Articulo 7', 150.00, 5, 'Descripción del Artículo 7', 1);

-- Deshacer la transacción
ROLLBACK;

-- Iniciar una transacción
START TRANSACTION;

-- Insertar un nuevo artículo
INSERT INTO articulo (idarticulo, idcategoria, codigo, nombre, precio_venta, stock, descripcion, condicion)
VALUES (102, 1, 'A008', 'Articulo 8', 200.00, 8, 'Descripción del Artículo 8', 1);

-- Crear un punto de guardado
SAVEPOINT punto1;

-- Insertar otro artículo
INSERT INTO articulo (idarticulo, idcategoria, codigo, nombre, precio_venta, stock, descripcion, condicion)
VALUES (4, 1, 'A004', 'Articulo 4', 250.00, 15, 'Descripción del Artículo 4', 1);

-- Deshacer hasta el punto de guardado
ROLLBACK TO punto1;

-- Confirmar la transacción
COMMIT;



