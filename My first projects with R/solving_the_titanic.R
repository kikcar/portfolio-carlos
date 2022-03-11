
library(dplyr)

#EJERCICIO 1

#Carga el set de datos en una variable llamada "titanic"

titanic = read.csv("enunciado de la practica de R/train.csv", header = T)

#Obten el numero de filas y columnas incluidas en el set de datos

numero_columnas = ncol(titanic)
numero_filas = nrow(titanic)

#Obten las primeras 10 observaciones para ver que pinta tienen

primeras_10_observaciones = head(titanic, 10)

#Obten el listado de variables inlcuidas en el set de datos y sus tipos

str(titanic)

#Obten la distribucion de las variables categoricas (sex, embarked, survived, pclass) del set de datos.Es decir, valores unicos / valores totales


distribucion_sex = table(titanic$Sex)/nrow(titanic)
distribucion_embarked = table(titanic$Embarked)/nrow(titanic)
distribucion_survived = table(titanic$Survived)/nrow(titanic)
distribucion_pclass = table(titanic$Pclass)/nrow(titanic)


#Obten los estadisticos basicos de las variables del set de datos

summary(titanic)

#EJERCICIO 2

#Indica en que variables hay valores con NA, NULL, o Vacios "" y cual es su proporcion dentro de la variable

Check_for_Null = sapply(titanic, function(x) sum(length(which(is.null(x))))) #Ninguna variable tiene algún NULL
check_for_NA = sapply(titanic, function(x) sum(length(which(is.na(x))))) #La unica variable con NA es AGE
Total_NA = (check_for_NA["Age"]) #sacamos total de NAs dentro de Age
Proporcion_NA_Age = Total_NA/nrow(titanic) #Proporcion de NAs dentro de Age
Check_for_Empty = sapply(titanic, function(x) sum(length(which(x == "")))) #Buscamos celdas vacias dentro del data frame. Encontramos celdas vacias en Cabin y Embarked.
Total_Empty_Cabin = Check_for_Empty["Cabin"] #Sacamos total de celdas vacias dentro de Cabin
Total_Empty_Embarked = Check_for_Empty["Embarked"] #Sacamos total de celdas vacias dentro de Embarked
Proporcion_Empty_Cabin = Total_Empty_Cabin/nrow(titanic) #Proporcion de celdas vacias dentro de Cabin
Proporcion_Empty_Embarked = Total_Empty_Embarked/nrow(titanic) #Proporcion de celdas vacias dentro de Embarked

#Imputa la media del valor de la variable en el caso de las numéricas y "No Disponible" en el caso de string

titanic[is.na(titanic)] = mean(na.omit(titanic$Age)) #Calculo la media de la variable Age omitiendo los NAs, y la imputo en los huecos donde hay NAs.
titanic[titanic == ""] = "No Disponible" #Imputamos como No Disponible aquellas celdas vacias

#Vuelve a comprobar la existencia de NAs y Null para verificar que has eliminado

Comprobar_Null = sapply(titanic, function(x) sum(length(which(is.null(x))))) #Compruebo que no haya Null
Comprobar_NA = sapply(titanic, function(x) sum(length(which(is.na(x))))) #Compruebo que no haya NA
Comprobar_Empty = sapply(titanic, function(x) sum(length(which(x == "")))) #Compruebo que no haya celdas vacias
















  


  
  
  
 

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  
  


  
  
  
  

  















