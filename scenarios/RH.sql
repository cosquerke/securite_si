CONNECT USER5/user@cienetdb;
EXECUTE admin12.set_entreprise_ctx_pkg.set_role;

SELECT * FROM admin12.TACHES;

SELECT * FROM admin12.POLES;

SELECT * FROM admin12.PROJETS;

SELECT * FROM admin12.EMPLOYES;
UPDATE admin12.employes SET salaire = 55000;
INSERT INTO admin12.employes (id_employe, nom_employe, id_pole, salaire) VALUES (111, 'USER100', 3, 100000);
SELECT * FROM admin12.EMPLOYES;
DELETE FROM admin12.employes WHERE id_employe = 111;
