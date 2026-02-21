---
name: multipletau
description: `multipletau` is a specialized Python library that implements the multiple-tau correlation algorithm.
homepage: https://github.com/FCS-analysis/multipletau
---

# multipletau

## Overview
`multipletau` is a specialized Python library that implements the multiple-tau correlation algorithm. It is designed to compute the correlation of two signals (autocorrelation or cross-correlation) on a logarithmic scale. This approach is significantly faster than conventional linear correlation methods (like `numpy.correlate`) because it reduces the number of computed data points as the lag time increases. It is the standard choice for analyzing dynamics in systems where processes occur across vastly different timescales, such as molecular diffusion or flow.

## Usage and Best Practices

### Installation
Ensure the environment has the necessary dependencies (Python 3.x and NumPy):
```bash
pip install multipletau
```

### Basic Correlation
The primary function is `multipletau.correlate()`. It accepts two NumPy arrays and returns a 2D array containing the lag times and the correlation values.

```python
import numpy as np
import multipletau

# Generate or load your data
data_a = np.random.rand(10000)
data_b = np.random.rand(10000)

# Compute correlation
# m defines the number of points per block (default is 16)
results = multipletau.correlate(data_a, data_b, m=16)

# results[:, 0] contains lag times
# results[:, 1] contains correlation values
```

### Key Parameters and Tuning
- **m (points per block)**: This is the most important parameter. It determines the number of points used in each "bin" of the logarithmic scale. 
    - Increasing `m` improves the resolution of the correlation function but increases computation time.
    - Common values are 16 or 32.
- **copy**: By default, the library may modify input arrays to save memory. Set `copy=True` if you need to preserve the original input data.
- **normalize**: While the library computes the raw correlation, users in FCS typically normalize the result by the product of the averages of the two signals.

### Expert Tips
- **Performance**: Use `multipletau` instead of `numpy.correlate` whenever your lag times span more than two orders of magnitude. The computational savings are exponential as the dataset grows.
- **Zero-Mean Traces**: The library includes a `ZERO_CUTOFF` constant. If your signal has a mean very close to zero, the algorithm might raise an error or produce unexpected results during normalization steps. Ensure your signal has a positive baseline if performing standard FCS analysis.
- **Input Types**: Always ensure inputs are NumPy arrays. While the library attempts to convert lists, pre-converting to `np.float64` prevents overhead and potential precision issues.

## Reference documentation
- [multipletau GitHub Repository](./references/github_com_FCS-analysis_multipletau.md)