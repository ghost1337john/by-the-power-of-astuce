# Bonnes pratiques SSH récapitulatives

Procédure adaptée du guide : https://verycloud.fr/docs/article/ssh-linux#11-bonnes-pratiques-recapitulatives

---

- Utilisez des clés ed25519 protégées par une passphrase, stockées dans `~/.ssh` avec des permissions strictes.
- Désactivez l’authentification par mot de passe une fois la connexion par clé vérifiée.
- Interdisez la connexion root directe, utilisez un utilisateur dédié avec sudo.
- Restreignez l’accès SSH à certains utilisateurs ou groupes avec `AllowUsers` ou `AllowGroups`.
- Surveillez régulièrement le fichier `/var/log/auth.log` et activez Fail2ban pour limiter les attaques par force brute.
- Sauvegardez vos clés privées et mettez en place une politique de rotation si nécessaire.
- Documentez tout changement de port SSH et mettez à jour les règles réseau associées.

---

**Source :** https://verycloud.fr/docs/article/ssh-linux#11-bonnes-pratiques-recapitulatives
