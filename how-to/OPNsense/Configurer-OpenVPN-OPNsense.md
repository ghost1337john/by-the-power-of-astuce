# Configuration d'OpenVPN sur OPNsense (Méthode Instances)

Procédure détaillée basée sur le tutoriel vidéo d'Aminos Ninatos.

---

## Étape 1 : Création de l'Autorité de Certification (CA)
1. Menu : **System > Trust > Authorities**
2. Cliquez sur "+"
   - **Description** : OpenVPN_CA
   - **Method** : Create an internal Certificate Authority
   - **Key length** : 4096 bits
   - **Digest Algorithm** : SHA512
   - **Common Name** : OpenVPN_CA
   - Remplissez les infos géographiques
3. Cliquez sur **Save**

---

## Étape 2 : Génération du Certificat Serveur
1. Menu : **System > Trust > Certificates**
2. Cliquez sur "+"
   - **Description** : OpenVPN_Server_Cert
   - **Type** : Server Certificate
   - **Issuer** : OpenVPN_CA
   - **Key length** : 4096 bits
   - **Digest Algorithm** : SHA512
3. Cliquez sur **Save**

---

## Étape 3 : Création de l'Utilisateur et de son Certificat
1. Menu : **System > Access > Users**
2. Cliquez sur "+" pour ajouter un utilisateur
   - Remplissez nom d'utilisateur et mot de passe
   - (Optionnel) Ajoutez au groupe admins
3. Une fois créé, éditez l'utilisateur
   - Section **User Certificates** : cliquez sur "+"
   - **Method** : Create an internal certificate
   - **Type** : Client Certificate
   - **Issuer** : OpenVPN_CA
4. Cliquez sur **Save**

---

## Étape 4 : Configuration de l'Instance OpenVPN (Serveur)
1. Menu : **VPN > OpenVPN > Instances**
2. Onglet **Static Keys** : générez une nouvelle clé
3. Onglet **Instances** : cliquez sur "+"
   - **Description** : OpenVPN_Server
   - **Protocol** : UDP
   - **Port** : 1194
   - **Server (IPv4)** : ex : 172.16.1.0/24
   - **Certificate** : OpenVPN_Server_Cert
   - **TLS Static Key** : clé générée précédemment
   - **Authentication** : Local Database
   - **Routing / Local Network** : ex : 192.168.1.0/24
   - **Push Options** : cochez "Redirect Gateway"
4. **Save** puis **Apply**

---

## Étape 5 : Assignation de l'Interface
1. Menu : **Interfaces > Assignments**
2. Ajoutez l'interface OpenVPN (ex : ovpns1)
3. Cliquez sur l'interface créée
   - Cochez **Enable Interface**
   - Nommez-la VPN_Server
4. **Save** puis **Apply changes**

---

## Étape 6 : Règles de Pare-feu
### A. Autoriser le port OpenVPN sur le WAN
- Menu : **Firewall > Rules > WAN**
- Ajoutez une règle :
  - **Action** : Pass
  - **Protocol** : UDP
  - **Destination Port** : 1194

### B. Autoriser le trafic à l'intérieur du tunnel
- Menu : **Firewall > Rules > [Votre_Interface_OpenVPN]**
- Ajoutez une règle :
  - **Action** : Pass
  - **Protocol** : Any
  - **Source** : [Votre_Interface_OpenVPN] net

---

## Étape 7 : Exportation de la Configuration Client
1. Menu : **VPN > OpenVPN > Client Export**
2. Sélectionnez votre serveur
3. **Hostname** : IP publique ou nom DDNS
4. Dans la liste des utilisateurs, cliquez sur l'icône de téléchargement à côté de l'utilisateur
5. Importez le fichier .ovpn dans votre client OpenVPN (Windows, Mac, Android, iOS)

---

**Source** :
Tutoriel vidéo : Setup A Secure Remote Access VPN On OPNsense With OpenVPN par Aminos Ninatos (YouTube)
