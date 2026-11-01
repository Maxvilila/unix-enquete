#!/usr/bin/env bash
# Niveau 1 : pwd, ls, cd, cat

niveau_verifier() { return 0; }

niveau_creer() {
  local M="$ENQUETE/musee"
  mkdir -p "$M"/{hall,salle_est,salle_ouest/vitrines,reserve,bureau_directeur,jardin}

  echo "Bienvenue au Musée des Joyaux de Paris. Les salles sont à l'est et à l'ouest." > "$M/hall/accueil.txt"
  echo "Le diamant 'Étoile de Paris' était exposé dans la salle ouest, dans l'une des vitrines." > "$M/hall/plan.txt"
  echo "Salle est : tableaux et sculptures. Rien à signaler." > "$M/salle_est/note.txt"
  echo "Inventaire de la réserve : 12 caisses de catalogues." > "$M/reserve/inventaire.txt"
  echo "Note du directeur : penser à renouveler les badges des gardiens." > "$M/bureau_directeur/memo.txt"
  echo "Les roses sont en fleurs." > "$M/jardin/jardinier.txt"
  for i in 1 2 3 4 5 6 8; do
    echo "Vitrine $i : objet en place, scellé intact." > "$M/salle_ouest/vitrines/vitrine_$i.txt"
  done
  cat > "$M/salle_ouest/vitrines/vitrine_7.txt" <<'EOF'
VITRINE 7 : EFFRACTION !
Le diamant 'Étoile de Paris' a disparu.
Numéro de scellé de la police : VITRINE-7
EOF

  entete 1 "Arrivée sur les lieux"
  cat <<EOF
Tu arrives au musée. Pour trouver le numéro de scellé de la police,
explore les salles. Commandes utiles :
  pwd         où suis-je ?
  ls          lister le contenu d'un dossier
  cd DOSSIER  entrer dans un dossier (cd .. pour remonter)
  cat FICHIER afficher un fichier

Mission : trouve la vitrine où le diamant a disparu et donne le numéro de scellé.
Le musée se trouve dans : $M
EOF
}
