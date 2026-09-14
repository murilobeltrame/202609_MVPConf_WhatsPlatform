---
marp: true
theme: my-default
paginate: true
size: 16:9
title: Plataformas Digitais pela perspectiva de Amrit Tiwana
description: Arquitetura, governança, métricas, Azure API Management e LLMs
---

<!-- _class: lead -->

# Plataformas Digitais

## Pela perspectiva de Amrit Tiwana

### Arquitetura, governança, métricas e evolução

<!--
_notes:
Abra com a pergunta: quando uma equipe publica uma API, ela criou uma plataforma?
Apresente a tese: plataforma não é apenas um componente técnico. É uma base extensível cercada por interfaces, participantes, regras e incentivos.
Duração total: 45 minutos.
-->

---

# A pergunta que organiza a conversa

## Uma API publicada já é uma plataforma?

| Serviço | Produto | Plataforma |
| --- | --- | --- |
| Entrega uma capacidade | Resolve uma necessidade | Permite que outros construam |
| Consumidor conhecido | Proposta de valor definida | Ecossistema em evolução |
| Operação local | Ciclo de produto | Interfaces, regras e incentivos |

<!--
_notes:
Não diga que serviço e produto são inferiores. São objetos diferentes.
A pergunta serve para mostrar que a palavra plataforma muda de significado conforme a lente: infraestrutura, produto, mercado ou ecossistema.
Transição: antes de medir, precisamos definir qual plataforma estamos observando.
-->

---

# Plataforma: vários objetos sob uma palavra

| Lente | Plataforma significa... | Pergunta |
| --- | --- | --- |
| Tecnológica | Base reutilizável com interfaces | O que pode ser construído? |
| Arquitetural | Núcleo estável + módulos variáveis | Onde estão as fronteiras? |
| Produto | Capacidade-base oferecida a consumidores | Que problema recorrente resolve? |
| Mercado | Intermediário entre lados | Como as interações acontecem? |
| Ecossistema | Rede de participantes e regras | Como todos coevoluem? |

<!--
_notes:
Destaque que as definições não são necessariamente contraditórias; elas respondem a perguntas diferentes.
Marketplace não é sinônimo de plataforma. Uma plataforma de APIs pode ter ecossistema sem intermediar uma transação entre comprador e vendedor.
Para business: escala de clientes, sozinha, não prova que exista uma plataforma.
-->

---

# O mapa das definições

<div style="display:grid;grid-template-columns:repeat(3,1fr);gap:14px;text-align:center;font-size:0.78em;margin-top:35px">
<div style="border:3px solid #f5d547;padding:20px"><strong>BASE</strong><br>capacidades<br>dados<br>infraestrutura</div>
<div style="font-size:2.6em;padding-top:25px">-&gt;</div>
<div style="border:3px solid #f5d547;padding:20px"><strong>INTERFACES</strong><br>APIs<br>eventos<br>SDKs</div>
<div style="font-size:2.6em;padding-top:25px">-&gt;</div>
<div style="border:3px solid #f5d547;padding:20px"><strong>COMPLEMENTOS</strong><br>apps<br>integrações<br>serviços</div>
<div style="font-size:2.6em;padding-top:25px">-&gt;</div>
<div style="border:3px solid #f5d547;padding:20px"><strong>VALOR</strong><br>usuários<br>adoção<br>resultado</div>
</div>

<!--
_notes:
Este é o primeiro diagrama. Leia da esquerda para a direita.
Uma API isolada é uma interface. A plataforma surge quando existe uma base, pontos de extensão, participantes que constroem e valor que retorna ao sistema.
A governança atravessa todas as caixas: define quem acessa, como usa e o que pode mudar.
-->

---

# Onde Tiwana se posiciona

## A plataforma é o núcleo; o ecossistema é a unidade de análise

> Uma base tecnológica extensível, com interfaces pelas quais complementos interoperam com o núcleo.

### O ecossistema inclui

