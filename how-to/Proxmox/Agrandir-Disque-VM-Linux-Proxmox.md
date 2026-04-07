# Augmenter la taille du disque d'une VM Linux (Debian) sur Proxmox

Procédure adaptée du guide : https://oleks.ca/2025/01/22/augmenter-la-taille-du-disque-debian-sur-proxmox/

---

## 1. Étendre le disque dans Proxmox
1. Arrêtez la VM concernée.
2. Faites une sauvegarde de la VM (recommandé).
3. Dans l'interface Proxmox :
   - Sélectionnez la VM > **Matériel (Hardware)**
   - Cliquez sur le disque > **Action > Resize disk**
   - Ajoutez la taille souhaitée (ex : +8 Go)
   - Cliquez sur **Redimensionner (Resize)**
4. Redémarrez la VM.

---

## 2. Redimensionner la partition avec SystemRescue
1. Téléchargez l'ISO de [SystemRescue](https://www.system-rescue.org/).
2. Ajoutez l'ISO à Proxmox (Stockage local > Téléverser ISO).
3. Dans la VM, montez l'ISO comme CD/DVD et démarrez dessus (modifiez l'ordre de boot si besoin).
4. Au démarrage, tapez :
   ```
   startx
   ```
   pour lancer l'interface graphique.
5. Lancez **GParted**.

---

## 3. Étendre la partition principale
1. Dans GParted :
   - Supprimez la partition swap (/dev/sda5) puis la partition étendue (/dev/sda2).
   - Redimensionnez la partition principale (/dev/sda1) pour utiliser tout l'espace libre (ajoutez l'espace non alloué).
   - Laissez ~950 Mo d'espace libre à la fin pour recréer la swap.
   - Appliquez les changements.
2. Créez une nouvelle partition linux-swap dans l'espace libre restant.
   - Appliquez les changements.

---

## 4. Redimensionner le système de fichiers
Dans SystemRescue, ouvrez un terminal et tapez :
```
resize2fs /dev/sda1
```
(Si le système de fichiers est déjà étendu, le message "Nothing to do!" s'affichera)

---

## 5. Mettre à jour l'UUID du swap dans /etc/fstab
1. Redémarrez la VM sur le disque (retirez l'ISO SystemRescue).
2. Connectez-vous et vérifiez les UUID :
   ```
   sudo blkid
   ```
3. Notez l'UUID de la nouvelle partition swap.
4. Modifiez `/etc/fstab` pour mettre à jour l'UUID du swap :
   ```
   sudo nano /etc/fstab
   ```
5. Sauvegardez et quittez.
6. Mettez à jour initramfs :
   ```
   sudo update-initramfs -u
   ```
7. Redémarrez la VM :
   ```
   sudo reboot
   ```

---

## 6. Vérifier l'espace disque
Après redémarrage, vérifiez l'espace disponible :
```
df -h
```
Vous devriez voir la nouvelle taille du disque.

---

**Remarque :**
- Cette procédure concerne les disques sans LVM. Pour LVM, la méthode diffère.
- Toujours sauvegarder avant toute opération de partitionnement !

---

**Source :**
https://oleks.ca/2025/01/22/augmenter-la-taille-du-disque-debian-sur-proxmox/
