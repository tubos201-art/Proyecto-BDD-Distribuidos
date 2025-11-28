-- Pruebas SQL Server → PostgreSQL
INSERT INTO Cliente (Nombre, Email) VALUES ('Usuario Local 1', 'local1@test.com');
UPDATE Cliente SET Email = 'actualizado@test.com' WHERE Nombre = 'Usuario Local 1';
DELETE FROM Cliente WHERE Nombre = 'Usuario Local 2';

-- Pruebas PostgreSQL → SQL Server
INSERT INTO cliente (nombre, email) VALUES ('Usuario Nube A', 'nubeA@cloud.com');
UPDATE cliente SET nombre = 'Usuario Nube Modificado' WHERE email = 'nubeA@cloud.com';
DELETE FROM cliente WHERE email = 'nubeB@cloud.com';