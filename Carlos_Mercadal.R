
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


#EJERCICIO 3

#¿Fallecieron mas mujeres u hombres? (Cuanto en porcentaje sobre el total de su genero)

total_hombres = nrow(filter(titanic, Sex =="male"))
total_mujeres = nrow(filter(titanic, Sex == "female"))
hombres_fallecidos = nrow(filter(titanic, Sex == "male", Survived == 0))
mujeres_fallecidas = nrow(filter(titanic, Sex == "female", Survived == 0))
max(mujeres_fallecidas, hombres_fallecidos) #han fallecido más hombres que mujeres
porcentaje_hombres_muertos = (hombres_fallecidos/total_hombres)*100 #porcentaje de hombres fallecidos sobre el total de hombres
porcentaje_mujeres_muertas = (mujeres_fallecidas/total_mujeres)*100 #porcentaje de mujeres fallecidas sobre el total de mujeres

#¿Qué clase de pasajeros (primera, segunda o tercera) sobrevivió más? Quiero que el resultado de, únicamente, el porcentaje y la clase que más sobrevivió (no el porcentaje de las 3 clases).


pasejeros_sobrevivido = titanic[titanic$Survived == 1, ]
clases_sobrevivido = pasejeros_sobrevivido[3:3]
clase3 = length(clases_sobrevivido[clases_sobrevivido$Pclass == 3, ])
clase2 = length(clases_sobrevivido[clases_sobrevivido$Pclass == 2, ])
clase1 = length(clases_sobrevivido[clases_sobrevivido$Pclass == 1, ])
max(clase3, clase2, clase1)

filtro_clase1 = titanic[titanic$Pclass == 1, ]
total_pasajeros_clase1 = nrow(filtro_clase1[3:3])
porcentaje_sobrevivido_clase1 = clase1 / total_pasajeros_clase1 * 100
print("Los pasajeros de la clase1 son los que más han sobrevivido con un porcentaje del 62.96296% del total de pasajeros asignados a la clase1")



# ¿Cuál fue la edad media y máxima de los supervivientes en cada una de las clases?

pasejeros_sobrevivido = titanic[titanic$Survived == 1, ]
clases_y_edad = select(pasejeros_sobrevivido, Pclass, Age)
class1 = (filter(clases_y_edad, Pclass == 1))
max(class1$Age)
mean(class1$Age)
print("La edad máxima de supervivientes de la clase1 fue de 80 años, y la media de 34.78462")
class2 = (filter(clases_y_edad, Pclass == 2))
max(class2$Age)
mean(class2$Age)
print("La edad máxima de supervivientes de la clase2 fue de 62 años, y la media de 26.07617")
class3 = (filter(clases_y_edad, Pclass == 3))
max(class3$Age)
mean(class3$Age)
print("La edad máxima de supervivientes de la clase2 fue de 63 años, y la media de 23.23269")

#EJERCICIO 4

# ¿Cuál de los puertos de embarque es el que tiene la media de precio de billete más barata? Indica solo ese puerto, no una lista con todos.

puertos_y_billetes = select(titanic, Fare , Embarked)
puerto_C = filter(puertos_y_billetes, Embarked == "C")
puerto_S = filter(puertos_y_billetes, Embarked == "S")
puerto_Q = filter(puertos_y_billetes, Embarked == "Q")
mean(puerto_C$Fare)
mean(puerto_S$Fare)
mean(puerto_Q$Fare)
print("La media de precio de billete mas baráta la tiene el puerto Q con 13.27603")

# ¿ Qué correlación hay entre la longitud del nombre de un pasajero y el importe de su billete? No modiqfiques el nombre del pasajero para hacer el cálculo (úsalo tal y como venga.)

nombres_y_billetes = select(titanic, Name, Fare)


for (fila in 1:nrow(nombres_y_billetes)) {
  nombres_y_billetes$Name[fila]  = nchar(nombres_y_billetes$Name[fila]) #sustituimos al fila con nombres por la longitud.
}

cor.test(as.numeric(nombres_y_billetes$Name), nombres_y_billetes$Fare)
print("La correlacion entre la longitud del nombre de un pasajero y el importe de su billete es de 0.1558324")

# EJERCICIO 5

#Obtén los nombres de los pasajeros que no sobrevivieron y el precio de su billete está en el decil superior. 

sobrevivido_nombre_billete = select(titanic, Survived, Name, Fare)
decil_superior = (quantile(sobrevivido_nombre_billete$Fare, probs = seq(0.1, length(11), by = .1)))
filtro_muertos = filter(sobrevivido_nombre_billete, Survived == 0 )

bajo = decil_superior[9]
alto = decil_superior[10]
nombres = filter(filtro_muertos, Fare >= bajo, Fare <= alto)
print("Las personas que han fallecido y su billete está en el decil superior son:")
print(nombres$Name)



#¿En qué cabina deberías alojarte para tener una mayor probabilidad de sobrevivir siendo hombre de entre 30 y 40 años? Indica una única cabina.

survived_sex_age_cabin = select(titanic, Survived, Sex, Age, Cabin)
filtro_sobrevividos = filter(survived_sex_age_cabin, Survived == 1)
filtro_hombres = filtro_sobrevividos[filtro_sobrevividos$Sex == "male", ]
filtro_edad = filter(filtro_hombres, Age <= 40 & Age >= 30)
filtro_disponibles = filtro_edad[filtro_edad$Cabin != "No Disponible", ]  #DUDA, DEBEMOS INLCUIR LOS QUE TENGAN 30 Y 40 AÑOS? NO ALTERA LA SOLCUION.
cabinas = filtro_disponibles$Cabin
cabinas = strsplit(cabinas, " ")
cabinas = unlist(cabinas)
cabinas[duplicated(cabinas, incomparables = FALSE)]
print("Para tener una mayor probabilidad de sobrevivir siendo hombre de entre 30 y 40 años, debería alojarme en la cabina 'E25'")

