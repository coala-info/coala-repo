---
name: bioconductor-deeptarget
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/DeepTarget.html
---

# bioconductor-deeptarget

name: bioconductor-deeptarget
description: Deep characterization of cancer drugs by integrating large-scale genetic (CRISPR) and drug screens. Use this skill to predict drug primary and secondary targets, assess mutant vs. wild-type specificity, and analyze drug-gene interactions using DepMap-style datasets.

# bioconductor-deeptarget

## Overview

The `DeepTarget` package provides tools to integrate drug sensitivity profiles with genetic knockout (KO) screens (like CRISPR/Avana) to characterize drug mechanisms of action. It enables researchers to identify primary targets, discover secondary targets that mediate response when the primary is absent, and determine if a drug preferentially targets specific mutant forms of a protein.

## Core Workflow

### 1. Data Preparation
The package relies on three main data types: Drug Response Scores (DRS), Gene Effect Scores (KO.GES), and genomic features (mutations and expression).

```r
library(DeepTarget)
data("OntargetM")

# Extract key matrices
sec.prism <- OntargetM$secondary_prism  # Drugs (rows) x Cell Lines (cols)
KO.GES <- OntargetM$avana_CRISPR        # Genes (rows) x Cell Lines (cols)
mutations <- OntargetM$mutations_mat    # Genes x Cell Lines (0/1)
expression <- OntargetM$expression_20Q4 # Genes x Cell Lines (log2)
```

### 2. Computing Similarity (DKS Score)
The Drug-KO Similarity (DKS) is calculated using correlation between drug sensitivity and gene knockout effects.

```r
# Compute correlation for a specific drug
# DRS_row should be a 1-row data frame or matrix for the drug of interest
out <- computeCor(drug_id, DRS_row, KO.GES)
# Returns a matrix with Correlation, P-val, and FDR for all genes
```

### 3. Target Prediction
Identify the most likely targets by comparing similarity scores across known targets or all genes.

```r
# Predict among known targets provided in metadata
drug_target_sim <- PredTarget(list_of_sim_results, metadata)

# Predict best target across all genes
drug_gene_max_sim <- PredMaxSim(list_of_sim_results, metadata)
```

### 4. Interaction Analysis
Determine if drug response is modulated by the target's mutation status or expression level.

```r
# Test for mutation-specific activity
# Returns strength and p-value of the interaction
out_mut <- DoInteractMutant(target_info, mutations, DRS, KO.GES)

# Test for expression-dependent activity (e.g., secondary targets)
# CutOff defines 'low' expression (default often 2)
out_expr <- DoInteractExp(target_info, expression, DRS, KO.GES, CutOff = 2)
```

## Application & Visualization

### Visualizing Primary Targets
Use `plotCor` to visualize the correlation between a drug and a specific gene.
```r
plotCor(drug_name, gene_name, prediction_df, drug_response_matrix, KO.GES, plot = TRUE)
```

### Mutant vs. Wild-Type Specificity
Use `DMB` (Drug-Mutation-Binding) to compare correlations in mutant vs. wild-type cell lines.
```r
# Helps identify if a drug (e.g., Dabrafenib) specifically targets mutant BRAF
out <- DMB(drug_name, gene_name, prediction_row, mutations, DRS, KO.GES, plot = TRUE)
```

### Secondary Target Discovery
Use `DTR` (Drug-Target-Response) to see if a drug's effect is lost when the primary target is not expressed, then use `plotSim` to find genes that correlate with the drug in those specific "low-expression" cell lines.
```r
# Check if response depends on primary target expression
out <- DTR(drug_name, primary_gene, prediction_row, expression, DRS, KO.GES, CutOff = 2)

# Find secondary targets in cell lines where primary is low
# 1. Filter cell lines where primary target expression < CutOff
# 2. Run computeCor on that subset of cell lines
```

## Tips for Success
- **Data Alignment**: Ensure cell line names (column names) match exactly between the drug response matrix and the CRISPR/expression matrices.
- **Duplicate Assays**: Some drugs in PRISM have multiple Broad IDs or replicates. Process them individually or average them before analysis.
- **Thresholds**: A common threshold for "low expression" in DepMap data is `log2(TPM+1) < 2`.
- **Interpretation**: A high positive correlation (R) between drug sensitivity and gene KO suggests the gene is a functional target (i.e., killing the gene mimics the drug's effect).

## Reference documentation
- [DeepTarget Vignette](./references/DeepTarget_Vignette.md)