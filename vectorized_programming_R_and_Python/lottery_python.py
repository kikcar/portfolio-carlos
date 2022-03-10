# %%
import random
import time
import numpy as np
import pandas as pd

start_time = time.time()

# Genero un array de ceros y le pongo cinco 1, luego hago un shuffle para sacar la combinación ganadora
combinacion_ganadora = np.zeros(shape=(50))
combinacion_ganadora[:5] = 1
np.random.shuffle(combinacion_ganadora)

# hago lo mismo que en el paso anterior, y le meto un for para que me genere un shuffle por filas
apuestas = np.zeros(shape=(50000, 50))
apuestas[:, :5] = 1

for fila in range(50000):
    np.random.shuffle(apuestas[fila])

# Aplicamos multiplicación matricial

aciertos = apuestas @ np.transpose(combinacion_ganadora)
pd.DataFrame(aciertos).value_counts()

print("--- %s seconds ---" % (time.time() - start_time))
