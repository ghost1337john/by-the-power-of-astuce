#!/bin/bash

################################################################################
# Script d'automatisation : Activation du Terminal Série sur Proxmox/Debian
# 
# Utilisation:
#   sudo ./enable-serial-terminal.sh
#
# Ce script automatise la configuration du terminal série sur une VM Debian
# pour permettre l'accès via 'qm terminal' depuis l'hôte Proxmox
#
# Prérequis:
#   - Exécution avec privilèges sudo
#   - Debian basée (avec systemd ou upstart)
#   - Port série déjà configuré sur l'hôte Proxmox (qm set <idVM> -serial0 socket)
#
################################################################################

set -e  # Arrête le script en cas d'erreur

# Couleurs pour l'output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fonction pour afficher les messages
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

################################################################################
# VÉRIFICATIONS PRÉALABLES
################################################################################

log_info "Vérification des prérequis..."

# Vérifier que le script s'exécute en tant que root
if [[ $EUID -ne 0 ]]; then
   log_error "Ce script doit être exécuté avec sudo"
   exit 1
fi

# Vérifier que le système est Debian
if ! command -v update-grub &> /dev/null; then
    log_warn "Ce script est optimisé pour Debian. Certaines commandes peuvent ne pas fonctionner."
fi

log_success "Prérequis satisfaits"

################################################################################
# ÉTAPE 1 : Vérifier et configurer getty sur le port série
################################################################################

log_info "Configuration du service getty sur ttyS0..."

if [[ -f /etc/init/ttyS0.conf ]]; then
    log_warn "Le fichier /etc/init/ttyS0.conf existe déjà. Sauvegarde en cours..."
    cp /etc/init/ttyS0.conf /etc/init/ttyS0.conf.backup.$(date +%s)
fi

cat > /etc/init/ttyS0.conf <<'EOF'
# ttyS0 - getty
#
# This service maintains a getty on ttyS0 from the point the system is
# started until it is shut down again.

start on stopped rc RUNLEVEL=[12345]
stop on runlevel [!12345]

respawn
exec /sbin/getty -L 115200 ttyS0 vt102
EOF

log_success "Fichier /etc/init/ttyS0.conf créé"

# Démarrer le service getty si le système utilise upstart
if command -v start &> /dev/null; then
    log_info "Démarrage du service ttyS0..."
    start ttyS0 || log_warn "Impossible de démarrer ttyS0 (système peut utiliser systemd)"
else
    log_warn "Upstart n'est pas disponible. Service getty peut nécessiter une configuration manuelle."
fi

################################################################################
# ÉTAPE 2 : Vérifier la présence du port série
################################################################################

log_info "Vérification du port série..."

if dmesg | grep -q "ttyS"; then
    log_success "Port série détecté :"
    dmesg | grep ttyS | tail -1
else
    log_warn "Port série non détecté. Il sera peut-être visible après redémarrage."
fi

################################################################################
# ÉTAPE 3 : Configurer GRUB pour les messages de démarrage
################################################################################

log_info "Configuration de GRUB..."

# Sauvegarder le fichier original
if [[ -f /etc/default/grub ]]; then
    cp /etc/default/grub /etc/default/grub.backup.$(date +%s)
    log_info "Sauvegarde de /etc/default/grub effectuée"
fi

# Modifier GRUB_CMDLINE_LINUX si elle existe, sinon la créer
if grep -q "^GRUB_CMDLINE_LINUX=" /etc/default/grub; then
    # Retirer les anciens paramètres console s'ils existent
    sed -i '/^GRUB_CMDLINE_LINUX=/s/ console=[^ ]* / /g' /etc/default/grub
    sed -i '/^GRUB_CMDLINE_LINUX=/s/"$//' /etc/default/grub
    
    # Ajouter les nouveaux paramètres si pas déjà présents
    if ! grep -q "console=ttyS0" /etc/default/grub; then
        sed -i 's/^GRUB_CMDLINE_LINUX="\(.*\)"$/GRUB_CMDLINE_LINUX="\1 console=tty0 console=ttyS0,115200"/' /etc/default/grub
    fi
else
    # Si la variable n'existe pas, la créer
    echo 'GRUB_CMDLINE_LINUX="quiet console=tty0 console=ttyS0,115200"' >> /etc/default/grub
fi

log_success "GRUB configuré"

# Mettre à jour GRUB
log_info "Mise à jour de GRUB..."
update-grub
log_success "GRUB mis à jour"

################################################################################
# ÉTAPE 4 : Résumé et prochaines étapes
################################################################################

cat <<EOF

${GREEN}=== CONFIGURATION COMPLÉTÉE ===${NC}

${BLUE}Configuration effectuée:${NC}
  ✓ Service getty configuré sur ttyS0
  ✓ GRUB configuré pour les messages de démarrage sur la console série
  ✓ Fichiers de sauvegarde créés avec les anciens fichiers

${YELLOW}PROCHAINES ÉTAPES:${NC}
  1. Redémarrez la VM :
     ${BLUE}sudo reboot${NC}

  2. Depuis l'hôte Proxmox, connectez-vous à la VM :
     ${BLUE}qm terminal <idVM>${NC}

  3. Pour quitter le terminal série, appuyez sur Ctrl-O (pas Ctrl-C)

${YELLOW}NOTES:${NC}
  - Assurez-vous que le port série est activé sur l'hôte Proxmox :
    ${BLUE}qm set <idVM> -serial0 socket${NC}
  
  - En cas de problème, les fichiers de sauvegarde sont disponibles:
    - /etc/init/ttyS0.conf.backup.*
    - /etc/default/grub.backup.*

${YELLOW}DÉPANNAGE:${NC}
  - Vérifier la configuration serie: ${BLUE}qm monitor <idVM>${NC}
                                      puis : ${BLUE}info chardev${NC}
  - Vérifier les messages: ${BLUE}dmesg | grep ttyS${NC}

EOF

log_success "Script terminé avec succès!"
