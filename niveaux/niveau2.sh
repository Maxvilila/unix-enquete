#!/bin/bash
# =====================================================================
# NIVEAU 2 : Les témoignages  (head, tail, wc, less, man)
# Ce script crée un gros fichier de 120 lignes. La réponse est sur la dernière.
# Réponse attendue : JULIEN
# =====================================================================

RACINE="$1"
D="$RACINE/enquete/commissariat"
mkdir -p "$D"
FICHIER="$D/temoignages.log"

# Les deux premières lignes du fichier. ">" crée le fichier (ou l'écrase).
echo "# DOSSIER TEMOIGNAGES - affaire de l'Etoile de Paris" > "$FICHIER"
# ">>" AJOUTE à la fin du fichier, sans effacer ce qui existe déjà.
echo "# Le dernier temoin est le seul a avoir vu le voleur. Son temoignage est tout a la fin." >> "$FICHIER"

# Boucle : les témoins 2 à 119 n'ont rien vu. "seq 2 119" génère les nombres de 2 à 119.
# printf est comme echo mais permet de mettre en forme : %03d affiche le nombre sur 3 chiffres (007).
for i in $(seq 2 119); do
  printf 'Temoin %03d : n a rien vu, rien entendu, etait au cafe.\n' "$i" >> "$FICHIER"
done

# La toute dernière ligne contient la réponse.
echo "Temoin 120 (dernier) : J ai vu le voleur sortir par la porte de service. C etait le gardien de nuit, il s appelle JULIEN." >> "$FICHIER"

# Un petit fichier d'aide.
cat > "$D/aide.txt" <<'EOF'
Besoin d'aide ? Consulte le manuel d'une commande avec : man head
(quitte le manuel avec la touche q)
EOF

# Affichage de la mission.
cat <<EOF

==================================================
  NIVEAU 2/5 : Les témoignages
==================================================
Le commissariat a recueilli plus de cent témoignages dans un seul gros fichier :
  $FICHIER
  
Trop long pour tout lire mais les policiers ont arrêtés d'interroger
des personnes lorsqu'ils ont enfin trouvé un témoin utile.

Commandes utiles :
  head -n 5 FICHIER   les 5 premières lignes
  tail -n 5 FICHIER   les 5 dernières lignes
  wc -l FICHIER       compter les lignes
  less FICHIER        lire page par page (q pour quitter)
  man COMMANDE        manuel d'une commande

Mission : trouve le prénom du voleur (en MAJUSCULES dans le témoignage).
EOF
