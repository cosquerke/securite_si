CONNECT USER6/user@cienetdb;
EXECUTE admin12.set_entreprise_ctx_pkg.set_role;
SELECT * FROM admin12.POLES;
SELECT * FROM admin12.PROJETS;
SELECT * FROM admin12.employes_view;
SELECT * FROM admin12.TACHES;
UPDATE admin12.taches SET etat_tache = 'In Progress';
SELECT * FROM admin12.TACHES;
