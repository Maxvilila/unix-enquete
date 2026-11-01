#!/bin/bash
# =====================================================================
# NIVEAU 1 : Arrivée sur les lieux  (pwd, ls, cd, cat)
# Ce script construit le musée : des dossiers et des fichiers texte.
# Réponse attendue : VITRINE-7
# =====================================================================

# $1 est le chemin du jeu, transmis par lancer.sh.
RACINE="$1"
M="$RACINE/enquete/musee"     # M = dossier du musée (raccourci pour écrire moins)

# mkdir crée des dossiers (-p crée aussi les dossiers parents manquants, et ne se plaint pas
# si le dossier existe déjà). On peut en créer plusieurs d'un coup.
mkdir -p "$M/hall" "$M/salle_est" "$M/salle_ouest/vitrines" "$M/reserve" "$M/bureau_directeur" "$M/jardin"

# echo "texte" > fichier  : écrit le texte dans un fichier (le crée s'il n'existe pas).
echo "Bienvenue au Musée des Joyaux de Paris. Les salles sont à l'est et à l'ouest." > "$M/hall/accueil.txt"
echo "Le diamant 'Étoile de Paris' était exposé dans la salle ouest, dans l'une des vitrines." > "$M/hall/plan.txt"
echo "Salle est : tableaux et sculptures. Rien à signaler." > "$M/salle_est/note.txt"
echo "Inventaire de la réserve : 12 caisses de catalogues." > "$M/reserve/inventaire.txt"
echo "Note du directeur : penser à renouveler les badges des gardiens." > "$M/bureau_directeur/memo.txt"
echo "Les roses sont en fleurs." > "$M/jardin/jardinier.txt"

# Boucle "for" : on répète la commande pour chaque valeur de la liste (1, 2, 3, ...).
# $i est remplacé à chaque tour par la valeur courante. La vitrine 7 est volontairement absente.
for i in 1 2 3 4 5 6 8; do
  echo "Vitrine $i : objet en place, scellé intact." > "$M/salle_ouest/vitrines/vitrine_$i.txt"
done

# La vitrine 7 contient la réponse.
# "cat > fichier <<'EOF' ... EOF" écrit plusieurs lignes dans un fichier :
# tout ce qui se trouve entre <<'EOF' et le mot EOF est le contenu du fichier.
cat > "$M/salle_ouest/vitrines/vitrine_7.txt" <<'EOF'
VITRINE 7 : EFFRACTION !
Le diamant 'Étoile de Paris' a disparu.
Numéro de scellé de la police : VITRINE-7
EOF

# Affichage de la mission à l'écran. Ici <<EOF (sans guillemets) remplace les $variables par leur valeur.
cat <<EOF

==================================================
  NIVEAU 1/5 : Arrivée sur les lieux
==================================================
Tu arrives au musée. Pour trouver le numéro de scellé de la police,
explore les salles. Commandes utiles :
  pwd         où suis-je ?
  ls          lister le contenu d'un dossier
  cd DOSSIER  entrer dans un dossier (cd .. pour remonter)
  cat FICHIER afficher un fichier

Mission : trouve la vitrine où le diamant a disparu et donne le numéro de scellé.
Le musée se trouve dans : $M
EOF
