# 🔄 Replicación Heterogénea SQL Server - PostgreSQL con SymmetricDS

## 👥 Integrantes del Grupo
- **Cholota Guaman Carlos Sebastian**
- **Mazabanda Pilamunga Diego Abraham** 
- **Tixilema Puaquiza Kevin Alexander**
- **Tubon Chipantiza Danilo Alexander**

## 📋 Resumen del Proyecto
Implementación exitosa de un sistema de replicación bidireccional heterogénea entre **SQL Server** (nodo central) y **PostgreSQL** (nodo sucursal) utilizando **SymmetricDS** como middleware de sincronización.

### 🎯 Objetivos Cumplidos
- ✅ Configuración de motores de bases de datos heterogéneos
- ✅ Implementación de SymmetricDS como middleware de replicación
- ✅ Definición de node groups, channels, triggers y routers
- ✅ Validación de replicación bidireccional con operaciones DML
- ✅ Verificación de sincronización horaria entre servidores

### 🛠️ Tecnologías Utilizadas
- **Microsoft SQL Server** - Nodo Central
- **PostgreSQL** - Nodo Sucursal  
- **SymmetricDS 3.16.7** - Middleware de replicación
- **Windows & Ubuntu Linux** - Sistemas operativos
- **JDBC Drivers** - Conectividad entre sistemas

### 📁 Estructura del Repositorio
Proyecto-BDD-Distribuidos/
├── scripts-sql/ # Scripts SQL organizados por fases
├── propiedades/ # Archivos de configuración SymmetricDS
├── evidencias/ # Capturas de pantalla del proceso
├── Informe.pdf # Documentación completa del proyecto
└── README.md # Este archivo

### 🚀 Resultados Obtenidos
- Replicación bidireccional funcional entre SQL Server y PostgreSQL
- Sincronización automática de operaciones INSERT, UPDATE, DELETE
- Configuración robusta de elementos de replicación en SymmetricDS
- Verificación completa de consistencia de datos
- Documentación técnica detallada del proceso

**Asignatura:** Sistemas de Base de Datos Distribuidos  
**Docente:** Ing. Rubén Caiza, Mg.

Explicación de las diferencias
de tipos de datos entre SQL Server y PostgreSQL.

# 🔄 DIFERENCIAS DE TIPOS DE DATOS ENTRE SQL SERVER Y POSTGRESQL

## 📊 COMPARATIVA DETALLADA POR TIPO DE DATO

### 1. **TIPOS ENTEROS Y AUTO-INCREMENTO**

| SQL Server | PostgreSQL | Diferencia | Impacto en Replicación |
|------------|------------|------------|------------------------|
| `INT IDENTITY(1,1)` | `SERIAL` | **Sintaxis diferente, mismo concepto** | SymmetricDS maneja la conversión automáticamente |
| `IDENTITY(seed, increment)` | `SERIAL` + secuencias | SQL Server usa IDENTITY, PostgreSQL usa secuencias implícitas | No afecta replicación si se configuran rangos separados |

**Ejemplo práctico:**
```sql
-- SQL Server
CREATE TABLE Cliente (
    IdCliente INT IDENTITY(1,1) PRIMARY KEY
);

-- PostgreSQL
CREATE TABLE cliente (
    idcliente SERIAL PRIMARY KEY
);
```

### 2. **TIPOS DE TEXTO Y CARACTERES**

| SQL Server | PostgreSQL | Diferencia | Impacto |
|------------|------------|------------|---------|
| `NVARCHAR(n)` | `VARCHAR(n)` | **Unicode vs No Unicode** | PostgreSQL VARCHAR soporta Unicode por defecto en UTF-8 |
| `NVARCHAR(MAX)` | `TEXT` o `VARCHAR` sin límite | Límites diferentes | SymmetricDS ajusta automáticamente |
| `CHAR(n)` | `CHAR(n)` | Similar | Sin problemas |

**Detalle importante:**
- **SQL Server**: `NVARCHAR` almacena datos Unicode (UTF-16)
- **PostgreSQL**: `VARCHAR` almacena texto en codificación de la base de datos (normalmente UTF-8)
- **En la práctica**: Ambos soportan caracteres internacionales

### 3. **TIPOS DE FECHA Y HORA**

| SQL Server | PostgreSQL | Diferencia | Impacto |
|------------|------------|------------|---------|
| `DATETIME2` | `TIMESTAMP` | **Precisión y rango diferentes** | SymmetricDS convierte formatos |
| `DATETIME` | `TIMESTAMP` | Menor precisión en SQL Server | Preferir DATETIME2 |
| `GETDATE()` | `NOW()` | **Funciones diferentes** | Ambas devuelven fecha/hora actual |
| `SYSDATETIME()` | `CURRENT_TIMESTAMP` | Equivalente funcional | |

**Comparativa de precisión:**
- **SQL Server DATETIME2**: Precisión de 100 nanosegundos
- **PostgreSQL TIMESTAMP**: Precisión de 1 microsegundo
- **Ambos**: Suficientes para aplicaciones empresariales

