# Orçamentos Nookweb — repositório padrão

Repositório Git para **orçamentos por cliente**, cada um na sua pasta. O conteúdo de referência é o orçamento **Gold Luxy** (`empresas/goldluxy/`): use-o como base para novas empresas.

**Remoto sugerido:** `https://github.com/Nookweb-SDE/orcamento_padrao.git`

## Estrutura

```
orcamento_padrao/
├── README.md                 ← este ficheiro
├── scripts/
│   └── nova-empresa.sh       ← cria pasta nova a partir do padrão Gold Luxy
└── empresas/
    ├── goldluxy/             ← padrão / proposta completa de referência
    ├── blackiceconfecoes/    ← exemplo de outro cliente
    └── <slug>/               ← um diretório por empresa (minúsculas, hífen)
        └── index.html        ← proposta (e assets na mesma pasta, se existirem)
```

## Nova empresa

Na raiz do repositório:

```bash
chmod +x scripts/nova-empresa.sh
./scripts/nova-empresa.sh nome-do-cliente
```

Isto copia `empresas/goldluxy` para `empresas/nome-do-cliente`. Depois:

1. Abre `empresas/nome-do-cliente/index.html` e adapta marca, valores, textos e links.
2. Remove ou ajusta `_transcricoes/` se não fizer sentido para esse cliente.
3. Faz `git add` / `commit` / `push`.

**Regra para o slug:** só letras minúsculas, números e hífens (ex.: `acme-joias`, `cliente2026`).

## Git — primeira vez

Se o remoto no GitHub ainda estiver vazio ou for o teu:

```bash
cd "/caminho/para/orcamento_padrao"
git init
git remote add origin https://github.com/Nookweb-SDE/orcamento_padrao.git
git add .
git commit -m "Estrutura inicial: empresas goldluxy e blackiceconfecoes"
git branch -M main
git push -u origin main
```

Se o remoto **já tiver histórico**, usa `git pull --rebase origin main` antes do primeiro push ou clona o repositório e copia a pasta `empresas/` para lá.

## Relação com `Nookweb/orçamento/`

Podes manter cópias de trabalho em `Nookweb/orçamento/<cliente>/` no disco e **sincronizar** com `orcamento_padrao/empresas/<cliente>/` quando for commitar, ou editar **direto** dentro de `orcamento_padrao/empresas/`. O importante é o Git ter uma pasta por empresa neste repositório.

## `.gitignore`

Ficheiros de áudio (`.wav`, `.ogg`) e `.venv` não entram no Git por defeito — mantém o repositório leve. Textos de transcrição (`.txt`, `.md`) e o HTML entram se fizer sentido.
