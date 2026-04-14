# Commandes de base Linux

Voici une sélection des commandes Linux les plus utiles pour bien débuter en ligne de commande :

## 1. Afficher le contenu d’un dossier
```
ls                # liste les fichiers et dossiers du répertoire courant
ls -l             # liste détaillée (droits, taille, date, propriétaire)
ls -a             # inclut les fichiers cachés (ceux commençant par .)
ls -lh            # taille lisible (Ko, Mo...)
ls -R             # liste récursive des sous-dossiers
ls --color=auto   # couleurs selon le type de fichier
```
**Options utiles :**
- `-l` : affichage détaillé
- `-a` : inclut les fichiers cachés
- `-h` : taille lisible (avec `-l`)
- `-R` : récursif

## 2. Se déplacer dans l’arborescence
```
cd /chemin/vers/dossier   # aller dans un dossier
cd ..                     # dossier parent
cd                        # dossier personnel (home)
cd -                      # dossier précédent
```
**Raccourcis :**
- `..` : parent
- `-` : précédent
- `~` : home

## 3. Afficher le chemin courant
```
pwd    # affiche le chemin absolu du dossier courant
```

touch mon_fichier.txt
## 4. Créer un dossier ou un fichier
```
mkdir mon_dossier              # créer un dossier
mkdir -p dossier/sousdossier   # crée aussi les parents si besoin

touch mon_fichier.txt           # crée un fichier vide ou met à jour la date
```
**Options mkdir :**
- `-p` : crée les dossiers parents si besoin

mv ancien.txt nouveau.txt    # déplacer ou renommer
## 5. Copier, déplacer, renommer
```
cp source.txt destination.txt      # copier un fichier
cp -r dossier1 dossier2            # copier un dossier récursivement
cp -i fichier.txt dossier/         # demande confirmation en cas d'écrasement

mv ancien.txt nouveau.txt           # déplacer ou renommer
mv fichier.txt dossier/            # déplacer dans un dossier
```
**Options cp :**
- `-r` : récursif (pour dossiers)
- `-i` : interactif (confirmation)
- `-u` : copie seulement si source plus récente

## 6. Supprimer
```
rm fichier.txt               # supprimer un fichier
rm -r dossier                # supprimer un dossier et son contenu
rm -rf dossier               # forcer la suppression sans confirmation
rm -i fichier.txt            # demande confirmation
```
**Options rm :**
- `-r` : récursif
- `-f` : force (pas de confirmation)
- `-i` : interactif

## 7. Afficher le contenu d’un fichier
```
cat fichier.txt              # affiche tout le contenu
head fichier.txt             # affiche les 10 premières lignes
head -n 5 fichier.txt        # affiche les 5 premières lignes
tail fichier.txt             # affiche les 10 dernières lignes
less fichier.txt             # navigation interactive (q pour quitter)
```
**Options :**
- `head -n N` : N premières lignes
- `tail -n N` : N dernières lignes

## 8. Rechercher
```
find /chemin -name "*.txt"   # recherche par nom
find /chemin -type d         # recherche de dossiers
find /chemin -size +10M      # fichiers > 10 Mo
locate fichier.txt           # recherche rapide (base de données)
```
**Options find :**
- `-name` : par nom
- `-type f/d` : fichier/dossier
- `-size` : taille
**Options locate :**
- rapide mais nécessite mise à jour avec `updatedb`

## 9. Droits et exécution
```
chmod +x script.sh           # rendre exécutable
chmod 755 fichier            # droits rwxr-xr-x
chown user:group fichier     # changer propriétaire
./script.sh                  # exécuter un script
```
**Options chmod :**
- `+x` : ajoute le droit d'exécution
- `755` : droits classiques pour scripts
**Options chown :**
- `user:group` : définit le propriétaire et le groupe

## 10. Aide et manuel
```
man ls               # manuel complet
ls --help            # aide rapide
```

## 11. Réseau et système
```
ping google.com                # tester la connexion
ping -c 4 google.com           # 4 paquets
wget http://site.com/fichier   # télécharger un fichier
hostname                      # nom de la machine
hostname -I                   # adresse IP
uname -a                      # infos système complètes
uname -r                      # version du noyau
```
**Options ping :**
- `-c N` : nombre de paquets
**Options uname :**
- `-a` : tout afficher
- `-r` : version du noyau

## 12. Processus et ressources
```
top                         # processus en temps réel
ps aux                      # liste tous les processus
ps -ef                      # format alternatif
kill PID                    # arrêter un processus
kill -9 PID                 # forcer l'arrêt
```
**Options ps :**
- `aux` ou `-ef` : affichage complet
**Options kill :**
- `-9` : forcer l'arrêt

## 13. Autres commandes utiles
```
echo "texte"                # afficher du texte
echo $HOME                  # afficher une variable
history                     # historique des commandes
clear                       # nettoyer le terminal
zip archive.zip fichier.txt # compresser
unzip archive.zip           # décompresser
shutdown now                # éteindre la machine
shutdown -r now             # redémarrer
```
**Options shutdown :**
- `now` : immédiat
- `-r` : redémarrage

---

Pour plus de détails, consultez le [guide complet LesJeudis](https://blog.lesjeudis.com/commandes-linux-de-base) ou la page de manuel de chaque commande (`man commande`).
