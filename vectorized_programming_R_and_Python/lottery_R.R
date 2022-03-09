# Vectoriza todo el programa

library(profvis)
library(plyr) 
library(Rfast)

profvis({
  
  tiempo <- proc.time()
  
  # Establecemos una semilla de generación aleatoria determinada para que los rdos sean siempre iguales.
  set.seed(1000)
  
  # Sacamos la combinación ganadora y la guardamos en un vector de 50 columnas.
  combi_ganadora = c(sample(c(rep(1,5),rep(0,45)), 50, replace = FALSE))
  
  # Sacamos 50.000 combinaciones. 
  
  apuestas = matrix(sample(c(rep(1,5),rep(0,45)), 50, replace = FALSE), nrow = 50000, ncol = 50, byrow = TRUE)
  apuestas = colShuffle(t(apuestas))
  
  # Sumamos las filas para obtener el número de aciertos de cada apuesta
  num_aciertos = apuestas * combi_ganadora
  num_aciertos = rowSums(t(num_aciertos))
  
  # Calculamos la frecuencia de los aciertos (cuantas veces hemos acertado 1 nº, cuantas veces 2 etc)
  aciertos<-count(num_aciertos)
  aciertos
  
  print(proc.time()-tiempo)
})





