# Se connecter en SSH depuis un client Linux/Mac/Windows

Procédure adaptée du guide : https://verycloud.fr/docs/article/ssh-linux#2-se-connecter-en-ssh-depuis-un-client

---

## 1. Connexion SSH de base
```bash
ssh utilisateur@ip_ou_domaine
```

## 2. Utiliser une clé privée spécifique
```bash
ssh -i ~/.ssh/id_ed25519 utilisateur@ip_ou_domaine
```

## 3. Se connecter sur un port non standard (ex : 2222)
```bash
ssh -p 2222 utilisateur@ip_ou_domaine
```

## 4. Augmenter la verbosité pour le diagnostic
```bash
ssh -vvv utilisateur@ip_ou_domaine
```

---

## Conseils
- Utilisez un utilisateur non-root pour la connexion.
- Sur Windows 10/11, l’outil ssh est intégré (PowerShell ou CMD).
- Pour automatiser la connexion, configurez un fichier `~/.ssh/config`.

---

**Source :** https://verycloud.fr/docs/article/ssh-linux#2-se-connecter-en-ssh-depuis-un-client
