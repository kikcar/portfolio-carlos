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