# Guide complet : Configurer un VPN d'accès distant sécurisé sur OPNsense avec OpenVPN

Ce tutoriel vous guide pas à pas pour mettre en place un VPN d'accès distant sécurisé sur OPNsense à l'aide d'OpenVPN. Idéal pour un usage personnel, professionnel ou pour accéder à distance à vos ressources internes.

## Sommaire
1. Installation et activation du plugin OpenVPN
2. Génération de l'autorité de certification (CA) et des certificats
3. Création des utilisateurs VPN
4. Configuration du serveur OpenVPN
5. Règles de pare-feu pour le VPN
6. Paramètres NAT
7. Exportation de la configuration client
8. Connexion depuis différents OS
9. Tests de sécurité et de routage

---

## 1. Installation et activation du plugin OpenVPN
- Connectez-vous à l'interface web OPNsense.
- Allez dans **Système > Firmware > Plugins**.
- Recherchez et installez le plugin `os-openvpn` si ce n'est pas déjà fait.

## 2. Génération de l'autorité de certification (CA) et des certificats
- Rendez-vous dans **Système > Trust > Authorities**.
- Cliquez sur **Ajouter** pour créer une nouvelle CA.
- Remplissez les champs (nom, durée, etc.) puis validez.
- Allez dans **Système > Trust > Certificates** pour générer un certificat serveur (type : serveur) et un certificat client (type : utilisateur).

## 3. Création des utilisateurs VPN
- Allez dans **Système > Accès > Utilisateurs**.
- Créez un utilisateur pour chaque personne devant accéder au VPN.
- Associez à chaque utilisateur un certificat client généré précédemment.

## 4. Configuration du serveur OpenVPN
- Allez dans **VPN > OpenVPN > Serveurs**.
- Cliquez sur **Ajouter**.
- Sélectionnez la CA et le certificat serveur créés.
- Définissez le port (par défaut 1194 UDP), le réseau VPN (ex : 10.8.0.0/24), le chiffrement (AES-256), etc.
- Activez l'option "Tunnel réseau IPv4".
- Enregistrez et démarrez le serveur.

## 5. Règles de pare-feu pour le VPN
- Allez dans **Pare-feu > Règles > OpenVPN**.
- Ajoutez une règle pour autoriser le trafic entrant/sortant selon vos besoins (ex : tout autoriser pour tester, puis restreindre).

## 6. Paramètres NAT
- Allez dans **Pare-feu > NAT > Outbound**.
- Passez en mode manuel si besoin.
- Ajoutez une règle NAT pour permettre aux clients VPN d'accéder à Internet via l'IP WAN d'OPNsense.

## 7. Exportation de la configuration client
- Installez le plugin `os-openvpn-client-export` si besoin.
- Allez dans **VPN > OpenVPN > Client Export**.
- Sélectionnez l'utilisateur et exportez le fichier de configuration (.ovpn) ou l'installeur adapté.

## 8. Connexion depuis différents OS
- **Windows/macOS** : Téléchargez [OpenVPN Connect](https://openvpn.net/client-connect-vpn-for-windows/) et importez le fichier .ovpn.
- **Linux** : Utilisez `openvpn --config fichier.ovpn`.
- **Android/iOS** : Installez l'application OpenVPN officielle et importez le fichier.

## 9. Tests de sécurité et de routage
- Connectez-vous au VPN et vérifiez l'accès aux ressources internes.
- Testez votre IP publique (https://ipleak.net) pour vérifier l'absence de fuite DNS/IP.
- Contrôlez le routage avec `traceroute` ou `tracert`.

---

**Conseil :** Désactivez l'accès administrateur à l'interface OPNsense depuis le VPN pour plus de sécurité.

---

*Ce guide est inspiré de la vidéo : https://www.youtube.com/watch?v=Wiy7lbaQmrw*