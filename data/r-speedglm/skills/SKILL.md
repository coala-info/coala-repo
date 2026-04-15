---
name: r-speedglm
description: This tool fits linear and generalized linear models to large datasets efficiently using high-performance updating algorithms. Use when user asks to fit linear models, perform logistic or poisson regression on large datasets, or process data in chunks to save memory.
homepage: https://cloud.r-project.org/web/packages/speedglm/index.html
---

# r-speedglm

name: r-speedglm
description: High-performance fitting of linear models (LM) and generalized linear models (GLM) for large datasets in R. Use this skill when standard lm() or glm() functions are too slow or memory-intensive, or when you need to process data in chunks using updating algorithms.

# r-speedglm

## Overview
The `speedglm` package is designed to fit linear and generalized linear models to large datasets efficiently. It uses updating algorithms that allow for processing data that might not fit entirely in memory or simply to speed up computation compared to base R functions. It is particularly effective for datasets with many observations and supports sparse matrices via the `Matrix` package.

## Installation
To install the package from CRAN:
```R
install.packages("speedglm")
```

## Core Functions

### Linear Models: speedlm()
Used for fitting linear models. It is significantly faster than `lm()` for large datasets.
```R
library(speedglm)
# Basic usage
mod <- speedlm(y ~ x1 + x2, data = my_data)
summary(mod)
```

### Generalized Linear Models: speedglm()
Used for fitting GLMs (e.g., Logistic, Poisson).
```R
# Logistic regression example
mod_glm <- speedglm(y ~ x1 + x2, data = my_data, family = binomial())
summary(mod_glm)
```

### Incremental Fitting (Chunking)
For datasets that exceed RAM, use the `update` methods or the `set.pqr` argument to process data in blocks.
```R
# Initialize with first chunk
mod <- speedlm(y ~ x1 + x2, data = chunk1, fitted = TRUE)

# Update with subsequent chunks
mod <- update(mod, data = chunk2)
```

## Workflows

### Handling Sparse Data
`speedglm` can handle sparse design matrices, which is common in high-dimensional data or text mining.
```R
library(Matrix)
X <- Matrix(my_matrix, sparse = TRUE)
mod <- speedglm.wfit(y, X, family = gaussian())
```

### Non-Memory Resident Data
When data is too large to load, use `speedglm` in conjunction with data-loading loops:
1. Read a chunk of data.
2. Fit or update the model.
3. Repeat until all chunks are processed.

## Tips for Performance
- **Method Selection**: For `speedlm`, the default method is "eigen". For very large matrices, "chol" (Cholesky) may be faster but less numerically stable.
- **Factor Variables**: Ensure factors are correctly coded before passing to `speedglm`, as large numbers of levels can still consume significant memory during model matrix construction.
- **Comparison with biglm**: While similar to the `biglm` package, `speedglm` often provides better performance for a wider range of GLM families and supports sparse matrices more natively.

## Reference documentation
- [Home Page](./references/home_page.md)