#MI PRIMER ALGORITMO DE INVERSION

#EJERCICIO 6

#Desarrolla un algoritmo de mechas
#Para cada activo, cada día, compra a precio de apertura y vende cuando ocurra el primero de los siguientes eventos: 
#  El activo sube 3 céntimos (stop profit)
#El activo cae 10 céntimos (stop loss)
#Si no ocurre ninguno de los anteriores, vende a precio de cierre

#Ojo, habrá días positivos y negativos a la vez, en estos casos, supón que toca primero el stop loss

#El capital que invertimos en cada activo, cada día, debe ser 30.000 €
#La comisión de compra será de 0.0003 * capital. Lo mismo para la venta.
#Comprueba que tienes al menos 30 datos para hacer los cálculos (si no es así descarta el activo)

#Entregable: Código que genere un dataframe con la siguiente estructura (para todos los activos):
  
IBEX35 = read.csv("enunciado de la practica de R/Ibex_data.csv", header = T)

#Creo un dataframe con los nombres de las empresas y los datos que debo rellenar
ejercicio_6 = matrix(nrow = 7, ncol = 79)
ejercicio_6 = as.data.frame(ejercicio_6)
nombres = unique(IBEX35$X)
colnames(ejercicio_6) = nombres
columnas = c("Bº medio por operación", "Beneficio acumulado", "% días positivos", "% días negativos", "Horquilla superior media", "Horquilla inferior media", "Número de operaciones")
rownames(ejercicio_6) = columnas
ejercicio_6[is.na(ejercicio_6)] = " "
ejercicio_6$MAS = NULL
ejercicio_6$activo = NULL

#CREAMOS FUNCIONES QUE VAMOS A USAR


#Establezo los parametros basicos para nuestra funcion principal en la que vamos a pasar las operaciones diarias

capital_diario = 30000
comision = capital_diario * 0.0003
stop_sell_baja = 0.10
stop_sell_sube = 0.03

#Creo un data frame 

compra_venta = data.frame("fecha" = character(), "ticker" = character(),  "compra" = numeric(), "venta" = numeric(), "stop_loss" = numeric(), "stop_profit" = numeric(), "no_stop" = numeric())

#Creo la funcion que recorre todos los activos para cada operacion

count_stoprofit = 0
count_stoploss = 0
no_stop = 0

recorremos = function(vector) {
  
  activo = IBEX35$X[vector]
  dia = IBEX35$X.1[vector]
  precio_apertura = IBEX35$open[vector]
  precio_baja = IBEX35$low[vector]
  precio_sube = IBEX35$high[vector]
  precio_cierre = IBEX35$close[vector]
  
  compra = (capital_diario) / precio_apertura
  stop_loss = precio_apertura - stop_sell_baja
  stop_profit = precio_apertura + stop_sell_sube
  
  
  
  if (precio_baja<= stop_loss) {
    orden_venta = compra * stop_loss
    count_stoploss = 1
    
  } else if (precio_sube >= stop_profit) {
    orden_venta = compra * stop_profit
    count_stoprofit = 2
  } else {
    orden_venta = compra * precio_cierre
    no_stop = 3
    
  }
  
  venta_neta = orden_venta - (orden_venta * 0.0003) - comision
  
  actualizado = data.frame("fecha" = dia, "ticker" = activo, "compra" = capital_diario, "venta" = venta_neta, "stop_loss" = count_stoploss, "stop_profit" = count_stoprofit, "no_stop" = no_stop)
  compra_venta = rbind(compra_venta, actualizado)
  
}

#Ejecuto la funcion y la guardo en un data frame

vector = c(1:136000)
matriz_compra_venta = sapply(vector, recorremos)

df_diario = as.data.frame(matriz_compra_venta)
df_diario = t(df_diario)
df_diario = as.data.frame(df_diario)
as.character(df_diario$ticker)

#Me devuelve con dataframe con listas dentro de las columnas, y las unlisteo
df_diario$ticker = unlist(df_diario$ticker)
df_diario$fecha = unlist(df_diario$fecha)
df_diario$compra = unlist(df_diario$compra)
df_diario$venta = unlist(df_diario$venta)
df_diario$stop_loss = unlist(df_diario$stop_loss)
df_diario$stop_profit = unlist(df_diario$stop_profit)
df_diario$no_stop = unlist(df_diario$no_stop)

#Compruebo si algun ticker tiene menos de 30 datos, y lo elimino del data frame

df_diario %>%
  group_by(ticker) %>%
  summarise(n = n()) %>%
  filter(n <= 30) #Comrpuebo que MAS tiene solo 9 datos. 

df_diario = filter(df_diario, ticker != "MAS") #elimino a MAS del dataframe


#Calculo el beneficio acumulado por activo 

beneficio = function(activo) {
  
  filtro = filter(df_diario, ticker == activo)
  total_compra = sum(filtro$compra)
  total_venta = sum(filtro$venta)
  beneficio_acumulado = total_venta - total_compra
  
} 

activo = unique(df_diario$ticker)
beneficio_acumulado  = sapply(activo, beneficio)
beneficio_acumulado = round(beneficio_acumulado, digits = 3)
beneficio_acumulado = as.data.frame(beneficio_acumulado)


