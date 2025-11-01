


############ Análise Descritiva Univariada ##############


#Anos de escolaridade

if(!require(rstatix)) install.packages("rstatix")
library(rstatix)
if(!require(dplyr)) install.packages("dplyr")
library(dplyr)
descritivas=ESS10_BG_2_ %>% 
  get_summary_stats(P35_eduyrs, type="full",
                    show=c("n", "min", "max", "q1", "median", "q3"))
descritivas

#No combate a uma pandemia, é mais importante para si seguir as regras estabelecidas pelo governo ou tomar as suas próprias decisões?

descritivas_1=ESS10_BG_2_ %>% 
  get_summary_stats(P49_panfolru, type="full",
                    show=c("n", "min", "max", "q1", "median", "q3"))
descritivas_1

#Tipo de Residência 

descritivas_2=ESS10_BG_2_ %>% 
  get_summary_stats(P34_domicil, type="full",
                    show=c("n", "min", "max", "q1", "median", "q3"))
descritivas_2

#Idade 
if(!require(rstatix)) install.packages("rstatix")
library(rstatix)
if(!require(dplyr)) install.packages("dplyr")
library(dplyr)
descritivas_3=ESS10_BG_2_ %>% 
  get_summary_stats(P32_agea, type="full",
                    show=c("n", "min", "max", "q1", "median", "q3", "mean", "sd"))
descritivas_3

#### Variável Sexo

## Qualitativa Nominal
# 1- Feminino
# 2- Masculino
ESS10_BG_2_$P31_gndr <- factor(ESS10_BG_2_$P31_gndr, 
                          levels = c(1, 2), 
                          labels = c("Masculino", "Feminino"))

Mode=function(x)
{
  ux=unique(x)
  ux[which.max(tabulate(match(x,ux)))]
}
Mode(ESS10_BG_2_$P31_gndr) #Feminino


#### Variável Interesse pela política

## Quantitativa 

if(!require(rstatix)) install.packages("rstatix")
library(rstatix)

if(!require(dplyr)) install.packages("dplyr")
library(dplyr)

descritivas_4= ESS10_BG_2_ %>% 
  get_summary_stats(P7_polintr , type="full",
                    show=c("n", "min", "max", "q1", "median", "q3"))
descritivas_4


########################## Tabela de Contigência #################################

## Questão de investigação
#   Será que a decisão de seguir as regras do governo ou não, tem a ver com o sexo do individuo?

tabelacontingencia=table(ESS10_BG_2_$P31_gndr,
                         ESS10_BG_2_$P49_panfolru)
tabelacontingencia

######################## Coeficiente de Correlação ################################

#correlaçao de Spearman
### Idade e P46
##  Questão de investigação 
#   Será que a idade influencia a comunição através da internet ou de redes móveis com as pessoas com quem se trabalha tornando mais fácil trabalhar a partir de casa ou de outro local à escolha?   

cor(ESS10_BG_2_$P32_agea, ESS10_BG_2_$P46_mcwrkhom,method="spearman", use = "pairwise")

#### correlaçao de cramer
if(!require(rcompanion)) install.packages("rcompanion") 
library(rcompanion)
tabela=table(ESS10_BG_2_$P31_gndr,ESS10_BG_2_$P34_domicil) 
cramerV(tabela)
boxplot(ESS10_BG_2_$P49_panfolru)

boxplot(ESS10_BG_2_$P51_panresmo~ESS10_BG_2_$P31_gndr)



########## Análise do Estudo inferencial ################################

### Tabela de Contingência #######
tabelacontingencia_agrupada <- table(ESS10_BG_2_$P43_wrkhome_agrupado, ESS10_BG_2_$P44_wrklong_agrupado)
tabelacontingencia_agrupada

####### Teste Qui-Quadrado###########
quiqua2_agrupado <- chisq.test(tabelacontingencia_agrupada)

quiqua2_agrupado

round(quiqua2_agrupado$expected,3)


####Teste de hipóteses para diferença de médias, com recurso ao teste de WilcoxonMann-Whitney ###

if(!require(rstatix)) install.packages("rstatix")
library(rstatix)
if(!require(dplyr)) install.packages("dplyr")
library(dplyr)
descritivas_7 = ESS10_BG_2_ %>%
  group_by(P31_gndr) %>%
  get_summary_stats(P44_wrklong, type = "full",
                    show=c("n", "min", "max", "q1", "median", "q3"))
