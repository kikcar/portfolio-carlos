import pandas as pd
import numpy as np
import cvxpy as cp


class optimizer:
    def __init__(self, n_samples=50, gamma_low=1, gamma_high=10):
        self.n_samples = n_samples
        self.gamma_low = gamma_low
        self.gamma_high = gamma_high

    def maximize_target(self, target_data, cov_returns):
        '''Esta función se encarga de optimizar las carteras que tienen como objetivo
           maximizar el target; concretamente:
            a) Maximizar las betas a Value, Growth, Quality, SP500.
            b) Maximizar dividendos.
            c) Momentum'''

        # Creamos un numpy de la matriz de correlaciones y betas/dividendos de los activos
        sigma = cov_returns.values
        target = target_data.values

        # Calculamos el numero de activos a optimizar
        n = sigma.shape[0]

        # Creamos las variables optimizables (cvxpy): vector de pesos (w), vector boolenano de
        # peso mayor que 0% (b), vector booleano de peso mayor que 5% (c), vector de exceso
        # de peso sobre 5% (x), volatilidad de la cartera (port_risk), beta/dividendo ponderada de la
        # cartera (port_ret) y variable sobre la que iterar (gamma: desde 0.1 hasta inf)
        w = cp.Variable(n)
        b = cp.Variable(n, boolean=True)
        c = cp.Variable(n, boolean=True)
        x = cp.Variable(n)

        port_risk = cp.quad_form(w, sigma)
        port_ret = target.T @ w
        gamma = cp.Parameter(nonneg=True)
        # Definimos las restricciones: la cartera objetivo estara full invested,
        # no tomara posiciones cortas, cumplira los limites del 5-10-40 y no estara invertida
        # en mas de 30 activos diferentes
        constraints = [cp.sum(w) == 1, w >= 0, w <= 0.1,
                       w-b <= 0, cp.sum(b) <= 30, x >= 0]

        for i in range(n):
            constraints.append(x[i] >= w[i] - 0.05)

        for i in range(n):
            constraints.append(x[i] <= 0.05*c[i])

        constraints.append(cp.sum(x + 0.05*c) <= 0.4)

        # Cargamos en una variable la optimizacion
        prob = cp.Problem(cp.Maximize(port_ret - gamma*port_risk), constraints)

        # Cuando iteremos por el valor de gamma, almacenaremos el resultado de
        # cada optimizacion sobre los arrays risk_data y ret_data
        risk_data = np.zeros(self.n_samples)
        ret_data = np.zeros(self.n_samples)

        # Almacenamos en la variable "gamma_vals" el array de gammas sobre las que
        # iterar. Crecreran exponencialmente desde el valor minimo hasta el maximo
        # con "n_samples" de valores diferentes.
        gamma_vals = np.logspace(
            self.gamma_low, self.gamma_high, num=self.n_samples)
        portfolio_weights = []
        for i in range(self.n_samples):
            gamma.value = gamma_vals[i]
            prob.solve('XPRESS')
            risk_data[i] = np.sqrt(port_risk.value)
            ret_data[i] = port_ret.value
            portfolio_weights.append(w.value)

        # Obetenemos el "sharpe" (beta/dividendo cartera / riesgo de la cartera) de cada
        # iteracion
        sharpes = ret_data/risk_data

        # Obtenemos el indice de la cartera de Sharpe maximo y la extraemos
        idx = np.argmax(sharpes)
        optimal_portfolio = pd.Series(portfolio_weights[idx],
                                      index=cov_returns.columns).round(3)
        return optimal_portfolio

    def minimum_variance(self, cov_returns):
        '''Esta función se encarga de optimizar la cartera que tiene como 
        objetivo minimizar la volatilidad.'''

        # Creamos un numpy de la matriz de correlaciones
        sigma = cov_returns.values

        # Calculamos el numero de activos a optimizar
        n = sigma.shape[0]

        # Creamos las variables optimizables (cvxpy): vector de pesos (w), vector boolenano de
        # peso mayor que 0% (b), vector booleano de peso mayor que 5% (c), vector de exceso
        # de peso sobre 5% (x) y volatilidad de la cartera (port_risk)
        w = cp.Variable(n)
        b = cp.Variable(n, boolean=True)
        c = cp.Variable(n, boolean=True)
        x = cp.Variable(n)

        port_risk = cp.quad_form(w, sigma)

        # Definimos las restricciones: la cartera objetivo estara full invested,
        # no tomara posiciones cortas, cumplira los limites del 5-10-40 y no estara invertida
        # en mas de 30 activos diferentes
        constraints = [cp.sum(w) == 1, w >= 0, w <= 0.1,
                       w-b <= 0, cp.sum(b) <= 30, x >= 0]

        for i in range(n):
            constraints.append(x[i] >= w[i] - 0.05)

        for i in range(n):
            constraints.append(x[i] <= 0.05*c[i])

        constraints.append(cp.sum(x + 0.05*c) <= 0.4)

        # Cargamos en una variable la optimizacion y la resolvemos
        prob = cp.Problem(cp.Minimize(port_risk), constraints)
        prob.solve('XPRESS')

        # Almacenamos los pesos de la cartera optima y la extraemos
        portfolio_weights = w.value
        optimal_portfolio = pd.Series(
            portfolio_weights, index=cov_returns.columns).round(3)

        return(optimal_portfolio)

    def min_beta(self, target_data, cov_returns):
        '''Esta función se encarga de optimizar la cartera que tiene como 
        objetivo minimizar la beta al mercado.'''

        # Creamos un numpy de la matriz de correlaciones y serie de dividendos

        sigma = cov_returns.values
        betas = target_data.values

        # Calculamos el numero de activos a optimizar
        n = sigma.shape[0]

        # Creamos las variables optimizables (cvxpy): vector de pesos (w), vector boolenano de
        # peso mayor que 0% (b), vector booleano de peso mayor que 5% (c), vector de exceso
        # de peso sobre 5% (x), volatilidad de la cartera (port_risk), beta ponderada de la
        # cartera (port_ret) y variable sobre la que iterar (gamma: desde 0.1 hasta inf)
        w = cp.Variable(n)
        b = cp.Variable(n, boolean=True)
        c = cp.Variable(n, boolean=True)
        x = cp.Variable(n)

        port_risk = cp.quad_form(w, sigma)
        port_beta = betas.T @ w
        gamma = sigma.mean().mean() / betas.mean()

        # Definimos las restricciones: la cartera objetivo estara full invested,
        # no tomara posiciones cortas, cumplira los limites del 5-10-40 y no estara invertida
        # en mas de 30 activos diferentes
        constraints = [cp.sum(w) == 1, w >= 0, w <= 0.1,
                       w-b <= 0, cp.sum(b) <= 30, x >= 0]

        for i in range(n):
            constraints.append(x[i] >= w[i] - 0.05)

        for i in range(n):
            constraints.append(x[i] <= 0.05*c[i])

        constraints.append(cp.sum(x + 0.05*c) <= 0.4)

        # Cargamos en una variable la optimizacion
        prob = cp.Problem(cp.Minimize(
            port_beta*gamma + port_risk), constraints)

        # Cuando iteremos por el valor de gamma, almacenaremos el resultado de
        # cada optimizacion sobre el array result_data

        # Almacenamos en la variable "gamma_vals" el array de gammas sobre las que
        # iterar. Crecreran exponencialmente desde el valor minimo hasta el maximo
        # con "n_samples" de valores diferentes.

        prob.solve('XPRESS')

        # Almacenamos los pesos de la cartera optima y la extraemos
        portfolio_weights = w.value
        optimal_portfolio = pd.Series(
            portfolio_weights, index=cov_returns.columns).round(3)
        return(optimal_portfolio)

    def beta_1_strategy(self, target_data, cov_returns):
        # Creamos un numpy de la matriz de correlaciones y betas de los activos
        sigma = cov_returns.values
        betas = target_data.values

        # Calculamos el numero de activos a optimizar
        n = sigma.shape[0]

        # Creamos las variables optimizables (cvxpy): vector de pesos (w), vector boolenano de
        # peso mayor que 0% (b), vector booleano de peso mayor que 5% (c), vector de exceso
        # de peso sobre 5% (x), volatilidad de la cartera (port_risk) y beta ponderada de la
        # cartera (port_ret)
        w = cp.Variable(n)
        b = cp.Variable(n, boolean=True)
        c = cp.Variable(n, boolean=True)
        x = cp.Variable(n)

        port_risk = cp.quad_form(w, sigma)
        port_beta = betas.T @ w

        # Definimos las restricciones: la cartera objetivo estara full invested,
        # no tomara posiciones cortas, cumplira los limites del 5-10-40, no estara invertida
        # en mas de 30 activos diferentes y la beta ponderada de la cartera estar comprendida
        # entre 0.9 y 1.1
        constraints = [cp.sum(w) == 1, w >= 0, w <= 0.1, w-b <= 0,
                       cp.sum(b) <= 30, x >= 0, port_beta <= 1.1, port_beta >= 0.9]

        for i in range(n):
            constraints.append(x[i] >= w[i] - 0.05)

        for i in range(n):
            constraints.append(x[i] <= 0.05*c[i])

        constraints.append(cp.sum(x + 0.05*c) <= 0.4)

        # Cargamos en una variable la optimizacion y la resolvemos
        prob = cp.Problem(cp.Minimize(port_risk), constraints)
        prob.solve()

        # Almacenamos los pesos de la cartera optima y la extraemos
        portfolio_weights = w.value
        optimal_portfolio = pd.Series(portfolio_weights,
                                      index=cov_returns.columns).round(3)

        return(optimal_portfolio)
