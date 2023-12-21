SET ECHO ON;
SET linesize 250;
CONNECT USER4/user@cienetdb;
EXECUTE admin12.set_entreprise_ctx_pkg.set_role;
SELECT sys_context('entreprise_ctx', 'role_nom') FROM DUAL;
SELECT * FROM admin12.POLES;
SELECT * FROM admin12.PROJETS;
SELECT * FROM admin12.employes_view;
