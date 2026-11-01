#!/usr/bin/env bash
# Niveau 4 : find, grep, pipes, wc, sort, redirections

niveau_verifier() { return 0; }

niveau_creer() {
  local A="$ENQUETE/acces"
  mkdir -p "$A"
  local jours=(lundi mardi mercredi jeudi vendredi)
  local pers=(LEROY BERNARD PETIT DURAND RICHARD ROBERT)
  local salles=(HALL SALLE_EST SALLE_OUEST RESERVE BUREAU)
  local d i j h m p s act
  for d in 0 1 2 3 4; do
    j="${jours[$d]}"
    {
      for i in $(seq 0 59); do
        h=$(( (i*7 + d*3) % 24 )); m=$(( (i*13 + d*5) % 60 ))
        p="${pers[$(( (i+d) % 6 ))]}"; s="${salles[$(( (i*5 + d) % 5 ))]}"
        act=ENTREE; [ $((i % 3)) -eq 0 ] && act=SORTIE
        printf '%02d:%02d %s %s %s\n' "$h" "$m" "$p" "$act" "$s"
      done
      printf '22:10 JMOREAU ENTREE HALL\n23:15 JMOREAU ENTREE SALLE_EST\n'
      [ "$j" = "jeudi" ] && printf '23:42 JMOREAU ENTREE SALLE_OUEST\n'
      [ "$j" = "mardi" ] && printf '23:42 JMOREAU SORTIE RESERVE\n'
    } | grep -v -E '^23:42 (LEROY|BERNARD|PETIT|DURAND|RICHARD|ROBERT) ' | sort > "$A/$j.log"
  done
  echo "Journaux du système de badges du musée (un fichier par jour)." > "$A/LISEZMOI.txt"

  entete 4 "Les badges du musée"
  cat <<EOF
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
}
