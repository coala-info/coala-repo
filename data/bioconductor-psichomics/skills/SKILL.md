---
name: bioconductor-psichomics
description: This tool performs integrative analyses of alternative splicing and gene expression using transcriptomic data. Use when user asks to load data from TCGA or GTEx, quantify Percent Spliced-In values, perform differential splicing analysis, correlate splicing with gene expression, or conduct survival analysis based on splicing events.
homepage: https://bioconductor.org/packages/release/bioc/html/psichomics.html
---

# bioconductor-psichomics

name: bioconductor-psichomics
description: Expert guidance for the psichomics R package to perform integrative analyses of alternative splicing and gene expression. Use this skill when users need to: (1) Load transcriptomic data from TCGA, GTEx, SRA (via recount), or local files; (2) Quantify alternative splicing (PSI) from junction counts; (3) Perform differential splicing or gene expression analysis; (4) Correlate splicing with gene expression; (5) Conduct survival analysis based on splicing events; or (6) Prepare custom splicing annotations from tools like SUPPA, rMATS, MISO, or VAST-TOOLS.

# bioconductor-psichomics

## Overview
The `psichomics` package is a powerful R/Bioconductor tool designed for the quantification and analysis of alternative splicing (AS) and gene expression. It facilitates the calculation of Percent Spliced-In (PSI) values from splice junction counts and enables downstream statistical analyses, including PCA, differential splicing, and survival analysis. It is particularly well-integrated with large-scale projects like TCGA and GTEx but supports any user-provided data following specific formats.

## Core Workflow

### 1. Data Loading
`psichomics` can automate the retrieval of data from major repositories or load local files.

```r
library(psichomics)

# Load TCGA data (e.g., Breast Cancer)
folder <- getDownloadsFolder()
data <- loadFirebrowseData(folder=folder, cohort="BRCA", 
                           data=c("clinical", "junction_quantification", "RSEM_genes"))

# Extract components
clinical      <- data[[1]]$`Clinical data`
junctionQuant <- data[[1]]$`Junction quantification (Illumina HiSeq)`
geneExpr      <- data[[1]]$`Gene expression`
```

### 2. Alternative Splicing Quantification
To quantify AS, you need junction quantification data and an annotation object.

```r
# List and load available annotations (e.g., hg19)
annotList <- listSplicingAnnotations(assembly="hg19")
annotation <- loadAnnotation(annotList[[1]])

# Quantify PSI (Percent Spliced-In)
psi <- quantifySplicing(annotation, junctionQuant, minReads=10)
```

### 3. Gene Expression Processing
Standardize gene expression data before correlation or differential expression analyses.

```r
# Filter and normalize (TMM method)
filter <- filterGeneExpr(geneExpr, minCounts=10, minTotalCounts=15)
geneExprNorm <- normaliseGeneExpression(geneExpr, geneFilter=filter, method="TMM")
```

### 4. Grouping and Differential Analysis
Define groups based on clinical attributes to compare splicing profiles.

```r
# Create groups based on sample type
groups <- createGroupByAttribute("Sample types", sampleMetadata)
groupList <- list(Normal = groups$`Solid Tissue Normal`, 
                  Tumor = groups$`Primary solid Tumor`)

# Differential Splicing Analysis
diffSplicing <- diffAnalyses(psi, groupList)
```

### 5. Correlation and Survival Analysis
Investigate the relationship between splicing and gene expression or patient outcomes.

```r
# Correlate a specific gene (e.g., QKI) with an AS event (e.g., NUMB)
corr <- correlateGEandAS(geneExprNorm, psi, "QKI|9444", "SE_14_-_73749067...")
plotCorrelation(corr)

# Survival analysis for an event
# Requires matching samples to subjects in clinical data
eventPSI <- assignValuePerSubject(psi[eventID, ], sampleToSubjectMatch, clinical)
opt <- optimalSurvivalCutoff(clinical, eventPSI, event="days_to_death")
```

## Custom Annotations
If using external tools, parse their output to create `psichomics` compatible annotations:
- **SUPPA**: `parseSuppaAnnotation(path)`
- **rMATS**: `parseMatsAnnotation(path)`
- **MISO**: `parseMisoAnnotation(path)`
- **VAST-TOOLS**: `parseVastToolsAnnotation(path)`
- **Final Step**: Always run `prepareAnnotationFromEvents(parsedData)` to finalize.

## Tips for Success
- **Memory Management**: TCGA/GTEx datasets are large. Use `filterGeneExpr` and `minReads` in `quantifySplicing` to reduce the data matrix size.
- **Identifier Matching**: Ensure sample IDs in `junctionQuant`, `geneExpr`, and `clinical` data match exactly. Use `getSubjectFromSample()` to bridge sample-level data to subject-level clinical outcomes.
- **Visual Interface**: If the CLI becomes complex, the package provides a Shiny app via `psichomics()`.

## Reference documentation
- [Preparing Alternative Splicing Annotation](./references/AS_events_preparation.md)
- [Command-Line Interface (CLI) Tutorial](./references/CLI_tutorial.md)
- [Visual Interface (GUI) Tutorial](./references/GUI_tutorial.md)
- [Loading User-Provided Data](./references/custom_data.md)