---
name: hdmedians
description: The hdmedians package provides fast implementations for calculating medoids and geometric medians in high-dimensional datasets. Use when user asks to calculate a robust central tendency, find a representative medoid from a dataset, or compute a geometric median that is resistant to outliers.
homepage: https://github.com/daleroberts/hdmedians
---


# hdmedians

## Overview
The `hdmedians` package provides fast, specialized implementations for extending median calculations into higher dimensions. While there is no single definition for a high-dimensional median, this tool implements the most common variants: the Medoid (an actual observed point) and the Geometric Median (a synthetic central point). These methods are particularly valuable in machine learning and computer vision because they maintain a high breakdown point, remaining accurate even when up to 50% of the data is contaminated by outliers.

## Implementation Patterns

### Medoid Calculation
The medoid is the observation within a dataset that minimizes the sum of distances to all other points. Use this when you require a representative point that actually exists in your input data.

```python
import hdmedians as hd
import numpy as np

# X is an array of shape (dimensions, observations)
X = np.random.randint(100, size=(6, 10))

# Get the medoid vector
median_vector = hd.medoid(X)

# Get only the index of the medoid
idx = hd.medoid(X, indexonly=True)

# Specify the observation axis (e.g., if observations are rows)
row_medoid = hd.medoid(X, axis=0)
```

### Geometric Median Calculation
The geometric median (or spatial median) is a synthetic point that minimizes the Euclidean distance to all observations. Use this for the most mathematically robust "center" of a high-dimensional cloud.

```python
import hdmedians as hd
import numpy as np

# Geometric median works best with float64 or float32
X = np.random.normal(1, size=(6, 10)).astype(np.float32)

# Calculate the synthetic median point
geo_median = hd.geomedian(X)
```

### Handling Missing Data (NaNs)
If your dataset contains missing values, use the specialized `nan` variants to prevent the entire calculation from returning NaN.

```python
# For medoids with missing values
result = hd.nanmedoid(X_with_nans, axis=1)

# For geometric medians with missing values
result = hd.nangeomedian(X_with_nans, axis=1)
```

## Expert Tips and Best Practices

- **Performance**: The `geomedian` implementation uses Cython. For large datasets, ensure your input is `float32` or `float64` to leverage the optimized C-extensions.
- **Axis Orientation**: Always verify your `axis` parameter. By default, `hdmedians` often treats the last axis as the number of observations. If your data is organized as `(n_samples, n_features)`, you must set `axis=0`.
- **Memory Efficiency**: When working with very large arrays, use `indexonly=True` for medoids to avoid creating unnecessary copies of large vectors if you only need to identify the representative sample.
- **Medoid vs. Geometric Median**: 
    - Choose **Medoid** when you need to maintain the integrity of the data (e.g., selecting a representative "typical" image from a set).
    - Choose **Geometric Median** when you need the most accurate central tendency and don't mind that the result is a calculated (synthetic) value.

## Reference documentation
- [hdmedians README](./references/github_com_daleroberts_hdmedians.md)