#Inserto el beneficio acumulado en el data frame resultado


ejercicio_6["Beneficio acumulado", ] = beneficio_acumulado$beneficio_acumulado

ejercicio_6["Beneficio acumulado", ] = unlist(ejercicio_6["Beneficio acumulado", ])

#Calculo el numero de operaciones por activo

operaciones = function(activo) {
  nrow(filter(df_diario, ticker == activo))
}

activo = unique(df_diario$ticker)
n_operaciones  = sapply(activo, operaciones)

#Inserto el numero de operaciones por activo en el data frame resultado

ejercicio_6["Número de operaciones", ] = n_operaciones

#Calculo el beneficio medio por accion

bmedio = function(activo) {
  z = ejercicio_6["Beneficio acumulado", activo] 
  y = ejercicio_6["Número de operaciones", activo]
  as.numeric(z)/as.numeric(y)
}

activo = unique(df_diario$ticker)
beneficio_med  = sapply(activo, bmedio)

#Inserto el beneficio medio por operacion en el data frame resultado

ejercicio_6["Bº medio por operación", ] = round(beneficio_med, digits = 3)

#Calculo la horquilla superior media

horquilla = function(activo) {
  
  z = filter(IBEX35, IBEX35$X == activo)
  z = select(z, high, open)
  z = z$high - z$open
  mean(z)
  
}

activo = unique(df_diario$ticker)
horquilla_superior = sapply(activo, horquilla)

#Inserto la horquilla superior media en el data frame resuelto

ejercicio_6["Horquilla superior media", ] = round(horquilla_superior, digits = 3)

#Calculo la horquilla inferior media


horquilla_inf = function(activo) {
  
  y = filter(IBEX35, IBEX35$X == activo)
  y = select(y, open, low)
  y = y$open - y$low
  mean(y)
  
}

activo = unique(df_diario$ticker)
horquilla_inferior = sapply(activo, horquilla_inf)

#Inserto la horquilla inferior media en el data frame resuelto

ejercicio_6["Horquilla inferior media", ] = round(horquilla_inferior, digits = 3)


#Calculo porcecntaje de dias positivos y negativos



dias_positivos = function(activo) {
  k = filter(df_diario, ticker == activo)
  positivo = filter(k, stop_profit == 2)
  positivo = as.data.frame(positivo)
  dias_pos = length(positivo$stop_profit)
  dias_totales = nrow(k)
  porcentaje_dias_positivos = dias_pos/dias_totales
  return(porcentaje_dias_positivos)
}



dias_negativos = function(activo) {
  k = filter(df_diario, ticker == activo)
  negativo = filter(k, stop_loss == 1)
  negativo = as.data.frame(negativo)
  dias_neg = length(negativo$stop_loss)
  dias_totales = nrow(k)
  porcentaje_dias_negativos = dias_neg/dias_totales
  return(porcentaje_dias_negativos)
}


activo = unique(df_diario$ticker)
porcentaje_positivo = sapply(activo, dias_positivos)

activo = unique(df_diario$ticker)
porcentaje_negativo = sapply(activo, dias_negativos)

#Inserto porcentajes dias positivos y negativos en el data frame resuelto

ejercicio_6["% días positivos", ] = round(porcentaje_positivo, digits = 3)
ejercicio_6["% días negativos", ] = round(porcentaje_negativo, digits = 3)



df_diario$beneficio_diario = df_diario$venta - df_diario$compra


graficamos = function(activo) { 
  
  z = filter(df_diario, ticker == activo)
  z$beneficio_diario_acumulado = cumsum(z$beneficio_diario)
  y = z$beneficio_diario_acumulado
  x = c(1:length(y))
  plot(x, y, type = "l", main = activo, ylab = " ", xlab = " ")
  
} 

activo = unique(df_diario$ticker)
sapply(activo, graficamos)

#EJERCICIO 7

#Partiendo del algoritmo de mechas anterior, añade el parámetro price_departure.
#Para cada activo, cada día, si el price_departure es >= 0.75, compra a precio de apertura y vende cuando ocurra el primer de los siguientes eventos: 
#  El activo sube 3 céntimos (stop profit)
#El activo cae 10 céntimos (stop loss)
#Si no ocurre ninguno de los anteriores, vende a precio de cierre

#Ojo, habrá días positivos y negativos a la vez, en estos casos, supón que toca primero el stop loss

#El capital que invertimos en cada activo, cada día, debe ser 30.000 €
#La comisión de cada compra y venta será de 0.0003 * capital
#Homogeneiza los datos Ibex_data y price_departure (utiliza solo las fechas que existan en ambos DF)
#Comprueba que tienes al menos 30 datos para hacer los cálculos, antes de aplicar el filtro del price_departure (si no es así descarta el activo)

#Entregable: Código que genere el mismo dataframe que en el ejercicio anterior y los mismos gráficos.



price_departure = read.csv("enunciado de la practica de R/price_departures.csv", header = T)
ibex_data= read.csv("enunciado de la practica de R/ibex_data.csv", header = T)
price_departure$MAS = NULL
ibex_data$price_departure = c(" ")
ibex_data = filter(ibex_data, ticker != "MAS")

col_def = data.frame(nada = character(0), nada2 = character(0), pricedep = numeric())

#Metemos los price departures en una columna dentro de IBEX35

