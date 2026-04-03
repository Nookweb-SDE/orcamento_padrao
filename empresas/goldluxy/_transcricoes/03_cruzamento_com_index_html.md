# Cruzamento: áudios ↔ `index.html` (Gold Luxy)

## Transcrição

Sem texto literal dos PTTs neste ambiente, o cruzamento **linha a linha** com o que o sócio disse **fica pendente**. Assim que tiveres os `.txt` preenchidos, usa as tabelas abaixo.

| Áudio | Trecho (citação) | Onde na página | Match? |
|-------|------------------|----------------|--------|
| 15.14.37 | | | |
| 15.19.28 | | | |

---

## Convergências já observáveis (proposta escrita vs diretrizes combinadas)

| Tema | Onde no `index.html` | Nota |
|------|----------------------|------|
| Fidelidade mínima 12 meses | FAQ “Há fidelidade na mensalidade?”; Observações | Coerente com plano recorrente. |
| Código-fonte do cliente | FAQ “Quem é o dono do código-fonte?”; Observações | Explícito. |
| Código vs plataforma pronta | FAQ “Vocês usam plataforma pronta ou código?” | Sem Wix/WordPress como base do produto (construtores/CMS genéricos). |
| Valores e tabelas | Secção Investimento (cards, resumo, cenários) | Verificar contra áudio quando disponível. |
| Copy sem ênfase em IA como produto | Textos de mercado, cases e NookLead | Revisto para evitar “IA” como entrega; ícone 🤖 substituído por 📐 onde era visual genérico. |

---

## Divergências / lacunas (preencher após transcrição)

| Risco | Detalhe |
|-------|---------|
| Números diferentes do áudio | Comparar R$ 1.621, 364, faixas 200–500, pacotes 300–1.200. |
| Prazo ou fases | Comparar “3–4 meses” e fases da timeline. |
| Promessas não escritas | Se o sócio mencionar algo que não está na página, acrescentar só após validação. |

---

## Alterações aplicadas nesta execução (HTML)

- Ajustes de **redação** para não sugerir **inteligência artificial** como entrega do projeto (ex.: case FIPS, estatística, busca no catálogo, ícone de tendência, texto do popup NookLead).
- **Nenhuma alteração de valores monetários** — isso exige confirmação com o texto dos áudios ou acordo explícito.

---

## Próximo passo

1. Correr `transcrever_local.py` localmente (ou colar transcrições nos `.txt`).
2. Atualizar tabelas deste ficheiro.
3. Se houver divergência em **reais ou prazos**, editar `index.html` e `INV_PLANS` (se existir no teu ficheiro) de forma **pontual** e espelhada.
