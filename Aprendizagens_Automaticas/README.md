# Projetos de Aprendizagem Automática (2024/2025)

## Introdução
Este repositório reúne dois projetos desenvolvidos no âmbito da unidade curricular **Aprendizagem Automática**, do curso de **Licenciatura em Bioinformática** no Instituto Politécnico de Setúbal.

Os trabalhos abordam diferentes tipos de aprendizagem:
- **Supervisionada:** KNN, Regressão Linear e Regressão Logística.
- **Não supervisionada:** K-Means e análise de Silhueta.

O objetivo global foi aplicar técnicas de *machine learning* para classificação, regressão e agrupamento, interpretando os resultados e avaliando o desempenho dos modelos.

---

## Projeto 1 — KNN, K-Means e Coeficiente de Silhueta

### Objetivos
- Implementar o algoritmo **KNN (K-Nearest Neighbors)**.
- Aplicar o algoritmo **K-Means**.
- Calcular e interpretar o **coeficiente de Silhueta**.
- Compreender o impacto da normalização e da escolha dos centróides.

### Descrição
O projeto foi dividido em duas partes:
- **Parte 1:** Aplicação do KNN com distância de Manhattan para classificar novos exemplos.
- **Parte 2:** Implementação do K-Means e cálculo do coeficiente de Silhueta, avaliando a qualidade dos clusters formados.

### Resultados
- O KNN (k=3) classificou corretamente novos exemplos.
- O K-Means criou dois clusters bem definidos.
- O coeficiente de Silhueta médio (~0.83) indicou uma boa separação entre grupos.
- A escolha inicial dos centróides afetou o número de iterações e a convergência.

### Ficheiros
| Ficheiro | Descrição |
|-----------|------------|
| `Projeto2_AA.py` | Código principal em Python com KNN, K-Means e Silhueta |
| `Parte_1.pdf` | Relatório da primeira parte (KNN) |
| `Parte_2.pdf` | Relatório da segunda parte (K-Means e Silhueta) |

---

## Projeto 2 — Previsão do Desempenho Escolar

### Objetivos
- Desenvolver modelos para prever o desempenho académico de estudantes.
- Comparar **Regressão Linear** e **Regressão Logística**.
- Analisar variáveis com maior impacto no sucesso escolar.

### Fonte de Dados
- **Dataset:** Student Performance (UCI Machine Learning Repository)
- **Amostras:** 649 estudantes
- **Variável alvo:** Nota final (`G3`, escala 0–20)

### Metodologia
- **Pré-processamento:** remoção de ruído, normalização e codificação one-hot.  
- **Modelos aplicados:**
  - Regressão Linear — previsão de `G3` (valor contínuo).
  - Regressão Logística — classificação binária (Aprovado/Reprovado).
- **Métricas de avaliação:** R², Acurácia e Matriz de Confusão.

### Resultados
- As variáveis `G1` e `G2` foram os principais preditores do desempenho final.
- A Regressão Linear mostrou boa correspondência entre valores reais e previstos.
- A Regressão Logística obteve **84% de acurácia**, com erros sobretudo em casos-limite.
- Conclui-se que o sucesso escolar é influenciado por fatores de estudo, motivação e assiduidade.

### Ficheiros
| Ficheiro | Descrição |
|-----------|------------|
| `AA.ipynb` | Notebook com código e análise completa |
| `AA Project Apresentation.pdf` | Apresentação final dos resultados |

---

## Tecnologias Utilizadas
- **Linguagem:** Python 3  
- **Bibliotecas:** numpy, pandas, matplotlib, seaborn, scikit-learn  

---

## Autores
Fábio Leonor (202200269)  
Maria Eduarda Oliveira (202200600)  
Sara Sampaio (202200639)  

---

Instituto Politécnico de Setúbal — 2024/2025  
Licenciatura em Bioinformática  
Unidade Curricular: Aprendizagem Automática
