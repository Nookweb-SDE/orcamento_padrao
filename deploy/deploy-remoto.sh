#!/usr/bin/env bash
# Uma sessão SSH + rsync: reduz tentativas de login (fail2ban no servidor).
#
# Uso (na tua máquina):
#   export ORCAMENTO_PEM="/home/almirante/Área de trabalho/Host/nookweb_admin.pem"
#   export ORCAMENTO_SSH="root@5.78.90.166"   # altere se o IP do VPS mudar
#   ./deploy/deploy-remoto.sh
#
# Opcional: ORCAMENTO_DIR remoto (default /root/orcamento_padrao)

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PEM="${ORCAMENTO_PEM:-}"
SSH_TARGET="${ORCAMENTO_SSH:-root@5.78.90.166}"
REMOTE_DIR="${ORCAMENTO_DIR:-/root/orcamento_padrao}"
STACK_FILE="${ORCAMENTO_STACK:-deploy/docker-stack.yml}"

if [[ ! -f "$PEM" ]]; then
  echo "Defina ORCAMENTO_PEM para o ficheiro .pem (ex.: pasta Área de trabalho/Host/nookweb_admin.pem)" >&2
  exit 1
fi

chmod 600 "$PEM"
SSH_BASE=(ssh -i "$PEM" -o StrictHostKeyChecking=accept-new -o ServerAliveInterval=30)

echo "→ rsync para $SSH_TARGET:$REMOTE_DIR"
RSYNC_SSH="ssh -i $(printf '%q' "$PEM") -o StrictHostKeyChecking=accept-new"
rsync -e "$RSYNC_SSH" -a --delete \
  --exclude '.git/' \
  --exclude '**/_transcricoes/' \
  --exclude '*.pdf' \
  --exclude '*.wav' --exclude '*.ogg' --exclude '*.mp3' --exclude '*.m4a' \
  "$REPO_ROOT/" "$SSH_TARGET:$REMOTE_DIR/"

echo "→ build + stack deploy (comandos remotos)"
"${SSH_BASE[@]}" "$SSH_TARGET" bash -s <<EOF
set -euo pipefail
cd "$REMOTE_DIR"
docker build -f deploy/Dockerfile -t nookweb-orcamento:latest .
docker stack deploy -c "$STACK_FILE" nookweb-orcamento
docker service ls | grep -i orcamento || true
EOF

echo "→ Feito. Testar: https://www.nookweb.com.br/orcamento/"
