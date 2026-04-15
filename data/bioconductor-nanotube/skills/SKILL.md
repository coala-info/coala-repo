---
name: bioconductor-nanotube
description: This tool processes, normalizes, and analyzes NanoString nCounter gene expression data. Use when user asks to read RCC files, perform nSolver or RUV normalization, conduct differential expression analysis, or run gene set enrichment analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/NanoTube.html
---

# bioconductor-nanotube

name: bioconductor-nanotube
description: Processing, normalization, and analysis of NanoString nCounter gene expression data. Use this skill to read RCC files, perform nSolver or RUV normalization, conduct differential expression analysis using limma or NanoStringDiff, and run gene set enrichment analysis (GSEA).

## Overview

The `NanoTube` package is designed for the end-to-end analysis of NanoString nCounter data. It streamlines the workflow from raw RCC files to differential expression (DE) and pathway analysis. Key features include multiple normalization methods (nSolver, RUV-III, RUVg), quality control (QC) metrics, and integrated wrappers for `limma` and `fgsea`.

## Typical Workflow

### 1. Data Import and Processing
The primary function `processNanostringData` handles reading raw files, merging sample metadata, and performing initial normalization.

```r
library(NanoTube)

# Process from a directory of RCC files
dat <- processNanostringData(
  nsFiles = "path/to/RCC_files",
  sampleTab = "sample_metadata.csv",
  idCol = "RCC_Name",           # Column in metadata matching RCC filenames
  groupCol = "Sample_Diagnosis", # Column defining experimental groups
  normalization = "nSolver"      # Options: "nSolver", "RUVIII", "RUVg", "none"
)
```

### 2. Quality Control
Assess the technical quality of the run using positive and negative control probes.

```r
# Positive Control QC (Scaling factors should be 0.3 - 3; R-squared > 0.95)
posQC <- positiveQC(dat)
posQC$tab
posQC$plt

# Negative Control QC (Background assessment)
negQC <- negativeQC(dat)
negQC$tab

# Principal Component Analysis
pca_res <- nanostringPCA(dat, interactive.plot = FALSE)
pca_res$plt
```

### 3. Normalization Options
- **nSolver**: Standard NanoString approach using positive controls and housekeeping genes.
- **RUV-III**: Uses technical replicates to remove unwanted variation. Requires `replicateCol`.
- **RUVg**: Uses housekeeping genes to remove unwanted variation.

```r
# Example: RUV-III normalization
datRUV <- processNanostringData(
  nsFiles = example_data,
  sampleTab = sample_info_reps,
  replicateCol = "Replicate_ID",
  normalization = "RUVIII",
  n.unwanted = 1
)
```

### 4. Differential Expression Analysis
Use `runLimmaAnalysis` for a linear modeling approach.

```r
# Compare groups against a baseline
limmaResults <- runLimmaAnalysis(dat, base.group = "Control")

# Generate a results table
limmaStats <- makeDiffExprFile(limmaResults, filename = NULL, returns = "stats")

# Visualize with a Volcano Plot
deVolcano(limmaResults, plotContrast = "Treatment_Group")
```

### 5. Gene Set Enrichment Analysis (GSEA)
`NanoTube` provides wrappers for `fgsea` to identify enriched pathways.

```r
# Run GSEA on limma results
fgseaResults <- limmaToFGSEA(limmaResults, gene.sets = MyPathways)

# Extract leading edge genes
leading_edge <- fgseaToLEdge(fgseaResults, cutoff.type = "padj", cutoff = 0.05)

# Cluster redundant pathways
grouped_res <- groupFGSEA(fgseaResults$ContrastName, leading_edge$ContrastName)
```

## Tips and Best Practices
- **Housekeeping Genes**: If not specified, `processNanostringData` uses genes labeled "Housekeeping" in the RCC files. You can provide a custom vector via the `housekeeping` argument.
- **Background Subtraction**: Use `bgType = "t.test"` or `"threshold"` within `processNanostringData` to filter out genes with expression near background noise.
- **Output Formats**: By default, `processNanostringData` returns an `ExpressionSet`. Use `output.format = "list"` if you need to access raw QC metrics directly.
- **NanoStringDiff**: For small sample sizes or when a negative binomial model is preferred, use `makeNanoStringSetFromEset(datNoNorm)` to interface with the `NanoStringDiff` package.

## Reference documentation
- [Analyzing NanoString nCounter Data with the NanoTube](./references/NanoTube.md)