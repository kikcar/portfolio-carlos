import numpy as np
import pandas as pd


def labelling(df, tiempo, porcentaje):

    label = list()
    fecha = list()

    for posicion in np.arange(0, len(df)):

        inicio = df.iloc[posicion][0]
        barrera_superior = inicio * (1 + porcentaje)
        barrera_inferior = inicio * (1 - porcentaje)
        rango = (df.iloc[(posicion + 1):(posicion + 1 + tiempo)][0]).tolist()

        if len(rango) < tiempo:
            label.append("NULL")
            fecha.append(df.index[posicion])
        else:

            if (rango >= barrera_superior).any() == False and (
                    rango <= barrera_inferior).any() == False:
                # La serie sale por el final, no ha tocado ninguna de las dos
                # barras.
                label.append(0)
                fecha.append(df.index[posicion])
            else:
                rango = np.array(rango)
                if (rango >= barrera_superior).any() and (
                        rango <= barrera_inferior).any() == False:
                    label.append(1)
                    fecha.append(df.index[posicion])
                elif (rango >= barrera_superior).any() == False and (rango <= barrera_inferior).any() == True:
                    label.append(-1)
                    fecha.append(df.index[posicion])
                elif np.min(np.where(rango >= barrera_superior)) < np.min(np.where(rango <= barrera_inferior)):
                    label.append(1)
                    fecha.append(df.index[posicion])
                else:
                    label.append(-1)
                    fecha.append(df.index[posicion])

    label = pd.DataFrame(label, index=fecha)
    dbar_etiquetas = pd.concat([df, label], ignore_index=True, axis=1)
    dbar_etiquetas = dbar_etiquetas.set_axis(["precio", "label"], axis=1)
    dbar_etiquetas = dbar_etiquetas[dbar_etiquetas != "NULL"]
    dbar_etiquetas = dbar_etiquetas.dropna()

    return(dbar_etiquetas, tiempo, porcentaje)


def bb(df, dias, n_std):

    asset = 0
    buy = list()
    sell = list()

    for numero, date in enumerate(df.index):

        precio_hoy = df["close"][date]
        band_upper = df["upper_band"][date]
        precio_ante_ayer = df["close"][numero - 2]
        banda_lower_ante_ayer = df["lower_band"][numero - 2]
        precio_ayer = df["close"][numero - 1]
        band_lower_ayer = df["lower_band"][numero - 1]
        band_upper_ayer = df["upper_band"][numero - 1]
        band_upper_ante_ayer = df["upper_band"][numero - 2]
        
        if numero == list(enumerate(df.index))[-1][0] and asset == 1:
            sell_signal = (date, precio_hoy)
            asset = 0
            sell.append(sell_signal)

        if asset == 0:
            if precio_ante_ayer < banda_lower_ante_ayer and precio_ayer > band_lower_ayer:
                buy_signal = (date, precio_hoy)
                asset = 1
                buy.append(buy_signal)

        elif asset == 1:

            if precio_ante_ayer < band_upper_ante_ayer and precio_ayer >= band_upper_ayer:
                sell_signal = (date, precio_hoy)
                asset = 0
                sell.append(sell_signal)

    if len(buy) and len(sell) >= 1:
        compras = pd.DataFrame(buy)
        ventas = pd.DataFrame(sell)
        result = pd.concat([compras, ventas], axis=1)
        result = result.dropna()
        result = result.set_axis(
            ['Fecha_C', 'Precio_C', 'Fecha_V', 'Precio_V'], axis=1)

        rentabilidad_media = (
            np.mean(result["Precio_V"] / result['Precio_C'] - 1)) * 100

        return(rentabilidad_media, dias, n_std)


def simulador_escenarios(sp500, dias, n_std):

    mv_avg = sp500.rolling(dias).mean()
    std = sp500.rolling(dias).std()
    upper_band = mv_avg + n_std * std
    lower_band = mv_avg - n_std * std

    df = pd.concat([sp500, upper_band, lower_band], axis=1)
    df = pd.DataFrame(df)
    df = df.set_axis(["close", "upper_band", "lower_band"], axis=1)
    df = df.dropna()

    return(df, dias, n_std)
