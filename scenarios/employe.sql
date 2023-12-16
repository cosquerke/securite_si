SET SERVEROUTPUT ON; -- Active la sortie serveur pour DBMS_OUTPUT
CONNECT USER3/user@cienetdb;
EXECUTE admin10.set_entreprise_ctx_pkg.set_role;
SELECT * FROM admin10.POLES;
SELECT * FROM admin10.PROJETS;
SELECT * FROM admin10.EMPLOYES;
SELECT * FROM admin10.TACHES;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Modification de la tâche 1005');
END;
/
UPDATE taches SET etat_tache = 'En cours' WHERE id_tache = 1005;
SELECT * FROM admin10.TACHES;
