#!/usr/bin/env bash
# Fonctions communes du jeu "Enquête au musée"

RACINE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENQUETE="$RACINE/enquete"
FICHIER_PROG="$RACINE/.progression"
NB_NIVEAUX=5
HASHES=("a9cdc4a092a0bada8b85b7071da6e7f60b29554837b6e86cc930692c5ab866a5" "047c78775291dfb5190bd23ef0ce00e418c303ee448960857eda68b37e3394db" "668bb86c9da6baf851187075b824f8fb203aca07fdd1a1d9ba4abbfe87556a9c" "d14f46bde5a099c4b68f7799b18f5260bbc1b1bc9136f51b004d8e94a4b93526" "4f356910aa07a04ea1afa8a1798f60193e16bf1bbf07f63b618ae5ed306cfb02")

VERT=$'\033[1;32m'; ROUGE=$'\033[1;31m'; JAUNE=$'\033[1;33m'; BLEU=$'\033[1;36m'; RESET=$'\033[0m'

niveau_courant() {
  if [ -f "$FICHIER_PROG" ]; then cat "$FICHIER_PROG"; else echo 1; fi
}

hash_texte() {
  if command -v sha256sum >/dev/null 2>&1; then
    printf '%s' "$1" | sha256sum | cut -d' ' -f1
  else
    printf '%s' "$1" | shasum -a 256 | cut -d' ' -f1
  fi
}

arreter_alarme() {
  ps aux 2>/dev/null | grep '[a]larme_musee' | awk '{print $2}' | xargs kill 2>/dev/null || true
}

entete() {
  echo
  echo "${BLEU}==================================================${RESET}"
  echo "${BLEU}  NIVEAU $1/$NB_NIVEAUX : $2${RESET}"
  echo "${BLEU}==================================================${RESET}"
}

lancer_niveau() {
  local n="$1"
  case "$n" in 1|2|3|4|5) ;; *) echo "Niveau invalide (1 à $NB_NIVEAUX)."; return 1 ;; esac
  arreter_alarme
  rm -rf "$ENQUETE"
  mkdir -p "$ENQUETE"
  # shellcheck source=/dev/null
  source "$RACINE/niveaux/niveau$n.sh"
  niveau_creer
  echo "$n" > "$FICHIER_PROG"
  echo
  echo "${JAUNE}Quand tu as trouvé la réponse :${RESET} bash $RACINE/valider.sh REPONSE"
  echo "${JAUNE}Point de départ :${RESET} $ENQUETE"
}
