# Cahier des Charges — Navigateur Web **Azot**

## 1. Vision & Positionnement
**Azot** est un navigateur desktop nouvelle génération conçu autour de trois piliers :
- **Minimalisme radical (Zero Bloat)** : Zéro flux d'actualités imposé, zéro intégration crypto/IA intrusive, zéro télémétrie. L'interface s'efface au profit du contenu web.
- **Fluidité & Réactivité extrême** : Transitions matérielles accélérées (GPU), ouverture/fermeture d'onglets avec animations physiques fluides, gestion intelligente de la mémoire (mise en veille des onglets inactifs).
- **Esthétique Moderne, Sobre & Transparente** : Design inspiré du verre dépoli (Glassmorphism subtil), intégration native avec le bureau (vibrancy / mica / acrylic selon l'OS), entièrement personnalisable via un créateur de thèmes intégré.

---

## 2. Stack Technique Recommandée
- **Core Runtime** : Electron (dernière version stable avec support `WebContentsView` et extensions MV3).
- **Frontend UI (Chrome du navigateur)** : HTML5 / CSS3 moderne (CSS Variables, `@starting-style`, Web Animations API) + TypeScript / Vanilla TS ou React léger (sans surcouche lourde).
- **Bloqueur de publicités & trackers** : `@ghostery/adblocker-electron` (basé sur EasyList / EasyPrivacy, filtrage réseau ultra-rapide au niveau `session.webRequest`).
- **Détection de sites malveillants** :
  - Filtrage local instantané via listes de domaines malveillants / phishing (ex: URLhaus / PhishTank / StevenBlack hosts mis en cache localement).
  - Analyse heuristique d'URL (typosquatting, homographes Punycode `xn--`, HTTP non sécurisé sur formulaires sensibles, redirections suspectes).
  - Option d'intégration API Google Safe Browsing / PhishStats avec clé utilisateur optionnelle.
- **Persistance locale** : `electron-store` ou stockage JSON natif sécurisé dans `app.getPath('userData')` (thèmes, favoris, historique minimaliste, configuration extensions).

---

## 3. Spécifications Fonctionnelles

### 3.1. Interface Utilisateur (UI) & Animations
- **Sidebar verticale escamotable** : l’interface primaire est une barre à gauche de 240px, repliable à 56px (survol pour déployer lorsqu’elle n’est pas épinglée). Elle rassemble les contrôles de fenêtre, la navigation, les statuts, les réglages et la liste verticale des onglets. La vue web conserve toute la hauteur de la fenêtre et est encadrée par une marge translucide de 8px.
- **Palette d’adresse** : l’omnibox est un déclencheur compact dans la sidebar et ouvre une palette centrale vitrée (raccourcis `Ctrl/Cmd + L` et `Ctrl/Cmd + T`) pour toute recherche ou navigation.
- **Liste d'onglets fluide** :
  - Animation d'apparition (scale + slide + fade-in fluide à l'ouverture d'un nouvel onglet).
  - Animation de fermeture douce avec remontée physique des onglets suivants.
  - Drag & drop fluide pour réorganiser les onglets.
  - Indicateur audio discret, favicon net, bouton de fermeture apparaissant au survol.
- **Barre d'adresse & Navigation unifiée (Omnibox)** :
  - Boutons minimalistes : Précédent, Suivant, Recharger/Stop.
  - Palette URL / Recherche centrée, épurée, affichant l’URL complète au focus.
  - Badge de sécurité intégré à gauche de l'URL (Bouclier vert/neutre = sûr + nb de pubs bloquées ; Alerte rouge/ambre = site suspect/bloqué).
  - Raccourcis clavier complets (`Ctrl/Cmd + T`, `Ctrl/Cmd + W`, `Ctrl/Cmd + L`, `Ctrl/Cmd + Tab`, `Ctrl/Cmd + Shift + T`, `Ctrl/Cmd + ,`).
- **Page Nouvel Onglet (New Tab)** :
  - Plein écran, organique et sans colonne parasite : lueur radiale pilotée par le thème, grain subtil, typographie Azot espacée, recherche flottante et 4 à 6 raccourcis à élévation douce.

### 3.2. Créateur de Thèmes Personnalisés (Theme Studio)
- Panneau latéral ou modale translucide permettant de personnaliser en temps réel :
  - **Couleur de fond principale & opacité** (ex: `rgba(15, 17, 23, 0.78)`).
  - **Intensité du flou (Glass Blur)** (`0px` à `32px`).
  - **Couleur d'accentuation** (boutons actifs, barre de progression de chargement, focus).
  - **Couleur du texte primaire & secondaire**.
  - **Arrondis des bordures (Border Radius)** (du style angulaire net `4px` au style doux `16px`).
  - **Bordures & Ombres** (opacité des séparateurs).
- **Presets inclus** :
  1. *Azot Obsidian* (Sombre, verre fumé, accent glace `#6EE7B7` ou `#7DD3FC`).
  2. *Azot Frost* (Clair, verre dépoli lumineux, minimaliste).
  3. *Azot Midnight* (OLED noir profond, contraste élevé).
  4. *Azot Pure Transparent* (Transparence maximale).
- **Import / Export** : Exportation et importation de thèmes au format `.azot-theme.json`.

### 3.3. Bloqueur de Publicités & Trackers (Azot Shield)
- Actif par défaut dès le premier lancement.
- Blocage des régies publicitaires, scripts de tracking, pop-ups intrusifs et bannière cosmétique.
- Popover compact au clic sur l'icône bouclier :
  - Interrupteur ON/OFF global et par site (liste blanche).
  - Compteur en temps réel des requêtes bloquées sur la page et au total.

### 3.4. Détecteur de Sites Malveillants (Azot Guard)
- Interception avant chargement (`will-navigate` / `onBeforeRequest`) si un domaine correspond à une menace connue (phishing, malware, cryptojacking).
- Écran d'interstitiel clair, sobre et pédagogique expliquant le risque détecté avec deux choix :
  - *Retourner en sécurité* (bouton principal).
  - *Ignorer l'avertissement et continuer* (action secondaire explicite).
- Détection d'attaques homographes (IDN spoofing) et alerte visuelle dans l'Omnibox.

### 3.5. Support des Extensions
- Gestionnaire d'extensions minimaliste (`azot://extensions` ou panneau dédié).
- Chargement d'extensions décompressées (Load Unpacked `.crx` / dossier manifest v3) via `session.defaultSession.loadExtension()`.
- Activation, désactivation et suppression propres des extensions installées, avec affichage de leurs icônes d'action dans la barre d'outils si pertinent.

---

## 4. Critères de Performance & Qualité
- Temps de démarrage à froid < 1,5 seconde.
- Animations UI verrouillées à 60+ FPS sans blocage du thread principal.
- Architecture propre permettant d'ajouter facilement la synchronisation, les profils ou la navigation privée dans une v2.
