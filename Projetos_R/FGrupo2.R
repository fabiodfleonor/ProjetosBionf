# Bernardo Coutinho 202200564
# Fabio Leonor 202200269
# Francisco Siva 202200631
# Mariana Raposo 202200642



mean(Grupo2$Idade)
summary(Grupo2$Idade)

summary(Grupo2$HorasRedes)

###### Limpeza de Grupo2
summary(Grupo2)

###### HorasRedes
sort(Grupo2$HorasRedes)
for(i in 1:nrow(Grupo2))
  if(!(is.na(Grupo2$HorasRedes[i])) & Grupo2$HorasRedes[i]<24){
    Grupo2$HorasRedes[i] = Grupo2$HorasRedes[i]
  } else {
    Grupo2$HorasRedes[i] = NA
  }

###### HorasEstudo
sort(Grupo2$HorasEstudo)
for(i in 1:nrow(Grupo2))
  if(!(is.na(Grupo2$HorasEstudo[i])) & Grupo2$HorasEstudo[i]<24){
    Grupo2$HorasEstudo[i] = Grupo2$HorasEstudo[i]
  } else {
    Grupo2$HorasEstudo[i] = NA
  }

##### HorasTV
sort(Grupo2$HorasTV)
for(i in 1:nrow(Grupo2))
  if(!(is.na(Grupo2$HorasTV[i])) & Grupo2$HorasTV[i]<24){
    Grupo2$HorasTV[i] = Grupo2$HorasTV[i]
  } else {
    Grupo2$HorasTV[i] = NA
  }

##### HorasSono
sort(Grupo2$HorasSono)
for(i in 1:nrow(Grupo2))
  if(!(is.na(Grupo2$HorasSono[i])) & Grupo2$HorasSono[i]<24){
    Grupo2$HorasSono[i] = Grupo2$HorasSono[i]
  } else {
    Grupo2$HorasSono[i] = NA
  }

# Para os resultados aparecerem em forma tabela (library(pander))
if(!require("pander")) install.packages('pander')
library(pander)
if(!require(rstatix)) install.packages("rstatix")
library(rstatix)

if(!require("ggplot2")) install.packages('ggplot2')
library(ggplot2)

###############Codificar Variaveis###############
#####Variavel Sexo
Grupo2$Sexo <- factor(Grupo2$Sexo,
                      label=c("Feminino","Masculino"),
                      levels=c(1,2))

####Variavel Opcao1
Grupo2$opcao1 <- factor(Grupo2$opcao1,
                        label=c("Sim","Não"),
                        levels=c(1,2))

####Variavel Escolhi
Grupo2$Escolhi <- factor(Grupo2$Escolhi,
                         label=c("Sim","Não"),
                         levels=c(1,2))

####Variavel PMentoria
Grupo2$PMentoria <- factor(Grupo2$PMentoria,
                           label=c("Sim","Não"),
                           levels=c(1,2))

########## Analise descritiva univariada ##########

###### Variavel Idade
mean(Grupo2$Idade,na.rm = TRUE)
min(Grupo2$Idade, na.rm = TRUE)

Idade = summary(Grupo2$Idade)
pandoc.table(Idade,plain.ascii = TRUE,
             caption = "Tabela com a analise univariada da ver Idade")

#### De todos os estudantes 1 nao disse a sua idade , sendo a media de idades 20,39
taable=table(Grupo2$Idade)
barplot(prop.table(table(Grupo2$Idade))*100,
        main= "Grafico de barras para a variavel 'Idade'", #--Grafico de barras da variavel Idade
        col = c("purple","yellow"),
        cex.main=1,
        xlab='Idade',
        ylab="Percentagem (%)",
        ylim = c(0,100))

boxplot(Grupo2$Idade,na.rm=TRUE,
        main="Diagrama dos extremos e quartis da idade",
        cex.main=1,
        ylab="Diferencial das idades ",cex.lab=0.7,
        horizontal=TRUE)

