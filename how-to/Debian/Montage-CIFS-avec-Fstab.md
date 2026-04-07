# Monter un partage CIFS/SMB avec fstab (Debian/Ubuntu)

> **Résumé :** Monter un partage réseau Windows (SMB/CIFS) sur Debian/Ubuntu, manuellement ou automatiquement au démarrage, avec gestion sécurisée des identifiants.

---

## 1️⃣ Installer les prérequis

```bash
sudo apt update
sudo apt install cifs-utils -y
```

---

## 2️⃣ Créer le point de montage

```bash
sudo mkdir -p /mnt/partage
```

---

## 3️⃣ Monter le partage manuellement

```bash
sudo mount -t cifs //serveur/Partage /mnt/partage -o username=MONUTILISATEUR
```
- Remplace `//serveur/Partage` par l'adresse de ton partage SMB
- `MONUTILISATEUR` = ton identifiant réseau
- Un mot de passe sera demandé

**Avec mot de passe en ligne (déconseillé) :**
```bash
sudo mount -t cifs //serveur/Partage /mnt/partage -o username=MONUTILISATEUR,password=MONMOTDEPASSE
```

---

## 4️⃣ Monter automatiquement au démarrage (fstab)

### a) Créer un fichier caché d'identifiants sécurisé

```bash
sudo nano /etc/.cifs-creds-partage
```
Contenu :
```
username=MONUTILISATEUR
password=MONMOTDEPASSE
```

**Sécuriser le fichier :**
```bash
sudo chmod 600 /etc/.cifs-creds-partage
```

### b) Éditer /etc/fstab

```bash
sudo nano /etc/fstab
```
Ajouter la ligne :
```
//serveur/Partage /mnt/partage cifs credentials=/etc/.cifs-creds-partage,iocharset=utf8,uid=1000,gid=1000,file_mode=0770,dir_mode=0770 0 0

**Explication des options :**
- `credentials=/etc/.cifs-creds-partage` : chemin vers le fichier contenant le nom d'utilisateur et le mot de passe.
- `iocharset=utf8` : utilise l'encodage UTF-8 pour les noms de fichiers (recommandé pour les caractères spéciaux).
- `uid=1000` : définit l'identifiant utilisateur propriétaire des fichiers montés (à adapter à ton utilisateur, voir la commande `id`).
- `gid=1000` : définit l'identifiant du groupe propriétaire des fichiers montés.
- `file_mode=0770` : permissions par défaut pour les fichiers (lecture/écriture/exécution pour propriétaire et groupe).
- `dir_mode=0770` : permissions par défaut pour les dossiers.
- Les deux derniers `0 0` : options pour dump et fsck (sauvegarde et vérification du système de fichiers, généralement laissées à 0 pour les montages réseau).
```
- Adapter `uid` et `gid` à ton utilisateur (voir `id`)
- Adapter les droits selon le besoin

### c) Monter sans redémarrer

```bash
sudo mount -a
```

**Alternative avec systemd :**
```bash
sudo systemctl restart remote-fs.target
```
Cette commande demande à systemd de remonter tous les systèmes de fichiers réseau définis dans fstab (dont CIFS/NFS).

**Remarque sur `daemon-reload` :**
```bash
sudo systemctl daemon-reload
```
Cette commande recharge la configuration de systemd (unités/services). Elle est utile si tu ajoutes ou modifies un fichier d’unité systemd personnalisé (ex : .mount, .service), mais n’est généralement pas nécessaire pour un simple changement dans fstab. Utilise-la si tu crées ou modifies des unités systemd liées au montage réseau.

---

## 5️⃣ Vérification

```bash
ls -l /mnt/partage
```

---

## 🔒 Sécurité
- **Ne jamais stocker de mot de passe en clair dans un script ou un fstab public.**
- Toujours restreindre les droits du fichier credentials (`chmod 600`).
- Préférer un compte dédié avec droits limités sur le partage.

---

## ℹ️ Notes
- Pour les partages sur un domaine AD, ajouter `domain=MONDOMAINE` dans les options.
- Pour du montage temporaire, la commande mount suffit.
- Pour du montage persistant, privilégier fstab + credentials.

---

## 📚 Sources
- https://wiki.debian.org/SambaClient
- https://doc.ubuntu-fr.org/cifs
- https://wiki.archlinux.org/title/samba
- [Tuto adapté et enrichi par ghost1337john]
