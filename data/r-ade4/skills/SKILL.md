---
name: r-ade4
description: This tool provides expert guidance for multivariate data analysis in ecology and environmental sciences using the ade4 R package. Use when user asks to perform ordination techniques like PCA or Correspondence Analysis, analyze mixed data types with Hill and Smith, or conduct multi-table methods such as Coinertia, RLQ, and STATIS.
homepage: https://cloud.r-project.org/web/packages/ade4/index.html
---


# r-ade4

name: r-ade4
description: Expert guidance for multivariate data analysis in ecology and environmental sciences using the ade4 R package. Use this skill when performing ordination techniques including PCA, Correspondence Analysis (CA), Hill and Smith analysis, and multi-table methods like Coinertia, RLQ, and STATIS.

## Overview
The `ade4` package (Analysis of Ecological Data: Exploratory and Euclidean Methods in Environmental Sciences) is a comprehensive framework for multivariate analysis. It implements a "Duality Diagram" approach, providing a unified mathematical structure for various ordination methods. It is particularly strong in analyzing ecological structures, environmental gradients, and the relationships between species traits and environmental variables.

## Installation
To install the stable version from CRAN:
```r
install.packages("ade4")
```

To use the modern graphical engine (recommended):
```r
install.packages("adegraphics")
```

## Core Workflow: The Dudi Object
Most analyses in `ade4` begin by creating a `dudi` (Duality Diagram) object.

### 1. One-Table Analysis (Ordination)
*   **PCA (Principal Component Analysis):** `dudi.pca(df, scannf = TRUE, nf = 2)`
    *   Use for quantitative variables.
    *   Set `scale = TRUE` (default) for correlation PCA, `scale = FALSE` for covariance PCA.
*   **CA (Correspondence Analysis):** `dudi.coa(df, ...)`
    *   Use for contingency tables or species abundance data (count data).
*   **MCA (Multiple Correspondence Analysis):** `dudi.acm(df, ...)`
    *   Use for categorical/nominal variables.
*   **Hill and Smith:** `dudi.hillsmith(df, ...)`
    *   Use for mixed data types (quantitative and qualitative).

### 2. Accessing Results
For a dudi object `res`:
*   `res$eig`: Eigenvalues (check scree plot with `screeplot(res)`).
*   `res$li`: Row coordinates (individuals/sites).
*   `res$co`: Column coordinates (variables/species).
*   `res$l1`: Row loadings (normed to 1).
*   `res$c1`: Column loadings (normed to 1).

### 3. Two-Table and Multi-Table Analysis
*   **Coinertia Analysis:** `coinertia(dudi1, dudi2, ...)`
    *   Finds common structures between two tables (e.g., Environment vs. Species).
*   **RLQ Analysis:** `rlq(dudiR, dudiL, dudiQ, ...)`
    *   Relates environmental variables (R) to species traits (Q) via a species distribution table (L).
*   **STATIS:** `statis(ktab, ...)`
    *   Analyzes K-tables (multiple tables with the same rows).

## Visualization
While `ade4` has base graphics, `adegraphics` is the modern standard. Load it **after** `ade4`.

*   **Label Plot:** `s.label(res$li)`
*   **Class Plot:** `s.class(res$li, fac)` (Draws ellipses around groups defined by factor `fac`).
    *   *Note:* Ellipses represent main variation (inertia), not statistical significance levels.
*   **Correlation Circle:** `s.corcircle(res$co)`

## Tips for Success
*   **Data Preparation:** Ensure your data frame contains only the variables intended for analysis. Move IDs or grouping factors to a separate vector.
*   **scannf:** Most functions default to `scannf = TRUE`, which opens an interactive prompt to choose the number of axes. For non-interactive scripts, set `scannf = FALSE` and specify `nf`.
*   **Testing Significance:** Use permutation tests (e.g., `randtest()`) to evaluate the significance of structures found in coinertia or RLQ.

## Reference documentation
- [FAQ](./references/faq.Rmd)