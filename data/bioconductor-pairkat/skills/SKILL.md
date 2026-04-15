---
name: bioconductor-pairkat
description: This tool performs statistical association tests between high-dimensional metabolomics data and clinical phenotypes by integrating biological pathway networks. Use when user asks to assess relationships between KEGG pathways and outcomes, incorporate graph topography into regression models, or perform pathway-integrated kernel association tests.
homepage: https://bioconductor.org/packages/release/bioc/html/pairkat.html
---

# bioconductor-pairkat

name: bioconductor-pairkat
description: Statistical analysis of metabolomics and high-dimensional data using pathway-integrated kernel association tests. Use this skill to assess relationships between biological networks (e.g., KEGG pathways) and clinical outcomes while adjusting for covariates, incorporating graph topography and smoothing.

# bioconductor-pairkat

## Overview

The `pairkat` package implements the Pathway Integrated Regression-based Kernel Association Test. It is designed to test for associations between high-dimensional data (like metabolomics) and phenotypes by leveraging known biological connections. By representing pathways as networks and applying graph regularization (smoothing), it improves statistical power compared to methods that ignore graph structure or treat nodes as independent.

## Core Workflow

### 1. Data Preparation
Data must be organized into a `SummarizedExperiment` object with three specific components:
*   **Assay**: A matrix named `"metabolomics"` (rows = metabolites, columns = subjects).
*   **colData**: Phenotype data (rows = subjects, columns = variables). Categorical variables should be dummy-coded.
*   **rowData**: Pathway mapping (rows = metabolites) containing a column with KEGG IDs.

```r
library(pairkat)
library(SummarizedExperiment)

se <- SummarizedExperiment(
  assays = list(metabolomics = metabolome_matrix),
  rowData = pathway_dataframe,
  colData = phenotype_dataframe
)
```

### 2. Network Construction
Use `GatherNetworks` to query the KEGG API and build network graphs based on the metabolites present in your dataset.

```r
# Identify species code (e.g., "hsa" for human)
# networks <- GatherNetworks(SE, keggID, species, minPathwaySize)

networks <- GatherNetworks(
  SE = se,
  keggID = "kegg_id",
  species = "hsa",
  minPathwaySize = 5
)
```

### 3. Association Testing
Run the kernel association test using a null model formula. The formula defines the relationship between the outcome and covariates to adjust for.

```r
# output <- PaIRKAT(formula.H0, networks, tau = 1)

output <- PaIRKAT(log_outcome ~ age + bmi + smoking_status, 
                  networks = networks,
                  tau = 1)

# View results
print(output$results)
```

### 4. Visualization
Visualize the connectivity of specific pathways used in the analysis.

```r
plotNetworks(networks = networks, 
             pathway = "Glycolysis / Gluconeogenesis")
```

## Key Parameters and Tips

*   **tau**: Controls the amount of graph smoothing. A value of `1` is typically recommended; excessive smoothing can lead to inflated Type I error rates.
*   **Species IDs**: Use `KEGGREST::keggList("organism")` to find the correct three-letter code for your data.
*   **Missing Nodes**: `pairkat` handles disconnected nodes (metabolites in a pathway with no known KEGG edges) via the smoothing approach, which prevents loss of power.
*   **Formula Syntax**: The `formula.H0` argument follows standard R formula conventions (e.g., `y ~ x1 + x2`).

## Reference documentation

- [Pathway Integrated Regression-based Kernel Association Test (PaIRKAT)](./references/using-pairkat.md)
- [PaIRKAT Vignette (Rmd)](./references/using-pairkat.Rmd)