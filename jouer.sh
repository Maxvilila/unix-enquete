#!/bin/bash
# =====================================================================
# jouer.sh : le script qu'on lance pour jouer.
# Il prépare et démarre un niveau. Il est aussi appelé par valider.sh
# pour passer au niveau suivant.
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

# ---------------------------------------------------------------------
# ÉTAPE 1 : quel niveau faut-il lancer ?
# ---------------------------------------------------------------------
if [ "$ACTION" = "reset" ]; then
  # Recommencer : on part du niveau 1.
  NIVEAU=1

elif [ "$ACTION" = "niveau" ]; then
  # Aller à un niveau précis : $2 est le deuxième mot tapé (le numéro du niveau).
  NIVEAU="$2"

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
fi

# ---------------------------------------------------------------------
# ÉTAPE 2 : vérification. Le niveau doit être 1, 2, 3, 4 ou 5.
# "case" compare NIVEAU à chaque valeur et exécute le bloc qui correspond.
# "1|2|3|4|5" veut dire "1 OU 2 OU 3 OU 4 OU 5". "*" veut dire "n'importe quoi d'autre".
# Chaque bloc se termine par ";;".
# ---------------------------------------------------------------------
case "$NIVEAU" in
  1|2|3|4|5) ;;
  *)
    echo "Niveau invalide : choisis un numéro entre 1 et 5."
    exit 1 ;;
esac

# ---------------------------------------------------------------------
# ÉTAPE 3 : préparation du niveau
# ---------------------------------------------------------------------

# 3.1 On arrête l'alarme du niveau 5 si elle tourne encore.
#     pkill -f arrête les processus dont le nom contient "alarme_musee".
#     2>/dev/null cache les messages d'erreur (s'il n'y a pas d'alarme, ce n'est pas grave).
pkill -f alarme_musee 2>/dev/null

# 3.2 On supprime l'ancien dossier "enquete" (-r = avec son contenu, -f = sans poser de question)
#     puis on en crée un tout neuf.
rm -rf "$RACINE/enquete"
mkdir "$RACINE/enquete"

# 3.3 On exécute le script du niveau, qui crée les fichiers de l'enquête.
#     On lui passe le chemin du jeu ($RACINE) : il le recevra dans sa variable $1.
bash "$RACINE/niveaux/niveau$NIVEAU.sh" "$RACINE"

# 3.4 On note le niveau en cours dans le fichier .progression.
#     ">" écrit le résultat de la commande echo dans un fichier (en écrasant l'ancien contenu).
echo "$NIVEAU" > "$RACINE/.progression"

# 3.5 On rappelle à l'élève comment répondre.
echo
echo "Quand tu as trouvé la réponse : bash $RACINE/valider.sh REPONSE"
echo "Point de départ : $RACINE/enquete"
