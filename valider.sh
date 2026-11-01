#!/bin/bash
# =====================================================================
# valider.sh : vérifie la réponse de l'élève pour le niveau en cours.
#
#   bash valider.sh MA_REPONSE
#
# Si c'est bon : on passe au niveau suivant (ou on termine le jeu).
# Si c'est faux : on affiche un message et on s'arrête.
# =====================================================================

RACINE="$(cd "$(dirname "$0")" && pwd)"

# Si l'élève n'a rien tapé après "valider.sh", on explique comment faire.
# -z veut dire "la chaîne est vide". "exit 1" arrête le script.
if [ -z "$1" ]; then
  echo "Usage : bash $RACINE/valider.sh REPONSE"
  exit 1
fi

# Quel est le niveau en cours ? On lit le fichier .progression (ou 1 s'il n'existe pas).
if [ -f "$RACINE/.progression" ]; then
  NIVEAU="$(cat "$RACINE/.progression")"
else
  NIVEAU=1
fi

# On prépare la réponse de l'élève ($* = tout ce qu'il a tapé) :
#   - tr 'a-z' 'A-Z' passe tout en MAJUSCULES
#   - tr -d ' ' supprime les espaces
# Le symbole | (pipe) envoie le résultat d'une commande vers la suivante.
REPONSE="$(echo "$*" | tr 'a-z' 'A-Z' | tr -d ' ')"

# La bonne réponse de chaque niveau.
# "case" compare NIVEAU à chaque valeur (1, 2, 3...) et exécute le bloc correspondant.
# Chaque bloc se termine par ";;".
case "$NIVEAU" in
  1) ATTENDU="VITRINE-7" ;;
  2) ATTENDU="JULIEN" ;;
  3) ATTENDU="GANT-NOIR" ;;
  4) ATTENDU="JMOREAU" ;;
  5) ATTENDU="DIAMANT-RETROUVE" ;;
esac

# Mauvaise réponse ? != veut dire "est différent de".
if [ "$REPONSE" != "$ATTENDU" ]; then
  echo "Ce n'est pas la bonne réponse. Relis les indices et continue l'enquête."
  exit 1
fi

# Vérifications supplémentaires pour le niveau 3 :
# en plus de la réponse, l'élève devait faire des manipulations de fichiers.
if [ "$NIVEAU" = "3" ]; then
  C="$RACINE/enquete/commissariat"
  ERREUR=0     # 0 = tout va bien, on passera à 1 dès qu'il manque quelque chose

  # -d teste si un dossier existe, -f si un fichier existe, ! veut dire "NON".
  if [ ! -d "$C/scelles" ]; then
    echo "Il manque le dossier scelles/"; ERREUR=1
  fi
  if [ ! -f "$C/scelles/empreinte_scellee.txt" ]; then
    echo "Il manque scelles/empreinte_scellee.txt"; ERREUR=1
  fi
  # -e teste si "quelque chose" existe (fichier ou dossier).
  if [ -e "$C/scelles/empreinte.txt" ]; then
    echo "scelles/empreinte.txt aurait dû être renommé"; ERREUR=1
  fi
  if [ ! -f "$C/preuves/empreinte.txt" ]; then
    echo "L'original preuves/empreinte.txt doit rester en place (copie, pas déplacement)"; ERREUR=1
  fi
  if [ -e "$C/preuves/brouillon.txt" ]; then
    echo "preuves/brouillon.txt n'a pas été supprimé"; ERREUR=1
  fi
  if [ ! -f "$C/scelles/rapport.txt" ]; then
    echo "Il manque scelles/rapport.txt"; ERREUR=1
  fi

  # S'il y a eu au moins une erreur, on s'arrête ici.
  if [ "$ERREUR" = "1" ]; then
    exit 1
  fi
fi

# Si on arrive ici, tout est bon !
echo "Bravo ! Niveau $NIVEAU réussi."

if [ "$NIVEAU" = "5" ]; then
  # Dernier niveau : fin du jeu. On arrête l'alarme par sécurité.
  pkill -f alarme_musee 2>/dev/null
  echo
  echo "*** AFFAIRE RÉSOLUE : le diamant est retrouvé et le coupable arrêté ! ***"
  echo "Tu connais maintenant les commandes de base d'UNIX. Félicitations, inspecteur !"
else
  # Sinon on lance le niveau suivant. $(( ... )) permet de faire un calcul.
  SUIVANT=$((NIVEAU + 1))
  echo "Retourne à la racine du projet avec : cd $RACINE"
  bash "$RACINE/lancer.sh" "$SUIVANT"
fi
