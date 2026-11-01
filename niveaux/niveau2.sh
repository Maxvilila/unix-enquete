#!/usr/bin/env bash
# Niveau 2 : head, tail, wc, less, man

niveau_verifier() { return 0; }

niveau_creer() {
  local D="$ENQUETE/commissariat"
  mkdir -p "$D"
  local f="$D/temoignages.log"
  {
    echo "# DOSSIER TEMOIGNAGES - affaire de l'Etoile de Paris"
    echo "# Le dernier temoin est le seul a avoir vu le voleur. Son temoignage est tout a la fin."
    for i in $(seq 2 119); do
      printf 'Temoin %03d : n a rien vu, rien entendu, etait au cafe.\n' "$i"
    done
    echo "Temoin 120 (dernier) : J ai vu le voleur sortir par la porte de service. C etait le gardien de nuit, il s appelle JULIEN."
  } > "$f"
  cat > "$D/aide.txt" <<'EOF'
Besoin d'aide ? Consulte le manuel d'une commande avec : man head
(quitte le manuel avec la touche q)
EOF

  entete 2 "Les témoignages"
  cat <<EOF
Le commissariat a recueilli plus de cent témoignages dans un seul gros fichier :
  $f
Trop long pour tout lire ! Commandes utiles :
  head -n 5 FICHIER   les 5 premières lignes
  tail -n 5 FICHIER   les 5 dernières lignes
  wc -l FICHIER       compter les lignes
  less FICHIER        lire page par page (q pour quitter)
  man COMMANDE        manuel d'une commande

Mission : trouve le prénom du voleur (en MAJUSCULES dans le témoignage).
EOF
}