descritivas_7

if(!require("pander")) install.packages('pander')
library(pander)
descritivas_7 %>% pander(.,split.table=inf)

boxplot(ESS10_BG_2_$P44_wrklong~ESS10_BG_2_$P31_gndr)

wilcox.test(P44_wrklong~P31_gndr, data = ESS10_BG_2_, mu=0,
            alternative= "two.sided", cooorrect="True")

######Teste de comparação de proporção populacional###############

# Carregar a biblioteca necessária
library(dplyr)
library(haven)

# Contagem de homens e mulheres que responderam "todos os dias"
total_homens_todos_dias <- nrow(filter(ESS10_BG_2_, P44_wrklong == 1 & P31_gndr == 1))
total_mulheres_todos_dias <- nrow(filter(ESS10_BG_2_, P44_wrklong == 1 & P31_gndr == 2))

# Tamanhos totais das amostras para homens e mulheres
total_homens_geral <- sum(ESS10_BG_2_$P31_gndr == 1)
total_mulheres_geral <- sum(ESS10_BG_2_$P31_gndr == 2)

# Teste de hipótese para comparação de proporções entre homens e mulheres
resultado <- prop.test(
  x = c(total_homens_todos_dias, total_mulheres_todos_dias),
  n = c(total_homens_geral, total_mulheres_geral),
  conf.level = 0.95,
  alternative = "greater",
  correct = FALSE)
print(resultado)

#################################################################################################################
#################### Teste de Hipótese para a diferença de Medianas #############################################
#################################################################################################################


if(!require(rstatix)) install.packages("rstatix")
library(rstatix)

if(!require(dplyr)) install.packages("dplyr")
library(dplyr)

descritivas= ESS10_BG_2_ %>% 
  group_by(P31_gndr)%>%
  get_summary_stats(P42_stfmjob , type="full",
                    show=c("n", "min", "max", "q1", "median", "q3"))
descritivas

if(!require("pander")) install.packages('pander')
library(rstatix)
descritivas %>% pander(.,split.table=Inf)


boxplot(ESS10_BG_2_$P42_stfmjob~ESS10_BG_2_$P31_gndr)

wilcox.test(P42_stfmjob ~ P31_gndr, data = ESS10_BG_2_, mu = 0,
            alternative = "two.sided",correct="True")

######################Teste inferacial de amostras independentes#########



######Questão 5##########################



if (!require(nortest)) install.packages("nortest")
library(nortest)          # Para o teste de Kolmogorov-Smirnov (Lilliefors)
# Filtrar dados
dados_filtrados <- ESS10_BG_1_[!is.na(ESS10_BG_1_$P47_govpriph) &
                                 !is.na(ESS10_BG_1_$P34_domicil), ]

# Converter P34_domicil para um formato legível
library(haven)  
dados_filtrados$P34_domicil <- as.character(as_factor(dados_filtrados$P34_domicil))
# Contar o número de observações por grupo em P34_domicil
contagem_grupos <- table(dados_filtrados$P34_domicil)
# Manter apenas os grupos com 5 ou mais observações
grupos_validos <- names(contagem_grupos[contagem_grupos >= 5])
dados_filtrados <- dados_filtrados[dados_filtrados$P34_domicil %in% grupos_validos, ]
# Verificar estrutura dos dados filtrados
str(dados_filtrados)

# Teste de normalidade Kolmogorov-Smirnov com correção Lilliefors
resultado_lillie <- by(dados_filtrados$P47_govpriph, 
                       dados_filtrados$P34_domicil, 
                       function(x) lillie.test(x))
print(resultado_lillie)

library(car)
leveneTest(P47_govpriph ~ P34_domicil, data = dados_filtrados)
#Tem distribuição normal mas não é homogênea, não dá para fazer a anova oneway

# Teste de Kruskal-Wallis
kruskal.test(P47_govpriph ~ P34_domicil,ESS10_BG_1_)

####Questão 6########

library(haven)     # Para importar arquivos .sav
library(ggplot2)   # Para visualização de dados
library(dplyr)     # Para manipulação de dados
library(car)       # Para testes como ANOVA
if(!require("psych"))install.packages("psych")
library(psych)     # Para análise descritiva



