# Configuration de WireGuard sur OPNsense

Procédure détaillée basée sur le tutoriel vidéo d'Aminos Ninatos.

## WireGuard : VPN moderne, rapide et léger

---

## Étape 1 : Configuration de l'Instance WireGuard
1. Connectez-vous à l'interface OPNsense.
2. Menu : **VPN > WireGuard > Instances**.
3. Cliquez sur "+" pour ajouter une instance.
   - **Nom** : (ex : WireguardHome)
   - **Clés** : Cliquez sur l'engrenage pour générer les clés.
   - **Port d'écoute** : 51821 (par défaut ou autre)
   - **Adresse du tunnel** : ex : 172.17.1.0/24 (différent de votre LAN)
4. Cliquez sur **Save**.

---

## Étape 2 : Création des Clients (Peers)
1. Onglet **Peer generator**.
2. Sélectionnez l'instance créée.
3. **Endpoint** : IP publique ou nom DDNS + port (ex : mon-domaine.com:51821)
4. **Nom** : (ex : WireguardUser)
5. **Keep-alive** : 25 secondes
6. **Serveur DNS** : ex : 8.8.8.8
7. Récupérez la configuration générée (texte + QR Code) pour l'importer dans l'appli WireGuard du client.
8. Cochez **Enable WireGuard** et cliquez sur **Apply**.

---

## Étape 3 : Assignation de l'Interface
1. Menu : **Interfaces > Assignments**
2. Dans "Assign a new interface", choisissez l'interface WireGuard (wg0)
3. Cliquez sur **Add**
4. Cliquez sur la nouvelle interface (ex : OPTx)
5. Cochez **Enable Interface** et donnez-lui un nom (ex : WAN_WG)
6. **Save** puis **Apply changes**

---

## Étape 4 : Création des Règles de Pare-feu
### A. Autoriser le trafic entrant sur le port WireGuard (WAN)
- Menu : **Firewall > Rules > WAN**
- Ajoutez une règle :
  - **Action** : Pass
  - **Protocol** : UDP
  - **Destination** : WAN address
  - **Port** : 51821
- Enregistrez et appliquez

### B. Autoriser le trafic du VPN vers le LAN/Internet
- Menu : **Firewall > Rules > [Votre_Interface_WireGuard]**
- Ajoutez une règle :
  - **Action** : Pass
  - **Protocol** : Any
  - **Source** : [Votre_Interface_WireGuard] net
- Enregistrez et appliquez

---

## Étape 5 : Règle de Normalisation (MSS)
1. Menu : **Firewall > Settings > Normalization**
2. Cliquez sur "+" pour ajouter une règle
3. **Interface** : WireGuard (Group)
4. **Max MSS** : 1360
5. Enregistrez et appliquez

---

## Vérification
- Menu : **VPN > WireGuard > Status**
- Le client connecté apparaît avec une icône verte.

---

**Source** :
Tutoriel vidéo : How To Set Up WireGuard for OPNsense Firewall par Aminos Ninatos (YouTube)
