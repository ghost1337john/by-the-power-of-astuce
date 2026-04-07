# Tunnels SSH (port forwarding)

Procédure adaptée du guide : https://verycloud.fr/docs/article/ssh-linux#7-tunnels-ssh-port-forwarding

---

## 1. Tunnel local (Local Forwarding)
Permet d’accéder à un service distant via un port local.

Exemple : accéder à un service distant sur le port 80 via http://localhost:8080
```bash
ssh -L 8080:localhost:80 utilisateur@ip_ou_domaine
```

## 2. Tunnel distant (Remote Forwarding)
Expose un service local du client vers le serveur.

Exemple : rendre accessible le port 3000 du client sur le port 9000 du serveur
```bash
ssh -R 9000:localhost:3000 utilisateur@ip_ou_domaine
```

## 3. Proxy SOCKS dynamique
Permet d’utiliser SSH comme proxy SOCKS (ex : pour naviguer anonymement).
```bash
ssh -D 1080 -N utilisateur@ip_ou_domaine
```

---

**Conseils :**
- Utilisez les tunnels SSH pour sécuriser l’accès à des services internes ou contourner des restrictions réseau.
- L’option `-N` indique de ne pas exécuter de commande distante (utile pour les tunnels).

---

**Source :** https://verycloud.fr/docs/article/ssh-linux#7-tunnels-ssh-port-forwarding
