# Changelog

Tous les changements notables de ce projet sont documentés dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et ce projet adhère à [Semantic Versioning](https://semver.org/lang/fr/).

---

## [Unreleased]

### Added
- (À venir)

### Changed
- (À venir)

### Fixed
- (À venir)

### Deprecated
- (À venir)

### Removed
- (À venir)

### Security
- (À venir)

---

## [1.0.0] - 2026-03-27

### Added

#### Documentation
- **how-to/Proxmox/Activer-Terminal-Serie.md** - Documentation complète et structurée
  - Procédure étape par étape pour activer le terminal série
  - Configuration Proxmox (hôte) et Debian (VM)
  - Configuration GRUB pour messages de démarrage
  - Section dépannage détaillée
  - Liens vers sources officielles

#### Scripts d'Automatisation
- **scripts/Proxmox/proxmox-configure-serial.sh** - Configuration côté Proxmox
  - Configure 1 ou N VMs automatiquement
  - Vérification des prérequis
  - Création de sauvegardes automatiques (.backup.*timestamp)
  - Affiche résumé et instructions
  - Usage: `sudo ./proxmox-configure-serial.sh <idVM1> [<idVM2> ...]`

- **scripts/Proxmox/enable-serial-terminal.sh** - Configuration côté Debian
  - Configuration getty sur ttyS0
  - Mise à jour GRUB
  - Validation du port série
  - Sauvegardes automatiques
  - Usage: `sudo ./enable-serial-terminal.sh`

#### Guides et README
- **scripts/Proxmox/README.md** - Guide d'utilisation complet
  - Démarrage rapide (3 étapes)
  - Description détaillée des scripts
  - Prérequis et dépannage
  - Structure du dossier Proxmox
  - **Nouvellement ajouté:** Section sécurité avec:
    - Tableau comparatif SSH vs Terminal Série
    - Clarification des cas d'usage
    - Recommandations de sécurité
    - Bonnes pratiques Proxmox (fail2ban, clés publiques)

### Features

#### Terminal Série
- ✅ Activation via socket Unix
- ✅ Copier/coller depuis d'autres terminaux
- ✅ Accès en cas de perte connectivité réseau
- ✅ Débogage du noyau et messages de panique
- ✅ Correction des problèmes de clavier/layout

#### Automatisation
- ✅ Scripts Bash pour Debian/Linux
- ✅ Configuration automatisée Proxmox + VM
- ✅ Gestion des sauvegardes
- ✅ Validation et vérification des étapes

### Security

#### Clarifications de Sécurité
- Terminal Série n'est **PAS un remplacement de SSH**
- Communication locale (pas d'exposition réseau)
- Pas de chiffrement (socket Unix locale)
- Nécessite accès root à Proxmox
- D'où l'importance de sécuriser l'hôte:
  - SSH avec clés publiques (jamais de password)
  - fail2ban pour prévenir brute-force
  - Terminal Série comme backup d'urgence uniquement

#### Recommandations
- ✅ Utiliser SSH en production (avec authentification++)
- ✅ Terminal Série comme secours d'urgence
- ✅ Monitorer les accès Proxmox
- ⚠️ Ne pas exposer SSH au public sans MFA

---

## Prochaines étapes potentielles

- [ ] Support pour CentOS/RHEL (modification GRUB)
- [ ] Support pour Ubuntu 20.04+ (systemd)
- [ ] Script de validation complète (pré-check)
- [ ] Documentation en d'autres langues
- [ ] Tests d'intégration automatisés
- [ ] Support Proxmox VE 8.x
- [ ] Metrics/monitoring du terminal série

---

## Conventions de commit

Ce projet utilise [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` Nouvelle fonctionnalité
- `fix:` Correction de bug
- `docs:` Changement ou ajout de documentation
- `style:` Formatage, sans impact fonctionnel
- `refactor:` Refonte de code existant
- `perf:` Amélioration de performance
- `test:` Ajout ou modification de tests
- `chore:` Changements d'infrastructure/dépendances

---

## Contribution

Pour contribuer:
1. Fork le projet
2. Créer une branche feature (`git checkout -b feature/AmazingFeature`)
3. Commit avec [Conventional Commits](https://www.conventionalcommits.org/)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

**Style de code:**
- Scripts Bash: shellcheck compatible
- Documentation: Markdown avec KaTeX pour les équations
- Nommage: kebab-case pour fichiers, snake_case pour variables Bash

---

## Ressources

- [Proxmox Serial Terminal - Wiki Officiel](https://pve.proxmox.com/wiki/Serial_Terminal)
- [Serial Console - 0pointer Blog](http://0pointer.de/blog/projects/serial-console.html)
- [Debian Serial Console](https://wiki.debian.org/SerialConsoleHowto)
- [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/)
- [Semantic Versioning](https://semver.org/lang/fr/)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

**Maintenance:** [Ghost John](https://github.com/ghost1337john)  
**Dernière mise à jour:** 2026-03-27
