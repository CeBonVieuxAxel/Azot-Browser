# Contribuer à Azot

Merci de contribuer à Azot. Gardez les changements ciblés, sans télémétrie ni dépendance lourde, et préservez la séparation stricte entre processus principal, preload et renderer.

## Démarrer

```bash
git clone <https://github.com/CeBonVieuxAxel/Azot-Browser>
cd azot-browser
npm install
npm start
```

Avant une proposition, vérifiez les scripts JavaScript modifiés et mettez `CHANGELOG_CODEX.md` à jour lorsque le changement est significatif.

## Compiler

```bash
npm run pack       # application non installable, validation rapide
npm run dist       # installeur pour l’OS courant
```

Les icônes versionnées dans `build/` sont déjà prêtes. Sous Windows, `npm run icons` permet de les régénérer depuis le logo. Les variantes CI sont `npm run dist:win`, `npm run dist:mac` et `npm run dist:linux`. Les fichiers produits sont placés dans `release/` et ne doivent pas être versionnés.
