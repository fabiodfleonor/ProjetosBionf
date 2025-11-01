# Projeto em R — Introdução à Estatística

Este projeto foi desenvolvido no âmbito da unidade curricular **Introdução à Estatística**, aplicando métodos de análise descritiva e inferencial em R sobre um conjunto de dados de estudantes.  

O objetivo principal foi compreender padrões e relações entre variáveis como idade, sexo, curso, horas de estudo, tempo de deslocação e outras, recorrendo a técnicas estatísticas e gráficas.

## Objetivos
- Limpar e preparar o conjunto de dados
- Aplicar medidas de tendência central e dispersão
- Representar dados graficamente (barras, pizza, boxplots)
- Analisar relações entre variáveis quantitativas e qualitativas
- Aplicar regressão linear simples e correlações

## Estrutura do código
O script `Fgrupo2.R` contém:
1. **Limpeza de dados:** remoção de valores inválidos e codificação de variáveis fatoriais (Sexo, Curso, etc.)  
2. **Análise univariada:** medidas descritivas e representações gráficas  
3. **Análise bivariada:** tabelas de contingência e correlações (Pearson e Spearman)  
4. **Modelos de regressão linear:** relação entre variáveis como tempo de deslocação e horas de estudo, e entre horas de TV e horas de sono.  

## Principais bibliotecas utilizadas
- `ggplot2` — visualização de dados  
- `dplyr` — manipulação de dados  
- `pander` — formatação de tabelas  
- `rstatix` — estatística descritiva  
- `clipr` — exportação de resultados  

## Como executar
1. Abrir o ficheiro `Fgrupo2.R` no **RStudio**.  
2. Garantir que o dataset `Grupo2` está carregado no ambiente de trabalho.  
3. Executar o script por secções para visualizar as análises e gráficos.  

## Autores
Bernardo Coutinho — 202200564  
Fábio Leonor — 202200269  
Francisco Silva — 202200631  
Mariana Raposo — 202200642  

---

**Instituto Politécnico de Setúbal — 2023/2024**  
Licenciatura em Bioinformática  
Unidade Curricular: Introdução à Estatística  
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Projeto em R — Análise e Tratamento de Dados Multivariados

Este projeto foi desenvolvido no âmbito da unidade curricular **Análise e Tratamento de Dados Multivariados**, com o objetivo de aplicar métodos estatísticos avançados na exploração de dados provenientes do inquérito europeu **European Social Survey (ESS)**.

O ficheiro de dados utilizado é `ESS10_BG.sav`, processado e analisado em R.

## Objetivos
- Realizar uma análise descritiva univariada e bivariada das variáveis selecionadas  
- Explorar relações entre variáveis através de testes de correlação e hipóteses  
- Aplicar testes não paramétricos (Qui-quadrado, Wilcoxon, Kruskal-Wallis, Dunn)  
- Construir modelos de regressão linear simples e múltipla  
- Implementar uma análise fatorial exploratória (AFE) para identificar estruturas latentes  

## Estrutura do código
O script `Script001.R` inclui:
1. **Análise Descritiva:** estatísticas resumo (mínimo, máximo, quartis, média, desvio padrão).  
2. **Testes de Associação:** Qui-quadrado, Cramér’s V e correlação de Spearman.  
3. **Testes de Hipóteses:** Wilcoxon-Mann-Whitney, comparação de proporções, Kruskal-Wallis e Dunn.  
4. **Regressão Linear Múltipla:** uso de variáveis dummy e interpretação de coeficientes.  
5. **Análise Fatorial Exploratória:** avaliação de KMO, teste de Bartlett, scree plot e rotação Varimax.

## Principais bibliotecas utilizadas
- `dplyr`, `rstatix`, `pander` — análise descritiva e tabelas  
- `rcompanion`, `car` — testes de associação e homogeneidade  
- `psych`, `GPArotation`, `corrplot`, `umx` — análise fatorial  
- `ggplot2`, `GGally` — visualização gráfica  
- `nortest`, `dunn.test` — testes de normalidade e comparações múltiplas  

## Dataset
O projeto utiliza os dados **European Social Survey — Ronda 10 (Bulgária)**, armazenados no ficheiro `ESS10_BG.sav`.  
> **Nota:** o dataset não é incluído no repositório por questões de tamanho e direitos de uso.

## Como executar
1. Abrir o ficheiro `Script001.R` no **RStudio**.  
2. Carregar o ficheiro `ESS10_BG.sav` com o pacote `haven`.  
3. Executar o script secção a secção para visualizar resultados e gráficos.  
 

---

**Instituto Politécnico de Setúbal — 2024/2025**  
Licenciatura em Bioinformática  
Unidade Curricular: Análise e Tratamento de Dados Multivariados

