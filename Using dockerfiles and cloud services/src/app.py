import dash
from dash import dcc
from dash import html
from datetime import date
from dateutil import parser
import plotly.express as px
import pandas as pd
from dash.dependencies import Input, Output
import numpy as np
import datetime


# Cargamos la base de datos desde AWS conecádonlo con S3 y bajándonos el bucket.

datos_diarios = pd.read_csv(
    f"s3://{'precios.diarios'}/{'precios_diarios.csv'}",
    storage_options={
        'key': 'AKIAZOSB643XWUVJ3SX6',
        'secret': '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'
    },
)

# Preguntamos por la última fecha disponible, ya que será la que ofreceremos al usuario como fecha actual.
last_date = datos_diarios.columns[-1]
last_date = parser.parse(last_date).date()

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
        html.Div([
            html.Div(["Precio medio diario por rango de fechas seleccionadas."],
                     className="titulo_grafico"),
            html.Div([
                # Utilizaremos el datepickerrange para que el usuario determine el rango de fechas sobre el cuál quiere ver el precio medio diario
                dcc.DatePickerRange(
                    id='calendario_uno',
                    display_format='Y-M-D',
                    min_date_allowed=date(2015, 1, 1),
                    initial_visible_month=last_date -
                    datetime.timedelta(days=30),
                    start_date=last_date - datetime.timedelta(days=30),
                    end_date=last_date)
            ], className="fecha_grafico"),
            html.Div([
                dcc.Graph(
                    id='grafico_uno')
            ], className="plot_grafico")
        ], className="espacio_grafico"),
        html.Div([
            html.Div(["Precio intradía por fechas y franja horaria."],
                     className="titulo_grafico"),
            html.Div([
                # Utilizamos el datepickersinlge para que el usuario determine la fecha que quiere comparar con la actual.
                dcc.DatePickerSingle(
                    id='calendario_dos',
                    display_format='Y-M-D',
                    min_date_allowed=date(2015, 1, 1),
                    max_date_allowed=last_date - datetime.timedelta(days=1),
                    date=last_date - datetime.timedelta(days=1))
            ], className="fecha_grafico"),
            html.Div([
                dcc.Graph(
                    id='grafico_dos')
            ], className="plot_grafico")
        ], className="espacio_grafico")
    ], className="cuerpo"),
    html.Div([], className="pie_pagina")

], className="container")


@app.callback(
    Output('grafico_uno', 'figure'),
    Input('calendario_uno', 'start_date'),
    Input('calendario_uno', 'end_date'))
def grafico_rango(fecha_inicio, fecha_fin):

    # Importamos la base de datos desde AWS con S3 y descargando el contenido del bucket.

    datos_diarios = pd.read_csv(
        f"s3://{'precios.diarios'}/{'precios_diarios.csv'}",
        storage_options={
            'key': 'AKIAZOSB643XWUVJ3SX6',
            'secret': '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'
        },
    )

    # Indexamos por las fechas de inicio y fin seleccionadas por el usuario y calculamos la media de los datos

    inicio = np.where(datos_diarios.columns == str(fecha_inicio))[0][0]
    fin = np.where(datos_diarios.columns == str(fecha_fin))[0][0]
    precio_medio_diario = np.mean(datos_diarios.iloc[:, inicio:fin])

    # Graficamos

    fig = px.line(
        precio_medio_diario,
        template='simple_white'
    )

    fig.add_scatter(
        y=[max(precio_medio_diario)],
        x=[precio_medio_diario.index[np.where(
            precio_medio_diario == max(precio_medio_diario))[0][0]]],
        mode="markers",
        marker_symbol="triangle-up",
        marker_color="blue",
        marker_size=12
    )

    fig.add_scatter(
        y=[min(precio_medio_diario)],
        x=[precio_medio_diario.index[np.where(
            precio_medio_diario == min(precio_medio_diario))[0][0]]],
        mode="markers",
        marker_symbol="triangle-down",
        marker_color="blue",
        marker_size=12
    )

    fig.update_xaxes(type='category')
    fig.update_layout(showlegend=False)

    return fig


@app.callback(
    Output('grafico_dos', 'figure'),
    Input('calendario_dos', 'date'))
def grafico_precio(fecha):

    # Importamos la base de datos desde AWS con S3 y descargando el contenido del bucket.

    datos_diarios = pd.read_csv(
        f"s3://{'precios.diarios'}/{'precios_diarios.csv'}",
        storage_options={
            'key': 'AKIAZOSB643XWUVJ3SX6',
            'secret': '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'
        },
    )

    # Indexamos por las fecha seleccionada y generamos el data_to_plot para que plotly grafique los datos.
    fecha = np.where(datos_diarios.columns == str(fecha))[0][0]
    data_selected = datos_diarios.iloc[:, fecha]

    today = np.where(datos_diarios.columns == datos_diarios.columns[-1])[0][0]
    fecha_hoy = datos_diarios.columns[-1]
    data_today = datos_diarios.iloc[:, today]

    data_to_plot = pd.DataFrame()
    data_to_plot[datos_diarios.columns[fecha]] = data_selected
    data_to_plot[fecha_hoy] = data_today

    # Graficamos
    fig = px.line(
        data_to_plot,
        template='simple_white'
    )

    fig.add_scatter(
        y=[max(data_today)],
        x=[[data_today.index[np.where(data_today == max(data_today))]][0][0]],
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
        x=[[data_selected.index[np.where(
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


if __name__ == '__main__':
    app.run_server(host='0.0.0.0', debug=False, port=8080)
