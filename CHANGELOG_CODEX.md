# Journal des Modifications — Azot Browser (`CHANGELOG_CODEX.md`)

> **Instruction pour Codex CLI** : Ce fichier sert de mémoire persistante entre les sessions. À chaque tâche accomplie, ajoute une nouvelle entrée en haut de la liste chronologique avec la date, les fichiers impactés, ce qui a été réalisé et ce qu'il reste à faire.

---

## [v1.0.0-beta] — Dépôt GitHub nettoyé
- **Structure** : création d’un dépôt de publication autonome, sans `node_modules`, builds générés, exécutable Electron local ni fichiers de prompt internes.
- **Contenu conservé** : code source, ressources d’icônes et de logo, scripts, workflow de release, documentation de contribution, README, licence et spécifications produit utiles.
- **Prochaine étape** : exécuter `git remote add origin <url>` puis pousser la branche principale; le premier tag `v*` déclenchera le workflow de release.

## [v1.0.0-beta] — Préparation GitHub & Installeurs
- **Fichiers créés/modifiés** : `package.json`, `.gitignore`, `build/icon.png`, `build/icon.ico`, `build/icon.icns`, `scripts/generate-icons.ps1`, `.github/workflows/release.yml`, `README.md`, `CONTRIBUTING.md`, `LICENSE`, `CHANGELOG_CODEX.md`.
- **Electron Builder** : manifeste de publication ajouté (`com.azot.browser`, produit Azot, sortie `release/`, ASAR, logo embarqué dans l’application et ressources supplémentaires). Cibles configurées : NSIS installable avec choix de dossier et raccourcis + portable sous Windows, DMG/ZIP sur macOS, AppImage/DEB sous Linux.
- **Ressources** : `build/icon.png` 512 px, `icon.ico` et `icon.icns` ont été générés depuis `azot logo.png` via le script reproductible `npm run icons` (Windows). Le logo original reste inclus dans l’ASAR et également copié vers les ressources de l’application.
- **Dépôt public** : ajout de la licence MIT 2026, d’un `.gitignore` de distribution, d’un guide de contribution et d’un README de release. Le workflow GitHub Actions construit et publie automatiquement les artefacts des trois plateformes lorsqu’un tag `v*` est poussé.
- **Validation** : génération locale des trois icônes réussie et configuration JSON validée par npm. `npm run pack` a été lancé mais ne peut pas s’exécuter dans cet environnement : `electron-builder` n’a pas pu être téléchargé car le registre npm est inaccessible ici. Le workflow GitHub exécutera `npm install` sur les runners connectés avant de compiler.
- **Prochaines étapes recommandées** : relancer `npm install` avec accès au registre, committer le lockfile mis à jour puis exécuter `npm run pack` avant de pousser le premier tag `v1.0.0-beta.1`; ajouter les secrets de signature/notarisation macOS et Windows avant une distribution grand public.

## [2026-11-19 — Europe/Paris] — Finition cinétique : reload, identité et matière atomique
- **Fichiers modifiés/créés** : `src/main/index.js`, `src/renderer/index.html`, `src/renderer/polish.css`, `src/renderer/polish.js`, `CHANGELOG_CODEX.md`.
- **Rechargement** : icône SVG remplacée à l’initialisation par une flèche circulaire équilibrée (`24 × 24`, `18 px`, trait `1.8`, coins et terminaisons arrondis). Sa rotation joue au clic et tourne continûment pendant un chargement, sans modifier le zoom existant au survol.
- **Nouvel Onglet** : logo original porté à `96 × 96 px`, auréolé subtilement, avec rotation lente continue sur 25 secondes et accentuation au survol.
- **Scène atomique** : ajout d’un Canvas 2D sans dépendance affichant des atomes anthracite/argent en profondeur (tailles, gradients métalliques et flou de distance). La boucle `requestAnimationFrame` applique une parallaxe et une force ressort amortie autour du curseur; le canvas est non capturant et demeure derrière le contenu.
- **Prochaines étapes recommandées** : vérifier visuellement les contrastes de la scène sur un écran OLED et réduire le nombre d’atomes sur les appareils très basse consommation si nécessaire.