##### Variavel Sexo

absol_sexo = table(Grupo2$Sexo)
relat_sexo = round(prop.table(absol_sexo),4)

pie(relat_sexo, labels = paste0(relat_sexo *100, "%"),cex=0.7,
    main="Grafico da variavel 'Sexo'",cex.main=1, #-- Grafico circular da variavel Sexo
    col=c("deeppink", "blue"))
legend("topright", legend = c("Feminino", "Masculino"),
       fill =  c("deeppink", "blue"),
       cex=0.7)

absol_sexo
relat_sexo
##### Com analise do grafico podemos ver que maior parte alunos sao so sexo Masculino

###### Variavel Curso 
taable<-table(Grupo2$Curso)
barplot(prop.table(table(Grupo2$Curso))*100,
        main= "Grafico de barras da distribuição dos alunos pelos cursos", #-- Grafico de barras da variavel Curso
        col = c("red","green","orange"),
        cex.main=1,
        xlab='Curso',
        ylab="Percentagem (%)",
        ylim = c(0,100))

relat<-round(prop.table(table(Grupo2$Curso)),3) 
pie(relat, labels = paste0(relat*100, "%"),cex=1.2,
    main = "Grafico circular para a variavel 'Curso'", cex.main=1, #--Grafico circular da variavel Curso
    col = c("red","green","orange"))
legend("bottomright", c("CTeSP TLQB","L.Bioinformatica","L.Biotecnologia"),
       fill = c("red","green","orange"),
       cex=0.8)

#### com a analise de ambos os graficos percebemos que há mais alunos em L.Biotecnologia e menos em CTeSP TLQB, mas dois alunos nao responderam

###### Variavel Ano curricular
absol_anocurricular = table(Grupo2$AnoCurricular)

barplot(absol_anocurricular, ylim = c(0,80),
        col = c("cyan","grey","pink"),
        xlab = "Anos curriculares",                     ## -- Grafico Barras da Variavel Ano Curriculares
        ylab = "Numero de alunos por ano (freq. absol)",
        main = "Divisao da Variavel Ano Curricular ")

absol_anocurricular
##### O grafico mostra-nos que há mais alunos no 1º ano e menos no 2º ano

###### Variavel opcao1

absol_opcao1 = table(Grupo2$opcao1)
relat_opcao1 = round(prop.table(absol_opcao1),2)
pie(relat_opcao1,labels = paste0(relat_opcao1*100,"%"),
    col = c("black","white"), cex = 0.8,                ##-- Grafico Circular da variavel Opcao1     
    main = "Grafico circular da precentagens das pessoas que entram na sua 1º opção")
legend("topright", legend = c("1º opção","2ºopção ou outra "),
       fill = c("black","white"),
       cex=0.7)

absol_opcao1
relat_opcao1
# com este grafico circular notamos que mais de 50% conseguir entrar na sua primeira opcao sendo a diferença muito pouca entre uma e outra

########## Variavel Escolhi

absol_escolha = table(Grupo2$Escolhi)
relat_escolha = round(prop.table(absol_escolha),3)

pie(relat_escolha,labels = paste0(relat_escolha*100,"%"),
    col = c("purple","green"), cex = 0.75,                        ##-- Grafico Circular da variavel Escol
    main = "Grafico de precentagens de alunos que escolheram o curso por si só")
legend("topleft", legend = c("Escolhi eu","Não fui eu que Escolhi"),
       fill = c("purple","green"),
       cex=0.8)

absol_escolha
relat_escolha
### Concluimos que mais de 99% escolheu o seu proprio curso 

####### Varaivel Tempo Desloca

TempDesloca = summary(Grupo2$TempoDesloca)
pandoc.table(TempoDesloca,plain.ascii = TRUE,
             caption = "Tabela com a analise univariada da variavel Tempo Desloca")
