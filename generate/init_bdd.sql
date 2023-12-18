PROMPT *** Création des tables
CREATE TABLE poles (
	id_pole NUMBER PRIMARY KEY,
	nom_pole VARCHAR2(50),
	id_employe NUMBER
);

CREATE TABLE employes (
	id_employe NUMBER PRIMARY KEY,
	nom_employe VARCHAR2(100),
	id_pole NUMBER,
	salaire NUMBER
);

CREATE TABLE projets (
	id_projet NUMBER PRIMARY KEY,
	nom_projet VARCHAR2(100),
	id_chef_de_projet NUMBER,
	id_pole NUMBER
);

CREATE TABLE taches (
	id_tache NUMBER PRIMARY KEY,
	nom_tache VARCHAR2(100),
	id_responsable_tache NUMBER,
	etat_tache VARCHAR2(100),
	id_projet NUMBER
);

PROMPT *** Création des clés étrangères
ALTER TABLE poles ADD CONSTRAINT fk_id_employe FOREIGN KEY (id_employe) REFERENCES employes(id_employe);
ALTER TABLE projets ADD CONSTRAINT fk_projets_id_pole FOREIGN KEY (id_pole) REFERENCES poles(id_pole);
ALTER TABLE projets ADD CONSTRAINT fk_projets_id_chef_projet FOREIGN KEY (id_chef_de_projet) REFERENCES employes(id_employe);
ALTER TABLE taches ADD CONSTRAINT fk_taches_id_projet FOREIGN KEY (id_projet) REFERENCES projets(id_projet);
ALTER TABLE taches ADD CONSTRAINT fk_taches_id_responsable_tache FOREIGN KEY (id_responsable_tache) REFERENCES employes(id_employe);

INSERT INTO employes (id_employe, nom_employe, id_pole, salaire) VALUES (101, 'Jean Dupont', 1, 50000);
INSERT INTO employes (id_employe, nom_employe, id_pole, salaire) VALUES (102, 'Alice Tremblay', 2, 55000);
INSERT INTO employes (id_employe, nom_employe, id_pole, salaire) VALUES (103, 'Éric Leclerc', 3, 48000);
INSERT INTO employes (id_employe, nom_employe, id_pole, salaire) VALUES (104, 'USER7', 2, 55000);
INSERT INTO employes (id_employe, nom_employe, id_pole, salaire) VALUES (105, 'USER6', 3, 48000);
INSERT INTO employes (id_employe, nom_employe, id_pole, salaire) VALUES (106, 'USER5', 2, 55000);
INSERT INTO employes (id_employe, nom_employe, id_pole, salaire) VALUES (107, 'USER4', 1, 48000);
INSERT INTO employes (id_employe, nom_employe, id_pole, salaire) VALUES (108, 'USER3', 2, 55000);
INSERT INTO employes (id_employe, nom_employe, id_pole, salaire) VALUES (109, 'USER2', 1, 48000);
INSERT INTO employes (id_employe, nom_employe, id_pole, salaire) VALUES (110, 'USER1', 3, 48000);

PROMPT *** Peuplement des tables
INSERT INTO poles (id_pole, nom_pole, id_employe) VALUES (1, 'Pôle Marketing', 101);
INSERT INTO poles (id_pole, nom_pole, id_employe) VALUES (2, 'Pôle R_D', 102);
INSERT INTO poles (id_pole, nom_pole, id_employe) VALUES (3, 'Pôle Ventes', 103);
INSERT INTO poles (id_pole, nom_pole, id_employe) VALUES (4, 'Pôle DSI', 107);

INSERT INTO projets (id_projet, nom_projet, id_chef_de_projet, id_pole) VALUES (501, 'Projet A', '102', 1);
INSERT INTO projets (id_projet, nom_projet, id_chef_de_projet, id_pole) VALUES (502, 'Projet B', '101', 2);
INSERT INTO projets (id_projet, nom_projet, id_chef_de_projet, id_pole) VALUES (503, 'Projet C', '103', 3);
INSERT INTO projets (id_projet, nom_projet, id_chef_de_projet, id_pole) VALUES (504, 'Projet D', '109', 3);

