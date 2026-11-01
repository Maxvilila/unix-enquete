#!/usr/bin/env bash
# Lance (ou relance) le niveau en cours.
# Usage : bash jouer.sh [start | niveau N | reset | aide]
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib/commun.sh"

case "${1:-start}" in
  start)
    n="$(niveau_courant)"
    if [ ! -f "$FICHIER_PROG" ]; then
      echo "${JAUNE}Commissariat de Paris, 1er arrondissement. Un diamant vient d'être volé au musée...${RESET}"
      echo "Tu es l'inspecteur chargé de l'affaire. Tout se passe dans ton terminal."
    fi
    lancer_niveau "$n" ;;
  niveau) lancer_niveau "${2:-1}" ;;
  reset)  echo 1 > "$FICHIER_PROG"; lancer_niveau 1 ;;
  *)
    echo "Usage : bash jouer.sh [start | niveau N | reset]"
    echo "  start    (re)lance le niveau en cours"
    echo "  niveau N va directement au niveau N (1 à $NB_NIVEAUX)"
    echo "  reset    recommence l'enquête depuis le début" ;;
esac