- owner ou orquestrador;
- complementadores e seus investimentos;
- usuários e seus resultados;
- interfaces, regras e incentivos;
- ambiente tecnológico, competitivo e regulatório.

<!--
_notes:
Esta é uma síntese operacional da obra de Tiwana, não uma citação literal.
O ponto importante: o owner não controla sozinho todo o valor criado. O ecossistema depende de participantes relativamente autônomos.
-->

---

# A coevolução em Tiwana

<div style="font-family:monospace;font-size:0.88em;line-height:1.9;margin:20px 0">
<div>[ ARQUITETURA ] -&gt; [ GOVERNANÇA ] -&gt; [ COMPLEMENTADORES ]</div>
<div style="padding-left:130px">^                                      |</div>
<div style="padding-left:130px">|                                      v</div>
<div>[ ESTRATÉGIA ] &lt;- [ VALOR E ADOÇÃO ] &lt;- [ USUÁRIOS ]</div>
</div>

### O ambiente pressiona o ciclo

`tecnologia` + `concorrência` + `regulação` + `expectativas`

<!--
_notes:
Segundo diagrama: não é uma cadeia linear. Uma mudança na API afeta complementadores; uma política de cobrança afeta entrada; perda de complementadores afeta valor para usuários.
O diagrama resume o retorno de valor e adoção para a estratégia.
-->

---

# O que a lente torna visível

| Tensão | Pergunta de arquitetura e negócio |
| --- | --- |
| Escala de inovação | O que terceiros podem criar melhor que o núcleo? |
| Coordenação | Como participantes autônomos interoperam? |
| Abertura x controle | O que abrir, para quem e sob quais regras? |
| Evolução sem ruptura | Como mudar sem destruir investimentos? |
| Criação x captura de valor | Por que os parceiros continuariam investindo? |

<!--
_notes:
Use esta tabela como ponte entre o público técnico e business.
Arquitetos tendem a começar por interfaces e confiabilidade. Business tende a começar por incentivos e captura de valor. Tiwana junta as duas perguntas.
-->

---

# Quatro propriedades para observar

| Propriedade | Em uma frase | Sinal prático |
| --- | --- | --- |
| **Composability** | Combinar capacidades sem reescrever o núcleo | APIs oficiais usadas em uma nova solução |
| **Plasticity** | Adaptar a novos contextos sem perder identidade | Tempo para atender um novo caso de uso |
| **Mutation** | Evoluir com mudanças controladas e legíveis | Migração de versão sem ruptura |
| **Governance fit** | Ajustar abertura, controle, risco e incentivo | Regra certa para cada consumidor |

<!--
_notes:
Apresente estas como propriedades de trabalho para a palestra. Não diga que Tiwana publicou um catálogo universal com estes nomes como KPIs.
O valor está na tradução: propriedade conceitual -> pergunta -> evidência operacional.
-->

---

# Composability

## Uma plataforma vale mais quando capacidades podem ser combinadas

```text
[ Identidade ] + [ Pedidos ] + [ Pagamentos ]
								 |
								 v
				  [ Nova experiência de negócio ]
```

### Observar

- tempo para montar uma integração;
- número de capacidades combinadas;
- uso de contratos oficiais;
- taxa de sucesso da composição em produção.

<!--
_notes:
Composability não é contar endpoints. É poder recombinar capacidades de maneira previsível.
Pergunta para a sala: uma equipe precisa conhecer detalhes internos para combinar suas APIs? Se sim, há acoplamento escondido.
-->

---

# Plasticity e Mutation

|  | Plasticity | Mutation |
| --- | --- | --- |
| Ideia | Adaptar a novos contextos | Mudar a própria base |
| Risco | Criar uma cópia para cada caso | Quebrar quem já depende |
| Observar | Tempo para novo caso de uso | Versões, deprecações e migrações |
| Boa pergunta | O que reutilizamos? | O que quebramos? |

