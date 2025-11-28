-- Script para SQL Server
CREATE DATABASE BD_CENTRAL;
GO
USE BD_CENTRAL;
GO
CREATE TABLE Cliente (
    IdCliente INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) NULL,
    FechaRegistro DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);
GO

-- Script para PostgreSQL
CREATE DATABASE bd_sucursal;
\c bd_sucursal;
CREATE TABLE cliente (
    idcliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    fecharegistro TIMESTAMP NOT NULL DEFAULT NOW()
);