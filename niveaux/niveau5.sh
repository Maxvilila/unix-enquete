#!/usr/bin/env bash
# Niveau 5 : ls -l, chmod, ps, kill

niveau_verifier() { return 0; }

niveau_creer() {
  local L="$ENQUETE/labo"
  mkdir -p "$L"
  cat > "$L/coffre.sh" <<'EOF'
#!/usr/bin/env bash
if ps aux | grep -v grep | grep -q alarme_musee; then
  echo "ALARME ACTIVE ! Le coffre refuse de s'ouvrir."
  exit 1
fi
echo "Coffre ouvert. Le diamant est retrouvé !"
echo "Le coupable est Julien Moreau, gardien de nuit."
echo "Mot de passe final : DIAMANT-RETROUVE"
EOF
  chmod 644 "$L/coffre.sh"
  echo "Le coffre du voleur est dans ce dossier. Il est protégé par une alarme." > "$L/LISEZMOI.txt"
  bash -c 'exec -a alarme_musee sleep 86400' >/dev/null 2>&1 &
  disown 2>/dev/null || true

  entete 5 "Le coffre du voleur"
  cat <<EOF
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
}
