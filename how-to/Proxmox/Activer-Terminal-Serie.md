# Activer Terminal Série pour faire du copier coller

Si vous faites beaucoup de travail via ssh sur votre serveur pve, vous apprécieriez peut-être de vous connecter à vos VMs en cours d'exécution en mode TS.

## Intérêts

- vous avez perdu l'accès réseau à l'invité et VNC est soit trop lent pour vous, soit n'a pas les fonctionnalités nécessaires (c'est-à-dire un copier/coller facile entre d'autres terminaux)
- votre invité se fige ou le noyau panique, vous voulez le déboguer, mais il est impossible de capturer tous les messages sur l'écran VNC
- La disposition de votre clavier est défectueuse sur l'invité

## Configuration sur l'hôte (Proxmox)

### Option 1 : Via l'éditeur de fichier de configuration

```bash
nano /etc/pve/qemu-server/<idVM>.conf
```

Ajouter le paramètre suivant à la fin du fichier :

```
serial0: socket
```

### Option 2 : Via la commande qm

```bash
qm set <idVM> -serial0 socket
```

## Configuration sur l'invité (VM Debian)

### 1. Configurer le service getty sur le port série

Éditer ou créer le fichier :

```bash
nano /etc/init/ttyS0.conf
```

Ajouter le contenu suivant :

```
# ttyS0 - getty
#
# This service maintains a getty on ttyS0 from the point the system is
# started until it is shut down again.

start on stopped rc RUNLEVEL=[12345]
stop on runlevel [!12345]

respawn
exec /sbin/getty -L 115200 ttyS0 vt102
```

Démarrer le service :

```bash
sudo start ttyS0
```

### 2. Vérifier que le port série émulé est bien présent

```bash
dmesg | grep ttyS
```

Vous devriez voir une sortie similaire à :

```
[    0.457814] 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
```

### 3. Configurer GRUB pour envoyer les messages de démarrage au port série

Éditer le fichier de configuration GRUB :

```bash
nano /etc/default/grub
```

Modifier la ligne `GRUB_CMDLINE_LINUX` pour inclure les sorties console :

```bash
GRUB_CMDLINE_LINUX="quiet console=tty0 console=ttyS0,115200"
```

Mettre à jour GRUB (Debian) :

```bash
update-grub
```

### 4. Redémarrer la VM

```bash
sudo reboot
```

## Connexion au terminal série

Depuis le shell de Proxmox, vérifier le statut de la VM :

```bash
qm status <idVM>
```

Se connecter en terminal série :

```bash
qm terminal <idVM>
```

Vous devriez voir :

```
starting serial terminal on interface serial0 (press control-O to exit)
Debian GNU/Linux X debian ttyS0
debian login:
```

## Dépannage

### Vérifier que le port série virtuel est correctement configuré

```bash
qm monitor <VMiD>
info chardev
```

Vous devriez voir une ligne commençant par `serial0` :

```
serial0: filename=disconnected:unix:/var/run/qemu-server/101.serial0,server
```

### Notes importantes

- Utilisez **Ctrl-O** pour quitter le terminal série (et non Ctrl-C)
- Si vous utilisez `nano`, sauvegarder avec Ctrl-O vous déconnectera à la place
- Assurez-vous que la VM est correctement configurée aux étapes précédentes

## Sources

- [Proxmox Documentation - Serial Terminal](https://pve.proxmox.com/wiki/Serial_Terminal)
- [Serial Console Documentation](http://0pointer.de/blog/projects/serial-console.html)
