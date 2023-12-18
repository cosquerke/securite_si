CONNECT USER1/user@cienetdb;
EXECUTE admin12.set_entreprise_ctx_pkg.set_role;

SELECT * FROM admin12.POLES;
INSERT INTO admin12.POLES (id_pole, nom_pole, id_employe) VALUES (5, 'Pôle Peche', 107);
SELECT * FROM admin12.POLES;

UPDATE admin12.POLES SET nom_pole = 'pole_correction' where id_pole = 5;
SELECT * FROM admin12.POLES;

DELETE FROM admin12.POLES WHERE id_pole = 5;

SELECT * FROM admin12.POLES;
