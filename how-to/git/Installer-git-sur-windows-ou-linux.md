## 1. Installer Git sur Windows ou Linux

Windows :

- **Windows** : Télécharger sur [git-scm.com](https://git-scm.com/download/win) ou via PowerShell :
  ```
  winget install --id Git.Git -e --source winget
  ```
Linux (Debian): 

- **Linux** : 
  ```
  sudo apt install git-all
  ```
- **Configurer votre identité** :
  ```
  git config --global user.name "VotreNom"
  git config --global user.email "votre@email.com"
  ```
