# Installer et activer le serveur SSH (OpenSSH) sur Linux (Debian/Ubuntu)

Procédure adaptée du guide : https://verycloud.fr/docs/article/ssh-linux#1-installer-et-activer-le-serveur-ssh-openssh-sur-

---

## 1. Installer OpenSSH Server
```bash
sudo apt update
sudo apt install -y openssh-server
```

## 2. Activer et démarrer le service SSH
```bash
sudo systemctl enable ssh --now
sudo systemctl status ssh --no-pager
```

## 3. Ouvrir le port SSH dans le pare-feu (UFW)
- Si UFW est utilisé :
```bash
sudo ufw allow OpenSSH
# ou, si le profil n'existe pas
sudo ufw allow 22/tcp
sudo ufw reload
sudo ufw status
```

## 4. Vérifier que SSH écoute sur le port 22
```bash
ss -tnlp | grep :22
```

---

## Conseils
- Utilisez un utilisateur non-root pour la connexion SSH.
- Assurez-vous que le port 22 est ouvert sur le réseau et le pare-feu.
- Sur Windows 10/11, l’outil ssh est intégré.

---

**Source :** https://verycloud.fr/docs/article/ssh-linux#1-installer-et-activer-le-serveur-ssh-openssh-sur-
