# Durcir la configuration du serveur SSH (OpenSSH)

Procédure adaptée du guide : https://verycloud.fr/docs/article/ssh-linux#4-durcir-la-configuration-du-serveur-ssh

---

## 1. Créer un fichier de configuration dédié (drop-in)
```bash
sudo nano /etc/ssh/sshd_config.d/10-hardening.conf
```

## 2. Exemple de configuration recommandée
```
Port 22
Protocol 2
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
KbdInteractiveAuthentication no
ChallengeResponseAuthentication no
X11Forwarding no
AllowAgentForwarding yes
AllowTcpForwarding yes
ClientAliveInterval 300
ClientAliveCountMax 2
MaxAuthTries 3
LoginGraceTime 30
UseDNS no
# Optionnel : restreindre à certains utilisateurs
# AllowUsers adminops deployer
```

## 3. Tester la configuration et recharger le service
```bash
sudo sshd -t
sudo systemctl reload ssh
```

**Important :**
- Ne désactivez `PasswordAuthentication` qu'après avoir vérifié que la connexion par clé fonctionne.
- Gardez une session SSH ouverte lors des modifications pour éviter un verrouillage.

---

**Source :** https://verycloud.fr/docs/article/ssh-linux#4-durcir-la-configuration-du-serveur-ssh
