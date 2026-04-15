---
name: r-transformer
description: This tool provides a native R implementation of the Transformer deep neural network architecture and its core components. Use when user asks to build Transformer layers, implement multi-headed attention, apply layer normalization, or configure feed-forward networks in R.
homepage: https://cran.r-project.org/web/packages/transformer/index.html
---

# r-transformer

name: r-transformer
description: Implementation of the Transformer Deep Neural Network architecture in R, based on the attention mechanism (Vaswani et al., 2017). Use this skill when a user needs to build, configure, or understand Transformer layers, multi-headed attention, layer normalization, or feed-forward components within the R environment.

# r-transformer

## Overview
The `transformer` package provides a native R implementation of the Transformer architecture. It allows for the construction of Transformer layers by providing functions for the core components: Multi-Headed Attention, Feed-Forward networks, and Layer Normalization.

## Installation
To install the package from CRAN:
```R
install.packages("transformer")
```

## Core Functions

### Transformer Layer
The `transformer()` function is the primary high-level interface that combines attention and feed-forward mechanisms.
```R
# Example usage
x <- matrix(rnorm(50 * 512), 50, 512)
output <- transformer(x, d_model = 512, num_heads = 8, dff = 2048)
```

### Component Functions
For custom architectures, use the individual building blocks:
- `multi_head(Q, K, V, d_model, num_heads, mask)`: Computes multi-headed attention.
- `feed_forward(x, dff, d_model)`: Applies the position-wise feed-forward network.
- `layer_norm(x, epsilon)`: Performs layer normalization to stabilize training.

## Workflows

### Building a Custom Layer
A standard transformer block typically follows this sequence:
1. Multi-head attention on the input.
2. Addition and Layer Normalization (Residual connection).
3. Feed-forward network.
4. Addition and Layer Normalization (Residual connection).

### Utility Functions
The package includes optimized row-wise operations for matrix inputs:
- `row_means(x)`: Efficiently calculates the mean of each row.
- `row_vars(x)`: Efficiently calculates the variance of each row.

## Tips
- **Input Shape**: Ensure inputs are matrices where rows represent observations/sequences and columns represent the model dimensions (`d_model`).
- **Masking**: Use the `mask` argument in `transformer()` or `multi_head()` to prevent the model from attending to specific tokens (e.g., padding or future tokens in causal modeling).
- **Dependencies**: This package relies on the `attention` package for underlying calculations.

## Reference documentation
- [transformer: Implementation of Transformer Deep Neural Network with Vignettes](./references/reference_manual.md)