INSERT INTO taches (id_tache, nom_tache, id_responsable_tache, etat_tache, id_projet) VALUES (1001, 'Tâche 1', 101, 'En cours', 501);
INSERT INTO taches (id_tache, nom_tache, id_responsable_tache, etat_tache, id_projet) VALUES (1002, 'Tâche 2', 102, 'En attente', 502);
INSERT INTO taches (id_tache, nom_tache, id_responsable_tache, etat_tache, id_projet) VALUES (1003, 'Tâche 3', 103, 'Terminée', 503);
INSERT INTO taches (id_tache, nom_tache, id_responsable_tache, etat_tache, id_projet) VALUES (1004, 'Tâche 4', 105, 'En cours', 504);

CREATE OR REPLACE VIEW employes_view AS
SELECT
    id_employe,
    nom_employe,
    id_pole,
    CASE
   	 WHEN SYS_CONTEXT('entreprise_ctx', 'role_nom') IN ('ADMIN12_CHEF_PROJET' ,'ADMIN12_CHEF_POLE') THEN NULL
   	 ELSE salaire
    END AS salaire
FROM
    ADMIN12.EMPLOYES;

PROMPT *** Création des rôles
CREATE ROLE ADMIN12_CHEF_PROJET;
CREATE ROLE ADMIN12_CHEF_POLE;
CREATE ROLE ADMIN12_EMPLOYE;
CREATE ROLE ADMIN12_RH;
CREATE ROLE ADMIN12_ADMIN;

PROMPT *** Application des droits sur les tables aux rôles
GRANT SELECT,UPDATE,DELETE, INSERT ON taches TO ADMIN12_CHEF_PROJET;
GRANT SELECT ON poles TO ADMIN12_CHEF_PROJET;
GRANT SELECT,UPDATE,insert,DELETE ON projets  TO ADMIN12_CHEF_PROJET;
GRANT SELECT ON employes TO ADMIN12_CHEF_PROJET;
GRANT SELECT ON employes_view TO ADMIN12_CHEF_PROJET;

GRANT SELECT ON poles TO ADMIN12_CHEF_POLE;
GRANT SELECT ON projets  TO ADMIN12_CHEF_POLE;
GRANT SELECT ON employes_view TO ADMIN12_CHEF_POLE;
GRANT SELECT ON employes TO ADMIN12_CHEF_POLE;

GRANT SELECT,UPDATE ON taches TO ADMIN12_EMPLOYE;
GRANT SELECT ON poles TO  ADMIN12_EMPLOYE;
GRANT SELECT  ON projets  TO ADMIN12_EMPLOYE;
GRANT SELECT ON employes_view TO ADMIN12_EMPLOYE;
GRANT SELECT ON employes TO ADMIN12_EMPLOYE;

GRANT SELECT,UPDATE,INSERT,DELETE ON employes TO ADMIN12_RH;
GRANT SELECT ON poles TO ADMIN12_RH;
GRANT SELECT ON projets TO ADMIN12_RH;
GRANT SELECT ON employes_view TO ADMIN12_RH;
GRANT SELECT ON employes TO ADMIN12_RH;

GRANT SELECT,UPDATE, INSERT, DELETE ON poles TO ADMIN12_ADMIN;

PROMPT *** Création du package et du contexte global
CREATE OR REPLACE CONTEXT entreprise_ctx USING set_entreprise_ctx_pkg;
CREATE OR REPLACE PACKAGE set_entreprise_ctx_pkg IS
    PROCEDURE set_role;
END;
/

