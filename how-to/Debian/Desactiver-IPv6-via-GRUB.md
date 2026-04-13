# Désactiver IPv6 via le GRUB sur Linux

## 🛠 Méthode via GRUB (permanente, nécessite redémarrage)

### 1. Éditer le fichier GRUB
Ouvre le fichier `/etc/default/grub` avec ton éditeur préféré (ex. nano) :

```bash
sudo nano /etc/default/grub
```

### 2. Ajouter le paramètre de désactivation
Modifie ou ajoute les lignes suivantes :

```bash
GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1 quiet splash"
GRUB_CMDLINE_LINUX="ipv6.disable=1"
```

### 3. Mettre à jour la configuration GRUB
Selon ta distribution :

- **Debian/Ubuntu/Linux Mint** :
  ```bash
  sudo update-grub
  ```
- **Fedora/RHEL/CentOS/OpenSUSE** :
  ```bash
  sudo grub2-mkconfig -o /boot/grub2/grub.cfg
  ```
- **UEFI** :
  ```bash
  sudo grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg
  ```

### 4. Redémarrer le système
Après redémarrage, IPv6 sera désactivé au niveau du noyau.

## 🔍 Vérification

Vérifie que IPv6 est bien désactivé :

```bash
cat /proc/sys/net/ipv6/conf/all/disable_ipv6
```

Si la valeur est `1`, c’est bon.

## 🧩 Complément : désactivation via sysctl (optionnel mais recommandé)

Pour renforcer la désactivation :

```bash
sudo nano /etc/sysctl.conf
```

Ajoute :

```bash
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
```

Puis applique :

```bash
sudo sysctl -p
```

---

**Astuce :** Pour automatiser sur plusieurs machines, un script Bash peut être créé.
