# Segmentación de Clientes Bancarios mediante Técnicas de Análisis Multivariado

**Proyecto Final BD-165. Modelos Estadísticos Avanzados**
Diplomado en Big Data, Colegio Universitario de Cartago
Grupo 8

## Descripción

Este proyecto usa técnicas de análisis multivariado para identificar perfiles de clientes de un banco a partir de sus datos demográficos y financieros. También se revisa si esos perfiles tienen relación con la fuga de clientes (churn).

**Pregunta de análisis:** ¿existen grupos naturales de clientes según su perfil financiero (puntaje crediticio, balance, edad, salario), y esos grupos tienen relación con que el cliente abandone el banco o no?

## Dataset

- Fuente: [Bank Customer Churn Dataset, Kaggle](https://www.kaggle.com/datasets/shrutimechlearn/churn-modelling)
- 10,000 clientes, 14 variables
- Variables usadas para el clustering: CreditScore, Age, Tenure, Balance, NumOfProducts, EstimatedSalary
- Variable de validación (no se usa en el clustering, solo para comparar después): Exited

## Técnicas aplicadas

1. K-means
2. K-medoids (PAM)
3. Escalamiento multidimensional (MDS)

## Estructura del repositorio
├── data/
│ └── Churn_Modelling.csv
├── code/
│ └── analisis.R
├── docs/
│ ├── documento_tecnico.md
│ └── documento_tecnico.html
└── README.md

## Cómo correr el análisis

1. Clonar el repositorio
2. Abrir code/analisis.R en RStudio
3. Instalar los paquetes que se usan (están al inicio del script)
4. Correr el script completo

## Documento técnico

- [Markdown](docs/documento_tecnico.md)
- [HTML compilado](docs/documento_tecnico.html)
- PDF de respaldo: docs/documento_tecnico.pdf

## Integrantes

- Mariana Méndez Pérez
- Luis Diego Montero Vargas
- Josué Redondo Gómez
- Claret Rodríguez Jiménez
- Nadin Rojas López
