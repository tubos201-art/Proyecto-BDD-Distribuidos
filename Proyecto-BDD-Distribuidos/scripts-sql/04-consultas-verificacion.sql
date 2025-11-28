-- Verificar configuración
SELECT * FROM sym_node_group_link;
SELECT * FROM sym_channel;
SELECT * FROM sym_trigger;
SELECT * FROM sym_router;
SELECT * FROM sym_trigger_router;

-- Verificar triggers
SELECT name FROM sys.triggers WHERE parent_id = OBJECT_ID('Cliente');

-- Verificar lotes
SELECT * FROM sym_incoming_batch;
SELECT * FROM sym_outgoing_batch;