# Configurer le client SSH avec ~/.ssh/config

Procédure adaptée du guide : https://verycloud.fr/docs/article/ssh-linux#5-configurer-le-client-ssh-avec-sshconfig

---

## 1. Créer le dossier et le fichier de configuration
```bash
mkdir -p ~/.ssh && chmod 700 ~/.ssh
nano ~/.ssh/config
```

## 2. Exemple d’entrée pour un serveur
```
Host prod-web
    HostName ip_ou_domaine
    User utilisateur
    Port 22
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
```

- Connexion rapide :
```bash
ssh prod-web
```

## 3. Exemple avec bastion (ProxyJump)
```
Host bastion
    HostName bastion.exemple.com
    User ops
    IdentityFile ~/.ssh/id_ed25519

Host prod-web
    HostName web.interne.local
    User deploy
    ProxyJump bastion
```

---

**Conseils :**
- Utilisez ce fichier pour automatiser et simplifier vos connexions SSH.
- Protégez le fichier `~/.ssh/config` avec les bonnes permissions.

---

**Source :** https://verycloud.fr/docs/article/ssh-linux#5-configurer-le-client-ssh-avec-sshconfig