CREATE OR REPLACE PACKAGE BODY set_entreprise_ctx_pkg IS
    PROCEDURE set_role IS
   	 role VARCHAR2(20);
   	 id_employe_session NUMBER;
	   id_pole_session NUMBER;
	BEGIN
	-- Requête permettant de récupérer le rôle de l'utilisateur qui est connecté
     SELECT granted_role INTO role FROM DBA_ROLE_PRIVS WHERE granted_role LIKE 'ADMIN12%' AND GRANTEE=user AND ROWNUM=1;
		 
     SELECT id_employe INTO id_employe_session
     FROM ADMIN12.EMPLOYES
     WHERE nom_employe=user;

	   SELECT id_pole INTO id_pole_session
     FROM ADMIN12.EMPLOYES
     WHERE nom_employe=user;
    -- Initialisation des variables de session
   	 DBMS_SESSION.SET_CONTEXT('entreprise_ctx', 'role_nom', role);
     DBMS_SESSION.SET_CONTEXT('entreprise_ctx', 'id_employe',id_employe_session);
	   DBMS_SESSION.SET_CONTEXT('entreprise_ctx', 'id_pole',id_pole_session);
    -- Si pas de données alors NULL
   	 EXCEPTION
   		 WHEN NO_DATA_FOUND THEN NULL;

 	END set_role;
END set_entreprise_ctx_pkg;
/
SHOW ERROR;

PROMPT *** Application des droits d execution du package aux rôles
GRANT EXECUTE ON set_entreprise_ctx_pkg to ADMIN12_CHEF_PROJET;
GRANT EXECUTE ON set_entreprise_ctx_pkg to ADMIN12_CHEF_POLE;
GRANT EXECUTE ON set_entreprise_ctx_pkg to ADMIN12_EMPLOYE;
GRANT EXECUTE ON set_entreprise_ctx_pkg to ADMIN12_RH;
GRANT EXECUTE ON set_entreprise_ctx_pkg to ADMIN12_ADMIN;

PROMPT *** Attribution des droits aux utilisateurs
GRANT ADMIN12_ADMIN to USER1;
GRANT ADMIN12_CHEF_PROJET to USER2;
GRANT ADMIN12_CHEF_POLE to USER3, USER4;
GRANT ADMIN12_RH to USER5;
GRANT ADMIN12_EMPLOYE to USER6, USER7;

PROMPT *** Création des VPDs
CREATE OR REPLACE FUNCTION VPD_EMPLOYES(
	SCHEMA_VAR IN VARCHAR2,
	TABLE_VAR IN VARCHAR2)
RETURN VARCHAR2
IS
	return_val VARCHAR2(400);
	le_role VARCHAR2(40);

BEGIN
	le_role := SYS_CONTEXT('entreprise_ctx', 'role_nom');

	IF le_role ='ADMIN12_EMPLOYE' THEN
    	return_val := 'id_employe = SYS_CONTEXT(''entreprise_ctx'', ''id_employe'')';
	ELSE
    	return_val := '1=1';
	END IF;

	RETURN return_val;
END VPD_EMPLOYES;
/

BEGIN
    DBMS_RLS.ADD_POLICY (
   	 OBJECT_SCHEMA => 'ADMIN12',
   	 OBJECT_NAME => 'EMPLOYES',
   	 POLICY_NAME => 'EMPLOYES_POLICY',
   	 FUNCTION_SCHEMA => 'ADMIN12',
   	 POLICY_FUNCTION => 'VPD_EMPLOYES',
   	 STATEMENT_TYPES => 'SELECT'
    );
END;
/

CREATE OR REPLACE FUNCTION VPD_POLE(
	SCHEMA_VAR IN VARCHAR2,
	TABLE_VAR IN VARCHAR2)
RETURN VARCHAR2
IS
	return_val VARCHAR2(400);
	le_role VARCHAR2(40);

