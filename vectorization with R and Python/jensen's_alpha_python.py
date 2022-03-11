# %%
import pandas as pd
import numpy as np
import time

start_time = time.time()

datos = pd.read_csv(
    r'C:\Users\Carlos\Documents\portfolio-carlos\portfolio-carlos\vectorized_programming_R_and_Python\DAX.csv',
    encoding="utf-8", parse_dates=True, index_col=0, sep=";")
activos = datos[datos.columns[0:30]]  # Seleccionamos los activos
BUND = datos["BUND"]
DAX = datos["Dax"]

# Calculamos los retornos logarítmicos de los activos, bund, y dax
rent_activos = np.log(activos).diff()
rent_BUND = np.log(BUND).diff()
rent_DAX = np.log(DAX).diff()

# Calculamos la varianza del índice y la covarianza con una ventana móvil de 30 días
varianza_ind = rent_DAX.rolling(30).var()
matriz_covarianza = rent_activos.rolling(30).cov(rent_DAX)
matriz_betas = np.transpose(np.transpose(
    matriz_covarianza) / np.array(varianza_ind))

alpha_activos = rent_activos - np.transpose(rent_BUND + (
    np.transpose(matriz_betas) * np.array(rent_DAX - rent_BUND)))
alpha_activos.dropna()

print("--- %s seconds ---" % (time.time() - start_time))

# %%
