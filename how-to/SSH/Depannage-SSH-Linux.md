# Dépannage SSH Linux : Problèmes courants et solutions

Procédure adaptée du guide : https://verycloud.fr/docs/article/ssh-linux#10-depannage-problemes-courants-et-solutions

---

## 1. Connexion refusée
- Vérifiez que le service SSH est actif :
  ```bash
  sudo systemctl status ssh
  ```
- Vérifiez le pare-feu :
  ```bash
  sudo ufw status
  ```
- Vérifiez que le port 22 est bien à l'écoute :
  ```bash
  ss -tnlp | grep :22
  ```

## 2. Authentification qui échoue
- Surveillez les logs côté serveur :
  ```bash
  sudo tail -f /var/log/auth.log
  ```
- Activez la verbosité côté client pour plus de détails :
  ```bash
  ssh -vvv utilisateur@ip_ou_domaine
  ```

## 3. Permissions incorrectes sur .ssh ou authorized_keys
- Corrigez les permissions :
  ```bash
  chmod 700 ~/.ssh
  chmod 600 ~/.ssh/authorized_keys
  ```

## 4. Clé privée non utilisée
- Forcez l'utilisation de la bonne clé :
  ```bash
  ssh -i ~/.ssh/id_ed25519 -o IdentitiesOnly=yes utilisateur@ip_ou_domaine
  ```

## 5. Port SSH non standard ou conflit de port
- Si le port SSH a changé, adaptez la connexion :
  ```bash
  ssh -p 2222 utilisateur@ip_ou_domaine
  ```
- Modifiez la configuration serveur si besoin :
  ```bash
  sudo nano /etc/ssh/sshd_config.d/10-hardening.conf
  sudo sshd -t && sudo systemctl reload ssh
  ```

## 6. Hôte derrière un firewall cloud
- Ouvrez le port 22 (ou personnalisé) dans la console du fournisseur cloud, en plus du pare-feu local (UFW).

---

## Conseils supplémentaires
- Gardez toujours une session SSH ouverte lors de modifications critiques.
- Testez la connexion par clé avant de désactiver l’authentification par mot de passe.
- Surveillez les logs d’authentification pour détecter les blocages ou attaques.

---

**Source :** https://verycloud.fr/docs/article/ssh-linux#10-depannage-problemes-courants-et-solutions
