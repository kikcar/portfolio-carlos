import requests
from bs4 import BeautifulSoup
import os
import numpy as np
import pandas as pd
from tqdm import tqdm



def limpiar_datos(df):
    '''Reemplazamos nulls y vacíos por NaN,
    limpamos los gaps en las cotizaciones'''

    df[df == 'null'] = np.nan
    df.replace('', np.nan)
    df.replace(' ', np.nan)
    df.replace('-', np.nan)
    df.replace('NA', np.nan)

    df = df.iloc[:].fillna(method="pad")
    df = df.iloc[:].fillna(method="bfill")
    return(df)
    
    
def homogeneización_fondos(df_allfunds,porcentaje_dias_cotizados):
    
    fechas = df_allfunds.index
    fechas = pd.date_range(fechas[0], fechas[-1], freq='B')
    activos = pd.DataFrame(index=fechas, columns=[df_allfunds["isin"].unique()])
    for fecha in tqdm(fechas):
        filtro = df_allfunds.loc[fecha, "isin":"nav"].drop_duplicates("isin")
        nav = filtro["nav"]
        indice_isin = df_allfunds.loc[fecha]["isin"].unique()
        activos.loc[fecha][indice_isin] = np.array(nav)
        
    filtro = activos.columns[(activos.count() >= (len(fechas) * porcentaje_dias_cotizados)) == True]
    activos = activos.loc[:, filtro]
    activos = limpiar_datos(activos)
    activos.to_pickle("fondos_homogeneizados.pkl")  
    return(activos)

def alpha_jensen(datos_fondos, msci_world, ventana):
    
    alphas_ventana = []
    rent_activos = np.log(datos_fondos).diff()
    rent_msci= np.log(msci_world).diff()
    varianza_ind = rent_msci.rolling(ventana).var()
    matriz_covarianza = rent_activos.rolling(ventana).cov(rent_msci)
    matriz_betas = matriz_covarianza.divide(varianza_ind, axis = 0)
    alpha_activos = rent_activos + (matriz_betas.mul(rent_msci.values, axis = 0))
    alpha_activos = alpha_activos.dropna()
    alphas_ventana.append(alpha_activos)
    return(alphas_ventana)

def calculo_alpha(ventanas_alpha, datos_fondos, fecha_compra, fecha_venta, ventana):
    activos_seleccionables = np.where(ventanas_alpha[ventana][fecha_compra] > 0)
    fondos_seleccionados = np.random.choice(activos_seleccionables[0], np.random.randint(2,30)).tolist()
    cartera_mono = datos_fondos[ventana][fondos_seleccionados]
    pesos_cartera = np.random.randint(1,100, size = len(cartera_mono))
    pesos_cartera = pesos_cartera/pesos_cartera.sum()
    compra_mono = cartera_mono
    venta_mono = datos_fondos[fecha_venta][fondos_seleccionados]
    rentabilidad_mono = 1 + ((venta_mono/compra_mono - 1)*pesos_cartera).sum()
    return(rentabilidad_mono)

def habilidad_alpha(ventanas_alpha, datos_fondos, ventana):
    fecha_compra = ventana
    datos_fondos_ventana = datos_fondos[0:ventanas_alpha[ventana].shape[0],]
    fecha_venta = np.random.randint(fecha_compra,datos_fondos_ventana.shape[0])
    rentabilidad_mono = calculo_alpha(ventanas_alpha, datos_fondos_ventana, fecha_compra, fecha_venta, ventana)
    rentabilidad_acumulada = rentabilidad_mono
    posibilidad_reinvertir = np.random.randint(80,100)/100
    while (rentabilidad_acumulada >= posibilidad_reinvertir) == True:
        fecha_compra = fecha_venta + 1
        if fecha_compra >= datos_fondos_ventana.shape[0]:
            break
        else:
            fecha_venta = np.random.randint(fecha_compra,datos_fondos_ventana.shape[0])
            rentabilidad_mono = calculo_alpha(ventanas_alpha, datos_fondos_ventana, fecha_compra, fecha_venta, ventana)
            rentabilidad_acumulada = rentabilidad_acumulada * rentabilidad_mono   
    return(rentabilidad_acumulada)

def ratio_sharpe(datos_fondos, windows):
    rent_activos = np.log(pd.DataFrame(datos_fondos)).diff()
    sharpe_ventanas = {}
    for ventana in windows:
        volatilidad = (rent_activos.rolling(ventana).var() ** 0.5)
        sharpe = rent_activos/volatilidad
        sharpe.replace([np.inf, -np.inf], np.nan, inplace = True)
        sharpe = sharpe.fillna(0)
        sharpe = sharpe.iloc[ventana:,:]
        sharpe_ventanas[ventana] = np.array(sharpe)
    return(sharpe_ventanas)


def calculo_sharpe(ventanas_sharpe, datos_fondos, fecha_compra, fecha_venta, ventana):
    activos_seleccionables = np.where(ventanas_sharpe[ventana][fecha_compra] > 0)
    fondos_seleccionados = np.random.choice(activos_seleccionables[0], np.random.randint(2,30)).tolist()
    cartera_mono = datos_fondos[ventana][fondos_seleccionados]
    pesos_cartera = np.random.randint(1,100, size = len(cartera_mono))
    pesos_cartera = pesos_cartera/pesos_cartera.sum()
    compra_mono = cartera_mono
    venta_mono = datos_fondos[fecha_venta][fondos_seleccionados]
    rentabilidad_mono = 1 + ((venta_mono/compra_mono - 1)*pesos_cartera).sum()
    return(rentabilidad_mono)

