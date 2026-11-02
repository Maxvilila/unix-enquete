# Enquête au musée : découvre UNIX en jouant

Un diamant, l'« Étoile de Paris », a été volé au musée. Tu es l'inspecteur : résous l'affaire en 5 niveaux, uniquement avec des commandes UNIX.

## Lancer le jeu

Prérequis : un terminal Linux, macOS ou WSL avec bash.

```bash
git clone https://github.com/Maxvilila/unix-enquete.git
cd unix-enquete
bash jouer.sh
```

À chaque niveau, le jeu génère un dossier `enquete/` et affiche la mission et les commandes utiles. Quand tu penses avoir la réponse :

```bash
bash valider.sh MA_REPONSE
```

Si la réponse est bonne, le niveau suivant démarre automatiquement. Les réponses ne tiennent pas compte des majuscules.

## Les 5 niveaux

| Niveau | Titre | Commandes découvertes |
|---|---|---|
| 1 | Arrivée sur les lieux | `pwd`, `ls`, `cd`, `cat` |
| 2 | Les témoignages | `head`, `tail`, `wc`, `less`, `man` |
| 3 | Mise sous scellés | `ls -a`, `mkdir`, `cp`, `mv`, `rm`, `touch` |
| 4 | Les badges du musée | `find`, `grep`, `\|`, `>`, `sort`, `wc` |
| 5 | Le coffre du voleur | `ls -l`, `chmod`, `ps`, `kill` |

## Commandes du jeu

```bash
bash jouer.sh          # relance le niveau en cours (le régénère)
bash jouer.sh niveau 3 # va directement au niveau 3
bash jouer.sh reset    # recommence depuis le début
bash valider.sh REP    # valide la réponse du niveau en cours
```

## Pour l'enseignant

- Les solutions sont dans [SOLUTIONS.md](SOLUTIONS.md).
- Le code est entièrement commenté en français. Pour comprendre le bash utilisé, lis [GUIDE_BASH.md](GUIDE_BASH.md).
- Les réponses sont écrites en clair dans `valider.sh` : le jeu repose sur le fair-play des élèves.

## Organisation du code

| Fichier | Rôle |
|---|---|
| `jouer.sh` | Point d'entrée : choisit le niveau, prépare l'enquête (nettoie, exécute le script du niveau, note la progression) |
| `valider.sh` | Vérifie la réponse, puis rappelle `jouer.sh` pour passer au niveau suivant |
| `niveaux/niveauN.sh` | Crée les fichiers et dossiers de l'enquête du niveau N |