### 4. **TIPOS NUMÉRICOS**

| SQL Server | PostgreSQL | Diferencia |
|------------|------------|------------|
| `DECIMAL(p,s)` | `DECIMAL(p,s)` | **Compatibilidad total** |
| `NUMERIC(p,s)` | `NUMERIC(p,s)` | Mismo comportamiento |
| `FLOAT` | `DOUBLE PRECISION` | Nombres diferentes, mismo concepto |
| `REAL` | `REAL` | Compatibles |

### 5. **TIPOS BINARIOS**

| SQL Server | PostgreSQL | Diferencia |
|------------|------------|------------|
| `VARBINARY(MAX)` | `BYTEA` | **Implementación diferente** |
| `IMAGE` (obsoleto) | `BYTEA` | PostgreSQL más moderno |

## 🎯 IMPACTO EN LA REPLICACIÓN CON SYMMETRICDS

### ✅ **Conversiones Automáticas**
```sql
-- SQL Server → PostgreSQL
NVARCHAR(100)    → VARCHAR(100)      ✅
DATETIME2        → TIMESTAMP         ✅  
INT IDENTITY     → SERIAL            ✅
```

### ⚠️ **Consideraciones Críticas**

#### 1. **Manejo de Valores Nulos**
```sql
-- SQL Server
Email NVARCHAR(150) NULL

-- PostgreSQL  
email VARCHAR(150)
-- PostgreSQL por defecto es NULL, igual comportamiento
```

#### 2. **Valores por Defecto**
```sql
-- SQL Server
FechaRegistro DATETIME2 NOT NULL DEFAULT SYSDATETIME()

-- PostgreSQL
fecharegistro TIMESTAMP NOT NULL DEFAULT NOW()
-- Diferentes funciones, mismo resultado
```

#### 3. **Sensibilidad a Mayúsculas/Minúsculas**
```sql
-- SQL Server (case-insensitive por defecto)
SELECT * FROM Cliente WHERE Nombre = 'juan'  -- Encuentra 'Juan'

-- PostgreSQL (case-sensitive)
SELECT * FROM cliente WHERE nombre = 'juan'  -- NO encuentra 'Juan'
SELECT * FROM cliente WHERE nombre = 'Juan'  -- ✓ Correcto
```

## 🔧 CONFIGURACIÓN PARA COMPATIBILIDAD

### Recomendaciones para Réplicas Exitosas:

#### 1. **Longitudes Consistentes**
```sql
-- Mantener mismas longitudes máximas
SQL Server: NVARCHAR(100)  →  PostgreSQL: VARCHAR(100)
```

#### 2. **Manejo de Fechas**
```sql
-- Usar tipos compatibles
SQL Server: DATETIME2      →  PostgreSQL: TIMESTAMP
```

#### 3. **Valores por Defecto**
```sql
-- SymmetricDS replica los datos, NO las definiciones de tabla
-- Los DEFAULT se aplican solo en inserciones locales
```

## 📋 TABLA RESUMEN DE COMPATIBILIDAD

| Categoría | SQL Server | PostgreSQL | Compatibilidad |
|-----------|------------|------------|----------------|
| **Entero Auto** | IDENTITY | SERIAL | ✅ Alta |
| **Texto** | NVARCHAR | VARCHAR | ✅ Alta |
| **Fecha/Hora** | DATETIME2 | TIMESTAMP | ✅ Alta |
| **Numérico** | DECIMAL | DECIMAL | ✅ Total |
| **Booleano** | BIT | BOOLEAN | ✅ Media |
| **Binario** | VARBINARY | BYTEA | ✅ Alta |

## 🚨 POSIBLES PROBLEMAS Y SOLUCIONES

### Problema 1: Diferencias de Case Sensitivity
**Síntoma**: Datos no se encuentran después de replicación
**Solución**: Usar collation case-insensitive en PostgreSQL o normalizar datos

### Problema 2: Límites de Longitud Diferentes
**Síntoma**: Error al replicar textos largos
**Solución**: Usar la misma longitud máxima en ambos lados

### Problema 3: Formato de Fechas
**Síntoma**: Fechas replicadas incorrectamente
**Solución**: SymmetricDS maneja conversiones automáticamente

## 💡 MEJORES PRÁCTICAS

1. **Mantener estructuras lógicas idénticas** aunque los tipos físicos difieran
2. **Usar longitudes consistentes** en campos de texto
3. **Probar replicación con datos edge cases** (fechas límite, textos largos, caracteres especiales)
4. **Documentar diferencias** en el esquema para troubleshooting

## 🎓 CONCLUSIÓN

Las diferencias entre SQL Server y PostgreSQL son **manejables** gracias a:
- ✅ **SymmetricDS** como traductor intermedio
- ✅ **JDBC Drivers** que normalizan el acceso
- ✅ **Tipos lógicos equivalentes** entre motores

**La replicación heterogénea es exitosa cuando:**  
Las estructuras de datos representan la misma **semántica empresarial**, aunque la **sintaxis técnica** difiera entre motores.



