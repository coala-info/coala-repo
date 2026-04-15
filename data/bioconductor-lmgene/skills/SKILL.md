---
name: bioconductor-lmgene
description: bioconductor-lmgene provides tools for analyzing microarray data using g-log transformations and linear models to identify differentially expressed genes. Use when user asks to estimate transformation parameters, stabilize variance in expression data, normalize microarray datasets, or perform linear model analysis to find significant genes.
homepage: https://bioconductor.org/packages/3.6/bioc/html/LMGene.html
---

# bioconductor-lmgene

## Overview
LMGene provides specialized tools for the analysis of microarray data. Its core methodology relies on the generalized log (g-log) transformation to stabilize variance across the dynamic range of expression data. The package facilitates a complete workflow from data preparation and parameter estimation to normalization and the identification of differentially expressed genes using linear models.

## Data Preparation
LMGene primarily operates on `ExpressionSet` objects.

- **Loading Data**: Ensure `LMGene` and `Biobase` are loaded.
- **Creating ExpressionSets**: If starting from raw matrices, use the `neweS` function.
  ```R
  library(LMGene)
  library(Biobase)
  # mat: matrix of expression values; vlist: list of phenotype factors
  eS <- neweS(mat, vlist)
  ```

## G-log Transformation
The g-log transformation requires two parameters: $\lambda$ (lambda) and $\alpha$ (alpha).

- **Parameter Estimation**: Use `tranest` to find optimal values.
  ```R
  # Basic estimation
  tranpar <- tranest(eS)
  
  # Using a subset of genes for speed
  tranpar <- tranest(eS, ngenes=100)
  
  # Estimating separate alpha for each sample (multi-alpha)
  tranpar_mult <- tranest(eS, mult=TRUE)
  
  # Using lowess normalization during estimation
  tranpar_lowess <- tranest(eS, lowessnorm=TRUE)
  ```
- **Applying Transformation**: Use `transeS` with the estimated parameters.
  ```R
  tr_eS <- transeS(eS, tranpar$lambda, tranpar$alpha)
  ```

## Normalization
After transformation, data should be normalized to ensure comparability across arrays.
```R
# Performs linear normalization on transformed ExpressionSet
ntr_eS <- lnormeS(tr_eS)
```

## Finding Differentially Expressed Genes
The `LMGene` function computes p-values for each factor in a linear model and adjusts for FDR.

- **Basic Call**: Uses the default model (usually main effects from phenoData).
  ```R
  sig_genes <- LMGene(ntr_eS, level=0.05)
  ```
- **Custom Models**: Specify interactions or specific factors using standard R formula syntax.
  ```R
  # Example with interaction
  sig_genes <- LMGene(ntr_eS, model="patient + dose + patient:dose", level=0.01)
  ```
- **Interpreting Results**: The output is a list named by the effects in the model. Each element contains the identifiers of genes found significant at the specified FDR level.

## Tips
- **Model Specification**: The `model` argument in `tranest` and `LMGene` follows the right-hand side of an `lm()` formula.
- **Overfitting**: Be cautious when using interaction terms (e.g., `factorA:factorB`) if you have few replicates, as this can exhaust degrees of freedom.
- **Memory/Speed**: For large datasets, use the `ngenes` parameter in `tranest` to estimate parameters on a random sample of genes.

## Reference documentation
- [LMGene User's Guide](./references/LMGene.md)