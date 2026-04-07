# Rendre Silencieux un Serveur Dell PowerEdge

Procédure basée sur le guide SPX Labs : https://www.spxlabs.com/blog/2019/3/16/silence-your-dell-poweredge-server

## ⚠️ Avertissement
Prendre le contrôle manuel des ventilateurs désactive la régulation automatique. Surveillez la température du serveur pour éviter toute surchauffe !

---

## 1. Prérequis
- Activer l'IPMI sur l'iDRAC :
  - Se connecter à l'iDRAC (interface web du serveur)
  - Aller dans **iDRAC Settings > Network**
  - Activer "Enable IPMI Over Lan"
- Installer `ipmitool` sur votre OS (Linux, Unraid, etc.)

---

## 2. Prendre le contrôle manuel des ventilateurs
Remplacez les valeurs IP, utilisateur et mot de passe par ceux de votre serveur.

```bash
ipmitool -I lanplus -H <IP_iDRAC> -U <user> -P <password> raw 0x30 0x30 0x01 0x00
```

---

## 3. Régler la vitesse des ventilateurs (exemples)
- 20% de la vitesse :
  ```bash
  ipmitool -I lanplus -H <IP_iDRAC> -U <user> -P <password> raw 0x30 0x30 0x02 0xff 0x14
  ```
- 10% :
  ```bash
  ipmitool -I lanplus -H <IP_iDRAC> -U <user> -P <password> raw 0x30 0x30 0x02 0xff 0x0A
  ```
- 50% :
  ```bash
  ipmitool -I lanplus -H <IP_iDRAC> -U <user> -P <password> raw 0x30 0x30 0x02 0xff 0x32
  ```
- Pour d'autres valeurs, convertissez le pourcentage en hexadécimal (ex : 80% = 0x50).

---

## 4. Désactiver le mode manuel (remettre la gestion automatique)
```bash
ipmitool -I lanplus -H <IP_iDRAC> -U <user> -P <password> raw 0x30 0x30 0x01 0x01
```

---

## 5. Vérifier la température et la vitesse des ventilateurs
- Afficher les capteurs :
  ```bash
  ipmitool -I lanplus -H <IP_iDRAC> -U <user> -P <password> sensor list
  ```
- Lire la température et les ventilateurs :
  ```bash
  ipmitool -I lanplus -H <IP_iDRAC> -U <user> -P <password> sensor reading "Temp" "Fan1A" "Fan1B"
  ```

---

## 6. Script Bash pour automatiser
Créez un script pour fixer la vitesse (ex : set_fan_speed.sh) :
```bash
#!/bin/bash
ipmitool -I lanplus -H <IP_iDRAC> -U <user> -P <password> raw 0x30 0x30 0x01 0x00
ipmitool -I lanplus -H <IP_iDRAC> -U <user> -P <password> raw 0x30 0x30 0x02 0xff 0x14 # 20%
```

---

## 7. Limitations et remarques
- Ne fonctionne pas sur iDRAC > 3.30.30.30 (Dell a désactivé cette fonction sur les firmwares récents).
- La vitesse des ventilateurs reste fixe : surveillez la température !
- Pour un contrôle dynamique, il faut écrire un script qui ajuste la vitesse selon la température.

---

## 8. Ressources complémentaires
- [Guide original SPX Labs](https://www.spxlabs.com/blog/2019/3/16/silence-your-dell-poweredge-server)
- [Exemple de script de régulation](https://github.com/NoLooseEnds/Scripts/tree/master/R710-IPMI-TEMP)
- [Documentation IPMI](https://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/ipmi-second-gen-interface-spec-v2-rev1-1.pdf)

---

**Testé sur Dell PowerEdge R330, R410, R510, R620, R720, R730, T630, etc.**

