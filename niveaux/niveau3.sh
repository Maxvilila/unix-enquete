#!/bin/bash
# =====================================================================
# NIVEAU 3 : Mise sous scellés  (ls -a, mkdir, cp, mv, rm, touch)
# Ce script crée un commissariat avec un fichier caché (son nom commence par un point).
# Réponse attendue : GANT-NOIR  (+ les manipulations de fichiers, vérifiées par valider.sh)
# =====================================================================

RACINE="$1"
C="$RACINE/enquete/commissariat"

mkdir -p "$C/bureau" "$C/preuves" "$C/archives"

echo "Empreinte digitale relevée sur la vitrine 7 : motif en boucle, pouce droit." > "$C/preuves/empreinte.txt"
echo "Photo 1 : vitrine brisée." > "$C/preuves/photo_01.txt"
echo "Photo 2 : traces de pas dans le couloir." > "$C/preuves/photo_02.txt"
echo "Brouillon à jeter : mauvaise piste, ne pas conserver." > "$C/preuves/brouillon.txt"
echo "Affaires classées 2019." > "$C/archives/classees.txt"
echo "Rien d'intéressant ici... regarde bien, certains fichiers se cachent." > "$C/bureau/note.txt"

# Fichier CACHÉ : sous UNIX, un nom qui commence par "." est invisible avec un simple "ls".
# Il faut faire "ls -a" pour le voir.
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

cat <<EOF

==================================================
  NIVEAU 3/5 : Mise sous scellés
==================================================
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
