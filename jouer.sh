#!/bin/bash
# =====================================================================
# jouer.sh : le script qu'on lance pour jouer.
#
#   bash jouer.sh            -> lance (ou relance) le niveau en cours
#   bash jouer.sh niveau 3   -> va directement au niveau 3
#   bash jouer.sh reset      -> recommence au niveau 1
# =====================================================================

# $0 est le nom du script lancé (ici "jouer.sh").
# "dirname" donne le dossier du script, et "cd ... && pwd" en donne le chemin complet.
# $( ... ) veut dire : "exécute la commande entre parenthèses et donne-moi son résultat".
# On range ce chemin dans une variable nommée RACINE (le dossier principal du jeu).
RACINE="$(cd "$(dirname "$0")" && pwd)"

# $1 est le premier mot tapé après le nom du script ("reset", "niveau", ...).
ACTION="$1"

if [ "$ACTION" = "reset" ]; then
  # Recommencer : on lance le niveau 1.
  bash "$RACINE/lancer.sh" 1

elif [ "$ACTION" = "niveau" ]; then
  # Aller à un niveau précis : $2 est le deuxième mot tapé (le numéro du niveau).
  bash "$RACINE/lancer.sh" "$2"

else
  # Cas normal : on reprend là où l'élève s'était arrêté.
  # Le fichier .progression contient le numéro du niveau en cours.
  if [ -f "$RACINE/.progression" ]; then
    # Le fichier existe : on lit son contenu avec "cat".
    NIVEAU="$(cat "$RACINE/.progression")"
  else
    # Pas de fichier : c'est la toute première partie.
    NIVEAU=1
    echo "Commissariat de Paris, 1er arrondissement. Un diamant vient d'être volé au musée..."
    echo "Tu es l'inspecteur chargé de l'affaire. Tout se passe dans ton terminal."
  fi
  bash "$RACINE/lancer.sh" "$NIVEAU"
fi
