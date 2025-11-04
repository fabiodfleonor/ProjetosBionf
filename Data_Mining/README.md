# Processo de Data Mining (CRISP-DM)

O **CRISP-DM** (Cross Industry Standard Process for Data Mining) é a metodologia de referência para o desenvolvimento de projetos de *Data Mining* e *Machine Learning*.  
Assenta num processo iterativo composto por seis fases interdependentes, que permitem compreender o problema, preparar os dados e construir modelos capazes de gerar conhecimento útil.

![CRISP-DM](diagram_CRISP-DM.svg)

---

## 1. Compreensão do Negócio

Nesta fase é essencial identificar claramente o problema e os objetivos do projeto.  
Define-se o propósito da análise, as perguntas de investigação e as métricas de sucesso.  

**Exemplo:** prever o desempenho académico de estudantes a partir de variáveis relacionadas com hábitos de estudo e motivação.

---

## 2. Compreensão dos Dados

Depois de clarificados os objetivos, procede-se à recolha e exploração inicial dos dados.  
Analisa-se a sua origem, estrutura, qualidade e relevância.  
Realizam-se análises descritivas e visualizações que ajudam a compreender tendências, outliers e possíveis relações entre variáveis.

---

## 3. Preparação dos Dados

A preparação constitui uma das etapas mais críticas do processo.  
Inclui a limpeza, transformação e integração dos dados, tratando valores em falta, removendo duplicados e normalizando variáveis.  
Nesta fase são ainda selecionados os atributos mais relevantes para o modelo, assegurando uma base de dados consistente e adequada.

---

## 4. Modelação

Com os dados preparados, são aplicados algoritmos de aprendizagem automática.  
Selecionam-se técnicas apropriadas — como Regressão, K-Nearest Neighbors (KNN), Decision Trees ou K-Means — e ajustam-se parâmetros de forma iterativa.  
Os resultados são validados para garantir a capacidade de generalização dos modelos.

---

## 5. Avaliação

Os modelos obtidos são avaliados de acordo com as métricas definidas na fase inicial.  
Utilizam-se indicadores como R², RMSE, Acurácia, F1-score ou AUC para determinar a qualidade das previsões.  
Se os resultados não forem satisfatórios, é comum regressar às fases anteriores para refinar os dados ou ajustar os modelos.

---

## 6. Implementação

Após a validação, o modelo é aplicado em contexto real.  
Nesta fase, os resultados podem ser comunicados através de relatórios, dashboards ou integração com sistemas existentes.  
É igualmente importante monitorizar o desempenho do modelo ao longo do tempo e proceder a atualizações quando necessário.

---

## Considerações Finais

O CRISP-DM é um processo cíclico e adaptável, o que o torna eficaz em diferentes domínios científicos e industriais.  
Raramente um modelo é finalizado à primeira iteração; a melhoria contínua é uma parte natural do processo.  
Esta metodologia permite garantir que as decisões baseadas em dados são fundamentadas, reprodutíveis e transparentes.
