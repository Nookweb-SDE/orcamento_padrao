#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SLUG="${1:-}"

if [[ -z "$SLUG" || "$SLUG" == *"/"* || "$SLUG" == *" "* ]]; then
  echo "Uso: $0 <slug>" >&2
  echo "Exemplo: $0 acme-joias" >&2
  echo "Use só minúsculas, números e hífens (sem espaços)." >&2
  exit 1
fi

SRC="$ROOT/empresas/goldluxy"
DEST="$ROOT/empresas/$SLUG"

if [[ ! -d "$SRC" ]]; then
  echo "Pasta padrão em falta: $SRC" >&2
  exit 1
fi

if [[ -e "$DEST" ]]; then
  echo "Já existe: $DEST" >&2
  exit 1
fi

cp -a "$SRC" "$DEST"
echo "Criado: $DEST"
echo "Próximo passo: editar index.html (marca, valores, FAQ) e fazer git add / commit."
