import pandas as pd
import numpy as np


class data_generator:

    def __init__(self, datos_cierre, dataset_inputs, filtro_sp):
        self.datos_cierre = datos_cierre
        self.dataset_inputs = dataset_inputs
        self.filtro_sp = filtro_sp

    def data_cleaning(self):
        '''Esta función se encarga de limpiar y preparar los datos de los activos
        del SP500 y de los inputs que vamos a utilizar.'''

        '''LIMPIEZA Y PREPARACION DE DATOS CIERRE'''
        # Descartamos aquellos activos con menos de un 90% de los días
        # cotizados. Calculamos el numero de dias correspondiente
        porc_no_nan = int(0.9 * self.datos_cierre.shape[0])

        # Eliminamos los nan en aquellos activos con menos de los dias necesarios
        # cotizados
        datos_cierre = self.datos_cierre.dropna(axis=1, thresh=porc_no_nan)

        # Rellenamos con el último valor previo y posteriormente con
        # el valor siguiente disponible
        datos_cierre = datos_cierre.fillna(axis=0, method="ffill")
        datos_cierre = datos_cierre.fillna(axis=0, method="bfill")

        '''LIMPIEZA Y PREPARACIÓN DE DATASET INPUTS'''

        # Seleccionamos los indices que vamos a necesitar para calcular las betas
        indices = self.dataset_inputs.loc[:, [
            'SP_VALUE_TR', 'SP_QUALITY_TR', 'SP_GROWTH_TR', 'SP_TR']]

        # Los datos vienen en formato string, al pasarlos a numeric algunos dan error porque tienen dos "." separando los miles y los decimales.
        # Elimino los "." de los miles y me quedo con los separadores decimales
        for name in indices.columns:
            for i in range(len(indices[name])):
                if indices[name][i][1:].startswith('.'):
                    indices[name][i] = indices[name][i][0] + \
                        indices['SP_VALUE_TR'][i][2:]

        # Convertimos los datos a numeric con apply para que lo haga en todas las columnas.
        indices = indices.apply(pd.to_numeric)
        indices = indices.sort_values(by='date')
        # Filtramos para que coincidan las fechas
        datos = pd.DataFrame(index=datos_cierre.index)
        datos['SP_VALUE_TR'] = indices['SP_VALUE_TR']
        datos['SP_QUALITY_TR'] = indices['SP_QUALITY_TR']
        datos['SP_GROWTH_TR'] = indices['SP_GROWTH_TR']
        datos['SP_TR'] = indices['SP_TR']
        datos = datos.fillna(axis=0, method='ffill')

        filtro = pd.DataFrame(index=datos_cierre.index)
        for activo in datos_cierre.columns:
            filtro[activo] = self.filtro_sp[activo]

        filtro = filtro.fillna(method='ffill')
        indices = datos
        self.datos_cierre = datos_cierre
        self.indices = indices
        self.filtro_sp = filtro

        return datos_cierre, indices, filtro

    def generador_estadisticos(self, n_activos=60, ventana=60):

        beta_value_list = []
        beta_quality_list = []
        beta_growth_list = []
        beta_sp_list = []
        min_vol_list = []
        returns_list = []
        beta_min_sp_list = []
        datos_filtrados = (self.datos_cierre * self.filtro_sp)

        for i in range(ventana, self.datos_cierre.shape[0]):
            activos = (np.where(datos_filtrados.iloc[0] > 0))[0]
            datos_cierre = self.datos_cierre.iloc[i-ventana:i, activos]
            returns = np.log(datos_cierre).diff().dropna()
            cov_returns = returns.cov()
            # Sacamos los retornos y covarianza de los activos junto con los indices
            datos = pd.concat([self.indices, datos_cierre], axis=1)
            returns_asset_market = np.log(
                datos.iloc[i-ventana:i, :]).diff().dropna()
            # Sacamos la covarianza de los activos con los indices
            cov_assets_market = returns_asset_market.cov().iloc[0:4, 4:].T
            # Obtenemos las betas diviendo la covarianza de los datos con los indices / varianza de los indices
            betas = cov_assets_market / returns_asset_market.iloc[:, :4].var()
            # Asignamos las betas de forma independiente
            beta_value = betas.SP_VALUE_TR.sort_values(ascending=False)[
                :n_activos]
            beta_quality = betas.SP_QUALITY_TR.sort_values(ascending=False)[
                :n_activos]
            beta_growth = betas.SP_GROWTH_TR.sort_values(ascending=False)[
                :n_activos]
            beta_sp = betas.SP_TR.sort_values(ascending=False)[:n_activos]
            min_vol = returns.var().sort_values(ascending=True)[:n_activos]
            returns = returns.sum().sort_values(ascending=False)[:n_activos]
            beta_min_sp = beta_sp.sort_values(ascending=True)[:n_activos]

            # Guardamos los datos de cada ventana en una lista
            beta_value_list.append([
                beta_value, cov_returns.loc[beta_value.index, beta_value.index]])
            beta_quality_list.append([
                beta_quality, cov_returns.loc[beta_quality.index, beta_quality.index]])
            beta_growth_list.append([
                beta_growth, cov_returns.loc[beta_growth.index, beta_growth.index]])
            beta_sp_list.append([
                beta_sp, cov_returns.loc[beta_sp.index, beta_sp.index]])
            min_vol_list.append([
                min_vol, cov_returns.loc[min_vol.index, min_vol.index]])
            returns_list.append([
                returns, cov_returns.loc[returns.index, returns.index]])
            beta_min_sp_list.append([
                beta_sp, cov_returns.loc[beta_min_sp.index, beta_min_sp.index]])

        return beta_value_list, beta_quality_list, beta_growth_list, beta_sp_list, min_vol_list, returns_list, beta_min_sp_list