for (numero in 1:78) {
  activo = unique(ibex_data$X)[numero]
  a = select(ibex_data, X, X.1)
  a = filter(a, X == activo)
  a$price_dep = c("")
  dep_filtrado = select(price_departure, X, activo)
  dep_filtrado = na.omit(dep_filtrado)
  
  for (dia in 1:nrow(dep_filtrado)) {
    
    fecha_dep_filtrado = dep_filtrado$X[dia]
    fecha_a = a$X.1
    
    if (fecha_dep_filtrado %in% fecha_a) {
      
      precio_dep = dep_filtrado[dia ,2]
      
      a[a$X.1 == fecha_dep_filtrado, "price_dep"] = precio_dep
    }
    
    else{
      next
    }
  }
  
  col_def = rbind(col_def, a)
  
}

col_def = select(col_def, price_dep)
ibex_data$price_departure = col_def
ibex_data = filter(ibex_data, price_departure != "")
ibex_data$price_departure = unlist(ibex_data$price_departure)

  
#Creo un dataframe con los nombres de las empresas y los datos que debo rellenar
ejercicio_7 = matrix(nrow = 7, ncol = 78)
ejercicio_7 = as.data.frame(ejercicio_7)
nombres = unique(ibex_data$X)
colnames(ejercicio_7) = nombres
columnas = c("Bº medio por operación", "Beneficio acumulado", "% días positivos", "% días negativos", "Horquilla superior media", "Horquilla inferior media", "Número de operaciones")
rownames(ejercicio_7) = columnas
ejercicio_7[is.na(ejercicio_7)] = " "
ejercicio_7$MAS = NULL
ejercicio_7$activo = NULL



#CREAMOS FUNCIONES QUE VAMOS A USAR


#Establezo los parametros basicos para nuestra funcion principal en la que vamos a pasar las operaciones diarias

capital_diario = 30000
comision = 0.0003
stop_sell_baja = 0.10
stop_sell_sube = 0.03

#Creo un data frame 

compra_venta = data.frame("fecha" = character(), "open" = numeric(), "low" = numeric(), "high" = numeric(), "ticker" = character(),  "compra" = numeric(), "venta" = numeric(), "stop_loss" = numeric(), "stop_profit" = numeric(), "no_stop" = numeric())

#Creo la funcion que recorre todos los activos para cada operacion

count_stoprofit = 0
count_stoploss = 0
no_stop = 0

recorremos = function(vector) {
  
  activo = ibex_data$X[vector]
  dia = ibex_data$X.1[vector]
  precio_apertura = ibex_data$open[vector]
  precio_baja = ibex_data$low[vector]
  precio_sube = ibex_data$high[vector]
  precio_cierre = ibex_data$close[vector]
  trigger = ibex_data$price_departure[vector]
  
  compra = (capital_diario) / precio_apertura
  stop_loss = precio_apertura - stop_sell_baja
  stop_profit = precio_apertura + stop_sell_sube
  
  if (trigger >= 0.75) {
  
    if (precio_baja<= stop_loss) {
      orden_venta = compra * stop_loss
      count_stoploss = 1
    } else if (precio_sube >= stop_profit) {
      orden_venta = compra * stop_profit
      count_stoprofit = 2
    } else {
      orden_venta = compra * precio_cierre
      no_stop = 3
    }
    
  } else {
    orden_venta = 000000
  }
  
  venta_neta = orden_venta - (orden_venta * comision) - 9
  
  actualizado = data.frame("fecha" = dia, "open" = precio_apertura, "low" = precio_baja, "high" = precio_sube, "ticker" = activo, "compra" = capital_diario, "venta" = venta_neta, "stop_loss" = count_stoploss, "stop_profit" = count_stoprofit, "no_stop" = no_stop)
  compra_venta = rbind(compra_venta, actualizado)
}

#Ejecuto la funcion y la guardo en un data frame

vector = c(1:133651)
matriz_compra_venta = sapply(vector, recorremos)
df_diario = as.data.frame(matriz_compra_venta)
df_diario = t(df_diario)
df_diario = as.data.frame(df_diario)
as.character(df_diario$ticker)

#Me devuelve con dataframe con listas dentro de las columnas, y las unlisteo
df_diario$ticker = unlist(df_diario$ticker)
df_diario$fecha = unlist(df_diario$fecha)
df_diario$compra = unlist(df_diario$compra)
df_diario$venta = unlist(df_diario$venta)
df_diario$stop_loss = unlist(df_diario$stop_loss)
df_diario$stop_profit = unlist(df_diario$stop_profit)
df_diario$no_stop = unlist(df_diario$no_stop)
df_diario$open = unlist(df_diario$open)
df_diario$low = unlist(df_diario$low)
df_diario$high = unlist(df_diario$high)
df_diario = filter(df_diario, venta != -9)


#Calculo el beneficio acumulado por activo 

beneficio = function(activo) {
  
  filtro = filter(df_diario, ticker == activo)
  total_compra = sum(filtro$compra)
  total_venta = sum(filtro$venta)
  beneficio_acumulado = total_venta - total_compra
  
} 

activo = unique(df_diario$ticker)
beneficio_acumulado  = sapply(activo, beneficio)
beneficio_acumulado = round(beneficio_acumulado, digits = 3)
beneficio_acumulado = as.data.frame(beneficio_acumulado)



#ELIMNO CAR DEL DF RESULTADO PORQUE NO TIENE OPERACIONES EJECUTADAS

ejercicio_7$CAR = NULL

#Inserto el beneficio acumulado en el data frame resultado



ejercicio_7["Beneficio acumulado", ] = beneficio_acumulado$beneficio_acumulado

