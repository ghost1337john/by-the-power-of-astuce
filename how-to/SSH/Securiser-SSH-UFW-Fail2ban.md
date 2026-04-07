# Sécuriser davantage SSH : UFW, Fail2ban et port non standard

Procédure adaptée du guide : https://verycloud.fr/docs/article/ssh-linux#8-securiser-davantage-ufw-fail2ban-et-port-non-sta

---

## 1. Utiliser un port SSH non standard
- Exemple pour passer de 22 à 2222 :
```bash
sudo ufw allow 2222/tcp
sudo ufw delete allow 22/tcp
sudo ufw reload
```
- Modifiez la configuration SSH :
```bash
sudo nano /etc/ssh/sshd_config.d/10-hardening.conf
# Changez Port 22 en Port 2222
sudo sshd -t && sudo systemctl reload ssh
```

## 2. Installer et configurer Fail2ban
- Installation :
```bash
sudo apt install -y fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo nano /etc/fail2ban/jail.local
```
- Exemple de configuration minimale pour sshd :
```
[sshd]
enabled = true
bantime = 1h
findtime = 10m
maxretry = 5
```
- Redémarrer Fail2ban et vérifier :
```bash
sudo systemctl restart fail2ban
sudo fail2ban-client status sshd
```

---

**Conseils :**
- Changer le port SSH ne remplace pas l’authentification par clé.
- Fail2ban protège contre les attaques par force brute.
- Gardez toujours une session SSH ouverte lors de modifications critiques.

---

**Source :** https://verycloud.fr/docs/article/ssh-linux#8-securiser-davantage-ufw-fail2ban-et-port-non-sta
