
> ⚠️ **Ce dépôt est actuellement en phase de test et de validation.**
> 
> Des modifications, ajouts ou suppressions peuvent survenir à tout moment.
> Je préciserai ici-même quand le dépôt sera considéré comme 100% fonctionnel et stable.

# ⚡ By the Power of Astuce

> *Recueil d'astuces, correctifs et solutions techniques glanés au fil des problèmes rencontrés.*  
> Par le pouvoir de l'astuce des maîtres de l'univers, ce dépôt rassemble mes trouvailles pour comprendre, réparer, contourner et documenter les défis du quotidien numérique.

[![Latest Release](https://img.shields.io/github/v/release/ghost1337john/by-the-power-of-astuce?style=flat-square)](https://github.com/ghost1337john/by-the-power-of-astuce/releases)
[![CHANGELOG](https://img.shields.io/badge/CHANGELOG-1.0.0-blue?style=flat-square)](./CHANGELOG.md)
[![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)](LICENSE)

---

## 🎯 Qu'est-ce que c'est ?

Un dépôt de solutions techniques, d'automatisations et de documentation accumulées au fil des expériences de production. Chaque entrée est :
- ✅ **Testée** — validée en environnement réel
- 📖 **Documentée** — avec procédures étape par étape
- 🔧 **Automatisée** — avec scripts Bash/Python quand applicable
- 🔒 **Sécurisée** — avec bonnes pratiques incluses

---

## 🎬 En vedette

### 🖥️ Terminal Série Proxmox
Configuration complète et automatisée du terminal série sur Proxmox avec VMs Debian.

**Inclut:**
- 📋 Documentation complète: [how-to/Proxmox/Activer-Terminal-Serie.md](./how-to/Proxmox/Activer-Terminal-Serie.md)
- 🔧 Scripts d'automatisation:
  - [`proxmox-configure-serial.sh`](./scripts/Proxmox/proxmox-configure-serial.sh) — Configuration côté hôte
  - [`enable-serial-terminal.sh`](./scripts/Proxmox/enable-serial-terminal.sh) — Configuration côté VM
- 📖 [Guide complet](./scripts/Proxmox/README.md) avec sécurité et dépannage

**Cas d'usage:**
- ✅ Copier/coller facile sans VNC
- ✅ Accès de secours sans réseau
- ✅ Débogage du noyau en cas de panique
- ✅ Résolution de problèmes de clavier

👉 **Démarrer:** [scripts/Proxmox/README.md](./scripts/Proxmox/README.md)

---

## 📂 Structure du dépôt

| Dossier | Description |
|---|---|
| [`tips/`](./tips/) | Petites astuces rapides, raccourcis et bonnes pratiques |
| [`fixes/`](./fixes/) | Correctifs et résolutions de bugs rencontrés |
| [`workarounds/`](./workarounds/) | Contournements de limitations ou de comportements inattendus |
| [`how-to/`](./how-to/) | Mini-guides et procédures pas à pas |
| [`how-to/Proxmox/`](./how-to/Proxmox/) | Documentation Proxmox & virtualisation |
| [`notes/`](./notes/) | Réflexions, rappels et idées en vrac |
| [`scripts/`](./scripts/) | Scripts d'automatisation |
| [`scripts/Proxmox/`](./scripts/Proxmox/) | Scripts Bash pour Proxmox |

---

## 🎯 Philosophie

Ce dépôt est un carnet de bord technique. Chaque fois qu'un problème est résolu, une astuce découverte ou une procédure optimisée, elle est consignée ici pour :

- **Ne plus réinventer la roue** — retrouver rapidement une solution éprouvée
- **Partager le savoir** — rendre ces trouvailles utiles à la communauté
- **Progresser continuement** — relire, améliorer et enrichir les solutions au fil du temps
- **Automatiser** — réduire la charge manuelle avec des scripts robustes

---

## 📋 Comment utiliser ?

### Pour trouver une solution
1. Consulte le [**CHANGELOG.md**](./CHANGELOG.md) pour voir les dernières additions
2. Navigue par catégorie: `how-to/`, `fixes/`, `tips/`, etc.
3. Lis la documentation Markdown ou exécute les scripts

### Pour une solution complète
**Exemple:** Configuration Terminal Série Proxmox
```bash
# 1. Lire la documentation
cat how-to/Proxmox/Activer-Terminal-Serie.md

# 2. Exécuter les scripts
sudo scripts/Proxmox/proxmox-configure-serial.sh 101 102
sudo scripts/Proxmox/enable-serial-terminal.sh
```

### Pour une automatisation rapide
```bash
# Tous les scripts sont dans scripts/
cd scripts/Proxmox/
chmod +x *.sh
sudo ./proxmox-configure-serial.sh <idVM>
```

---

## 📚 Documentation

- **[CHANGELOG.md](./CHANGELOG.md)** — Historique complet des changements
- **[scripts/Proxmox/README.md](./scripts/Proxmox/README.md)** — Guide Terminal Série complet
- **[how-to/Proxmox/](./how-to/Proxmox/)** — Procédures détaillées

---

## 🤝 Contribution

Les contributions sont bienvenues ! Pour contribuer:

1. **Fork** le dépôt
2. **Crée une branche**: `git checkout -b feature/ma-astuce`
3. **Commit** selon [Conventional Commits](https://www.conventionalcommits.org/): `feat:`, `fix:`, `docs:`, etc.
4. **Push** ta branche
5. **Ouvre une Pull Request**

### Conventions
- 📝 Markdown formaté et lisible
- 🔧 Scripts testés et documentés
- 📖 Procédures étape par étape
- 🔒 Considérations de sécurité incluses
- 📊 Badges et emojis pour la clarté

---

## 📊 Stats du dépôt

- **Version:** 1.0.0
- **Dernière mise à jour:** 2026-03-27
- **Mainteneur:** [Ghost John](https://github.com/ghost1337john)
- **Licence:** MIT

---

*Par le pouvoir de l'astuce… j'ai le pouvoir !* ⚔️