<!--
_notes:
Plasticity é adaptação sem perder a identidade da plataforma.
Mutation é evolução: novos contratos, políticas, dependências e capacidades.
Toda plataforma precisa mudar. A qualidade da mutação depende de compatibilidade, documentação, telemetria, reversibilidade e tempo de transição.
-->

---

# Da propriedade ao painel de métricas

<div style="display:grid;grid-template-columns:1fr 1fr;gap:18px;font-size:0.82em">
<div style="border:2px solid #f5d547;padding:14px"><strong>ARQUITETURA</strong><br>sucesso | latência p95/p99<br>mudanças quebradoras<br>adoção de versões</div>
<div style="border:2px solid #f5d547;padding:14px"><strong>ECOSSISTEMA</strong><br>complementadores ativos<br>ativação | retenção<br>diversidade | concentração</div>
<div style="border:2px solid #f5d547;padding:14px"><strong>GOVERNANÇA</strong><br>aprovação | rejeição<br>incidentes | disputas<br>SLA | custo de suporte</div>
<div style="border:2px solid #f5d547;padding:14px"><strong>VALOR</strong><br>adoção | retenção<br>expansão | receita<br>retorno dos parceiros</div>
</div>

> Crescer em cadastros não compensa perder qualidade, autonomia e valor.

<!--
_notes:
Enfatize a atribuição: Tiwana oferece a lente de coevolução; este painel é uma operacionalização proposta para diagnóstico.
Não maximize uma única coluna. Uma plataforma pode crescer em integrações e piorar em robustez.
Use coortes, versões e segmentos; totais acumulados escondem abandono.
-->

---

# Tiwana e *Platform Revolution*

| | Tiwana | Parker, Van Alstyne e Choudary |
| --- | --- | --- |
| Foco | Arquitetura, governança e coevolução | Interações, efeitos de rede e liquidez |
| Unidade | Base + complementos + participantes | Produtores + consumidores |
| Pergunta | Como evoluir sem quebrar o ecossistema? | Como escalar interações valiosas? |
| Risco | Fragmentação, ruptura e perda de parceiros | Baixa liquidez e baixa confiança |
| Métricas | Compatibilidade, saúde e evolução | Participação, conversão e valor por interação |

<!--
_notes:
As lentes se complementam; não apresente como disputa teórica.
Uma plataforma de APIs pode ser importante para Tiwana sem ser um marketplace.
Uma app store ou marketplace evidencia melhor a lente de *Platform Revolution*.
-->

---

# A ponte entre as duas lentes

```text
Composability  ->  novas combinações  ->  novas interações
Plasticity     ->  novos contextos    ->  novos lados e nichos
Mutation       ->  evolução confiável  ->  confiança e liquidez
Retenção       ->  uso recorrente     ->  efeitos de rede
Governança     ->  regras previsíveis  ->  participação sustentável
```

<!--
_notes:
Esta é a síntese: propriedades técnicas habilitam interações; governança torna essas interações confiáveis.
O APIM entra como uma camada que torna contratos, políticas e sinais observáveis.
-->

---

# Azure API Management

## APIM é uma peça da plataforma, não a plataforma inteira

<div style="font-family:monospace;font-size:0.82em;line-height:2.2">
[ Consumidores e complementadores ]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br>
[ Portal ] -&gt; [ APIM: contratos, políticas, produtos ] -&gt; [ Backends ]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;v<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ Monitor | Logs | Traces | Alertas ]
</div>

<!--
_notes:
Terceiro diagrama: APIM é a fronteira governada e observável entre consumidores e capacidades.
Ele ajuda a publicar APIs, organizar produtos e assinaturas, aplicar autenticação, quota, rate limit, transformações, versões e revisões.
Mas a plataforma também inclui backends, dados, identidade, eventos, complementos, experiência e modelo de valor.
-->

---

# O que o APIM ajuda a governar