## [2026-11-19  — Europe/Paris] — Passe de finition : identité, navigation et panneaux fondamentaux
- **Fichiers modifiés** : `src/main/index.js`, `src/preload/index.js`, `src/renderer/index.html`, `src/renderer/renderer.js`, `src/renderer/style.css`, `CHANGELOG_CODEX.md`.
- **Logo officiel** : intégration stricte du fichier original `azot logo.png` (son espace est encodé dans l’URL) dans la sidebar, en `24 × 24 px` avec `object-fit: contain`. La page Nouvel Onglet l’embarque depuis le même fichier en data URI, en `60 × 60 px`, avec respiration et halo discrets ; aucun monogramme de remplacement ne subsiste.
- **Chrome raffiné** : remplacement des commandes principales par des SVG cohérents (18 px, traits 1,75), cibles de 32 px, tooltips rapides, transitions ressort `180ms cubic-bezier(.22,1,.36,1)`, état actif à `0.94` et survol à `1.16`. Les sections de sidebar, badges de raccourcis, favicon et fermeture d’onglets ont été réalignés.
- **Historique** : persistance JSON dans `userData`, recherche instantanée, groupes Aujourd’hui / Hier / Plus ancien, ouverture en onglet, suppression unitaire et purge complète. Le `WebContentsView` actif est masqué pendant l’affichage du panneau. Raccourci `Ctrl/Cmd + H` et commande de palette pris en charge.
- **Paramètres** : choix DuckDuckGo, Google, Brave Search, Startpage ou URL personnalisée avec `%s`; démarrage Nouvel onglet/restauration de session; raccourcis NTP; Shield, Guard, cookies tiers, purge des données, accès Theme Studio et sidebar épinglée/escamotable. Les réglages sont persistés et utilisés par le processus principal.
- **Extensions** : sélecteur natif limité à un dossier, validation de `manifest.json`, chargement Electron, activation/désactivation persistante, métadonnées, suppression et raccourci `Ctrl/Cmd + Shift + E`.
- **Validation** : `node --check` réussi pour `src/main/index.js`, `src/preload/index.js` et `src/renderer/renderer.js`.
- **Prochaines étapes recommandées** : réaliser une validation manuelle Electron des extensions MV3 et de la restauration de session sur Windows/macOS/Linux; ajouter des tests d’intégration IPC automatisés.

## [2026-11-19] — Correctifs d’interaction et thème Azot Noir
- **Fichiers modifiés** : `src/main/index.js`, `src/preload/index.js`, `src/renderer/index.html`, `src/renderer/style.css`, `src/renderer/renderer.js`, `CHANGELOG_CODEX.md`.
- **Correction critique** : ajout d’une passerelle d’overlay qui masque la `WebContentsView` active pendant les palettes et panneaux, garantissant focus, saisie et clics dans les interfaces HTML.
- **Navigation** : palette focalisée immédiatement, champ de recherche réellement éditable et autofocus sur la nouvelle page, avec navigation/recherche à Entrée.
- **Direction artistique** : nouveau preset par défaut *Azot Noir* (carbone monochrome, accent blanc/argent, blur 28px) et preset OLED disponible.
- **Finitions** : monogramme typographique temporaire Azot (aucun fichier image de logo détecté dans le dépôt), badges de raccourcis alignés, fermeture d’onglet au survol et progression de chargement blanche de 2px.
- **Prochaines étapes recommandées** : ajouter le fichier logo définitif au dépôt afin de remplacer le monogramme temporaire, et persister le thème actif entre les sessions côté processus principal.