Atdm <- Atdm[!is.na(Atdm$Idade) & !is.na(Atdm$Satisfacao_Cat), ]

# Verificar as variáveis
str(ESS10_BG_2_)
summary(ESS10_BG_2_)

# Selecionar as variáveis de interesse (idade e grau de satisfação)
Atdm <- ESS10_BG_2_ %>%
  select(Idade =P32_agea, Satisfacao = P52_gvhanc19)


# Transformar a variável de satisfação em categórica ( baixo, médio, alto)
Atdm <- Atdm %>%
  mutate(Satisfacao_Cat = cut(Satisfacao, 
                              breaks = c(0, 3, 7, 10),
                              labels = c("Baixo", "Médio", "Alto"),
                              include.lowest = TRUE))
# Estatistica
summary(Atdm)

if(!require(nortest)) install.packages("nortest") 
library(nortest)    # Carregamento do pacote
by(Atdm$Idade, Atdm$Satisfacao_Cat, function(x) lillie.test(x))


# Realizar o teste de Kruskal-Wallis
kruskal_result <- kruskal.test(Idade ~ Satisfacao_Cat, data = Atdm)
kruskal_result
# Se p-value <= 0.05, rejeitamos a hipótese nula (H0) de que as distribuições são iguais.
# Há evidências de diferenças entre as categorias de Satisfação.



if(!require(dunn.test))install.packages("dunn.test")
library(dunn.test)
Atdm$Idade <- as.numeric(Atdm$Idade)
Atdm$Satisfacao_Cat <- as.factor(Atdm$Satisfacao_Cat)
# Executar o teste de Dunn
dunn_test <- dunn.test(x = Atdm$Idade, g = Atdm$Satisfacao_Cat, method = "bonferroni")
dunn_test


#Para um nível de significância de 5%, pode-se considerar que existem diferenças significativas 
#no nivel de satisfaçao das pessoas
boxplot(Idade ~ Satisfacao_Cat, data = Atdm, main = "Distribuição de Idade por Categoria de Satisfação",
        xlab = "Satisfação", ylab = "Idade", col="lightblue")


# Interpretação:
# Se p-value <= 0.05, rejeitamos a hipótese nula (H0) de que as distribuições são iguais.
# Há evidências de diferenças entre as categorias de Satisfação.


############# Regressão Linear Múltipla ###########################

##### dummy #################

ATMD <- ESS10_BG_2_ %>%
  mutate(
    dummy_37_cat2 = ifelse(P37_wrkctra == 2, 1, 0),  # Categoria 2
    dummy_37_cat3 = ifelse(P37_wrkctra == 3, 1, 0)   # Categoria 3
  ) %>%
  filter(!is.na(P39_wkhtot) & !is.na(P37_wrkctra))  

# Visualizar o resultado
head(ATMD)

# Definir a variável dependente (P39)
y <- ATMD$P39_wkhtot

# Construir a matriz de variáveis independentes 
X <- cbind(1, ATMD$dummy_37_cat2, ATMD$dummy_37_cat3) 


# Ajustar o modelo de regressão linear usando a função lm() para análise completa
modelo <- lm(P39_wkhtot ~ dummy_37_cat2 + dummy_37_cat3, data = ATMD)
modelo

# Resumo do modelo ajustado
cat("\nResumo do modelo ajustado:\n")
summary(modelo)



######### dummy #############################

if (!require("ggplot2")) install.packages('ggplot2')
if (!require("GGally")) install.packages('GGally')
library(ggplot2)
library(GGally)
library(haven)  # Para lidar com objetos haven_labelled

# Converter a variável dependente Horas de trabalho para ser numérico
ESS10_BG_2_$P39_wkhtot <- as.numeric(zap_labels(ESS10_BG_2_$P39_wkhtot))

# Remover valores inválidos (666, 777, 888, 999)
ESS10_BG_2_ <- ESS10_BG_2_[!(ESS10_BG_2_$P39_wkhtot %in% c(666, 777, 888, 999)), ]

# Criação da variável Dummy para "Masculino"
ESS10_BG_2_$Dummy <- ifelse(ESS10_BG_2_$P31_gndr == "Masculino", 1, 0)

