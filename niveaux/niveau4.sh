#!/bin/bash
# =====================================================================
# NIVEAU 4 : Les badges du musée  (find, grep, pipes, redirections)
# Ce script crée 5 journaux de badges (un par jour). Une seule ligne répond à
# la question : "23:42 JMOREAU ENTREE SALLE_OUEST" dans le fichier du jeudi.
# Les autres lignes sont des fausses pistes.
# Réponse attendue : JMOREAU
# =====================================================================

RACINE="$1"
A="$RACINE/enquete/acces"
mkdir -p "$A"

# Format de chaque ligne : HEURE NOM ACTION SALLE
cat > "$A/lundi.log" <<'EOF'
08:05 LEROY ENTREE HALL
09:12 BERNARD ENTREE SALLE_OUEST
10:30 PETIT ENTREE SALLE_EST
12:45 DURAND SORTIE SALLE_OUEST
14:20 RICHARD ENTREE RESERVE
18:02 ROBERT SORTIE HALL
22:10 JMOREAU ENTREE HALL
23:15 JMOREAU ENTREE SALLE_EST
EOF

cat > "$A/mardi.log" <<'EOF'
08:10 PETIT ENTREE HALL
09:40 LEROY ENTREE SALLE_OUEST
11:05 RICHARD SORTIE SALLE_EST
13:30 BERNARD ENTREE BUREAU
17:55 DURAND SORTIE SALLE_OUEST
22:10 JMOREAU ENTREE HALL
23:15 JMOREAU ENTREE SALLE_EST
23:42 JMOREAU SORTIE RESERVE
EOF

cat > "$A/mercredi.log" <<'EOF'
08:00 ROBERT ENTREE HALL
09:25 DURAND ENTREE SALLE_OUEST
10:50 LEROY SORTIE SALLE_OUEST
15:15 PETIT ENTREE BUREAU
19:40 BERNARD SORTIE HALL
22:10 JMOREAU ENTREE HALL
23:15 JMOREAU ENTREE SALLE_EST
23:50 RICHARD SORTIE RESERVE
EOF

# Jeudi : la nuit du vol. Seule la ligne de 23:42 dans la SALLE_OUEST nous intéresse.
cat > "$A/jeudi.log" <<'EOF'
08:20 BERNARD ENTREE HALL
09:00 PETIT ENTREE SALLE_OUEST
11:35 DURAND SORTIE SALLE_OUEST
16:10 LEROY ENTREE BUREAU
21:30 RICHARD SORTIE HALL
22:10 JMOREAU ENTREE HALL
23:10 ROBERT ENTREE SALLE_OUEST
23:15 JMOREAU ENTREE SALLE_EST
23:42 JMOREAU ENTREE SALLE_OUEST
23:55 ROBERT SORTIE SALLE_OUEST
EOF

cat > "$A/vendredi.log" <<'EOF'
08:15 LEROY ENTREE HALL
09:30 RICHARD ENTREE SALLE_OUEST
12:00 PETIT SORTIE SALLE_OUEST
14:45 ROBERT ENTREE RESERVE
18:20 DURAND SORTIE HALL
22:10 JMOREAU ENTREE HALL
23:15 JMOREAU ENTREE SALLE_EST
EOF

echo "Journaux du système de badges du musée (un fichier par jour)." > "$A/LISEZMOI.txt"

cat <<EOF

==================================================
  NIVEAU 4/5 : Les badges du musée
==================================================
Les badges des gardiens enregistrent chaque entrée et sortie : un fichier par jour dans
  $A
Chaque ligne a la forme : HEURE NOM ACTION SALLE.
Le vol a eu lieu le jeudi à 23:42 dans la SALLE_OUEST. Commandes utiles :
  find DOSSIER -name "*.log"   chercher des fichiers
  grep MOTIF FICHIER           chercher du texte (grep -r pour un dossier entier)
  COMMANDE1 | COMMANDE2        pipe : envoie la sortie de l'une dans l'autre
  COMMANDE > FICHIER           redirige le résultat vers un fichier
  wc -l, sort, uniq            compter, trier, dédoublonner

Mission : qui a badgé en entrant dans la SALLE_OUEST à 23:42 la nuit du vol ?
Donne son identifiant de badge (en MAJUSCULES).
EOF