## [2026-11-19] — Refonte Sidebar verticale Azot
- **Fichiers modifiés** : `src/main/index.js`, `src/preload/index.js`, `src/renderer/index.html`, `src/renderer/style.css`, `src/renderer/renderer.js`, `docs/CAHIER_DES_CHARGES.md`, `CHANGELOG_CODEX.md`.
- **UI/UX** : remplacement total des barres horizontales par une sidebar gauche minimaliste, déployée (240px) ou compacte (56px), avec déclencheur d’omnibox sous forme de palette centrale vitrée.
- **Mouvement** : transitions `280ms cubic-bezier(0.22, 1, 0.36, 1)`, déploiement au survol, pilule active glissante, animations d’insertion/fermeture des onglets et panneaux verre fumé.
- **Rendu natif** : `WebContentsView` repositionnée sur toute la hauteur, dans un cadre de 8px, et redimensionnée par IPC à chaque état de la sidebar.
- **Nouvel onglet** : fond organique profond, grain léger, identité Azot et grille de raccourcis sans chrome parasite.
- **Validation** : contrôles syntaxiques Node réussis pour les processus principal, preload et renderer ; lancement Electron sans erreur de démarrage.
- **Prochaines étapes recommandées** : ajouter la persistance du choix épinglé/compact et propager les couleurs de thème vers les onglets New Tab déjà ouverts.

## [2026-11-19] — Première version fonctionnelle d’Azot
- **Correctif dépendance** : version inexistante `@ghostery/adblocker-electron@^1.36.0` remplacée par `^2.20.3`, version actuellement publiée du paquet Ghostery.
- **Correctif lancement Windows** : scripts npm rendus explicites (`node node_modules/electron/cli.js`) afin d’éviter qu’un éventuel `electron.exe` présent à la racine du projet ne masque le lanceur Electron installé.
- **Fichiers modifiés/créés** : `src/main/index.js`, `src/preload/index.js`, `src/renderer/index.html`, `src/renderer/style.css`, `src/renderer/renderer.js`, `CHANGELOG_CODEX.md`.
- **Cœur Electron** : fenêtre frameless/transparente, chrome sécurisé (`contextIsolation`, sandbox, absence de Node dans les renderers) et rendu web par `WebContentsView`. Les onglets supportent création, fermeture, sélection, déplacement par glisser-déposer, duplication, restauration et navigation (retour, suivant, rechargement, omnibox DuckDuckGo/URL).
- **Interface** : UI verre dépoli à variables CSS, contrôles de fenêtre, transitions GPU des onglets, raccourcis principaux, compteur Azot Shield, Theme Studio et gestionnaire d’extensions.
- **Personnalisation** : quatre thèmes inclus (Obsidian, Frost, Midnight, Pure Glass), réglages en direct, sauvegarde locale, import et export JSON.
- **Protection** : filtre local de requêtes publicitaires/trackers avec tentative d’activation Ghostery, liste/heuristiques Azot Guard et page d’avertissement, liste blanche par site persistante préparée dans le stockage local.
- **Extensions** : chargement de dossiers Chromium décompressés, activation/désactivation et persistance de leur état.
- **Validation** : vérification syntaxique Node réussie pour les trois scripts JavaScript. L’installation des dépendances n’a pas pu être exécutée dans cet environnement isolé (le binaire Electron n’est donc pas présent localement) ; elle reste disponible via `npm install` sur une machine ayant accès au registre npm.
- **Prochaines étapes recommandées** : ajouter une interface explicite de liste blanche par domaine et une source signée pour actualiser les listes de menaces; couvrir les flux Electron avec tests manuels et tests d’intégration sur chaque OS cible.

## [Initialisation] — Setup de l'environnement Azot
- **Statut** : Environnement prêt pour le développement.
- **Structure créée** :
  - `AGENTS.md` : Règles d'architecture, de design UI transparent/minimaliste et d'obligation de mise à jour de ce journal.
  - `docs/CAHIER_DES_CHARGES.md` : Spécifications fonctionnelles et techniques complètes du navigateur Azot.
  - `PROMPT_CODEX.md` : Prompt prêt à l'emploi pour lancer le développement avec Codex CLI.
  - `package.json` & squelette `src/` : Base technique Electron moderne (`WebContentsView`, TypeScript/JS).
- **Prochaines étapes pour Codex** :
  1. Implémenter le processus principal (`src/main/main.ts` ou `.js`) avec fenêtre transparente/frameless et gestion multi-onglets via `WebContentsView`.
  2. Construire l'interface verre dépoli (`src/renderer/`) avec animations fluides des onglets.
  3. Intégrer le studio de thèmes personnalisables avec sauvegarde JSON.
  4. Intégrer le bloqueur de publicités, le détecteur de sites malveillants et le chargeur d'extensions.
