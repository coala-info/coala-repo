---
name: bioconductor-variancepartition
description: This tool quantifies and visualizes the contribution of multiple sources of variation in gene expression datasets using linear mixed models. Use when user asks to partition variance attributable to biological and technical variables, perform differential expression analysis with repeated measures using the dream workflow, or visualize correlation structures between samples.
homepage: https://bioconductor.org/packages/release/bioc/html/variancePartition.html
---


# bioconductor-variancepartition

name: bioconductor-variancepartition
description: Quantify and visualize the contribution of multiple sources of variation in gene expression datasets. Use this skill for: (1) Partitioning variance attributable to biological and technical variables, (2) Performing differential expression analysis with repeated measures or complex designs using the "dream" workflow, (3) Visualizing correlation structures between samples, and (4) Conducting multivariate hypothesis testing.

# bioconductor-variancepartition

## Overview

The `variancePartition` package provides a statistical framework to quantify the drivers of variation in complex gene expression experiments. It uses linear mixed models to decompose the total variance of each gene into fractions attributable to specific variables (e.g., individual, tissue, age, batch). The package also includes the **dream** (Differential expression for repeated measures) workflow, which adapts the `limma/voom` pipeline to use linear mixed models, providing increased power and better false positive control for datasets with multiple measurements per individual.

## Core Workflows

### Variance Partitioning Analysis

Use this workflow to identify which variables contribute most to the variation in your dataset.

1.  **Define the formula**: Model categorical variables as random effects (e.g., `(1|Individual)`) and continuous variables as fixed effects (e.g., `Age`).
2.  **Fit the model**: Use `fitExtractVarPartModel()` to estimate the variance fractions for each gene.
3.  **Visualize results**: Use `plotVarPart()` to create a violin plot of the variance fractions across all genes.

Example:
form <- ~ (1|Individual) + (1|Tissue) + Age + Batch
vp <- fitExtractVarPartModel(geneExpr, form, info)
plotVarPart(sortCols(vp))

### Differential Expression with "dream"

Use the dream workflow when you have repeated measures or a nested study design where standard `limma` or `duplicateCorrelation` is insufficient.

1.  **Pre-process**: Filter and normalize counts using `edgeR` or `limma`.
2.  **Estimate weights**: Use `voomWithDreamWeights()` to calculate precision weights while accounting for the random effects structure.
3.  **Fit dream model**: Use `dream()` to fit the linear mixed model for each gene.
4.  **Apply Empirical Bayes**: Use `variancePartition::eBayes()` to apply shrinkage.
5.  **Extract results**: Use `topTable()` to get differential expression statistics.

Example:
form <- ~ Disease + (1|Individual)
vobj <- voomWithDreamWeights(dge, form, metadata)
fit <- dream(vobj, form, metadata)
fit <- eBayes(fit)
topTable(fit, coef="Disease1")

### Advanced Hypothesis Testing

*   **Contrasts**: Use `makeContrastsDream()` to define comparisons between specific levels of a factor.
*   **Joint Tests**: Pass multiple coefficients to `topTable()` to perform an F-test (e.g., `topTable(fit, coef=c("Subtype1", "Subtype2"))`).
*   **Small Samples**: For datasets with < 20 samples, specify `ddf="Kenward-Roger"` in `dream()` for better small-sample inference, though it is more computationally intensive.

## Visualization and Diagnostics

*   **Correlation Structure**: Use `plotCorrStructure(fit, "Variable")` to visualize the correlation between samples for a single gene based on a specific model component.
*   **Collinearity**: Use `canCorPairs()` to check for high correlation between variables in your metadata before fitting models. Strong collinearity can lead to rank-deficient matrices and unstable estimates.
*   **P-value Comparison**: Use `plotCompareP()` to compare p-values between different methods (e.g., dream vs. duplicateCorrelation).

## Best Practices and Tips

*   **Categorical Variables**: Always model categorical variables as random effects in variance partitioning to ensure unbiased estimates and to handle variables with many levels (e.g., Individual ID).
*   **Intercept**: Ensure an intercept is included in the formula (default behavior) to maintain statistical validity.
*   **Parallel Processing**: Use the `BPPARAM` argument with `SnowParam()` from the `BiocParallel` package to speed up analysis across thousands of genes.
*   **Residuals**: Avoid over-interpreting the residual variance fraction; it represents all variation not captured by your model, including measurement noise and unmodeled biology.
*   **Convergence**: If a few genes fail to converge, `dream()` will return a warning. Successful fits are still returned; use `attr(fit, "errors")` to inspect failures.

## Reference documentation

- [Frequently asked questions](./references/FAQ.md)
- [Additional visualizations of variance structure](./references/additional_visualization.md)
- [dream analysis: Differential expression testing with linear mixed models](./references/dream.md)
- [Error handling and troubleshooting](./references/errors.md)
- [Multivariate tests: Combining results of univariate tests](./references/mvtests.md)
- [Theory and practice of random effects and REML](./references/rnd_effects.md)
- [Variance partitioning analysis tutorial](./references/variancePartition.md)