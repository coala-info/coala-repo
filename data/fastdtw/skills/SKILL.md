---
name: fastdtw
description: FastDTW is a Python implementation of the Fast Dynamic Time Warping algorithm, which provides an $O(N)$ approximation of the standard $O(N^2)$ DTW algorithm.
homepage: https://github.com/slaypni/fastdtw
---

# fastdtw

## Overview

FastDTW is a Python implementation of the Fast Dynamic Time Warping algorithm, which provides an $O(N)$ approximation of the standard $O(N^2)$ DTW algorithm. It is designed to find the optimal alignment between two sequences by recursively projecting a solution from a lower resolution and refining it. This makes it a critical tool for signal processing, speech recognition, and any domain involving time-series analysis where performance and memory efficiency are paramount.

## Implementation Guide

### Installation
Ensure the package is installed in your environment:
```bash
pip install fastdtw
```

### Basic Usage
The core function `fastdtw` returns the calculated distance and the warping path (a list of index pairs).

```python
import numpy as np
from scipy.spatial.distance import euclidean
from fastdtw import fastdtw

# Define sequences as numpy arrays
x = np.array([[1,1], [2,2], [3,3], [4,4], [5,5]])
y = np.array([[2,2], [3,3], [4,4]])

# Calculate distance and path
distance, path = fastdtw(x, y, dist=euclidean)

print(f"Distance: {distance}")
print(f"Path: {path}")
```

### Expert Tips and Best Practices

1. **Input Formatting**: While the library accepts lists, always use NumPy arrays for input sequences to ensure compatibility with `scipy` distance metrics and to improve processing speed.
2. **Distance Metrics**: The `dist` parameter can take any callable. For high-dimensional data, consider using `cityblock` (Manhattan) or `cosine` from `scipy.spatial.distance` if Euclidean distance is not appropriate for your feature space.
3. **Handling Multi-dimensional Data**: Ensure your input arrays are shaped as `(n_samples, n_features)`. If you are comparing univariate time series, they should be reshaped to `(n_samples, 1)`.
4. **Performance Optimization**:
   - **Cython**: FastDTW attempts to use Cython for speed. If you encounter performance bottlenecks, verify that Cython is installed and that the package was compiled correctly during installation.
   - **Radius Parameter**: Although often left at default, the `radius` parameter (default is 1) controls the search window. Increasing the radius improves accuracy (approaching standard DTW) but increases computational cost.
5. **Memory Management**: Because FastDTW is $O(N)$ in both time and space, it can handle sequences with tens of thousands of points that would typically cause out-of-memory errors with standard DTW implementations.

## Common Troubleshooting

- **Compilation Errors**: If you see errors related to `numpy.math` or `INFINITY` during installation, it is likely a compatibility issue with newer NumPy versions and the Cython fallback. Ensure your build environment has the latest version of `setuptools` and `cython`.
- **Docker Performance**: When running in containerized environments, ensure sufficient memory is allocated, as the recursive nature of the algorithm can be sensitive to stack size limits in restricted environments.

## Reference documentation
- [FastDTW Main Repository](./references/github_com_slaypni_fastdtw.md)
- [Known Issues and Performance Notes](./references/github_com_slaypni_fastdtw_issues.md)