ejercicio_7["Beneficio acumulado", ] = unlist(ejercicio_7["Beneficio acumulado", ])

#Calculo el numero de operaciones por activo

operaciones = function(activo) {
  nrow(filter(df_diario, ticker == activo))
}

activo = unique(df_diario$ticker)
n_operaciones  = sapply(activo, operaciones)

#Inserto el numero de operaciones por activo en el data frame resultado

ejercicio_7["Número de operaciones", ] = n_operaciones

#Calculo el beneficio medio por accion

bmedio = function(activo) {
  z = ejercicio_7["Beneficio acumulado", activo] 
  y = ejercicio_7["Número de operaciones", activo]
  as.numeric(z)/as.numeric(y)
}

activo = unique(df_diario$ticker)
beneficio_med  = sapply(activo, bmedio)

#Inserto el beneficio medio por operacion en el data frame resultado

ejercicio_7["Bº medio por operación", ] = round(beneficio_med, digits = 3)

#Calculo la horquilla superior media

horquilla = function(activo) {
  
  z = filter(df_diario, ticker == activo)
  z = select(z, high, open)
  z = z$high - z$open
  mean(z)
  
}

activo = unique(df_diario$ticker)
horquilla_superior = sapply(activo, horquilla)

#Inserto la horquilla superior media en el data frame resuelto

ejercicio_7["Horquilla superior media", ] = round(horquilla_superior, digits = 3)

#Calculo la horquilla inferior media


horquilla_inf = function(activo) {
  
  y = filter(df_diario, ticker == activo)
  y = select(y, open, low)
  y = y$open - y$low
  mean(y)
  
}

activo = unique(df_diario$ticker)
horquilla_inferior = sapply(activo, horquilla_inf)

#Inserto la horquilla inferior media en el data frame resuelto

ejercicio_7["Horquilla inferior media", ] = round(horquilla_inferior, digits = 3)


#Calculo porcecntaje de dias positivos y negativos



dias_positivos = function(activo) {
  k = filter(df_diario, ticker == activo)
  positivo = filter(k, stop_profit == 2)
  positivo = as.data.frame(positivo)
  dias_pos = length(positivo$stop_profit)
  dias_totales = nrow(k)
  porcentaje_dias_positivos = dias_pos/dias_totales
  return(porcentaje_dias_positivos)
}



dias_negativos = function(activo) {
  k = filter(df_diario, ticker == activo)
  negativo = filter(k, stop_loss == 1)
  negativo = as.data.frame(negativo)
  dias_neg = length(negativo$stop_loss)
  dias_totales = nrow(k)
  porcentaje_dias_negativos = dias_neg/dias_totales
  return(porcentaje_dias_negativos)
}


activo = unique(df_diario$ticker)
porcentaje_positivo = sapply(activo, dias_positivos)

activo = unique(df_diario$ticker)
porcentaje_negativo = sapply(activo, dias_negativos)

#Inserto porcentajes dias positivos y negativos en el data frame resuelto

ejercicio_7["% días positivos", ] = round(porcentaje_positivo, digits = 3)
ejercicio_7["% días negativos", ] = round(porcentaje_negativo, digits = 3)



df_diario$beneficio_diario = df_diario$venta - df_diario$compra


graficamos = function(activo) { 
  
  z = filter(df_diario, ticker == activo)
  z$beneficio_diario_acumulado = cumsum(z$beneficio_diario)
  y = z$beneficio_diario_acumulado
  x = c(1:length(y))
  plot(x, y, type = "l", main = activo, ylab = " ", xlab = " ")
  
} 

activo = unique(df_diario$ticker)
sapply(activo, graficamos)


#EJERCICIO 8

# Optimización de la mecha y el capital por activo
#Utilizar un stop profit, o un stop loss estático, no parece lo más eficiente. 
#Tampoco lo parece el utilizar el mismo capital para todos los activos.
#Objetivo: Partiendo del algoritmo de mechas anterior
#o	Modifica el capital asignado a cada activo: usa la media de datos de cierre y el 0,5% del volumen.
#o	Modifica el stop profit de cada activo: utiliza el cuantil 30 de la mecha superior (max – open)
#o	Modifica el stop loss de cada activo: utiliza el cuantil 80 de la mecha inferior (open – low)
#Entregable: Código que genere un dataframe con la siguiente estructura (para todos los activos), y los mismos gráficos.


price_departure = read.csv("enunciado de la practica de R/price_departures.csv", header = T)
ibex_data= read.csv("enunciado de la practica de R/ibex_data.csv", header = T)
ibex_data$price_departure = c(" ")
price_departure$MAS = 0
col_def = data.frame(nada = character(0), nada2 = character(0), pricedep = numeric())

#Metemos los price departures en una columna dentro de IBEX35

for (numero in 1:79) {
  activo = unique(ibex_data$X)[numero]
  a = select(ibex_data, X, X.1)
  a = filter(a, X == activo)
  a$price_dep = c("")
  dep_filtrado = select(price_departure, X, activo)
  dep_filtrado = na.omit(dep_filtrado)
  
  for (dia in 1:nrow(dep_filtrado)) {
    
    fecha_dep_filtrado = dep_filtrado$X[dia]
    fecha_a = a$X.1
    
    if (fecha_dep_filtrado %in% fecha_a) {
      
      precio_dep = dep_filtrado[dia ,2]
      
      a[a$X.1 == fecha_dep_filtrado, "price_dep"] = precio_dep
    }
    
    else{
      next
    }
  }
  
  col_def = rbind(col_def, a)
  
}

