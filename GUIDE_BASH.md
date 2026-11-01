# Mini-guide bash pour comprendre le code

Ce guide explique, avec des mots simples, les notions de bash utilisées dans le jeu. Chaque script est de toute façon commenté ligne par ligne.

## Les bases

| Notion | Exemple | Explication |
|---|---|---|
| Script | `bash jouer.sh` | Un fichier texte contenant des commandes exécutées l'une après l'autre |
| Première ligne `#!/bin/bash` | | Indique que le script s'exécute avec bash |
| Commentaire | `# ceci est ignoré` | Tout ce qui suit un `#` est ignoré : c'est une note pour les humains |
| Variable | `NOM="Max"` puis `echo "$NOM"` | Une boîte qui garde une valeur. On l'écrit sans espace autour du `=` et on la lit avec `$` |
| Arguments | `$1`, `$2`, `$*` | Les mots tapés après le nom du script. `$1` est le premier, `$*` est l'ensemble |
| Résultat d'une commande | `X="$(cat fichier)"` | `$( ... )` exécute la commande et récupère ce qu'elle affiche |
| Calcul | `$((N + 1))` | Fait une addition (ou autre opération) sur des nombres |

## Afficher et écrire dans des fichiers

| Notion | Exemple | Explication |
|---|---|---|
| `echo` | `echo "Bonjour"` | Affiche un texte à l'écran |
| `>` | `echo "a" > f.txt` | Écrit dans un fichier, en écrasant son contenu |
| `>>` | `echo "b" >> f.txt` | Ajoute à la fin du fichier |
| `\|` (pipe) | `echo "abc" \| tr 'a-z' 'A-Z'` | Envoie le résultat d'une commande à la suivante |
| Bloc `<<EOF` | `cat > f.txt <<'EOF'` ... `EOF` | Écrit plusieurs lignes d'un coup. Avec `'EOF'` le texte est pris tel quel ; avec `EOF` seul, les `$variables` sont remplacées |
| `2>/dev/null` | `pkill x 2>/dev/null` | Cache les messages d'erreur |
| `&` en fin de ligne | `commande &` | Lance la commande en arrière-plan |

## Décisions et répétitions

| Notion | Exemple | Explication |
|---|---|---|
| `if` | `if [ "$A" = "oui" ]; then ... fi` | Exécute des commandes seulement si la condition est vraie. `elif` = sinon si, `else` = sinon, `fi` termine le bloc |
| Tests texte | `=`, `!=`, `-z` | égal, différent, vide |
| Tests nombres | `-lt`, `-gt`, `-eq` | plus petit, plus grand, égal |
| Tests fichiers | `-f`, `-d`, `-e` | est un fichier, est un dossier, existe |
| `!` | `[ ! -d dossier ]` | Inverse la condition (« n'existe pas ») |
| `\|\|` | `[ A ] \|\| [ B ]` | « OU » : vrai si l'un des deux tests est vrai |
| `for` | `for i in 1 2 3; do ... done` | Répète des commandes pour chaque valeur de la liste |
| `case` | `case "$N" in 1) ... ;; esac` | Choisit un bloc selon la valeur d'une variable |
| `exit 1` | | Arrête le script (1 signifie « erreur », 0 « tout va bien ») |

## Commandes utilisées par le jeu

| Commande | Rôle |
|---|---|
| `cat` | Affiche ou écrit le contenu d'un fichier |
| `mkdir -p` | Crée des dossiers |
| `rm -rf` | Supprime un dossier et son contenu |
| `chmod 644` | Change les droits d'un fichier |
| `tr` | Transforme des caractères (majuscules, suppression d'espaces) |
| `seq 2 119` | Génère les nombres de 2 à 119 |
| `printf` | Comme `echo`, avec mise en forme |
| `pkill -f mot` | Arrête les processus dont le nom contient `mot` |
| `dirname`, `pwd` | Trouvent le dossier d'un fichier / le dossier courant |
