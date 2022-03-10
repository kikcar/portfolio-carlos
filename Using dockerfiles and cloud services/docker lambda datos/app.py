import pandas as pd
import numpy as np
import requests
from datetime import date, timedelta, datetime


def handler(event, context):

    # Nos conectamos con S3 de AWS y descargamos el ultimo csv disponible
    precios_diarios = pd.read_csv(
        f"s3://{'precios.diarios'}/{'precios_diarios.csv'}",
        storage_options={
            'key': '***',
            'secret': '****'
        },
    )

    # Inicializamos la url que debemos atacar, a falta de completar con la
    # fecha deseseada
    link = "https://api.esios.ree.es/archives/70/download_json?locale=es&date="

    # Consultamos la ultima fecha disponible en el csv
    ultima_fecha_disponible = datetime.strptime(
        precios_diarios.columns[-1], "%Y-%m-%d")

    # Generamos el rango de fechas por completar
    rango_fechas = pd.date_range(start=ultima_fecha_disponible + timedelta(days=1),
                                 end=date.today()).tolist()

    # Inicializamos el df que recibira los nuevos datos
    nuevos_datos = pd.DataFrame()

    # Iteramos sobre cada una de las fechas pendientes de descargar
    for fecha in rango_fechas:

        # Construimos la url con la fecha concreta
        url = link + str(fecha)
        response = requests.get(url)
        df = pd.DataFrame(response.json()['PVPC'])

        # Buscamos el precio (GEN o PCB, en funcion de la version)
        if 'GEN' in df.columns:
            data = df[['GEN']]
            data = [pd.to_numeric(x.replace(',', '.'))
                    for x in data.GEN]

        if 'PCB' in df.columns:
            data = df[['PCB']]
            data = [pd.to_numeric(x.replace(',', '.'))
                    for x in data.PCB]

        # En contadas ocasiones el API devuelve menos/mas de 24 precios (hora)
        # Para homogeneizar el data frame:
        # Completamos con 0, si la respuesta tiene menos de 25 horas
        if len(data) < 24:
            data.append(0)
        # Descartamos los valores correspondientes a la hora 25 en adelante
        if len(data) > 24:
            data = data[:24]

        nuevos_datos[str(fecha)[:-9]] = data

    # Reemplazamos 0 por NaN y completamos con la ultima hora disponible
    nuevos_datos.replace(0, np.nan, inplace=True)
    nuevos_datos.ffill(axis=0)

    # Completamos la base de datos con los nuevos precios
    base_datos_completo = pd.concat([precios_diarios, nuevos_datos], axis=1)

    # Conectamos con S3 de ASW y almacenamos la base de datos completa
    base_datos_completo.to_csv(
        f"s3://{'precios.diarios'}/{'precios_diarios.csv'}",
        storage_options={
            'key': 'AKIAZOSB643XWUVJ3SX6',
            'secret': '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'
        },
    )

    return