col_def = select(col_def, price_dep)
ibex_data$price_departure = col_def
ibex_data = filter(ibex_data, price_departure != "")
ibex_data$price_departure = unlist(ibex_data$price_departure)


#Creo un dataframe con los nombres de las empresas y los datos que debo rellenar
ejercicio_8 = matrix(nrow = 11, ncol = 79)
ejercicio_8 = as.data.frame(ejercicio_8)
nombres = unique(ibex_data$X)
colnames(ejercicio_8) = nombres
columnas = c("Importe medio por operación", "Bº medio por operación", "Bº medio por euro invertido" ,"Beneficio acumulado", "% días positivos", "% días negativos", "Horquilla superior media", "Horquilla inferior media", "Stop profit objetivo", "Stop loss",  "Número de operaciones")
rownames(ejercicio_8) = columnas
ejercicio_8[is.na(ejercicio_8)] = " "

#CREAMOS FUNCIONES QUE VAMOS A USAR

#Creo un data frame 

compra_venta = data.frame("fecha" = character(), "open" = numeric(), "low" = numeric(), "high" = numeric(), "ticker" = character(),  "compra" = numeric(), "venta" = numeric(), "stop_loss" = numeric(), "stop_profit" = numeric(), "no_stop" = numeric())

#Establezco los nuevos parametros de capital y stops

count_stoprofit = 0
count_stoploss = 0
no_stop = 0
comision = 0.0003
criterios = data.frame("asset" = character(), "capital_diario" = numeric(), "stop_sell_baja" = numeric(), "stop_sell_sube" = numeric())


criterios_previos = function(numero) {

  activo = unique(ibex_data$X)[numero]
  volumen = select(ibex_data, X, vol, close)
  volumen = filter(volumen, X == activo)
  volumen_medio = mean(volumen$vol)
  cierre_medio = mean(volumen$close)
  capital_diario = (volumen_medio * cierre_medio) * 0.005
  
  
  cuantil = select(ibex_data, X, high, low, open)
  cuantil_activo = filter(cuantil, X == activo)
  cuantil_stop_profit = cuantil_activo$high - cuantil_activo$open
  cuantil_stop_profit = quantile(cuantil_stop_profit, probs = seq(0.1, length(100), by = .1))
  stop_sell_sube = as.numeric(cuantil_stop_profit[3])
  
  cuantil_stop_loss = cuantil_activo$open - cuantil_activo$low
  cuantil_stop_loss = quantile(cuantil_stop_loss, probs = seq(0.1, length(100), by = .1))
  stop_sell_baja = as.numeric(cuantil_stop_loss[8])
  
  actualiza = data.frame("asset" = activo, "capital_diario" = capital_diario, "stop_sell_baja" = stop_sell_baja, "stop_sell_sube" = stop_sell_sube)
  criterios = rbind(compra_venta, actualiza)

}

numero = 1:length(unique(ibex_data$X))
criterios_para_activos = sapply(numero, criterios_previos)
criterios_para_activos = as.data.frame(criterios_para_activos)
criterios_para_activos = t(criterios_para_activos)
criterios_para_activos = as.data.frame(criterios_para_activos)
criterios_para_activos$asset = as.character(unlist(criterios_para_activos$asset))
criterios_para_activos$capital_diario = unlist(criterios_para_activos$capital_diario)
criterios_para_activos$stop_sell_baja = unlist(criterios_para_activos$stop_sell_baja)
criterios_para_activos$stop_sell_sube = unlist(criterios_para_activos$stop_sell_sube)

ibex_data$capital_diario = c("")
ibex_data$stop_sell_baja = c("")
ibex_data$stop_sell_sube = c("")

#Incluyo los nuevos parametros en IBEX_DATA

for (numero in 1:length(unique(ibex_data$X))) {
  
  activo = unique(ibex_data$X)[numero]
  
  ibex_data[ibex_data$X == activo, "capital_diario" ] = as.numeric(select(filter(criterios_para_activos, asset == activo), capital_diario))
  ibex_data[ibex_data$X == activo, "stop_sell_baja"] = as.numeric(select(filter(criterios_para_activos, asset == activo), stop_sell_baja))
  ibex_data[ibex_data$X == activo, "stop_sell_sube"] = as.numeric(select(filter(criterios_para_activos, asset == activo), stop_sell_sube))

}





recorremos = function(vector) {

  
  activo = ibex_data$X[vector]
  dia = ibex_data$X.1[vector]
  precio_apertura = ibex_data$open[vector]
  precio_baja = ibex_data$low[vector]
  precio_sube = ibex_data$high[vector]
  precio_cierre = ibex_data$close[vector]
  trigger = ibex_data$price_departure[vector]
  
 
  capital_diario = as.numeric(ibex_data$capital_diario[vector])
  stop_sell_baja = as.numeric(ibex_data$stop_sell_baja[vector])
  stop_sell_sube = as.numeric(ibex_data$stop_sell_sube[vector])
  
  compra = (capital_diario) / precio_apertura
  stop_loss = precio_apertura - stop_sell_baja
  stop_profit = precio_apertura + stop_sell_sube
  
  if (trigger >= 0.75) {
    
    if (precio_baja<= stop_loss) {
      orden_venta = compra * stop_loss
      count_stoploss = 1
    } else if (precio_sube >= stop_profit) {
      orden_venta = compra * stop_profit
      count_stoprofit = 2
    } else {
      orden_venta = compra * precio_cierre
      no_stop = 3
    }
    
  } else {
    orden_venta = 000000
  }
  
  venta_neta = orden_venta - (orden_venta * comision) - (capital_diario * comision)
  
  if (venta_neta == - (orden_venta * comision) - (capital_diario * comision)) {
    venta_neta = 0
  }
  
  
  actualizado = data.frame("fecha" = dia, "open" = precio_apertura, "low" = precio_baja, "high" = precio_sube, "ticker" = activo, "compra" = capital_diario, "venta" = venta_neta, "stop_loss" = count_stoploss, "stop_profit" = count_stoprofit, "no_stop" = no_stop)
  compra_venta = rbind(compra_venta, actualizado)
}

