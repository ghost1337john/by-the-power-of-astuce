# Vérifier l’empreinte de la clé hôte SSH (sécurité)

Procédure adaptée du guide : https://verycloud.fr/docs/article/ssh-linux#9-verifier-lempreinte-de-la-cle-hote-securite

---

## 1. Vérifier l’empreinte de la clé hôte sur le serveur
```bash
sudo ssh-keygen -l -f /etc/ssh/ssh_host_ed25519_key.pub
```

## 2. Comparer l’empreinte lors de la première connexion SSH
- Lors de la première connexion, SSH affiche l’empreinte de la clé hôte.
- Comparez-la avec celle obtenue sur le serveur pour éviter les attaques de type "man-in-the-middle".

## 3. Pré-remplir le fichier known_hosts côté client
```bash
ssh-keyscan -t ed25519 ip_ou_domaine >> ~/.ssh/known_hosts
```

---

**Conseils :**
- Toujours vérifier l’empreinte de la clé hôte lors de la première connexion à un nouveau serveur.
- Pour plus de sécurité, limitez les connexions SSH aux IPs de confiance.

---

**Source :** https://verycloud.fr/docs/article/ssh-linux#9-verifier-lempreinte-de-la-cle-hote-securite
