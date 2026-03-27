# Activer SUDO sur Debian (10/11/12/13)

> **Résumé :** Comment installer et configurer sudo sur Debian, accorder les droits à un utilisateur, et automatiser l'opération.

---

## 1️⃣ Installer sudo

Si la commande `sudo` n'est pas reconnue :

```bash
su -
apt update
apt install sudo
```

---

## 2️⃣ Accorder les droits sudo

### ➡️ Méthode recommandée : ajouter l'utilisateur au groupe sudo

```bash
usermod -aG sudo <utilisateur>
```
- Remplace `<utilisateur>` par ton nom d'utilisateur.
- Déconnecte-toi puis reconnecte-toi pour appliquer les droits.

### ➡️ Méthode avancée : éditer sudoers

Utilise l'éditeur sécurisé :
```bash
visudo
```
Ajoute une ligne pour l'utilisateur :
```bash
<utilisateur> ALL=(ALL:ALL) ALL
```

---

## 3️⃣ Vérifier le fonctionnement

```bash
sudo whoami
# ou
sudo cat /etc/sudoers
```

---

## 4️⃣ Script d'automatisation (root)

```bash
# Remplacer USERNAME par le nom d'utilisateur
apt update && apt install -y sudo && usermod -aG sudo USERNAME
```

---

## ℹ️ Notes
- **visudo** protège contre les erreurs de syntaxe.
- Le groupe `sudo` donne tous les droits root à ses membres.
- Pour des droits plus fins, personnalise la ligne dans sudoers.

---

## 📚 Sources
- https://wiki.debian.org/sudo
- https://www.debian.org/doc/manuals/securing-debian-howto/ch7.fr.html
- [Tuto adapté et enrichi par ghost1337john]
