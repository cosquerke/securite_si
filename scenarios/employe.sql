CONNECT USER6/user@cienetdb;
EXECUTE admin10.set_entreprise_ctx_pkg.set_role;
SELECT * FROM admin10.POLES;
SELECT * FROM admin10.PROJETS;
SELECT * FROM admin10.employes_view;
SELECT * FROM admin10.TACHES;
UPDATE admin10.taches SET etat_tache = 'In Progress';
SELECT * FROM admin10.TACHES;