BEGIN
	le_role := SYS_CONTEXT('entreprise_ctx', 'role_nom');

	IF le_role IN ('ADMIN12_EMPLOYE', 'ADMIN12_CHEF_PROJET', 'ADMIN12_CHEF_POLE') THEN

    	return_val := 'id_pole = SYS_CONTEXT(''entreprise_ctx'', ''id_pole'')';
	ELSE
    	return_val := '1=1';
	END IF;

	RETURN return_val;
END VPD_POLE;
/

BEGIN
    DBMS_RLS.ADD_POLICY (
   	 OBJECT_SCHEMA => 'ADMIN12',
   	 OBJECT_NAME => 'POLES',
   	 POLICY_NAME => 'POLES_POLICY',
   	 FUNCTION_SCHEMA => 'ADMIN12',
   	 POLICY_FUNCTION => 'VPD_POLE',
   	 STATEMENT_TYPES => 'SELECT'
    );
END;
/

CREATE OR REPLACE FUNCTION VPD_TACHES (
	schema_var IN VARCHAR2,
	table_var IN VARCHAR2
) RETURN VARCHAR2
IS
  return_val VARCHAR2(400);
  le_role VARCHAR2(40);

BEGIN
	-- Récupération du rôle de l'utilisateur connecté depuis le contexte
   le_role := SYS_CONTEXT('entreprise_ctx', 'role_nom');
	-- Filtrage des tâches en fonction du rôle de l'utilisateur
	IF le_role  = 'ADMIN12_CHEF_PROJET' THEN
    	return_val := 'id_projet IN (SELECT id_projet FROM projets WHERE id_chef_de_projet = SYS_CONTEXT(''entreprise_ctx'', ''id_employe''))';
	ELSIF le_role  = 'ADMIN12_EMPLOYE' THEN
    	return_val := 'id_responsable_tache = SYS_CONTEXT(''entreprise_ctx'', ''id_employe'')';
	ELSE
    	return_val := '1=1';
	END IF;

	RETURN return_val ;
END VPD_TACHES;
/

-- Activer la politique de sécurité VPD pour la table TACHES
BEGIN
	DBMS_RLS.ADD_POLICY(
    	OBJECT_SCHEMA	=> 'ADMIN12',
  	OBJECT_NAME 	=> 'TACHES',
    	POLICY_NAME 	=> 'TACHES_POLICY',
    	FUNCTION_SCHEMA  =>'ADMIN12',
    	POLICY_FUNCTION  => 'VPD_TACHES',
    	STATEMENT_TYPES  => 'SELECT, UPDATE, DELETE'
	);
END;
/

CREATE OR REPLACE FUNCTION VPD_PROJET(
	schema_var IN VARCHAR2,
    TABLE_VAR IN VARCHAR2)
RETURN VARCHAR2
IS
    return_val VARCHAR2(400);
    le_role VARCHAR2(40);

BEGIN
    le_role := SYS_CONTEXT('entreprise_ctx', 'role_nom');

    IF le_role = 'ADMIN12_CHEF_PROJET'
    	THEN return_val := 'id_chef_de_projet = SYS_CONTEXT(''entreprise_ctx'', ''id_employe'')';
	ELSIF le_role = 'ADMIN12_CHEF_POLE'
    	THEN return_val := 'id_pole = SYS_CONTEXT(''entreprise_ctx'', ''id_pole'')';
	ELSE return_val := '1=1';
    END IF;

	RETURN return_val;
END VPD_PROJET;
/

BEGIN
	DBMS_RLS.ADD_POLICY (
  	  OBJECT_SCHEMA => 'ADMIN12',
  	  OBJECT_NAME => 'PROJETS',
  	  POLICY_NAME => 'PROJET_POLICY',
  	  FUNCTION_SCHEMA => 'ADMIN12',
  	  POLICY_FUNCTION => 'VPD_PROJET',
  	  STATEMENT_TYPES => 'SELECT, UPDATE'
	);
END;
/
