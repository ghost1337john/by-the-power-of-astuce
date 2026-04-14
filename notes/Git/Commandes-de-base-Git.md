# Commandes de base Git & GitHub

## 1. Initialiser un dépôt local

- **Créer un nouveau dossier et initialiser Git** :
  ```
  mkdir MonProjet
  cd MonProjet
  git init
  ```

## 2. Cloner un dépôt existant

- **Depuis GitHub** :
  ```
  git clone https://github.com/utilisateur/nom-du-repo.git
  ```

## 3. Ajouter des fichiers

- **Ajouter un fichier spécifique** :
  ```
  git add fichier.txt
  ```
- **Ajouter tous les fichiers** :
  ```
  git add .
  ```

## 4. Vérifier l’état du dépôt

- **Voir les modifications en attente** :
  ```
  git status
  ```

## 5. Enregistrer les modifications (commit)

- **Créer un commit avec message** :
  ```
  git commit -m "Votre message explicite"
  ```

## 6. Lier un dépôt distant

- **Ajouter un remote (si besoin)** :
  ```
  git remote add origin https://github.com/utilisateur/nom-du-repo.git
  ```
- **Vérifier les remotes** :
  ```
  git remote -v
  ```

## 7. Envoyer les modifications sur GitHub

- **Pousser sur la branche principale** :
  ```
  git push origin main
  ```

## 8. Récupérer les modifications du serveur

- **Mettre à jour votre dépôt local** :
  ```
  git pull
  ```

## 9. Gérer les branches

- **Créer et basculer sur une nouvelle branche** :
  ```
  git checkout -b nouvelle-branche
  ```
- **Supprimer une branche** :
  ```
  git branch -d nom-branche
  ```

## 10. Fusionner une branche

- **Fusionner une branche dans la branche courante** :
  ```
  git merge nom-branche
  ```

## 11. Voir l’historique des commits

- **Afficher la liste des commits** :
  ```
  git log
  ```

## Sources
- Pour aller plus loin, consultez l’[aide-mémoire Git](https://about.gitlab.com/images/press/git-cheat-sheet.pdf)
- le tutoriel complet sur [DataCamp](https://www.datacamp.com/fr/tutorial/github-and-git-tutorial-for-beginners).
