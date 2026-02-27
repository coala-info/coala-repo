---
name: bioconductor-rnbeads
description: RnBeads performs comprehensive end-to-end analysis of DNA methylation data from microarrays and bisulfite sequencing. Use when user asks to import methylation data, perform quality control, normalize array data, conduct exploratory analysis, or compute differential methylation.
homepage: https://bioconductor.org/packages/release/bioc/html/RnBeads.html
---


# bioconductor-rnbeads

name: bioconductor-rnbeads
description: Comprehensive analysis of DNA methylation data from Infinium microarrays (450k, EPIC, 27k) and bisulfite sequencing (WGBS, RRBS). Use this skill to perform data import, quality control, preprocessing, normalization, covariate inference, exploratory analysis, and differential methylation workflows in R.

# bioconductor-rnbeads

## Overview
RnBeads is an R package designed for the end-to-end analysis of genome-wide DNA methylation data. It supports both array-based platforms and single-base resolution sequencing data. The package is modular, allowing for "vanilla" automated pipelines or highly customized manual workflows. Key outputs include interactive HTML reports that summarize quality control, exploratory data analysis, and differential methylation results.

## Core Workflow

### 1. Initialization and Options
Before running an analysis, configure global options to define how RnBeads behaves (e.g., filtering criteria, identifiers).

```R
library(RnBeads)
# View all options
?rnb.options
# Set specific options
rnb.options(filtering.sex.chromosomes.removal = TRUE,
            identifiers.column = "Sample_ID",
            differential.site.test.method = "limma")
```

### 2. Data Import
RnBeads requires a sample annotation sheet (CSV) and the raw data (IDAT files for arrays or BED-like files for sequencing).

```R
data.dir <- "path/to/data"
idat.dir <- file.path(data.dir, "idat")
sample.annotation <- file.path(data.dir, "sample_annotation.csv")

# Automated import and analysis
report.dir <- "path/to/report"
rnb.run.analysis(dir.reports = report.dir, 
                 sample.sheet = sample.annotation,
                 data.dir = idat.dir, 
                 data.type = "infinium.idat.dir")
```

### 3. Working with RnBSet Objects
The `RnBSet` object is the central data container.

- `meth(rnb.set)`: Extract beta values.
- `pheno(rnb.set)`: Access sample annotation.
- `annotation(rnb.set, type="sites")`: Get genomic coordinates.
- `remove.samples(rnb.set, sample_names)`: Filter samples manually.
- `summarized.regions(rnb.set)`: List available region types (e.g., "promoters", "genes").

### 4. Preprocessing and Normalization
For Infinium data, normalization is critical to remove technical bias.

```R
# Manual preprocessing
rnb.set.norm <- rnb.execute.normalization(rnb.set, 
                                          method = "illumina",
                                          bgcorr.method = "methylumi.noob")
```

### 5. Differential Methylation
Analyze differences between groups defined in the sample annotation.

```R
# Define comparison columns
rnb.options(differential.comparison.columns = c("Group"))

# Run differential analysis
diffmeth <- rnb.execute.computeDiffMeth(rnb.set, pheno.cols = "Group")

# Get results table for a specific comparison and region
comparison <- get.comparisons(diffmeth)[1]
tab.promoters <- get.table(diffmeth, comparison, "promoters", return.data.frame = TRUE)
```

## Advanced Features
- **Cell Type Inference**: Estimate cell type proportions using `rnb.execute.ct.estimation`.
- **Age Prediction**: Predict epigenetic age using `rnb.execute.age.prediction`.
- **LOLA Enrichment**: Perform genomic context enrichment for DMRs using `performLolaEnrichment.diffMeth`.
- **Batch Effect Control**: Use Surrogate Variable Analysis (SVA) via `rnb.execute.sva`.

## Tips for Success
- **Memory Management**: For large WGBS datasets, enable disk-based caching: `rnb.options(disk.dump.big.matrices = TRUE)`.
- **Ghostscript**: Ensure Ghostscript is installed on your system for PDF plot generation.
- **Report Directory**: The `dir.reports` directory must not exist before running `rnb.run.analysis`; RnBeads will create it.
- **Parallelization**: Enable multicore processing using `logger.start(fname = NA)` and `parallel.setup(cores)`.

## Reference documentation
- [RnBeads](./references/RnBeads.md)
- [RnBeads_Annotations](./references/RnBeads_Annotations.md)