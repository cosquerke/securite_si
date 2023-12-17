CONNECT USER5/user@cienetdb;
EXECUTE admin10.set_entreprise_ctx_pkg.set_role;

SELECT * FROM admin10.TACHES;

SELECT * FROM admin10.POLES;

SELECT * FROM admin10.PROJETS;

SELECT * FROM admin10.EMPLOYES;
UPDATE admin10.employes SET salaire = 50000;
INSERT INTO admin10.employes (id_employe, nom_employe, id_pole, salaire) VALUES (111, 'USER100', 3, 100000);
SELECT * FROM admin10.EMPLOYES;
DELETE FROM admin10.employes WHERE id_employe = 111;