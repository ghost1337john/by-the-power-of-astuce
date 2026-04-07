# Annexes SSH : Cartes mémo utiles

Procédure adaptée du guide : https://verycloud.fr/docs/article/ssh-linux#annexes-cartes-memo-utiles

---

## Lister les clés publiques côté serveur
```bash
sudo ls -l /etc/ssh/ssh_host_*_key.pub
```

## Imprimer l’empreinte de la clé locale
```bash
ssh-keygen -l -f ~/.ssh/id_ed25519.pub
```

## Exécuter une commande distante en une ligne
```bash
ssh utilisateur@ip_ou_domaine 'sudo systemctl status --no-pager ssh'
```

## Multiplexage SSH pour accélérer les connexions répétées
Ajoutez dans `~/.ssh/config` :
```
Host *
    ControlMaster auto
    ControlPath ~/.ssh/cm-%r@%h:%p
    ControlPersist 5m
```

---

**Source :** https://verycloud.fr/docs/article/ssh-linux#annexes-cartes-memo-utiles