# Criar um novo data frame com as variáveis de interesse
DadosRM <- data.frame(Masculino = ESS10_BG_2_$Dummy,
                      Horas_trabalho = ESS10_BG_2_$P39_wkhtot)

# Filtrar linhas com valores NA (caso existam)
dados_filtrados <- DadosRM[!is.na(DadosRM$Masculino) 
                           & !is.na(DadosRM$Horas_trabalho), ]


## Representação gráfica
colvec <- ifelse(ESS10_BG_2_$P31_gndr == "Masculino", "blue", "deeppink")
plot(ESS10_BG_2_$P39_wkhtot ~ ESS10_BG_2_$P31_gndr, col = colvec, pch = 19,
     xlab = "Sexo", ylab = "Horas de Trabalho")
legend("topright", legend = c("Masculino", "Feminino"),
       fill = c("blue", "deeppink"), cex = 0.8)

## Construir Modelo de RLM 
modelo_2 <- lm(Horas_trabalho ~ Masculino, data = DadosRM)
summary(modelo_2)




#################### Análise Fatorial #############################

library(psych)
library(haven)
if (!require(GPArotation))install.packages("GPArotation")
library(GPArotation)
if(!require(corrplot)) install.packages("corrplot")
library(corrplot)
library(haven)     # Para importar arquivos .sav
library(ggplot2)   # Para visualização de ATMD
library(dplyr)     # Para manipulação de ATMD
library(car)       # Para testes como ANOVA
if(!require("psych"))install.packages("psych")
library(psych)     # Para análise descritiva


# Seleção de variáveis
delay <- ESS10_BG_2_ %>% 
  select(P9_1_trstprl, P9_2_trstlgl, P9_3_trstplc, 
         P9_4_trstplt, P9_5_trstprt, P9_6_trstep, 
         P9_7_trstun, P9_8_trstsci,P13_stflife,P14_stfeco,
         P15_stfgov,P16_stfdem,P17_stfedu,P18_stfhlth)
delayy <- na.omit(delay)

# Matriz de correlação de Spearman
correlation_spearman <- cor(delayy, method = "spearman", use = "pairwise.complete.obs")
correlation_spearman

## Representacao grafica da matriz de correlacao
corrplot(correlation_spearman,
         sig.level=0.05,method="number",type="lower")

# Teste de esfericidade de Bartlett
cortest.bartlett(correlation_spearman, n = nrow(delayy))

# 2. Verificação de adequabilidade para AFE
correlation_spearman <- cor(delayy)
correlation_spearman

# Medida de Kaiser-Meyer-Olkin (KMO)
kmo_result <- KMO(correlation_spearman)
kmo_result

#########
##                        Solução Inicial                          ##
#####################################################################
# Padronizar os dados
St_dados <- scale(delayy)
St_dados

# Estimação dos loadings com Método das Componentes Principais
fit <- princomp(St_dados, cor = TRUE)
fit
summary(fit)

# Screeplot
screeplot(fit, main = "Scree Plot")
plot(fit, type = "lines", main = "Scree Plot - Linhas")

#####################################################################
##              Solução com Número de Fatores Definido             ##
#####################################################################
# Supondo que queremos uma solução com 3 fatores
# Solução sem rotação
fit1 <- principal(St_dados, 
                  nfactors = 3,         # Número de fatores
                  n.obs = nrow(delayy), 
                  rotate = "none",      # Sem rotação
                  scores = TRUE)
fit1

# Solução com rotação Varimax
fit1_rot <- principal(St_dados, 
                      nfactors = 3, 
                      n.obs = nrow(delayy), 
                      rotate = "varimax", # Rotação varimax
                      scores = TRUE)
fit1_rot

## Visualizacao grafica do Modelo de AF e das suas cargas fatoriais
fa.diagram(fit1_rot)

install.packages("umx")
library(umx)
head(delayy)
Fator<-data.matrix(delayy[,c(4,5,1,2,11)])
head(Fator)
reliability(cov(Fator))

Fator2<-data.matrix(delayy[,c(14,13,12,10,9)])
head(Fator2)
reliability(cov(Fator2))

Fator2_13<-data.matrix(delayy[,c(14,13,12,10)])
head(Fator2_13)
reliability(cov(Fator2_13))

Fator3<-data.matrix(delayy[,c(7,8,6,3)])
head(Fator3)
reliability(cov(Fator3))
