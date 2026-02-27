---
name: bioconductor-proteomm
description: This tool performs peptide-level differential expression analysis and normalization for single or multiple proteomic datasets. Use when user asks to normalize proteomics data with EigenMS, impute missing values using model-based approaches, or perform statistical testing for differential expression across one or more datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/ProteoMM.html
---


# bioconductor-proteomm

name: bioconductor-proteomm
description: Peptide-level differential expression analysis for single or multiple proteomic datasets. Use when analyzing bottom-up MS-based proteomics data to perform EigenMS normalization, model-based imputation of missing values, and statistical testing (MBDE) across one or more datasets simultaneously.

# bioconductor-proteomm

## Overview

ProteoMM is a specialized platform for peptide-level differential expression analysis. Unlike methods that "roll up" peptide intensities into protein-level averages, ProteoMM utilizes all available peptide observations to increase statistical power. It is particularly effective for combining multiple datasets (e.g., different species or experiments) into a single p-value and effect size estimate.

The package follows a specific pipeline:
1. **Data Preparation**: Log2 transformation and metadata organization.
2. **EigenMS Normalization**: SVD-based removal of bias trends.
3. **Model-Based Imputation**: Handling informative missingness (abundance-dependent).
4. **Statistical Analysis**: Differential expression (MBDE) and Presence/Absence analysis.

## Workflow and Key Functions

### 1. Data Preparation
ProteoMM requires intensities and metadata to be separated but linked.

```r
library(ProteoMM)

# Extract intensities and log2 transform
# intsCols: indices of columns containing intensity values
m_logInts <- make_intencities(df, intsCols)
m_logInts <- convert_log2(m_logInts)

# Extract metadata
# metaCols: indices for peptide sequences, protein IDs, etc.
m_prot.info <- make_meta(df, metaCols)
```

### 2. EigenMS Normalization
Normalization is performed in two steps: identifying bias trends and then removing them.

```r
# Step 1: Identify trends
# treatment: factor level for groups
eig1 <- eig_norm1(m = m_logInts, treatment = grps, prot.info = m_prot.info)

# Step 2: Remove bias trends
# You can manually adjust eig1$h.c if visual inspection suggests more trends
norm_data <- eig_norm2(rv = eig1)
```

### 3. Model-Based Imputation
ProteoMM accounts for both "Missing Completely at Random" (MCAR) and "Abundance-Dependent" (left-censored) missingness.

```r
# pr_ppos: column index in prot.info containing the Protein ID
imp_res <- MBimpute(norm_data$normalized[, intsCols], 
                    grps, 
                    prot.info = norm_data$normalized[, metaCols], 
                    pr_ppos = 3, 
                    my.pi = 0.05) # 0.05 is a standard estimate for MCAR
```

### 4. Differential Expression (DE)

#### Single Dataset Analysis
Use `peptideLevel_DE` for standard single-experiment analysis.

```r
de_results <- peptideLevel_DE(imp_res$y_imputed, 
                             grps, 
                             prot.info = imp_res$imp_prot.info, 
                             pr_ppos = 2)
```

#### Multi-Dataset Analysis
To combine datasets (e.g., Human and Mouse), use parallel lists and identify common proteins.

```r
# Prepare lists
mms <- list(dataset1_ints, dataset2_ints)
treats <- list(grps1, grps2)
protinfos <- list(meta1, meta2)

# Subset for common proteins
subset_data <- subset_proteins(mm_list = mms, prot.info = protinfos, 'ProteinID_Col')

# Run Multi-Matrix DE
comb_MBDE <- prot_level_multi_part(mm_list = mms, 
                                   treat = treats, 
                                   prot.info = protinfos, 
                                   prot_col_name = 'ProteinID_Col', 
                                   nperm = 500) # Use 500+ for publication
```

### 5. Presence/Absence Analysis
For proteins with too many missing values to be imputed/normalized, use Presence/Absence testing.

```r
# Identify proteins not included in normalization
presAbs_prots <- get_presAbs_prots(mm_list = raw_list, 
                                   prot.info = meta_list, 
                                   protnames_norm = normalized_protein_names, 
                                   prot_col_name = 2)

# Test for differential presence
pa_results <- peptideLevel_PresAbsDE(presAbs_ints, grps, presAbs_meta, pr_ppos = 3)
```

## Visualization
ProteoMM provides specific functions for proteomics-style plots:
- `plot_3_pep_trends_NOfile()`: Compares raw, normalized, and imputed peptide trends for a specific protein.
- `plot_volcano_wLab()`: Generates volcano plots with gene labels and specific fold-change/p-value cutoffs.

## Tips for Success
- **Seed Setting**: Functions like `eig_norm1` and `MBimpute` use random number generators. Always use `set.seed()` for reproducibility.
- **Group Order**: When performing multi-dataset analysis, ensure the treatment group order is consistent across all datasets in your lists.
- **P-value Adjustment**: The package provides `BH_P_val` (Benjamini-Hochberg). Always check the p-value distribution histograms to ensure the adjustment is appropriate for your data.

## Reference documentation
- [ProteoMM Vignette](./references/ProteoMM_vignette.md)