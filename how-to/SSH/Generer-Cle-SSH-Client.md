# Générer une paire de clés SSH sur le client

Procédure adaptée du guide : https://verycloud.fr/docs/article/ssh-linux#3-generer-une-paire-de-cles-ssh-sur-le-client

---

## 1. Générer une clé SSH moderne protégée par une passphrase
```bash
ssh-keygen -t ed25519 -a 100 -C "poste-client"
```
- La clé publique sera généralement dans `~/.ssh/id_ed25519.pub`.

## 2. Copier la clé publique sur le serveur
- Méthode automatique :
```bash
ssh-copy-id -i ~/.ssh/id_ed25519.pub utilisateur@ip_ou_domaine
```
- Méthode manuelle (si ssh-copy-id n'est pas disponible) :
```bash
cat ~/.ssh/id_ed25519.pub | ssh utilisateur@ip_ou_domaine 'mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys'
```

## 3. Activer l’agent SSH et charger la clé (pour éviter de retaper la passphrase)
- Sous Linux/macOS :
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```
- Sous Windows PowerShell :
```powershell
Start-Service ssh-agent
Get-Service ssh-agent | Set-Service -StartupType Automatic
ssh-add $env:USERPROFILE\.ssh\id_ed25519
```

---

**Source :** https://verycloud.fr/docs/article/ssh-linux#3-generer-une-paire-de-cles-ssh-sur-le-client
