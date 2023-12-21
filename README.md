# Projet Gestion des droits d'accès 

## Exécution du Projet

Pour exécuter le projet, veuillez suivre les étapes ci-dessous :

1. **Décompression de l'archive :**
    ```bash
    tar -xvf nom_de_l_archive.tar.gz
    ```

2. **Accès au Répertoire :**
    ```bash
    cd nom_du_repertoire
    ```

3. **Ouverture d'une Console SqlPlus avec l'Utilisateur admin12 :**
    ```bash
    sqlplus admin12@cienetdb  # Mot de passe : 'admin'
    ```

4. **Nettoyage des Bases de l'Utilisateur admin12 :**
    ```sql
    @sanityze
    ```

5. **Création des Tables, Rôles, VPD, etc. :**
    ```sql
    @init_bdd
    ```

6. **Déconnexion de SqlPlus :**
    ```sql
    exit
    ```

À ce stade, les tables sont créées, de même que les utilisateurs, leurs rôles et la politique de contrôle d'accès. Il est maintenant nécessaire de tester les rôles en ouvrant 5 terminaux et en vous rendant dans le répertoire où l'archive a été décompressée.

## Test des Rôles

7. **Connexion avec n'importe quel Utilisateur dans chacune des Consoles :**
    ```bash
    sqlplus admin12@cienetdb  # Mot de passe : 'admin'
    ```

8. **Exécution des Rôles dans Chaque Fenêtre :**
   - **Terminal 1 (RH) :**
     ```sql
     @RH
     ```

   - **Terminal 2 (admin) :**
     ```sql
     @admin
     ```

   - **Terminal 3 (chef_pole) :**
     ```sql
     @chef_pole
     ```

   - **Terminal 4 (chef_projet) :**
     ```
     @chef_projet
     ```

   - **Terminal 5 (employe) :**
     ```sql
     @employe
     ```

     
