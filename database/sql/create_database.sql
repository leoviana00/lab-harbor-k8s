--  CRIPTOGRAFIA DE SENHA
-- ALTER SYSTEM SET password_encryption = 'md5';
-- SELECT pg_reload_conf();
ALTER USER root WITH PASSWORD 'password';

-- CREATE DATABASES
CREATE DATABASE registry;
CREATE DATABASE notary_signer;
CREATE DATABASE notary_server;


