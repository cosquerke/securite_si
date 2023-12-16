CONNECT USER6/user@cienetdb;
EXECUTE admin10.set_entreprise_ctx_pkg.set_role;
SELECT * FROM admin10.POLES;
SELECT * FROM admin10.PROJETS;
SELECT * FROM admin10.EMPLOYES;
SELECT * FROM admin10.TACHES;
UPDATE admin10.taches SET etat_tache = 'In Progress' WHERE id_responsable_tache = (SELECT id_employe FROM admin10.employes WHERE nom_employe = 'USER6');
SELECT * FROM admin10.TACHES;
