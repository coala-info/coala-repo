---
name: bioconductor-rcellminer
description: The rcellminer package provides programmatic access to the NCI-60 cancer cell line panel data, integrating drug activity with multi-omic molecular characterization. Use when user asks to search for compounds by NSC number, visualize drug activity patterns across cell lines, identify drug-gene correlations, or access mechanism of action annotations.
homepage: https://bioconductor.org/packages/release/bioc/html/rcellminer.html
---

# bioconductor-rcellminer

## Overview
The `rcellminer` package provides programmatic access to the NCI-60 cancer cell line panel data. It integrates drug activity data with multi-omic characterization (expression, copy number, mutation) from the Developmental Therapeutics Program (DTP). This skill enables the identification of drug-gene correlations, visualization of compound structures, and analysis of drug mechanisms of action.

## Core Workflows

### 1. Data Initialization
To begin analysis, load the package and the associated data package.
```r
library(rcellminer)
library(rcellminerData)

# Load drug activity and molecular data matrices
drugAct <- exprs(getAct(rcellminerData::drugData))
molData <- getMolDataMatrices() # Returns a list: exp, cop, mut, etc.
```

### 2. Searching for Compounds
Compounds are identified by NSC numbers. Use regex to find drugs by name.
```r
# Search for kinase inhibitors ending in "nib"
nscs <- searchForNscs("nib$")

# Get a drug name from an NSC ID
drugName <- getDrugName("609699")
```

### 3. Profile Visualization
Visualize patterns across the 60 cell lines for drugs, gene expression (`exp`), copy number (`cop`), or mutations (`mut`).
```r
# Plot a single drug's activity
plotCellMiner(drugAct, molData, plots = "drug", nsc = "94600")

# Plot gene expression and drug activity together
plotCellMiner(drugAct, molData, plots = c("exp", "drug"), nsc = "609699", gene = "SLFN11")

# Plot average activity for a set of drugs (e.g., Camptothecins)
drugs <- as.character(searchForNscs("camptothecin"))
plotDrugSets(drugAct, drugs, "Camptothecin Derivatives")
```

### 4. Mechanism of Action (MOA) and Annotations
Access biochemical targets and clinical status for compounds.
```r
# Get drug annotations
drugAnnot <- getFeatureAnnot(rcellminerData::drugData)[["drug"]]

# Get MOA string for a specific NSC
moa <- getMoaStr("609699")

# Filter for FDA approved drugs
fdaDrugs <- drugAnnot[drugAnnot$FDA_STATUS == "FDA approved", "NSC"]
```

### 5. Pattern Comparison and Correlation
Identify drugs whose activity correlates with a specific molecular pattern (e.g., a gene knockdown).
```r
# Define a pattern (e.g., PTEN expression)
pattern <- molData[["exp"]]["expPTEN", ]

# Compare pattern against a set of drugs
results <- patternComparison(pattern, drugAct)

# Filter significant correlations
sigResults <- results[results$PVAL < 0.01, ]
```

## Tips and Best Practices
- **NSC IDs**: Always treat NSC IDs as strings when indexing matrices to avoid numeric coercion errors.
- **Data Types**: When plotting molecular data, use the prefixes `exp` (expression), `cop` (copy number), or `mut` (mutation) before the gene symbol if required by the specific matrix.
- **Subscript out of bounds**: If this error occurs during plotting, verify the gene exists in the specific molecular matrix (e.g., `gene %in% rownames(molData$exp)`).
- **GI50 Values**: Drug activity is often stored as -log10(GI50). To convert to molar concentration: `10^(-activityValue)`.

## Reference documentation
- [Using rcellminer](./references/rcellminerUsage.md)