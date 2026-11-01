#!/bin/bash
# =====================================================================
# NIVEAU 5 : Le coffre du voleur  (ls -l, chmod, ps, kill)
# Ce script crée un script "coffre.sh" SANS droit d'exécution, et lance en
# arrière-plan un faux processus "alarme_musee" qui bloque le coffre.
# Réponse attendue : DIAMANT-RETROUVE
# =====================================================================

RACINE="$1"
L="$RACINE/enquete/labo"
mkdir -p "$L"

# On écrit le script du coffre. Il commence par vérifier si l'alarme tourne :
#   ps aux liste les processus, grep alarme_musee garde ceux qui contiennent ce mot,
#   grep -v grep retire la ligne de la commande grep elle-même, grep -q ne montre rien
#   (il sert juste à tester). Si on trouve l'alarme : message + "exit 1" (arrêt).
cat > "$L/coffre.sh" <<'EOF'
#!/bin/bash
if ps aux | grep -v grep | grep -q alarme_musee; then
  echo "ALARME ACTIVE ! Le coffre refuse de s'ouvrir."
  exit 1
fi
echo "Coffre ouvert. Le diamant est retrouvé !"
echo "Le coupable est Julien Moreau, gardien de nuit."
echo "Mot de passe final : DIAMANT-RETROUVE"
EOF

# chmod modifie les droits d'un fichier. 644 = lecture/écriture pour le propriétaire,
# lecture seule pour les autres, et SURTOUT pas d'exécution : l'élève devra faire chmod +x.
chmod 644 "$L/coffre.sh"

echo "Le coffre du voleur est dans ce dossier. Il est protégé par une alarme." > "$L/LISEZMOI.txt"

# On lance l'alarme : un processus "sleep" (qui attend 86400 secondes = 24 h) mais déguisé
# sous le nom "alarme_musee" grâce à "exec -a". Le "&" à la fin le fait tourner en arrière-plan.
# >/dev/null 2>&1 cache tous ses messages.
bash -c 'exec -a alarme_musee sleep 86400' >/dev/null 2>&1 &

cat <<EOF

==================================================
  NIVEAU 5/5 : Le coffre du voleur
==================================================
Le coupable est identifié, il reste à ouvrir son coffre. Va dans :
  $L
Le script coffre.sh ne se lance pas tout seul, et une alarme tourne en arrière-plan. Commandes utiles :
  ls -l            voir les droits d'un fichier (rwx)
  chmod +x FICHIER rendre un fichier exécutable
  ./coffre.sh      lancer un script du dossier courant
  ps aux           lister les processus (ps aux | grep MOT pour filtrer)
  kill PID         arrêter un processus à partir de son numéro (PID)

Mission : ouvre le coffre et donne le mot de passe final.
EOF