sd(Grupo2$TempoDesloca,
   na.rm = TRUE)
### Todos os estudantes responderam à pergunta , tendo uma media de 111.2 , com +/- 77.57 min

##### horas de estudo

HoraEstudo = summary(Grupo2$HorasEstudo)
pandoc.table(HorasEstudo,plain.ascii = TRUE,
             caption = "Tabela com a analise univariada da variavel Horas de estudo ")
sd(Grupo2$HorasEstudo, na.rm = TRUE)

##### 12 do estudantes nao responderam há pergunta ou resposta nao valida tendo uma media de 8.134 , com +/- 5.472 min

###### horas nas redes

HoraRedes = summary(Grupo2$HorasRedes)
pandoc.table(HorasRedes,plain.ascii = TRUE,
             caption = "Tabela com a analise univariada da variavel Horas de Rede ")

sd(Grupo2$HorasRedes,na.rm = TRUE)

### 3 do estudantes nao responderam há pergunta ou resposta nao valida, tendo uma media 2.796 +/- 2.386 min

###### horas de tv

HoraTV = summary(Grupo2$HorasTV)
pandoc.table(HorasTV,plain.ascii = TRUE,
             caption = "Tabela com a analise univariada da variavel Horas de Tv ")
sd(Grupo2$HorasTV, na.rm = TRUE)

#### 3 dos estudantes nao responderam há pergunta ou resposta nao valida , tendo uma media 1.749 com +/- 1.309 min

###### horas de sono

HoraSonos = summary(Grupo2$HorasSono)
pandoc.table(HorasSonos,plain.ascii = TRUE,
             caption = "Tabela com a analise univariada da variavel Horas de Sono ")
sd(Grupo2$HorasSono, na.rm = TRUE)

###### todos responderam há perguntam tendo uma media de 6.981 , com +/- 0,943

###### Variavel Pmentoria
relat = round(prop.table(table(Grupo2$PMentoria)),2) 
pie(relat, labels = paste0(relat*100, "%"),cex=1.2,
    main = "Grafico circular para a variavel 'Programa Mentoria'", cex.main=1, #--Grafico circular da variavel Programa de Mentoria
    col = c("green","red"))
legend("bottomright", c("Sim","Nao"),
       fill = c("green","red"),
       cex=0.8)

####### Mais de 60% dos alunos conhece o programa mentoria

##################### Analise Descritiva Bivariada ################# 
############# Tabela de contigencia
tabelacontigencia = round(prop.table(table(Grupo2$Burnout_P2,
                                 Grupo2$Sexo),2)*100,2)

tabelacontigencia1 = rbind(tabelacontigencia,margin.table(tabelacontigencia,2))
colnames(tabelacontigencia1) = c("Feminino","Masculino")
rownames(tabelacontigencia1) = c("Nunca","Quase nunca","Algumas vezes","Regurlamente","Muitas vezes","Quase sempre","Sempre","Total")
pandoc.table(tabelacontigencia1, plain.ascii = TRUE,
             caption = "Tabela Contingencia Burnout_P2 vs Sexo")
tabelacontigencia1

###### esta tabela mostra qual dos sexos se sente mais de rastos ao fim de um dia de escola

########### coeficiente de correlacao de pearson entre a variavel das horas de estudo com a variavel das horas de rede e sera que as horas de rede afetam os estudo
cor(Grupo2$HorasEstudo,Grupo2$HorasRedes,
    method = "pearson", use="pairwise")

########## coeficiente de correlacao de spearman entre a variavel das horas de sono com a Burnout_P15 , se o nosso desempenho e melhor quanto mais dormimos
cor(Grupo2$HorasSono,Grupo2$Burnout_P15, 
    method = "spearman", use = "pairwise")
    

############### Regressao Linear ##############

## definir variaveis 
names(Grupo2)
x = Grupo2$TempoDesloca
y = Grupo2$HorasEstudo

