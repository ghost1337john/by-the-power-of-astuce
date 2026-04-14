# Commandes de base Git & GitHub

## 1. Initialiser un dépôt local

- **Créer un nouveau dossier** :
  ```
  mkdir MonProjet
  cd MonProjet
  ```
## 2. Cloner un dépôt existant

- **Depuis GitHub** :
  ```
  git clone https://github.com/utilisateur/nom-du-repo.git
  ```
## 3. Initialiser Git
  
  ```
  git init
  ```
## 4. Ajouter des fichiers dans l'espace de staging

- **Ajouter un fichier spécifique** :
  ```
  git add fichier.txt
  ```
- **Ajouter tous les fichiers** :
  ```
  git add .
  ```
## 5. Vérifier l’état du dépôt

- **Voir les modifications en attente** :
  ```
  git status
  ```
ou
  ```
  git status -s
  ```
## 6. Enregistrer le snapshot des modifications (commit)

- **Créer un commit avec message** :
  ```
  git commit -m "Votre message explicite"
  ```
ou pour combiner add et commit
  ```
  git commit -am "Votre message explicite"
  ```
## 7. Afficher les changements entre le répertoire de travail et l'espace de staging

  ```
  git diff
  ```
## 8.  Retirer un fichier spécifique de l'espace de staging
  ```
  git reset nom_du_fichier
  ```
ou pour tout le contenu
  ```
  git reset
  ```
# 8.  Retirer un fichier spécifique de l'espace de staging et du répertoire de travail
  ```
  git rm <nom_du_fichier>
  ```
ou Retirer tout le contenu de l'espace de staging et du répertoire de travail
  ```
  git rm  *
  ```
## 9. Voir l’historique des commits

- **Afficher la liste des commits** :
  ```
  git log
  ```
ou en une ligne 
  ```
  git log --oneline
  ```  
## 10. Suppression du commit

**Suppression du dernier commit**
 ```
git revert -e HEAD
 ```
**Suppression de l'avant dernier commit**
 ```
git revert -e HEAD~1
 ```
**Suppression d'un commit à partir de son hash**
 ```
git revert -e hash
 ```
## 11. Restaurer une version antérieur d'un commit

 ```
git reset --hard hash
 ```

## 12. Voir la branche en cours

 ```
git branch
 ```
ou basculter sur une autre branche

 ```
git checkout nouvelle-banche
 ```

## 13. Gérer les branches

- **Créer et basculer sur une nouvelle branche** :
  ```
  git checkout -b nouvelle-branche
  ```
- **Supprimer une branche** :
  ```
  git branch -d nom-branche
  ```
## 14. Fusionner une branche (avant se placer dans la branche de destination)

- **Fusionner une branche dans la branche courante** :
  ```
  git merge nom-branche-source
  ```
ou en squash merge pour ne pas conserver l'historique des commits de la branche secondaire
  ```
  git merge --squash nom-branche
  ```
## 15. Rebaser les commits d'une branche vers une branche cible (avant se placer dans la branche source)

  ```
  git rebase branche-cible
  ```
## 16. Afficher les branches du dépôt distant

  ```
  git remote -v
  ```
## 17. Envoyer les modifications sur GitHub

- **Pousser sur la branche principale** :
  ```
  git push
  ```
## 18. Récupérer les modifications du serveur

- **Mettre à jour votre dépôt local** :
  ```
  git pull
  ```

## Sources
- Pour aller plus loin, consultez l’[aide-mémoire Git](https://about.gitlab.com/images/press/git-cheat-sheet.pdf)
- le tutoriel complet sur [DataCamp](https://www.datacamp.com/fr/tutorial/github-and-git-tutorial-for-beginners)
- Un autre tutoriel sur [IT-Connect](https://www.it-connect.fr/bien-debuter-avec-git-installation-et-prise-en-main/*)