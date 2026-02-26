---
name: bioconductor-indeed
description: The bioconductor-indeed package identifies biomarkers by integrating differential expression and differential network analysis to calculate molecule activity scores. Use when user asks to identify biomarkers using integrated correlation analysis, perform non-partial or partial correlation network analysis, or visualize differential networks.
homepage: https://bioconductor.org/packages/release/bioc/html/INDEED.html
---


# bioconductor-indeed

## Overview
The `INDEED` package implements a method to identify biomarkers by integrating differential expression (DE) and differential network (DN) analysis. Unlike standard DE analysis which looks at molecules in isolation, `INDEED` considers how the relationships (correlations) between molecules change between two biological groups (e.g., Case vs. Control). It calculates an **Activity Score** for each molecule, where higher scores indicate both statistical significance in expression changes and high connectivity within the differential network.

## Typical Workflow

### 1. Data Preparation
The package requires three primary inputs:
- **Data Matrix**: A $p \times n$ dataframe of expression levels (rows = biomolecules, columns = samples).
- **Class Labels**: A $1 \times n$ vector/dataframe with group labels (0 for group 1, 1 for group 2).
- **ID**: A $p \times 1$ dataframe containing unique identifiers (e.g., KEGG IDs, Gene Symbols) for each biomolecule.
- **P-values (Optional)**: A $p \times 1$ dataframe of p-values from a separate DE analysis. If not provided, the functions will calculate them.

### 2. Non-Partial Correlation Analysis
Use `non_partial_cor()` for a straightforward correlation-based network. This is the most common starting point.

```r
library(INDEED)

# Perform analysis
result <- non_partial_cor(
  data = Met_GU, 
  class_label = Met_Group_GU, 
  id = Met_name_GU, 
  method = "pearson",          # or "spearman"
  p_val = pvalue_M_GU,         # optional
  permutation = 1000, 
  permutation_thres = 0.05, 
  fdr = TRUE                   # Set to FALSE if the resulting network is too sparse
)

# Access results
# result$activity_score  <- Ranked list of biomarkers
# result$diff_network    <- Network edge weights and binary connections
```

### 3. Partial Correlation Analysis
Use partial correlation to identify direct relationships by removing the influence of other variables. This requires a two-step process to select the tuning parameter ($\rho$).

```r
# Step 1: Pre-process and select rho
pre_data <- select_rho_partial(
  data = Met_GU, 
  class_label = Met_Group_GU, 
  id = Met_name_GU,
  error_curve = TRUE
)

# Step 2: Perform partial correlation analysis
result <- partial_cor(
  data_list = pre_data, 
  rho_group1 = 'min',          # 'min' (minimum) or 'ste' (one standard error)
  rho_group2 = 'min', 
  p_val = pvalue_M_GU,
  permutation = 1000, 
  permutation_thres = 0.05, 
  fdr = TRUE
)
```

### 4. Interactive Visualization
The `network_display()` function creates an interactive widget to explore the results.

```r
network_display(
  result = result, 
  nodesize = 'Node_Degree',    # Options: 'Node_Degree', 'Activity_Score', 'P_Value', 'Z_Score'
  nodecolor = 'Activity_Score', 
  edgewidth = FALSE,           # TRUE scales edge width by weight
  layout = 'nice'              # Options: 'nice', 'sphere', 'grid', 'star', 'circle'
)
```

## Tips for Interpretation
- **Activity Score**: This is the primary metric for biomarker ranking. It integrates the node's degree in the differential network with its DE p-value.
- **Edge Colors**: In the visualization, green edges typically represent positive correlations and red edges represent negative correlations.
- **Sparsity Issues**: If the resulting network has no edges, try setting `fdr = FALSE` or increasing the `permutation_thres` (e.g., to 0.1) to relax the stringency of the differential network construction.

## Reference documentation
- [Introduction to INDEED](./references/Introduction_to_INDEED.Rmd)