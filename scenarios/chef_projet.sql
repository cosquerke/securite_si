CONNECT USER2/user@cienetdb;
EXECUTE admin10.set_entreprise_ctx_pkg.set_role;

SELECT * FROM admin10.POLES;

SELECT * FROM admin10.EMPLOYES;

SELECT * FROM admin10.PROJETS;
UPDATE admin10.projets SET nom_projet = "projet_correction";
INSERT INTO projets (id_projet, nom_projet, id_chef_de_projet, id_pole) VALUES (505, 'Projet E', '109', 3);
SELECT * FROM admin10.PROJETS;

SELECT * FROM admin10.TACHES;
UPDATE admin10.taches SET nom_tache = "taches_correction";
INSERT INTO taches (id_tache, nom_tache, id_responsable_tache, etat_tache, id_projet) VALUES (1005, 'Tâche 5', 104, 'En cours', 505);
SELECT * FROM admin10.TACHES;
DELETE FROM admin10.TACHES WHERE id_tache = 1001;
DELETE FROM admin10.TACHES WHERE id_tache = 1005;
SELECT * FROM admin10.TACHES;
