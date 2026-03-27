#!/bin/bash

################################################################################
# Script Proxmox : Configuration du port série pour une ou plusieurs VMs
#
# Utilisation:
#   ./proxmox-configure-serial.sh <idVM1> [<idVM2> <idVM3> ...]
#   ou pour une seule VM :
#   ./proxmox-configure-serial.sh 101
#
# Ce script configure le port série sur l'hôte Proxmox pour permettre
# l'accès aux VMs via 'qm terminal' et 'qm monitor'.
#
# Prérequis:
#   - Exécution sur l'hôte Proxmox avec privilèges root
#   - Les VMs doivent être arrêtées ou à l'état donné
#
################################################################################

set -e

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

################################################################################
# VÉRIFICATION DES PARAMÈTRES
################################################################################

if [[ $# -eq 0 ]]; then
    log_error "Aucune VM spécifiée"
    echo "Utilisation: $0 <idVM1> [<idVM2> ...]"
    echo "Exemple: $0 101 102 103"
    exit 1
fi

# Vérifier les droits root
if [[ $EUID -ne 0 ]]; then
    log_error "Ce script doit être exécuté avec les droits root"
    exit 1
fi

################################################################################
# CONFIGURATION DES VMs
################################################################################

log_info "Configuration du port série sur Proxmox"
echo ""

for VM_ID in "$@"; do
    log_info "Traitement de la VM $VM_ID..."
    
    # Vérifier si la VM existe
    if ! qm list | grep -q "^ *$VM_ID "; then
        log_error "VM $VM_ID non trouvée!"
        continue
    fi
    
    # Vérifier l'état de la VM
    VM_STATUS=$(qm status "$VM_ID" | awk '{print $NF}')
    
    if [[ "$VM_STATUS" == "running" ]]; then
        log_warn "VM $VM_ID est en cours d'exécution. Idéalement, elle devrait être arrêtée."
        read -p "Continuer quand même ? (o/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[OoYy]$ ]]; then
            log_warn "Passage de la VM $VM_ID..."
            continue
        fi
    fi
    
    # Obtenir le chemin du fichier de configuration
    VM_CONFIG="/etc/pve/qemu-server/${VM_ID}.conf"
    
    if [[ ! -f "$VM_CONFIG" ]]; then
        log_error "Fichier de configuration non trouvé: $VM_CONFIG"
        continue
    fi
    
    # Sauvegarder la configuration
    cp "$VM_CONFIG" "${VM_CONFIG}.backup.$(date +%s)"
    log_info "Sauvegarde créée: ${VM_CONFIG}.backup.*"
    
    # Vérifier si serial0 est déjà configuré
    if grep -q "^serial0:" "$VM_CONFIG"; then
        log_warn "serial0 est déjà configuré dans la VM $VM_ID"
        CURRENT_SERIAL=$(grep "^serial0:" "$VM_CONFIG")
        echo "  Valeur actuelle: $CURRENT_SERIAL"
        
        read -p "Remplacer par 'socket' ? (o/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[OoYy]$ ]]; then
            sed -i '/^serial0:/d' "$VM_CONFIG"
            log_info "Ancienne configuration supprimée"
        else
            log_warn "Configuration non modifiée pour VM $VM_ID"
            continue
        fi
    fi
    
    # Ajouter serial0: socket
    echo "serial0: socket" >> "$VM_CONFIG"
    log_success "Port série configuré pour la VM $VM_ID"
    
    # Utiliser aussi 'qm set' pour s'assurer que c'est appliqué
    log_info "Application via qm set..."
    qm set "$VM_ID" -serial0 socket
    log_success "VM $VM_ID configurée avec serial0: socket"
    
    echo ""
done

################################################################################
# RÉSUMÉ ET INSTRUCTIONS
################################################################################

cat <<EOF

${GREEN}=== CONFIGURATION PROXIMOX COMPLÉTÉE ===${NC}

${BLUE}VMs configurées: $*${NC}

${YELLOW}PROCHAINES ÉTAPES:${NC}
  1. Sur chaque VM (Debian):
     - Téléchargez et exécutez le script d'automatisation:
       ${BLUE}enable-serial-terminal.sh${NC}
     - Ou suivez les étapes manuelles dans:
       ${BLUE}Activer-Terminal-Serie.md${NC}

  2. Redémarrez les VMs configurées

  3. Testez la connexion au terminal série:
     ${BLUE}qm terminal <idVM>${NC}

${YELLOW}VÉRIFICATION:${NC}
  Vous pouvez vérifier la configuration avec:
    ${BLUE}qm monitor <idVM>${NC}
    puis : ${BLUE}info chardev${NC}

  Vous devriez voir une ligne comme:
    ${BLUE}serial0: filename=disconnected:unix:/var/run/qemu-server/<idVM>.serial0,server${NC}

${YELLOW}FICHIERS DE SAUVEGARDE:${NC}
  Les fichiers originaux sont sauvegardés avec '.backup.<timestamp>'
  Exemple: /etc/pve/qemu-server/101.conf.backup.1234567890

EOF

log_success "Script Proxmox terminé!"
