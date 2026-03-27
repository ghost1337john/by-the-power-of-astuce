# Ajouter un sous-module Git privé à un projet

> **Résumé :** Comment intégrer un dossier privé dans un projet public grâce aux sous-modules Git.

---

## 1️⃣ Créer le dépôt privé

- Sur GitHub, crée un nouveau dépôt privé (ex : `secrets-repo`).

---

## 2️⃣ Ajouter le sous-module dans le projet principal

Dans le dossier de ton projet principal :

```bash
git submodule add git@github.com:tonuser/secrets-repo.git mon-dossier-prive
git submodule update --init --recursive
git commit -am "feat: ajout du sous-module privé"
git push
```
- `mon-dossier-prive` = nom du dossier où sera monté le sous-module
- Utilise l’URL SSH ou HTTPS selon ta configuration

---

## 3️⃣ Cloner le projet avec le sous-module

```bash
git clone --recurse-submodules git@github.com:tonuser/projet-public.git
```
- L’utilisateur doit avoir accès au dépôt privé (clé SSH ou token).

---

## 4️⃣ Mettre à jour le sous-module

```bash
git submodule update --remote mon-dossier-prive
```

---

## ⚠️ Points importants

- Les utilisateurs sans accès au repo privé ne verront pas le contenu du sous-module.
- Le sous-module n’est pas versionné dans le repo principal, seul le pointeur l’est.
- Pour supprimer le sous-module :
  - `git submodule deinit mon-dossier-prive`
  - Supprimer le dossier et la ligne correspondante dans `.gitmodules`

---

## 📚 Sources
- https://git-scm.com/book/fr/v2/Utilitaires-Git-Sous-modules
- https://docs.github.com/fr/get-started/working-with-submodules
- [Tuto adapté et enrichi par ghost1337john]