- **Acesso:** autenticação, autorização, assinaturas e produtos.
- **Consumo:** quotas, rate limits e políticas por consumidor.
- **Contrato:** schemas, versões, revisões e deprecações.
- **Descoberta:** Developer Portal, documentação e testes.
- **Operação:** métricas, logs, traces, alertas e SLOs.
- **Evolução:** migração observável antes de retirar uma versão.

> APIM transforma uma chamada técnica em um contrato governado.

<!--
_notes:
Para arquitetos: APIM centraliza políticas e reduz acoplamento na borda.
Para business: APIs podem ser empacotadas como produtos, com limites, acesso diferenciado e evidência de adoção.
Para todos: o ganho não está em centralizar por centralizar, mas em tornar regras previsíveis.
-->

---

# Quais métricas podem sair da arquitetura?

| Sinal | Métrica | Propriedade relacionada |
| --- | --- | --- |
| Confiabilidade | sucesso, 4xx, 5xx, timeout | Robustez |
| Desempenho | p50, p95, p99 por operação | Interoperabilidade |
| Evolução | versão obsoleta, migração, ruptura | Mutation |
| Entrada | tempo até primeira chamada válida | Plasticity |
| Composição | APIs combinadas por solução | Composability |
| Governança | consumo por produto e consumidor | Governance fit |
| Resiliência | incidentes, MTTR, concentração | Robustez |
| Autonomia | tickets e suporte por integração | Qualidade da interface |

<!--
_notes:
Fontes: APIM e Azure Monitor para métricas; diagnostic logs e Log Analytics para contexto; Application Insights e OpenTelemetry para traces ponta a ponta; Versions and Revisions para evolução; Workbooks para cruzamento.
Não confunda métricas disponíveis no gateway com valor final de negócio. O gateway observa condições e sinais; a tarefa concluída e a retenção completam a leitura.
-->

---

# Um exemplo de leitura do painel

## Crescimento pode esconder fragilidade

<div style="display:grid;grid-template-columns:1fr 1fr;gap:22px">
<div style="border:3px solid #f5d547;padding:18px">
<strong>Indicador isolado</strong><br><br>
Integrações: <strong>+40%</strong><br>
Conclusão: “a plataforma cresceu”
</div>
<div style="border:3px solid #f5d547;padding:18px">
<strong>Painel balanceado</strong><br><br>
Latência p99: <strong>+100%</strong><br>
Versão obsoleta: <strong>+25%</strong><br>
Suporte por integração: <strong>+30%</strong>
</div>
</div>

### Diagnóstico

**Entrada melhorou; robustez, evolução e autonomia pioraram.**

<!--
_notes:
Este exemplo torna concreto o argumento de Tiwana.
Uma decisão de abrir mais a plataforma pode aumentar entrada e variedade, mas também elevar custo de suporte ou instabilidade.
A pergunta não é “qual número venceu?”. É “qual trade-off aconteceu e qual decisão tomaremos?”.
-->

---

# A equação de primeiro valor

> **Ativação técnica** = integrações que atingem o primeiro evento de valor sobre integrações que iniciaram onboarding

### Defina o evento de valor

- primeira chamada de produção bem-sucedida;
- primeiro fluxo completo;
- primeiro usuário atendido;
- primeira transação ou tarefa concluída.

<!--
_notes:
O denominador não deve ser “todos os que se cadastraram” se o cadastro não representa intenção real.
Use mediana para tempo até primeiro valor e segmente por parceiro, API, versão e tipo de consumidor.
Combine telemetria com entrevistas: dados mostram o que aconteceu; parceiros ajudam a explicar por quê.
-->

---

# O que muda com LLMs?

<div style="font-family:monospace;font-size:0.83em;line-height:2.2">
[ Aplicação ou agente ] -&gt; [ APIM: auth, quota, roteamento ]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;v<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ Modelos ] + [ Ferramentas ]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;v<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ Avaliação: qualidade, custo, segurança ]
</div>

<!--
_notes:
Quarto diagrama: o gateway continua importante, mas agora governa uma capacidade probabilística e suas ferramentas.
O schema pode permanecer igual enquanto o comportamento muda por modelo, prompt, contexto ou ferramenta.
-->