## diagrama de dispersao
plot(x,y,xlab="Tempo de Deslocacao (X)",ylab=" Horas de estudo (Y)")

## determinar coeficiente de correlacao linear de Pearson
cor(x,y)

## Ajuste do modelo de regressao linear simples
# Y = b0 + b1 X + E
modelo = lm(Grupo2$TempoDesloca ~ Grupo2$HorasEstudo )
## Organizar equacao do modelo
coeficientes <- data.frame(model = paste("Y^ = ",round(coefficients(modelo)[1],4),
                                         " + (",
                                         round(coefficients(modelo)[2],4),
                                         " * X)", sep=""))
coeficientes

## Coef de determinacao e coef de determinacao ajustado
# Coef de determinacao
R2 <- summary(modelo)$r.squared
cat("O coeficiente de determinacao tem o valor ",round(R2,4))

# Coef de determinacao ajustado
R2_adj <- summary(modelo)$adj.r.squared
cat("O coeficiente de determinacao ajustado tem o valor ",round(R2_adj,4))

coef_deter <- data.frame(paste("R^2 = ",round(R2,4)))
coef_deter_adj <- data.frame(paste("R^2 adj = ",round(R2_adj,4)))

## Diagrama de dispersao com reta ajustada
plot(Grupo2$TempoDesloca,Grupo2$HorasEstudo,
     xlab="Tempo de Deslocacao (X)",ylab="Horas de estudo (Y)")
abline(lm(y~x),col="deeppink")
coef_deter <- 
  data.frame(paste("R^2 = ",round(summary(modelo)$r.squared,4)))
coef_deter_adj <- 
  data.frame(paste("R^2 adj = ",round(summary(modelo)$adj.r.squared,4)))
legend("topright",
       legend=c(paste(coeficientes), paste(coef_deter),
                paste(coef_deter_adj)),
       bty="n",cex=0.8)



## definir variaveis 
names(Grupo2)
x = Grupo2$HorasTV
y = Grupo2$HorasSono

## diagrama de dispersao
plot(x,y,xlab="Horas de TV (X)",ylab=" Horas de Sono (Y)")

## determinar coeficiente de correlacao linear de Pearson
cor(x,y)

## Ajuste do modelo de regressao linear simples
# Y = b0 + b1 X + E
modelo = lm(Grupo2$HorasTV ~ Grupo2$HorasSono )
## Organizar equacao do modelo
coeficientes <- data.frame(model = paste("Y^ = ",round(coefficients(modelo)[1],3),
                                         " + (",
                                         round(coefficients(modelo)[2],3),
                                         " * X)", sep=""))
coeficientes

## Coef de determinacao e coef de determinacao ajustado
# Coef de determinacao
R2 <- summary(modelo)$r.squared
cat("O coeficiente de determinacao tem o valor ",round(R2,4))

# Coef de determinacao ajustado
R2_adj <- summary(modelo)$adj.r.squared
cat("O coeficiente de determinacao ajustado tem o valor ",round(R2_adj,4))

coef_deter <- data.frame(paste("R^2 = ",round(R2,4)))
coef_deter_adj <- data.frame(paste("R^2 adj = ",round(R2_adj,4)))

## Diagrama de dispersao com reta ajustada
plot(Grupo2$HorasTV,Grupo2$HorasSono,
     xlab="Horas de Tv (X)",ylab="Horas de Sono (Y)")
abline(lm(y~x),col="purple")
coef_deter <- 
  data.frame(paste("R^2 = ",round(summary(modelo)$r.squared,4)))
coef_deter_adj <- 
  data.frame(paste("R^2 adj = ",round(summary(modelo)$adj.r.squared,4)))
legend("topright",
       legend=c(paste(coeficientes), paste(coef_deter),
                paste(coef_deter_adj)),
       bty="n",cex=0.8)

if(!require("clipr")) install.packages("clipr")
library(clipr)


write_clip(Grupo2)
