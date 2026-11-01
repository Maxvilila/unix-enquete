#!/usr/bin/env bash
# Valide la réponse du niveau en cours.
# Usage : bash valider.sh REPONSE
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/lib/commun.sh"

if [ $# -eq 0 ]; then
  echo "Usage : bash $DIR/valider.sh REPONSE"; exit 1
fi

niv="$(niveau_courant)"
source "$RACINE/niveaux/niveau$niv.sh"

rep="$(printf '%s' "$*" | tr '[:lower:]' '[:upper:]' | tr -d '[:space:]')"
if [ "$(hash_texte "$rep")" != "${HASHES[$((niv-1))]}" ]; then
  echo "${ROUGE}Ce n'est pas la bonne réponse. Relis les indices et continue l'enquête.${RESET}"
  exit 1
fi

if ! niveau_verifier; then
  exit 1
fi

echo "${VERT}Bravo ! Niveau $niv réussi.${RESET}"
if [ "$niv" -ge "$NB_NIVEAUX" ]; then
  arreter_alarme
  echo
  echo "${VERT}*** AFFAIRE RÉSOLUE : le diamant est retrouvé et le coupable arrêté ! ***${RESET}"
  echo "Tu connais maintenant les commandes de base d'UNIX. Félicitations, inspecteur !"
  exit 0
fi
echo "Retourne à la racine du projet avec : cd $RACINE"
lancer_niveau $((niv+1))
