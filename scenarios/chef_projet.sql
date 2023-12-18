CONNECT USER2/user@cienetdb;
EXECUTE admin12.set_entreprise_ctx_pkg.set_role;

SELECT * FROM admin12.POLES;

SELECT * FROM admin12.employes_view;

SELECT * FROM admin12.PROJETS;
UPDATE admin12.projets SET nom_projet = 'projet_correction';
INSERT INTO admin12.projets (id_projet, nom_projet, id_chef_de_projet, id_pole) VALUES (505, 'Projet E', '109', 3);
SELECT * FROM admin12.PROJETS;

SELECT * FROM admin12.TACHES;
UPDATE admin12.taches SET nom_tache = 'taches_correction';
INSERT INTO admin12.taches (id_tache, nom_tache, id_responsable_tache, etat_tache, id_projet) VALUES (1005, 'Tâche 5', 104, 'En cours', 505);
SELECT * FROM admin12.TACHES;
DELETE FROM admin12.TACHES WHERE id_tache = 1001;
DELETE FROM admin12.TACHES WHERE id_tache = 1005;
SELECT * FROM admin12.TACHES;

DELETE FROM admin12.projets WHERE id_projet = 505;
