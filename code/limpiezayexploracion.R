

# ============================================================
# # Proyecto Final BD-165 - Grupo 8
# Segmentacion de Clientes Bancarios mediante Analisis Multivariado
# Dataset: Bank Customer Churn Dataset (Kaggle)
#
# PARTE 1: Carga, limpieza y exploracion de datos
# ============================================================

# 1. Paquetes necesarios
#install.packages(c("tidyverse", "cluster", "factoextra"))
library(tidyverse)
library(cluster)     # pam()
library(factoextra)  # fviz_cluster(), fviz_nbclust()

# 2. Cargar los datos 
datos <- Churn_Modelling

str(datos)
head(datos)
dim(datos)  # filas x columnas


# 3. Exploracion inicial 

# Resumen general de todas las variables
summary(datos)

# Duplicados
sum(duplicated(datos))  

# Valores faltantes por columna
colSums(is.na(datos))  

# 4. Limpieza: quitar columnas identificadoras como 
# RowNumber, CustomerId y Surname que en realidad noaportan al analisis:
# son identificadores, no describen el comportamiento del cliente.


datos_limpios <- datos %>%
  select(-RowNumber, -CustomerId, -Surname)

str(datos_limpios)

# 5. Exploracion de outliers y distribuciones 
# Revisamos las variables numericas  antes de escalar

# Edad
hist(datos_limpios$Age,
     main = "Distribucion de edad",
     xlab = "Edad", col = "#1F497D")

# Balance
hist(datos_limpios$Balance,
     main = "Distribucion de balance de cuenta",
     xlab = "Balance", col = "#C55A11")

# Cuantos clientes tienen balance en 0
mean(datos_limpios$Balance == 0)  # proporcion de clientes con balance 0

# Puntaje crediticio
hist(datos_limpios$CreditScore,
     main = "Distribucion de puntaje crediticio",
     xlab = "CreditScore", col = "#38761D")

# Salario estimado
hist(datos_limpios$EstimatedSalary,
     main = "Distribucion de salario estimado",
     xlab = "Salario estimado", col = "#7F6000")

# Boxplots para ver outliers de forma mas clara
boxplot(datos_limpios[, c("CreditScore", "Age", "Tenure")],
        main = "Boxplots de variables (escala original)")

# 6. Seleccion de variables para el clustering 
# Elegimos variables numericas de comportamiento financiero.
# Se excluyen: Geography, Gender, HasCrCard, IsActiveMember (categoricas)
# y Exited (se guarda aparte para validar los clusters despues.

vars_cluster <- datos_limpios %>%
  select(CreditScore, Age, Tenure, Balance, NumOfProducts, EstimatedSalary)

# Guardamos Exited aparte para la validacion posterior
exited <- datos_limpios$Exited

# 7. Escalado 
# Las variables estan en escalas muy distintas
# (Balance en miles, Tenure de 0 a 10): hay que escalar
# antes de calcular distancias

datos_esc <- scale(vars_cluster)

# Verificar: media 0 y desviacion 1 en cada columna
round(colMeans(datos_esc), 2)
round(apply(datos_esc, 2, sd), 2)

# A. Correlacion entre las variables del clustering 

matriz_cor <- cor(vars_cluster)
round(matriz_cor, 2)

install.packages("GGally")
library(GGally)
ggpairs(vars_cluster)

# B. Exploracion de variables categoricas (contexto demografico) 

table(datos_limpios$Geography)
round(prop.table(table(datos_limpios$Geography)) * 100, 1)

table(datos_limpios$Gender)
round(prop.table(table(datos_limpios$Gender)) * 100, 1)

table(datos_limpios$HasCrCard)
table(datos_limpios$IsActiveMember)

round(prop.table(table(datos_limpios$Exited)) * 100, 1)

# C. Deteccion formal de outliers (regla del IQR) 

detectar_outliers <- function(x) {
  q1 <- quantile(x, 0.25)
  q3 <- quantile(x, 0.75)
  iqr <- q3 - q1
  limite_inf <- q1 - 1.5 * iqr
  limite_sup <- q3 + 1.5 * iqr
  sum(x < limite_inf | x > limite_sup)
}

sapply(vars_cluster, detectar_outliers)

