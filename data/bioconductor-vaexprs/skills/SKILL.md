---
name: bioconductor-vaexprs
description: This tool generates synthetic gene expression data using Variational Autoencoders and Conditional Variational Autoencoders. Use when user asks to generate artificial gene expression samples, augment small transcriptomic datasets, create targeted cell-type subpopulations, or perform dimensionality reduction using deep generative models.
homepage: https://bioconductor.org/packages/release/bioc/html/VAExprs.html
---

# bioconductor-vaexprs

name: bioconductor-vaexprs
description: Use the VAExprs package to generate synthetic gene expression data (especially single-cell RNA-seq) using Variational Autoencoders (VAE) and Conditional Variational Autoencoders (CVAE). Use this skill when you need to augment small datasets, create targeted cell-type samples, or perform dimensionality reduction using deep generative models.

# bioconductor-vaexprs

## Overview

VAExprs implements Variational Autoencoders (VAE) to address the challenge of low observation numbers in biomedical research. By capturing the probability distribution of gene expression data, it allows for the generation of artificial samples that maintain the biological characteristics of the original data. It supports both standard VAEs for general data augmentation and Conditional VAEs (CVAE) for generating specific subpopulations or cell types.

## Core Workflow

### 1. Data Preparation
The package requires a matrix of expression data (genes as rows, samples as columns) or a `SingleCellExperiment` object.
- Ensure data is normalized (e.g., log-transformed).
- For CVAE, provide cell type annotations within the `colData` of a `SingleCellExperiment` object.
- Transpose the matrix for training: `x_train <- t(expression_matrix)`.

### 2. Model Construction and Training
Use `fit_vae()` to define the architecture and train the model. This function requires `keras` and `tensorflow` backends.

```r
# Define dimensions
original_dim <- ncol(x_train)
intermediate_dim <- 256

# Fit VAE
vae_result <- fit_vae(
    x_train = x_train, 
    x_val = x_train,
    encoder_layers = list(
        layer_input(shape = c(original_dim)),
        layer_dense(units = intermediate_dim, activation = "relu")
    ),
    decoder_layers = list(
        layer_dense(units = intermediate_dim, activation = "relu"),
        layer_dense(units = original_dim, activation = "sigmoid")
    ),
    epochs = 100, 
    batch_size = 32
)
```

### 3. Sample Generation
Generate new expression profiles using the trained model with `gen_exprs()`.

```r
# Generate 100 new samples
gen_sample_result <- gen_exprs(vae_result, num_samples = 100)

# Access generated data
synthetic_data <- gen_sample_result$x_gen
```

### 4. Visualization and Validation
- **Architecture**: Use `plot_vae(vae_result$model)` to visualize the neural network layers.
- **Augmentation Quality**: Use `plot_aug(gen_sample_result, "PCA")` or `"TSNE"` to compare real and synthetic samples in reduced dimensional space.
- **Heatmaps**: Compare `t(x_train)` and `t(gen_sample_result$x_gen)` to ensure expression patterns are preserved.

## Key Functions

- `fit_vae()`: Main training function. Accepts matrices or `SingleCellExperiment` objects. Supports `use_generator = TRUE` for large datasets.
- `gen_exprs()`: Generates synthetic data from a fitted VAE/CVAE object.
- `plot_vae()`: Plots the Keras model architecture.
- `plot_aug()`: Visualizes the overlap between original and generated data using PCA or t-SNE.

## Usage Tips
- **CVAE**: To use conditional generation, pass a `SingleCellExperiment` object with labels to `fit_vae()`. This allows the model to learn category-specific distributions.
- **Loss Function**: The package uses a combination of Binary Cross-Entropy (reconstruction loss) and Kullback-Leibler divergence (regularization loss).
- **Environment**: Ensure `reticulate::py_available()` and `keras::is_keras_available()` return `TRUE` before starting, as the package relies on a Python backend.
- **Early Stopping**: Always use `keras::callback_early_stopping` in `fit_vae()` to prevent overfitting and save the best weights.

## Reference documentation
- [Generating Samples of Gene Expression Data with Variational Autoencoders](./references/VAExprs.md)