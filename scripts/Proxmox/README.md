# Configuration du Terminal Série - Proxmox & Debian

Ce dossier contient la documentation et les scripts d'automatisation pour activer le terminal série sur Proxmox avec des VMs Debian.

## 📋 Structure

```
Proxmox/
├── how-to/
│   └── Proxmox/
│       └── Activer-Terminal-Serie.md      # Documentation complète
│
└── scripts/
    └── Proxmox/
        ├── proxmox-configure-serial.sh    # Configuration côté Proxmox (hôte)
        ├── enable-serial-terminal.sh       # Configuration côté Debian (VM)
        └── README.md                       # Ce fichier
```

## 🎯 Objectif

Activer le terminal série pour :
- **Copier/coller facile** entre le terminal et d'autres applications
- **Accès de secours** quand le réseau est indisponible
- **Débogage du noyau** sans dépendre de VNC
- **Résoudre les problèmes de clavier** sur l'invité

## 🚀 Démarrage rapide

### Étape 1 : Configuration Proxmox (sur l'hôte)

```bash
cd scripts/Proxmox
chmod +x proxmox-configure-serial.sh
sudo ./proxmox-configure-serial.sh 101 102 103
```

**Remplacez `101 102 103` par les IDs réels de vos VMs**

### Étape 2 : Configuration Debian (sur chaque VM)

1. Copiez le script dans la VM :
   ```bash
   scp enable-serial-terminal.sh root@192.168.x.x:/tmp/
   ```

2. Exécutez le script :
   ```bash
   ssh root@192.168.x.x
   sudo chmod +x /tmp/enable-serial-terminal.sh
   sudo /tmp/enable-serial-terminal.sh
   ```

3. Redémarrez la VM :
   ```bash
   sudo reboot
   ```

### Étape 3 : Tester la connexion

Depuis Proxmox :
```bash
qm terminal 101
```

Vous devriez voir l'invite de connexion Debian sur le port série.

## 📖 Documentation détaillée

Voir [Activer-Terminal-Serie.md](../../how-to/Proxmox/Activer-Terminal-Serie.md) pour :
- Explication détaillée de chaque étape
- Configuration manuelle
- Dépannage
- Notes importantes

## 🔧 Scripts disponibles

### `proxmox-configure-serial.sh`

Configure le port série côté Proxmox pour une ou plusieurs VMs.

**Utilisation:**
```bash
sudo ./proxmox-configure-serial.sh <idVM1> [<idVM2> ...]
```

**Exemple:**
```bash
sudo ./proxmox-configure-serial.sh 101 102 103
```

**Ce que le script fait:**
- ✓ Vérifie que les VMs existent
- ✓ Crée des sauvegardes des fichiers de configuration
- ✓ Ajoute `serial0: socket` aux configurations
- ✓ Applique les changements via `qm set`

**Sauvegarde:** Les fichiers originaux sont conservés avec `.backup.<timestamp>`

---

### `enable-serial-terminal.sh`

Configure le terminal série côté Debian (à exécuter dans la VM).

**Utilisation:**
```bash
sudo chmod +x enable-serial-terminal.sh
sudo ./enable-serial-terminal.sh
```

**Ce que le script fait:**
- ✓ Configure getty sur ttyS0
- ✓ Met à jour GRUB pour les messages de démarrage
- ✓ Crée des sauvegardes
- ✓ Détecte le port série et valide la configuration

**Redémarrage requis:** Oui, exécutez `sudo reboot` après le script

---

## ⚠️ Prérequis

### Côté Proxmox
- Accès root/sudo
- VMs existantes à configurer
- Proxmox ≥ 5.x (testé sur 6.x/7.x)

### Côté Debian
- Debian Jessie ou plus récent
- Accès root/sudo
- Système basé systemd ou upstart

## 🐛 Dépannage

### Le terminal série ne fonctionne pas

1. **Vérifier la configuration Proxmox:**
   ```bash
   qm monitor 101
   info chardev
   ```
   Vous devez voir `serial0: filename=disconnected:unix:...`

2. **Vérifier le port série dans la VM:**
   ```bash
   dmesg | grep ttyS
   ```
   Vous devez voir `ttyS0 at I/O 0x3f8`

3. **Vérifier GRUB dans la VM:**
   ```bash
   cat /etc/default/grub | grep GRUB_CMDLINE
   ```
   Doit contenir `console=ttyS0,115200`

4. **Redémarrer la VM:**
   ```bash
   sudo reboot
   ```

### Ctrl-O ne fonctionne pas pour quitter

- Utilisez exactement **Ctrl-O** (pas Ctrl-C ni Ctrl-D)
- Si vous êtes dans `nano`, sauvegardez d'abord avec Ctrl-X, Y, Enter

## 📝 Notes importantes

- **Quitter le terminal:** Utilisez **Ctrl-O** (ou tapez `exit` puis Enter)
- **Sauvegarde automatique:** Des fichiers `.backup.<timestamp>` sont créés
- **VM arrêtée:** Idéalement, arrêtez les VMs avant la configuration
- **Distribution:** Les scripts sont optimisés pour Debian, adaptez pour Ubuntu/autres

## 🔗 Sources

- [Proxmox Serial Terminal Documentation](https://pve.proxmox.com/wiki/Serial_Terminal)
- [Serial Console - 0pointer Blog](http://0pointer.de/blog/projects/serial-console.html)
- [Debian Serial Console](https://wiki.debian.org/SerialConsoleHowto)

## 📄 Licence

Ces scripts font partie du dépôt `by-the-power-of-astuce`.

---

**Créé:** 2026-03-27  
**Dernière mise à jour:** 2026-03-27
