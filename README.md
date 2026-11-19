<p align="center">
  <img src="azot%20logo.png" width="112" height="112" alt="Logo Azot">
</p>
<img width="2752" height="1536" alt="Azot" src="https://github.com/user-attachments/assets/46588d0e-6eb2-43b9-a099-e2eec40db489" />
<h1 align="center">Azot</h1>
<p align="center"><em>Le web, sans le bruit.</em></p>
<p align="center">
  <img src="https://img.shields.io/badge/version-v1.0.0--beta-111113?style=flat-square" alt="Version v1.0.0-beta">
  <img src="https://img.shields.io/badge/Electron-33-47848F?style=flat-square&logo=electron" alt="Electron 33">
  <img src="https://img.shields.io/badge/license-MIT-8A8A93?style=flat-square" alt="Licence MIT">
</p>
<p align="center">
  <img src="azot%20logo.png" width="112" height="112" alt="Logo Azot">
</p>

Azot est un navigateur desktop minimaliste : une interface qui s’efface, des animations qui répondent immédiatement et des protections natives sans télémétrie.

## Points forts

- Sidebar verticale escamotable, onglets réordonnables et animations physiques optimisées pour 60/120 FPS.
- Palette de commande avec `Ctrl/Cmd + L` et Nouvel Onglet vivant : logo cinétique et atomes 3D réactifs au curseur.
- Theme Studio en temps réel, avec **Azot Noir** comme signature par défaut.
- **Azot Shield**, bloqueur natif de publicités et trackers, et **Azot Guard**, protection anti-phishing et malware.
- Fondamentaux prêts pour le quotidien : historique persistant, paramètres de confidentialité et gestionnaire d’extensions Chromium décompressées.

## Installation et compilation

Téléchargez l’installeur correspondant à votre système depuis la page **Releases** : NSIS ou portable sous Windows, DMG sous macOS, AppImage ou DEB sous Linux.

Pour compiler localement, Node.js 20+ et les outils propres à votre plateforme sont requis.

```bash
git clone <url-du-dépôt>
cd azot-browser
npm install
npm start
```

```bash
npm run pack       # validation d’un package non installable
npm run dist       # installeur pour l’OS courant
npm run dist:win   # Windows : NSIS + portable
npm run dist:mac   # macOS : DMG + ZIP
npm run dist:linux # Linux : AppImage + DEB
```

Les livrables sont générés dans `release/`. Les builds macOS doivent être effectués sur macOS pour une signature/notarisation de production.

## Raccourcis

| Raccourci | Action |
| --- | --- |
| `Ctrl/Cmd + L` | Ouvrir la palette de navigation |
| `Ctrl/Cmd + T` | Nouvel onglet |
| `Ctrl/Cmd + W` | Fermer l’onglet actif |
| `Ctrl/Cmd + Shift + T` | Restaurer le dernier onglet fermé |
| `Ctrl/Cmd + Tab` | Onglet suivant |
| `Ctrl/Cmd + H` | Historique |
| `Ctrl/Cmd + ,` | Paramètres |
| `Ctrl/Cmd + Shift + E` | Extensions |

## Contribution et licence

Consultez [CONTRIBUTING.md](CONTRIBUTING.md) pour démarrer. Azot est distribué sous [licence MIT](LICENSE).
