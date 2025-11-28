USE BD_CENTRAL;
GO
-- Node Group Links
INSERT INTO sym_node_group_link VALUES ('central', 'sucursal', 'P');
INSERT INTO sym_node_group_link VALUES ('sucursal', 'central', 'W');

-- Channel
INSERT INTO sym_channel VALUES ('canal_cliente', 1, 100000, 1, 'Canal para tabla Cliente');

-- Trigger
INSERT INTO sym_trigger VALUES ('tr_cliente', 'Cliente', 'canal_cliente', GETDATE(), GETDATE());

-- Routers
INSERT INTO sym_router VALUES ('central_2_sucursal', 'central', 'sucursal', 'default', GETDATE(), GETDATE());
INSERT INTO sym_router VALUES ('sucursal_2_central', 'sucursal', 'central', 'default', GETDATE(), GETDATE());

-- Trigger Router
INSERT INTO sym_trigger_router VALUES ('tr_cliente', 'central_2_sucursal', 100, GETDATE(), GETDATE());
INSERT INTO sym_trigger_router VALUES ('tr_cliente', 'sucursal_2_central', 100, GETDATE(), GETDATE());