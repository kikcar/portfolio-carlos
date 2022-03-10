import glob
import os
import pandas as pd
import numpy as np
from datetime import timedelta
import datetime


def read_multiple_csv(directorio):
    '''Lee todos los CSV que hay en un directorio y
    los mete dentro de una lista'''

    archivos_csv = glob.glob(os.path.join(directorio, '*.csv'))
    lista_csv = []
    for archivo in archivos_csv:
        df = pd.read_csv(archivo)
        lista_csv.append(df)
    return(lista_csv)


def dataframe_fondos(lista_csv):
    '''Leemos la lista de dataframes y concatenamos los
    70 archivos en un único df. Dejamos el último como un df
    a parte.'''
    indice_fondos = lista_csv[-1]
    df_allfunds = pd.concat(lista_csv[0:(len(lista_csv)-1)], ignore_index=True)
    df_allfunds = df_allfunds.set_index(df_allfunds["date"])
    df_allfunds = df_allfunds.sort_index()
    return(df_allfunds, indice_fondos)


def homogeneizar_datos(df, porcentaje_dias_cotizados):
    '''Homogeneizamos los datos de los fondos dejando unas fechas únicas
    y los fondos como columnas cada uno con sus respectivos NAV'''
    fechas = df["date"].unique()
    fechas.sort()
    fechas = pd.date_range(fechas[0], fechas[-1], freq='B')
    fechas = fechas.strftime("%Y-%m-%d")
    activos = pd.DataFrame(index=fechas, columns=[df["isin"].unique()])
    activos.columns = activos.columns.map(''.join)

    for numero in range(0, len(fechas)):
        fecha = fechas[numero]
        filtro = df.loc[fecha, "isin":"nav"].drop_duplicates("isin")
        nav = filtro["nav"]
        indice_isin = df.loc[fecha]["isin"].unique()
        activos.loc[fecha][indice_isin] = np.array(nav)

    filtro = activos.columns[(activos.count() >= (len(fechas) * porcentaje_dias_cotizados)) == True]
    activos = activos.loc[:, filtro]
    return(activos)


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

    
def markowitz(rentabilidad_fondos, lista, rentabilidad_diaria):
    '''Pasamos el df de los fondos limpios, y una lista que contiene un array con
    los activos seleccionados, y la matriz de cov para esos activos.'''
    activos_seleccionados = lista
   
    pesos = np.random.random(len(activos_seleccionados))
    pesos = pesos/np.sum(pesos)
        
    matriz_covarianzas = rentabilidad_fondos.iloc[:,activos_seleccionados].cov()
    rentabilidad_diaria = rentabilidad_diaria.iloc[activos_seleccionados]
    rentabilidad_cartera = np.dot(pesos.T,rentabilidad_diaria)
    riesgo_carteras = np.dot(pesos.T,np.dot(matriz_covarianzas,pesos))
    riesgo_carteras = riesgo_carteras**0.5
    eficiencia_carteras = rentabilidad_cartera/riesgo_carteras
    resultado = {"tamaño_cartera": len(lista),"activos_seleccionados": activos_seleccionados,"pesos": pesos, "riesgo": riesgo_carteras, "rentabilidad": rentabilidad_cartera,"eficiencia":      eficiencia_carteras}
    return(resultado)



