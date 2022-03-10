import dash
from dash import dcc
from dash import html
from datetime import date
import datetime
import plotly.express as px
import pandas as pd
from dash.dependencies import Input, Output
import requests
import numpy as np

app = dash.Dash(__name__)

# Generamos el diseño de la página dash mediante las conexiones con el CSS y los classnames
app.layout = html.Div([
    html.Div([
        html.Div([
            html.Div(["Carlos Mercadal Carretero"], className="alumno"),
            html.Div(["Alberto Castaño Martín"], className="alumno")
        ], className="espacio_alumnos"),
        html.Div(["Práctica Tecnologías Cloud - MIAX7"],
                 className="titulo_practica"),
        html.Img(src="assets/logo_bme.png", className="espacio_logo")
    ], className="banner"),
    html.Div([], className="espacio_pre_cuerpo"),
    html.Div([
        html.Div(["Precio intradía por franja horaria"],
                 className="titulo_grafico"),
        html.Div([
            # Utilizamos el datepickersingle para que el usuario seleccione la fecha que desee comparar con la fecha actual.
            dcc.DatePickerSingle(
                id='calendario',
                display_format='Y-M-D',
                min_date_allowed=date(2015, 1, 1),
                max_date_allowed=date.today() - datetime.timedelta(days=1),
                date=date.today() - datetime.timedelta(days=1))
        ], className="fecha_grafico"),
        html.Div([
            # Generaremos el gráfico
            dcc.Graph(
                id='grafico')
        ], className="plot_grafico")
    ], className="espacio_grafico"),
    html.Div([], className="pie_pagina")
], className="container")

# Utilizamos un callback para que el dash interactúte con la fecha seleccionada por el usuario


@app.callback(
    Output('grafico', 'figure'),
    Input('calendario', 'date'))
def grafico_precio(fecha):

    # Inicializamos el link que hay que atacar para obtener los datos de los precios de la electricidad
    link = "https://api.esios.ree.es/archives/70/download_json?locale=es&date="

    # Nos bajamos los datos para las fechas seleccionadas y unimos la fecha con el link, generando así la URL.
    # Día actual
    url = link + str(date.today())
    response = requests.get(url)
    df_today = pd.DataFrame(response.json()['PVPC'])
    data_today = df_today[['PCB']]
    data_today = [pd.to_numeric(x.replace(',', '.'))
                  for x in data_today.PCB]

    # En contadas ocasiones el API devuelve menos/mas de 24 precios (hora)
    # Para homogeneizar el data frame:
    # Completamos con 0, si la respuesta tiene menos de 25 horas

    if len(data_today) < 24:
        data_today.append(0)

    if len(data_today) > 24:
        data_today = data_today[:24]

    # Reemplazamos 0 por NaN y completamos con la ultima hora disponible
    data_today = pd.DataFrame(data_today)
    data_today.replace(0, np.nan, inplace=True)
    data_today.ffill(axis=0)

    # Repetimos el proceso para la fecha seleccionada por el usuario
    # Día seleccionado

    url = link + str(fecha)
    response = requests.get(url)
    df_selected_date = pd.DataFrame(response.json()['PVPC'])
    # Buscamos el precio (GEN o PCB, en funcion de la version)
    if 'GEN' in df_selected_date.columns:
        data_selected = df_selected_date[['GEN']]
        data_selected = [pd.to_numeric(x.replace(',', '.'))
                         for x in data_selected.GEN]

    if 'PCB' in df_selected_date.columns:
        data_selected = df_selected_date[['PCB']]
        data_selected = [pd.to_numeric(x.replace(',', '.'))
                         for x in data_selected.PCB]

    # En contadas ocasiones el API devuelve menos/mas de 24 precios (hora)
    # Para homogeneizar el data frame:
    # Completamos con 0, si la respuesta tiene menos de 25 horas

    if len(data_selected) < 24:
        data_selected.append(0)

    if len(data_selected) > 24:
        data_selected = data_selected[:24]

    data_selected = pd.DataFrame(data_selected)
    data_selected.replace(0, np.nan, inplace=True)
    data_selected.ffill(axis=0)

    # Unificamos en un dataframe para que plotly lo utilice como entrada de datos a pintar

    data_to_plot = pd.DataFrame()
    data_to_plot[str(fecha)] = data_selected[0]
    data_to_plot[str(date.today())] = data_today[0]
    data_selected = data_to_plot.iloc[:, 0]
    data_today = data_to_plot.iloc[:, 1]

    # Graficamos

    fig = px.line(
        data_to_plot,
        template='simple_white'
    )

    fig.add_scatter(
        y=[max(data_today)],
        x=[[data_today.index[np.where(data_today == max(data_today))[0][0]]]],
        mode="markers",
        marker_symbol="triangle-up",
        marker_color="red",
        marker_size=12,
        showlegend=False
    )

    fig.add_scatter(
        y=[min(data_today)],
        x=[[data_today.index[np.where(data_today == min(data_today))]][0][0]],
        mode="markers",
        marker_symbol="triangle-down",
        marker_color="red",
        marker_size=12,
        showlegend=False
    )

    fig.add_scatter(
        y=[max(data_selected)],
        x=[[data_selected.index[np.where(
            data_selected == max(data_selected))]][0][0]],
        mode="markers",
        marker_symbol="triangle-up",
        marker_color="blue",
        marker_size=12,
        showlegend=False
    )

    fig.add_scatter(
        y=[min(data_selected)],
        x=[[data_selected .index[np.where(
            data_selected == min(data_selected))]][0][0]],
        mode="markers",
        marker_symbol="triangle-down",
        marker_color="blue",
        marker_size=12,
        showlegend=False
    )

    fig.update_xaxes(type='category')
    fig.update_layout(legend_title_text=None,
                      legend=dict(
                          yanchor='top',
                          y=0.99,
                          xanchor='left',
                          x=0.01
                      )
                      )

    return fig


if __name__ == ("__main__"):
    app.run_server(port=8080)
