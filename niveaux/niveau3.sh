#!/usr/bin/env bash
# Niveau 3 : ls -a, mkdir, cp, mv, rm, touch

niveau_verifier() {
  local C="$ENQUETE/commissariat" ok=0
  [ -d "$C/scelles" ]                          || { echo "${ROUGE}Il manque le dossier scelles/${RESET}"; ok=1; }
  [ -f "$C/scelles/empreinte_scellee.txt" ]    || { echo "${ROUGE}Il manque scelles/empreinte_scellee.txt${RESET}"; ok=1; }
  [ ! -e "$C/scelles/empreinte.txt" ]          || { echo "${ROUGE}scelles/empreinte.txt aurait dû être renommé${RESET}"; ok=1; }
  [ -f "$C/preuves/empreinte.txt" ]            || { echo "${ROUGE}L'original preuves/empreinte.txt doit rester en place (copie, pas déplacement)${RESET}"; ok=1; }
  [ ! -e "$C/preuves/brouillon.txt" ]          || { echo "${ROUGE}preuves/brouillon.txt n'a pas été supprimé${RESET}"; ok=1; }
  [ -f "$C/scelles/rapport.txt" ]              || { echo "${ROUGE}Il manque scelles/rapport.txt${RESET}"; ok=1; }
  return $ok
}

niveau_creer() {
  local C="$ENQUETE/commissariat"
  mkdir -p "$C"/{bureau,preuves,archives}
  echo "Empreinte digitale relevée sur la vitrine 7 : motif en boucle, pouce droit." > "$C/preuves/empreinte.txt"
  echo "Photo 1 : vitrine brisée." > "$C/preuves/photo_01.txt"
  echo "Photo 2 : traces de pas dans le couloir." > "$C/preuves/photo_02.txt"
  echo "Brouillon à jeter : mauvaise piste, ne pas conserver." > "$C/preuves/brouillon.txt"
  echo "Affaires classées 2019." > "$C/archives/classees.txt"
  echo "Rien d'intéressant ici... regarde bien, certains fichiers se cachent." > "$C/bureau/note.txt"
  cat > "$C/bureau/.carnet_secret" <<'EOF'
CARNET DU COMMISSAIRE (confidentiel)
Avant de donner le code de l'affaire, mets les preuves sous scellés :
 1. Crée un dossier "scelles" dans le dossier commissariat.      (mkdir)
 2. Copie preuves/empreinte.txt dans scelles/.                   (cp)
 3. Renomme scelles/empreinte.txt en empreinte_scellee.txt.      (mv)
 4. Supprime le brouillon preuves/brouillon.txt.                 (rm)
 5. Crée un fichier vide scelles/rapport.txt.                    (touch)
Code de l'affaire : GANT-NOIR
EOF

  entete 3 "Mise sous scellés"
  cat <<EOF
Le commissariat est ici : $C
Un fichier caché traîne dans le bureau. Commandes utiles :
  ls -a                      voir aussi les fichiers cachés (commençant par un point)
  mkdir DOSSIER              créer un dossier
  cp SOURCE DESTINATION      copier
  mv SOURCE DESTINATION      déplacer / renommer
  rm FICHIER                 supprimer
  touch FICHIER              créer un fichier vide

Mission : trouve le carnet caché, exécute les consignes, puis donne le code de l'affaire.
EOF
}