#Ejecuto la funcion y la guardo en un data frame

vector = c(1:133660)
matriz_compra_venta = sapply(vector, recorremos)
df_diario = as.data.frame(matriz_compra_venta)
df_diario = t(df_diario)
df_diario = as.data.frame(df_diario)
as.character(df_diario$ticker)

#Me devuelve con dataframe con listas dentro de las columnas, y las unlisteo
df_diario$ticker = unlist(df_diario$ticker)
df_diario$fecha = unlist(df_diario$fecha)
df_diario$compra = unlist(df_diario$compra)
df_diario$venta = unlist(df_diario$venta)
df_diario$stop_loss = unlist(df_diario$stop_loss)
df_diario$stop_profit = unlist(df_diario$stop_profit)
df_diario$no_stop = unlist(df_diario$no_stop)
df_diario$open = unlist(df_diario$open)
df_diario$low = unlist(df_diario$low)
df_diario$high = unlist(df_diario$high)
df_diario = filter(df_diario, venta != 0.00)


#Calculo el beneficio acumulado por activo 

beneficio = function(activo) {
  
  filtro = filter(df_diario, ticker == activo)
  total_compra = sum(filtro$compra)
  total_venta = sum(filtro$venta)
  beneficio_acumulado = total_venta - total_compra
  
} 

activo = unique(df_diario$ticker)
beneficio_acumulado  = sapply(activo, beneficio)
beneficio_acumulado = round(beneficio_acumulado, digits = 3)
beneficio_acumulado = as.data.frame(beneficio_acumulado)



#ELIMNO CAR DEL DF RESULTADO PORQUE NO TIENE OPERACIONES EJECUTADAS

ejercicio_8$CAR = NULL
ejercicio_8$MAS = NULL

#Inserto el beneficio acumulado en el data frame resultado



ejercicio_8["Beneficio acumulado", ] = beneficio_acumulado$beneficio_acumulado

ejercicio_8["Beneficio acumulado", ] = unlist(ejercicio_8["Beneficio acumulado", ])

#Calculo el numero de operaciones por activo

operaciones = function(activo) {
  nrow(filter(df_diario, ticker == activo))
}

activo = unique(df_diario$ticker)
n_operaciones  = sapply(activo, operaciones)

#Inserto el numero de operaciones por activo en el data frame resultado

ejercicio_8["Número de operaciones", ] = n_operaciones

#Calculo el beneficio medio por accion

bmedio = function(activo) {
  z = ejercicio_8["Beneficio acumulado", activo] 
  y = ejercicio_8["Número de operaciones", activo]
  as.numeric(z)/as.numeric(y)
}

activo = unique(df_diario$ticker)
beneficio_med  = sapply(activo, bmedio)

#Inserto el beneficio medio por operacion en el data frame resultado

ejercicio_8["Bº medio por operación", ] = round(beneficio_med, digits = 3)

#Calculo la horquilla superior media

horquilla = function(activo) {
  
  z = filter(df_diario, ticker == activo)
  z = select(z, high, open)
  z = z$high - z$open
  mean(z)
  
}

activo = unique(df_diario$ticker)
horquilla_superior = sapply(activo, horquilla)

#Inserto la horquilla superior media en el data frame resuelto

ejercicio_8["Horquilla superior media", ] = round(horquilla_superior, digits = 3)

#Calculo la horquilla inferior media


horquilla_inf = function(activo) {
  
  y = filter(df_diario, ticker == activo)
  y = select(y, open, low)
  y = y$open - y$low
  mean(y)
  
}

activo = unique(df_diario$ticker)
horquilla_inferior = sapply(activo, horquilla_inf)

#Inserto la horquilla inferior media en el data frame resuelto

ejercicio_8["Horquilla inferior media", ] = round(horquilla_inferior, digits = 3)


#Calculo porcecntaje de dias positivos y negativos



dias_positivos = function(activo) {
  k = filter(df_diario, ticker == activo)
  positivo = filter(k, stop_profit == 2)
  positivo = as.data.frame(positivo)
  dias_pos = length(positivo$stop_profit)
  dias_totales = nrow(k)
  porcentaje_dias_positivos = dias_pos/dias_totales
  return(porcentaje_dias_positivos)
}



dias_negativos = function(activo) {
  k = filter(df_diario, ticker == activo)
  negativo = filter(k, stop_loss == 1)
  negativo = as.data.frame(negativo)
  dias_neg = length(negativo$stop_loss)
  dias_totales = nrow(k)
  porcentaje_dias_negativos = dias_neg/dias_totales
  return(porcentaje_dias_negativos)
}


activo = unique(df_diario$ticker)
porcentaje_positivo = sapply(activo, dias_positivos)

activo = unique(df_diario$ticker)
porcentaje_negativo = sapply(activo, dias_negativos)

#Inserto porcentajes dias positivos y negativos en el data frame resuelto

