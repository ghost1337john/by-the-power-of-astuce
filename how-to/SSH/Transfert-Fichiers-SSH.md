# Transférer des fichiers avec SSH (scp, rsync, sftp)

Procédure adaptée du guide : https://verycloud.fr/docs/article/ssh-linux#6-transferer-des-fichiers-avec-ssh

---

## 1. Transfert avec scp
- Vers le serveur :
```bash
scp fichier.txt utilisateur@ip_ou_domaine:/home/utilisateur/
```
- Depuis le serveur :
```bash
scp utilisateur@ip_ou_domaine:/var/log/syslog ./
```

## 2. Transfert efficace et incrémental avec rsync
```bash
rsync -avz -e "ssh -p 22" ./site/ utilisateur@ip_ou_domaine:/var/www/site/
```

## 3. Session SFTP interactive
```bash
sftp utilisateur@ip_ou_domaine
```

---

**Conseils :**
- `scp` est simple pour des transferts ponctuels.
- `rsync` est recommandé pour synchroniser des dossiers volumineux ou faire des sauvegardes.
- `sftp` permet de naviguer et transférer des fichiers en mode interactif.

---

**Source :** https://verycloud.fr/docs/article/ssh-linux#6-transferer-des-fichiers-avec-ssh
