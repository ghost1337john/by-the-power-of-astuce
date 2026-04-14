# Installer Git sur Windows ou Linux

## 1. Installation sur Windows

### Méthode 1 : Téléchargement officiel
1. Visitez [git-scm.com](https://git-scm.com/download/win) pour télécharger l'installeur officiel
2. Suivez l'assistant d'installation en acceptant les paramètres par défaut (sauf si vous avez des besoins spécifiques)

### Méthode 2 : Utiliser Windows Package Manager (Winget) dans powershell
```
winget install --id Git.Git -e --source winget
```
--id Git.Git : Identifiant du package Git
--e : Mode administrateur
--source winget : Utilise le dépôt Winget par défaut

## 2. Installation sur Linux (Debian/Ubuntu)

### Utiliser APT
- **Linux** : 
  ```
  sudo apt install git-all
  ```
- `git-all` inclut :
  - Git-core (outil de base)
  - Git-doc (documentation)
  - Git-gui (interface graphique)
  - Git-manpages (pages de manuel)

- Utilisez `git` seul si vous n'avez pas besoin des outils supplémentaires

## 3. Vérifier la version installée

- **Linux** : 
  ```
  sudo git --version
  ```

## 4. Configurer le profil utilisateur de Git

**Etape 1 - paramétrage du compte ** : 
  ```
  git config --global user.name "Prénom_Nom"
  git config --global user.email "monmail@domain.com"
  ```
**Etape 2 - vérifier la configuration ** :
 ```
 git config --global --list
 ```
**Etape 3 - si erreur - pour supprimer ** 
 ```
git config --global --unset-all user.name 
git config --global --unset-all user.email
 ```
## 5. Installation du module post-git pour avoir le prompt git dans powershell

**Etape 1 - paramétrage du compte ** : 
  ```
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```
**Etape 2 - vérifier la configuration ** :
 ```
Install-Module posh-git -Scope CurrentUser
 ```
**Etape 3 - si erreur - pour supprimer ** 
 ```
Import-Module posh-git
 ```
C:\Users\User\Documents\GitHub\Project (main)>


 ## Sources : 
- https://www.it-connect.fr/chapitres/git-installation-linux-ou-windows/
- https://www.it-connect.fr/chapitres/git-configurer-un-profil-utilisateur-vscode/