ejercicio_8["% días positivos", ] = round(porcentaje_positivo, digits = 5)
ejercicio_8["% días negativos", ] = round(porcentaje_negativo, digits = 5)



df_diario$beneficio_diario = df_diario$venta - df_diario$compra


#Calculo el importe medio por operacion y lo inserto en el resultado

importe_operacion = select(criterios_para_activos, asset, capital_diario)
importe_operacion = filter(importe_operacion, asset != "MAS", asset != "CAR")
ejercicio_8["Importe medio por operación", ] = round(unlist(importe_operacion$capital_diario), digits = 3)

#calculo el beneficio medio por euro invertido y lo inserto en el resultado

medio_por_euro = as.numeric(ejercicio_8["Bº medio por operación", ]) / as.numeric(ejercicio_8["Importe medio por operación", ]) 
ejercicio_8["Bº medio por euro invertido", ] = round(medio_por_euro, digits = 5)

#Calculo el stop loss y profit y lo inserto en el resultado

stop_profit_objetivo = select(criterios_para_activos, asset, stop_sell_sube)
stop_profit_objetivo = filter(stop_profit_objetivo, asset != "MAS", asset != "CAR")
ejercicio_8["Stop profit objetivo", ] = round(unlist(stop_profit_objetivo$stop_sell_sube), digits = 3)

stop_loss = select(criterios_para_activos, asset, stop_sell_baja)
stop_loss = filter(stop_loss, asset != "MAS", asset != "CAR")
ejercicio_8["Stop loss", ] = -(round(unlist(stop_loss$stop_sell_baja), digits = 3))

#GRAFICAMOS 

graficamos = function(activo) { 
  
  z = filter(df_diario, ticker == activo)
  z$beneficio_diario_acumulado = cumsum(z$beneficio_diario)
  y = z$beneficio_diario_acumulado
  x = c(1:length(y))
  plot(x, y, type = "l", main = activo, ylab = " ", xlab = " ")
  
} 

activo = unique(df_diario$ticker)
sapply(activo, graficamos)

#EJERCICIO 9

#Obtén de la CNMV la suma de las posiciones largas, para cada empresa, del listado de empresas que se indica más abajo. Ten cuidado, la url cambia cada día, por lo que deberás solventar este problema.


section#maincontent

library(rvest)
library(tidyverse)
library(tryCatchLog)

NIF = data.frame(TELEFONICA = "A-28015865", BBVA = "A-48265169", ACS = "A-28004885",  ACCIONA = "A08001851", ACERINOX = "A-28250777", AENA = "A86212420",
                 ALRMIRALL = "A-58869389&lang=es", AMADEUS = "A-84236934", ARCELORMITTAL = "N0181056C" ,  BANCO_SANTANDER = "A39000013" , BANCO_SABADELL= "A-08000143" ,
                 BANKINTER = "A28157360",  CELLNEX = "A64907306",  CIE_AUTOMOTIVE = "A-20014452",  ENAGAS = "A-28294726", ENDESA = "A-28023430",  FERROVIAL= "A81939209",
                 FLUIDRA = "A-17728593",  GRIFOLS = "A-58389123", IAG = "A85845535" , IBERDROLA = "A-48010615",   INDITEX =  "A-15075062",  INDRA = "A-28599033", COLONIAL = "A-28027399" , 
                 MAPFRE = "A08055741" ,  MELIA = "A78304516", MERLIN_PROPERTIES = "A86977790" ,  NATURGY = "A-08015497",  PHARMAMAR = "A-78267176", RED_ELECTRICA = "A-78003662",
                 REPSOL = "A-78374725",  SIEMES_GAMESA = "A-01011253",  SOLARIA = "A83511501",  VISCOFAN =  "A-31065501")

posiciones = NIF[1, ]
posiciones[1, ] = ""
as.character(posiciones[1, ])

vector = NIF[1 , ]  

for (numero in 1:length(vector)) {
  
  
  nif = NIF[1,numero]
  
  CNMV = read_html(paste0("https://www.cnmv.es/Portal/Consultas/DerechosVoto/PS_AC_INI.aspx?nif=", nif))
  
  enlace = as.data.frame(CNMV %>%
    html_nodes("a") %>%
    html_attr(name = "href"))
    
  link = read_html(paste0("https://www.cnmv.es/Portal/Consultas/DerechosVoto/", enlace[110, ]))
  tabla = link %>%
          html_nodes("section#maincontent") %>%
          html_table()
   
  datos = as.data.frame(tabla)
  datos = select(datos, X6)
  datos = datos[4:nrow(datos) , ]
  
  posiciones_largas = datos
  posiciones_largas = gsub(",", ".", posiciones_largas) 
  posiciones_largas = sum(as.numeric(posiciones_largas))
  posiciones[1, numero] = posiciones_largas
  
}

ejercicio_9 = posiciones

#Falta caixabank porque no he conseguido entrar en la web utilizando mi método. No me dejaba desde el CIF. 

#En cuanto a la respuesta a la pregunta planteada para este ejercicio, a mi parecer las posiciones largas pueden ser superiores al 100% en algunos casos debido a que
#Puede haber determinados derechos societarios que den lugar a un derecho de suscripción en una eventual ampliación de capital, pero que todavía no se han ejercido porque
#No se ha producido dicha ampliación. También podría suceder con la existencia de deuda convertible, la cual en determinados casos (i.e. el precio de la accion es superior al premium de la conversión)
#Podría considerarse como una posición larga en equity. 











  


  
  
  
 

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  
  


  
  
  
  

  