def habilidad_sharpe(ventanas_sharpe, datos_fondos, ventana):
    fecha_compra = ventana
    datos_fondos_ventana = datos_fondos[0:ventanas_sharpe[ventana].shape[0],]
    fecha_venta = np.random.randint(fecha_compra,datos_fondos_ventana.shape[0])
    rentabilidad_mono = calculo_sharpe(ventanas_sharpe, datos_fondos_ventana, fecha_compra, fecha_venta, ventana)
    rentabilidad_acumulada = rentabilidad_mono
    posibilidad_reinvertir = np.random.randint(80,100)/100
    while (rentabilidad_acumulada >= posibilidad_reinvertir) == True:
        fecha_compra = fecha_venta + 1
        if fecha_compra >= datos_fondos_ventana.shape[0]:
            break
        else:
            fecha_venta = np.random.randint(fecha_compra,datos_fondos_ventana.shape[0])
            rentabilidad_mono = calculo_sharpe(ventanas_sharpe, datos_fondos_ventana, fecha_compra, fecha_venta, ventana)
            rentabilidad_acumulada = rentabilidad_acumulada * rentabilidad_mono   
    return(rentabilidad_acumulada)

    
def habilidad_markowitz(datos_fondos, rentabilidad_fondos, simulaciones):
    ventana_marko = 250
    simulaciones_marko = 100
    fecha_compra = ventana_marko + 1
    posibilidad_reinvertir = np.random.randint(80,100)/100
    rentabilidad_acumulada = 1
    while (rentabilidad_acumulada >= posibilidad_reinvertir) == True:
        if fecha_compra >= datos_fondos.shape[0]:
            break 
        fecha_venta = np.random.randint(fecha_compra,datos_fondos.shape[0])
        activos_seleccionados = np.random.randint(0,(rentabilidad_fondos.shape[1]-1),size=np.random.randint(2,30))
        rent_activos = rentabilidad_fondos[((fecha_compra-1)-ventana_marko):(fecha_compra-1),activos_seleccionados]
        matriz_covarianzas= np.cov(rent_activos, rowvar = False)
        rent_diaria = np.cumsum(rent_activos, axis = 0)[-1]/ventana_marko
        pesos = np.random.randint(1,100,(simulaciones_marko,rent_activos.shape[1]))
        pesos = pesos/np.sum(pesos)
        rentabilidad_carteras = np.dot(rent_diaria, np.transpose(pesos))
        matriz_intermedia = np.dot(matriz_covarianzas,pesos.T)
        matriz_intermedia = np.transpose(matriz_intermedia)
        matriz_intermedia = matriz_intermedia * pesos
        riesgo_carteras = np.sum(matriz_intermedia, axis = 1) ** 0.5
        eficiencia_carteras = rentabilidad_carteras / riesgo_carteras
        pesos_eficientes = pesos[eficiencia_carteras.argmax(),:]
        operacion = (datos_fondos[fecha_venta,activos_seleccionados]/datos_fondos[fecha_compra,activos_seleccionados])
        rentabilidad_mono = 1 + np.transpose(pesos_eficientes)@(operacion)
        fecha_compra = fecha_venta + 1
        rentabilidad_acumulada = rentabilidad_acumulada * rentabilidad_mono  
    return(rentabilidad_acumulada)

def calculo_aleatorio(fecha_compra, fecha_venta, datos_fondos):

    fondos_seleccionados = np.random.randint(0,datos_fondos.shape[1],size=np.random.randint(2,30))
    cartera_mono = datos_fondos[fecha_compra][fondos_seleccionados]
    pesos_cartera = np.random.randint(1,100, size = len(cartera_mono))
    pesos_cartera = pesos_cartera/pesos_cartera.sum()
    compra_mono = cartera_mono
    venta_mono = datos_fondos[fecha_venta][fondos_seleccionados]
    rentabilidad_mono = 1 + ((venta_mono/compra_mono - 1)*pesos_cartera).sum()
    return(rentabilidad_mono)

def habilidad_aleatorio(datos_fondos):
    fecha_compra = 0
    fecha_venta = np.random.randint(fecha_compra, datos_fondos.shape[0])
    rentabilidad_mono = calculo_aleatorio(fecha_compra, fecha_venta, datos_fondos)
    rentabilidad_acumulada = rentabilidad_mono
    posibilidad_reinvertir = np.random.randint(80,100)/100
    while (rentabilidad_acumulada >= posibilidad_reinvertir) == True:
        fecha_compra = fecha_venta + 1
        if fecha_compra >= datos_fondos.shape[0]:
            break
        else:
            fecha_venta = np.random.randint(fecha_compra, datos_fondos.shape[0])
            rentabilidad_mono = calculo_aleatorio(fecha_compra, fecha_venta, datos_fondos)
            rentabilidad_acumulada = rentabilidad_acumulada * rentabilidad_mono   
    return(rentabilidad_acumulada)