---

# APIs tradicionais x LLMs

| Dimensão | API tradicional | Integração com LLM |
| --- | --- | --- |
| Resultado | Geralmente determinístico | Probabilístico e contextual |
| Custo | Chamada e infraestrutura | Tokens, modelo e ferramentas |
| Qualidade | Status, schema e regras | Relevância, grounding e consistência |
| Evolução | Versão de contrato | Modelo, prompt, contexto e política |
| Risco | Abuso e indisponibilidade | Injection, vazamento e alucinação |

### Novos sinais

`custo por tarefa` | `tokens` | `tempo até primeiro token` | `fallback` | `qualidade` | `segurança`

<!--
_notes:
LLM não substitui a API. Ele se torna uma capacidade dentro de uma plataforma de APIs, dados e ferramentas.
Composability fica mais poderosa, porque combinamos modelo, busca, ferramentas e regras. Mutation fica mais delicada, porque mudanças comportamentais podem ocorrer sem mudar o schema.
-->

---

# O painel de uma plataforma de LLM

<div style="display:grid;grid-template-columns:repeat(3,1fr);gap:14px;text-align:center;font-size:0.78em">
<div style="border:2px solid #f5d547;padding:16px"><strong>TÉCNICO</strong><br>latência<br>erro<br>disponibilidade</div>
<div style="border:2px solid #f5d547;padding:16px"><strong>ECONÔMICO</strong><br>tokens<br>custo por tarefa<br>concentração de provedor</div>
<div style="border:2px solid #f5d547;padding:16px"><strong>COMPORTAMENTAL</strong><br>qualidade<br>grounding<br>segurança e policy</div>
</div>

> A resposta só tem valor quando é útil, segura, explicável o suficiente e economicamente sustentável.

<!--
_notes:
Não prometa uma métrica única de “qualidade do LLM”. Use conjuntos de avaliação por caso de uso e acompanhe regressão ao trocar modelo, prompt ou ferramenta.
Conecte o argumento de LLM ao de Tiwana: o ecossistema agora coevolui em torno de capacidades probabilísticas.
-->

---

<!-- _class: lead -->

# Três ideias para levar

1. **Plataforma não é um componente isolado.**
   Base + interfaces + participantes + regras + incentivos.
2. **Métricas precisam acompanhar o sistema.**
   Crescimento não compensa perda de robustez, evolução e valor.
3. **APIM e LLMs ampliam a responsabilidade arquitetural.**
   Governar a borda é governar contratos, custo, risco e capacidade de evolução.

### Pergunta final

**Na plataforma que você está construindo, o que está faltando hoje: composability, plasticity, mutation ou governança?**

<!--
_notes:
Feche retomando a pergunta inicial.
Uma plataforma saudável permite que outros construam sobre ela sem transformar cada consumidor em uma exceção operacional.
Deixe a pergunta final aberta para iniciar a conversa com a audiência.
-->

---

# Referências

- Tiwana, Amrit. *Platform Ecosystems: Aligning Architecture, Governance, and Strategy*. 2014.
- Tiwana, Konsynski e Bush. *Platform Evolution: Coevolution of Platform Architecture, Governance, and Environmental Dynamics*. 2010.
- Parker, Van Alstyne e Choudary. *Platform Revolution*. 2016.
- Iansiti e Levien. *The Keystone Advantage*. 2004.
- [Azure API Management](https://learn.microsoft.com/azure/api-management/)
- [Observability in Azure API Management](https://learn.microsoft.com/azure/api-management/observability)
- [Azure Monitor data platform](https://learn.microsoft.com/azure/azure-monitor/fundamentals/data-platform)

<!--
_notes:
Este slide pode permanecer no deck ou ser ocultado na apresentação ao vivo, dependendo do tempo.
Os links são fontes de consulta; não é necessário lê-los durante a palestra.
-->