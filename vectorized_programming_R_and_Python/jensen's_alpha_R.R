

library(profvis)
library(roll)
profvis({
  
  tiempo =  proc.time()
  
  # Cargamos los datos y extraemos por un lado los activos, la renta fija y el índice Dax
  datos =  read.csv("C:/Users/Carlos/Google Drive/MIA-X/Modulo 2/Dias 1, 2 y 3 (ejercicios sin resolver)/Días 3 , 4 y 5/Ejercicios sin resolver/DAX.csv", header = T, sep = ";") 

  n_activos =  length(datos)-2
  activos=  datos[,2:n_activos] # Extraemos los activos quitando las dos últimas columnas y la primera.
  BUND =  datos[,length(datos)] # Extraemos la renta fija.
  DAX =  datos[,length(datos)-1] # Extraemos el índice.
  rango_fechas =  as.Date(datos[,1])
  
  # Calculamos la rentabilidad de los 10 primeros días para usarlos como datos iniciales.
  rent_activos= as.data.frame(matrix(0,nrow=dim(activos)[1],ncol=length(activos),byrow=F)) 
  names(rent_activos)= names(activos) # Ponemos nombres a las columnas
  rownames(rent_activos) = datos[,1] # Ponemos nombres a las filas.
  
  rent_BUND =  rep(0,length(BUND)) # Genero un vector donde guardaré las rentabilidades de la renta fija.
  rent_DAX =  rep(0,length(DAX)) # Genero un vector donde guardaré las rentabilidades del índice.
  
  alpha_activos= as.data.frame(matrix(0,nrow=dim(activos)[1],ncol=length(activos),byrow=F)) 
    names(alpha_activos)= names(activos) # Ponemos nombres a las columnas
    rownames(alpha_activos) =  datos[,1] # Ponemos nombres a las filas.
    
    matriz_covarianza= as.data.frame(matrix(0,nrow=dim(activos)[1],ncol=length(activos),byrow=F)) 
    names(matriz_covarianza)= names(activos) # Ponemos nombres a las columnas
    rownames(matriz_covarianza) =  datos[,1] # Ponemos nombres a las filas.
  
    matriz_betas= as.data.frame(matrix(0,nrow=dim(activos)[1],ncol=length(activos),byrow=F)) 
    names(matriz_betas)= names(activos) # Ponemos nombres a las columnas
    rownames(matriz_betas) =  datos[,1] # Ponemos nombres a las filas.
  

  # Teniendo ya datos históricos, calculamos los Alphas para cada día con un bucle.

  rent_activos[2:dim(activos)[1],1:length(activos)] = log(activos[2:dim(activos)[1],1:length(activos)]/activos[(1:dim(activos)[1])-1,(1:length(activos))])
  rent_BUND[2:length(rent_BUND)] =  log(BUND[2:length(BUND)]/BUND[(1:length(BUND))-1])
  rent_DAX[2:length(rent_DAX)] = log(DAX[2:length(DAX)]/DAX[(1:length(DAX))-1])
    
    # Calculamos la varianza del DAX
  
  varianza_ind = roll_var(rent_DAX, 30)
  
    # Calculamos la covarianza entre el activo y el índice
  
  for (activo in 1:length(rent_activos)){
    matriz_covarianza[ ,activo] = roll_cov(rent_DAX, rent_activos[ ,activo], 30)
  }  
  
  matriz_betas[1:dim(activos)[1],1:length(activos)] = matriz_covarianza[1:dim(matriz_covarianza)[1], 1:length(matriz_covarianza)]/varianza_ind

      # Calculamos el Alpha del activo. α=Rc-(Rf+β(Rm-Rf))
  
  alpha_activos[1:dim(activos)[1],1:length(activos)]=  rent_activos[1:dim(rent_activos)[1],1:length(rent_activos)] - (rent_BUND[1:length(rent_BUND)] + matriz_betas[1:dim(activos)[1],1:length(activos)] * (rent_DAX[1:length(rent_DAX)] - rent_BUND[1:length(rent_BUND)]))
  alpha_activos = na.omit(alpha_activos)
   -
  print(proc.time()-tiempo)

})



