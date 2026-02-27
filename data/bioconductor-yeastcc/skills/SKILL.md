---
name: bioconductor-yeastcc
description: This tool provides access to yeast cell cycle microarray datasets from the Spellman and Pramila/Breeden studies as ExpressionSet objects. Use when user asks to load yeast cell cycle expression data, analyze time-course gene expression in Saccharomyces cerevisiae, or access metadata for cell cycle regulated genes.
homepage: https://bioconductor.org/packages/release/data/experiment/html/yeastCC.html
---


# bioconductor-yeastcc

name: bioconductor-yeastcc
description: Access and analyze yeast cell cycle microarray data from Spellman et al. (1998) and Pramila/Breeden (2006). Use this skill to load ExpressionSet objects containing time-course gene expression data for Saccharomyces cerevisiae, specifically for studies involving cell cycle synchronization (alpha factor, cdc15, cdc28, and elutriation).

## Overview
The `yeastCC` package is an experiment data package providing classic yeast cell cycle microarray datasets. It primarily contains `ExpressionSet` objects that facilitate the study of gene expression dynamics across different cell cycle phases. The package includes data from two landmark studies: the Spellman et al. (1998) dataset (77 conditions) and the Pramila/Breeden (2006) dataset (50 samples).

## Data Objects
The package provides four primary data objects:
- `yeastCC`: An `ExpressionSet` containing the Spellman et al. (1998) data (6,178 genes, 77 conditions).
- `breeden`: An `ExpressionSet` containing the Pramila/Breeden (2006) dye-swap experiment data (50 samples).
- `orf800`: A character vector of the 800 genes identified as cell cycle regulated by Spellman et al.
- `spYCCmeta`: A data frame containing metadata for the 800 cell cycle regulated genes, including peak phase and promoter elements.

## Typical Workflows

### Loading the Data
```R
library(yeastCC)

# Load the Spellman dataset
data(yeastCC)

# Load the Breeden dataset
data(breeden)

# Load the list of 800 regulated genes
data(orf800)
```

### Exploring the Spellman Dataset (yeastCC)
The `yeastCC` object contains four main time-courses: alpha, cdc15, cdc28, and elu.
```R
# View basic info
yeastCC

# Access expression values (log-ratios)
exp_data <- exprs(yeastCC)

# Check sample metadata (time points and synchronization methods)
pData(yeastCC)

# Filter for the 800 regulated genes
regulated_data <- yeastCC[orf800, ]
```

### Analyzing the Breeden Dataset
The `breeden` dataset includes a `sign` variable in the phenotype data to handle dye-swap samples.
```R
data(breeden)

# Plot raw expression for a specific gene (e.g., YBL002W)
plot(exprs(breeden)["YBL002W", ] ~ breeden$mins)

# Plot expression adjusted for dye-swap sign
plot(I(exprs(breeden)["YBL002W", ] * breeden$sign) ~ breeden$mins)
```

### Using Metadata (spYCCmeta)
Use `spYCCmeta` to find functional annotations or predicted cell cycle phases for the 800 genes.
```R
data(spYCCmeta)

# View metadata for the first few genes
head(spYCCmeta[, c("ORF", "Peak", "Phase.Order", "Function")])

# Find genes peaking in S phase
s_phase_genes <- spYCCmeta$ORF[spYCCmeta$Peak == "S"]
```

## Tips
- **Synchronization Methods**: When using `yeastCC`, remember that the 77 samples are grouped by synchronization method. Use `pData(yeastCC)` to subset the data by specific experiments (e.g., only the "alpha" time course).
- **Dye-Swaps**: In the `breeden` dataset, always multiply the expression values by the `sign` column in `pData` to ensure consistent orientation of the log-ratios across dye-swap replicates.
- **Gene Identifiers**: The package uses systematic ORF names (e.g., "YAL022C") as feature names.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)