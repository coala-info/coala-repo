---
name: pyopt
description: The pyopt skill provides a specialized workflow for quantitative finance tasks using the pyOptionPricing toolkit.
homepage: https://github.com/boyac/pyOptionPricing
---

# pyopt

## Overview
The pyopt skill provides a specialized workflow for quantitative finance tasks using the pyOptionPricing toolkit. It enables the calculation of theoretical option prices, the estimation of annualized volatility from historical market data, and the simulation of exotic derivatives like Shout options. This skill is particularly useful for traders and analysts who need to model European options or analyze stock price variances using traditional or Garman-Klass methodologies.

## Usage Instructions

### Option Pricing with Black-Scholes
To price a standard European option, use the `BlackScholes` function within `black_scholes.py`. 

**Parameters:**
- `CallPutFlag`: 'c' for Call, 'p' for Put.
- `S`: Current stock price.
- `K`: Option strike price.
- `t`: Time until exercise (in years).
- `r`: Risk-free interest rate (decimal).
- `s`: Volatility (standard deviation).

**Execution Pattern:**
```bash
python black_scholes.py
```
*Note: Modify the `if __name__ == "__main__":` block to input specific market parameters.*

### Volatility Calculations
The library supports two primary methods for calculating annualized volatility based on historical data.

1.  **Traditional Historical Volatility**: Calculates the annualized standard deviation of daily log returns.
    - Script: `historical_vol.py`
    - Function: `historical_volatility(sym, days)`
2.  **Garman-Klass Volatility**: A more sophisticated estimate using Open-High-Low-Close (OHLC) data.
    - Script: `garman_klass_vol.py`
    - Function: `gk_vol(sym, days)`

**CLI Usage:**
Ensure you have `pandas_datareader` installed to fetch data from Yahoo Finance.
```bash
python historical_vol.py
python garman_klass_vol.py
```

### Exotic Options and Simulations
For complex derivatives that cannot be priced with a closed-form solution, use the Monte Carlo approximation scripts.
- **Shout Options**: Use the Monte Carlo implementation to approximate the value of options where the holder can "shout" to lock in profits.
- **Geometric Brownian Motion**: Use `30_70_simulation.py` for path-based simulations of asset prices.

## Expert Tips
- **Trading Days**: The volatility scripts default to 252 trading days (NYSE). If analyzing the Shanghai Stock Exchange, adjust the constant to 242; for the Tokyo Stock Exchange, use 246.
- **Data Sourcing**: The `historical_volatility` and `gk_vol` functions attempt to pull data directly from Yahoo Finance. Ensure your environment has internet access and the `pandas_datareader` library is configured correctly.
- **Environment**: This library was originally authored for Python 2.7. When running in Python 3.x environments, ensure you handle the `print` statement syntax and `division` imports accordingly.

## Reference documentation
- [pyOptionPricing Main Repository](./references/github_com_boyac_pyOptionPricing.md)