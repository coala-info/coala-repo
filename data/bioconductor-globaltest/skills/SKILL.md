---
name: bioconductor-globaltest
description: This tool performs statistical testing of groups of covariates to determine their association with a response variable using the globaltest R package. Use when user asks to perform gene set enrichment analysis, conduct pathway analysis, test high-dimensional data for phenotype associations, or adjust for confounders in group-level regression models.
homepage: https://bioconductor.org/packages/release/bioc/html/globaltest.html
---

# bioconductor-globaltest

name: bioconductor-globaltest
description: Statistical testing of groups of covariates (gene sets, pathways) for association with a response variable using the globaltest R package. Use this skill when performing gene set enrichment analysis (GSEA), pathway analysis, or testing high-dimensional data where the number of covariates exceeds the number of subjects. It supports linear, logistic, multinomial, Poisson, and Cox regression models.

## Overview
The `globaltest` package is designed to determine if a group of variables (e.g., genes in a pathway) is significantly associated with a phenotype or response. Unlike competitive tests that compare a gene set against the rest of the genome, `globaltest` is a self-contained test that evaluates the null hypothesis that none of the genes in the set are associated with the response. It is particularly powerful for detecting groups where many genes have small, coordinated effects.

## Core Workflow

### 1. Basic Testing
The primary function is `gt()`. It can be called using formulas or design matrices.

```R
library(globaltest)

# Formula interface: gt(response ~ null_model, alternative_model, data)
# Test if genes A, B, and C are associated with response Y
res <- gt(Y ~ 1, ~ A + B + C, data = X)

# Matrix interface: gt(response, alternative_matrix)
res <- gt(Y, X_subset)

# Extract results
p.value(res)
summary(res)
```

### 2. Gene Set Testing (Bioconductor)
`globaltest` integrates with Bioconductor `ExpressionSet` objects and annotation databases.

```R
# Testing an ExpressionSet
# ALL.AML is a phenotype column in pData(Golub_Train)
gt(ALL.AML, Golub_Train)

# Testing specific databases
# KEGG Pathways
gtKEGG(ALL.AML, Golub_Train, id = "04110")

# Gene Ontology (GO)
gtGO(ALL.AML, Golub_Train, ontology = "BP", minsize = 10, maxsize = 500)
```

### 3. Adjusting for Confounders
To correct for nuisance variables (e.g., age, sex, batch effects), include them in the null model.

```R
# Test gene_set association with Y, adjusting for Age
gt(Y ~ Age, ~ gene_set, data = X)
```

### 4. Diagnostic Plots
Visualize the contribution of individual genes or subjects to the test statistic.

*   **Features Plot**: Shows which genes drive the significance.
    ```R
    # Use alias to show Gene Symbols instead of Probe IDs
    features(res, alias = hu6800SYMBOL)
    ```
*   **Subjects Plot**: Identifies outlier samples or groups of samples with similar expression patterns.
    ```R
    subjects(res)
    ```

## Advanced Options

### Multiple Testing
When testing many sets (e.g., all GO terms), use `p.adjust` or structured methods.
*   **Focus Level**: Exploits the GO graph structure for better power.
    ```R
    res <- gtGO(ALL.AML, Golub_Train, ontology = "BP", multtest = "focus")
    ```
*   **Inheritance**: Used for tree-structured hypotheses (e.g., hierarchical clustering).
    ```R
    res <- inheritance(gt_obj, hclust_obj)
    ```

### Model Selection
The package automatically detects the model based on the response type:
*   **Continuous**: Linear regression.
*   **Binary/Logical**: Logistic regression.
*   **Factor (>2 levels)**: Multinomial logistic.
*   **Surv object**: Cox proportional hazards.
*   **Counts**: Poisson (specify `model = "Poisson"`).

### Weights and Directionality
*   **Standardize**: Use `standardize = TRUE` if covariates are in different units.
*   **Directional**: Use `directional = TRUE` if you expect all genes in a set to be regulated in the same direction (e.g., all up-regulated).
*   **Weights**: Provide a vector to `weights` to prioritize specific genes.

## Reference documentation
- [The Global Test and the globaltest R package](./references/GlobalTest.md)