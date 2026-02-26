---
name: fitter
description: The fitter tool identifies the best-fitting probability distribution for a dataset by testing it against multiple statistical models. Use when user asks to fit data to probability distributions, find the best statistical model for a sample, or rank distributions based on goodness-of-fit metrics.
homepage: https://github.com/cokelaer/fitter
---


# fitter

## Overview
The `fitter` tool automates the process of testing a dataset against over 80 probability distributions available in Scipy. It systematically fits the data, ignores distributions that fail to converge, and ranks the results based on goodness-of-fit metrics such as Sum of Squared Errors (SSE), Akaike Information Criterion (AIC), and Bayesian Information Criterion (BIC). This allows for rapid identification of the most suitable statistical model for a given data sample.

## Installation
Install via pip or conda:
```bash
pip install fitter
# OR
conda install -c bioconda fitter
```

## CLI Usage Patterns
The `fitter` package provides a standalone command-line application called `fitter`.

### Basic Distribution Fitting
To fit a CSV file and identify the best distribution:
```bash
fitter fitdist data.csv --column-number 1
```

### Restricting Distributions
Fitting all 80+ Scipy distributions can be computationally expensive. Limit the search to specific distributions to save time:
```bash
fitter fitdist data.csv --distributions gamma,norm,expon,lognorm
```

### Output Management
By default, the tool creates `fitter.png` and `fitter.log`. You can specify the output image name:
```bash
fitter fitdist data.csv --output-image results_plot.png
```

## Python API Usage
For more granular control, use the Python interface.

### Standard Workflow
```python
from fitter import Fitter
import pandas as pd

# Load your data
data = pd.read_csv("data.csv")["target_column"].values

# Initialize and fit
f = Fitter(data, distributions=['gamma', 'norm', 'expon'])
f.fit()

# View results
print(f.summary())
print(f.get_best(method='sumsquare_error'))
```

## Expert Tips
- **Performance**: Fitting is a heavy process. If your dataset is large, consider downsampling to ~10,000 points for the initial distribution search.
- **Common Distributions**: Use `f.distributions = f.get_common_distributions()` to test only the most frequently used statistical models (e.g., norm, lognorm, gamma, etc.) instead of the full Scipy suite.
- **Goodness-of-Fit**: While SSE is the default, you can evaluate fits using `ks_statistic` (Kolmogorov-Smirnov) or `bic`/`aic` for a more robust selection depending on your sample size and complexity.
- **Parallelization**: Recent versions support multiprocessing. Ensure your environment allows for parallel execution to speed up the fitting of multiple distributions.

## Reference documentation
- [fitter Overview](./references/anaconda_org_channels_bioconda_packages_fitter_overview.md)
- [fitter GitHub Repository](./references/github_com_cokelaer_fitter.md)