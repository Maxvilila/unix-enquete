#!/bin/bash
# =====================================================================
# lancer.sh : prépare et démarre un niveau.
# Il est appelé par jouer.sh et valider.sh (on ne le lance pas à la main).
#
#   bash lancer.sh 3   -> prépare le niveau 3
# =====================================================================

RACINE="$(cd "$(dirname "$0")" && pwd)"

# $1 = le numéro du niveau demandé.
NIVEAU="$1"

# Vérification : le niveau doit être compris entre 1 et 5.
# -lt veut dire "plus petit que" (less than), -gt "plus grand que" (greater than).
# || veut dire "OU".
if [ "$NIVEAU" -lt 1 ] || [ "$NIVEAU" -gt 5 ]; then
  echo "Niveau invalide : choisis un numéro entre 1 et 5."
  exit 1
fi

# 1. On arrête l'alarme du niveau 5 si elle tourne encore.
#    pkill -f arrête les processus dont le nom contient "alarme_musee".
#    2>/dev/null cache les messages d'erreur (s'il n'y a pas d'alarme, ce n'est pas grave).
pkill -f alarme_musee 2>/dev/null

# 2. On supprime l'ancien dossier "enquete" (-r = avec son contenu, -f = sans poser de question)
#    puis on en crée un tout neuf.
rm -rf "$RACINE/enquete"
mkdir "$RACINE/enquete"

# 3. On exécute le script du niveau, qui crée les fichiers de l'enquête.
#    On lui passe le chemin du jeu ($RACINE) : il le recevra dans sa variable $1.
bash "$RACINE/niveaux/niveau$NIVEAU.sh" "$RACINE"

# 4. On note le niveau en cours dans le fichier .progression.
#    ">" écrit le résultat de la commande echo dans un fichier (en écrasant l'ancien contenu).
echo "$NIVEAU" > "$RACINE/.progression"

# 5. On rappelle à l'élève comment répondre.
echo
echo "Quand tu as trouvé la réponse : bash $RACINE/valider.sh REPONSE"
echo "Point de départ : $RACINE/enquete"
