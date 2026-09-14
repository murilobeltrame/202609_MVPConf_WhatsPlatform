# Roteiro de Palestra sobre Plataformas Digitais Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Produzir um roteiro de 45 minutos, em portugues, sobre plataformas digitais a partir de Amrit Tiwana, conectando teoria, metricas, Azure API Management e integracao com LLMs.

**Architecture:** Criar um documento independente em `docs/` organizado por tempo, objetivo, mensagem central, notas de fala, exemplo e transicao. O roteiro usara o Azure API Management como fio condutor e distinguira conceitos de Tiwana de operacionalizacoes metricas propostas.

**Tech Stack:** Markdown; Mermaid para um diagrama conceitual opcional; referencias bibliograficas e Microsoft Learn.

## Global Constraints

- Duracao total: 45 minutos.
- Publico principal: arquitetos e desenvolvedores, com possivel participacao de business.
- Idioma: portugues.
- Cobrir todas as perguntas do pedido original.
- Nao atribuir a Tiwana uma lista canonica de KPIs que ele nao publicou.
- Usar apenas alteracoes documentais, sem modificar codigo ou infraestrutura.

---

### Task 1: Escrever o roteiro final

**Files:**
- Create: `docs/roteiro-palestra-plataformas-digitais.md`

**Interfaces:**
- Consome: `docs/ecossistema-plataforma-amrit-tiwana.md`, `docs/kpis-tecnicas-observabilidade-apis-azure.md` e os requisitos da palestra.
- Produz: roteiro pronto para ensaio, com distribuicao de tempo, notas de fala, transicoes e referencias.

- [x] **Step 1: Escrever o documento**

Incluir nove blocos: abertura; definicoes de plataforma; posicionamento de Tiwana; composability/plasticity/mutation e metricas relacionadas; comparacao com *Platform Revolution*; Azure API Management; metricas observaveis no APIM; LLMs; consideracoes finais.

- [x] **Step 2: Validar cobertura**

Confirmar que o arquivo contem explicitamente os termos `Composability`, `Plasticity`, `Mutation`, `Azure API Management`, `LLM`, `Platform Revolution`, `Parker`, `Van Alstyne` e `Choudary`, alem de uma distribuicao que some 45 minutos.

- [x] **Step 3: Validar o Markdown**

Executar uma verificacao textual de titulos, referencias, termos obrigatorios e soma dos tempos; revisar manualmente se nao houver ferramenta de lint Markdown disponivel.
