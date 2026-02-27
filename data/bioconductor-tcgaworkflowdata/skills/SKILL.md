---
name: bioconductor-tcgaworkflowdata
description: This package provides subsets of The Cancer Genome Atlas (TCGA) data to support bioinformatic workflows and pipeline testing. Use when user asks to load example TCGA datasets, perform differential expression or methylation analysis, identify master regulators using ELMER, or visualize genomic alterations with maftools.
homepage: https://bioconductor.org/packages/release/data/experiment/html/TCGAWorkflowData.html
---


# bioconductor-tcgaworkflowdata

## Overview

The `TCGAWorkflowData` package is an experiment data package that provides subsets of The Cancer Genome Atlas (TCGA) data. It is designed to support the "TCGA Workflow" which demonstrates how to download, process, and integrate data from the Genomic Data Commons (GDC), ENCODE, and Roadmap Epigenomics projects. This skill guides the use of these data subsets for testing and executing complex bioinformatic pipelines including differential expression, differential methylation, and master regulator analysis.

## Core Workflows

### 1. Loading Example Data
The package contains pre-processed objects for various cancer types (primarily LGG and GBM). Use `data()` to load specific datasets into your R session.

```r
library(TCGAWorkflowData)

# Load gene expression data (SummarizedExperiment)
data("TCGA_GBM_Transcriptome_20_samples")
data("TCGA_LGG_Transcriptome_20_samples")

# Load DNA methylation and expression data for ELMER analysis
data(elmerExample)

# Load mutation data (MAF format)
data(maf_lgg_gbm)

# Load GISTIC (Copy Number) results
data(gbm_gistic)
```

### 2. Transcriptomic Analysis
Use the loaded `SummarizedExperiment` objects to perform normalization and Differential Expression Analysis (DEA).

```r
library(TCGAbiolinks)

# Pre-processing and Normalization
exp_lgg_preprocessed <- TCGAanalyze_Preprocessing(object = exp_lgg, cor.cut = 0.6)
exp_normalized <- TCGAanalyze_Normalization(
  tabDF = exp_lgg_preprocessed,
  geneInfo = TCGAbiolinks::geneInfoHT,
  method = "gcContent"
)

# Filtering and DEA
exp_filtered <- TCGAanalyze_Filtering(tabDF = exp_normalized, method = "quantile", qnt.cut = 0.25)
diff_expressed_genes <- TCGAanalyze_DEA(
  mat1 = exp_filtered[, 1:10], 
  mat2 = exp_filtered[, 11:20],
  Cond1type = "Group1", Cond2type = "Group2",
  fdr.cut = 0.01, logFC.cut = 1
)
```

### 3. Epigenetic Analysis (DMR)
Identify Differentially Methylated CpG sites (DMC) using the methylation data provided in the package.

```r
# met is a SummarizedExperiment object from elmerExample
dmc <- TCGAanalyze_DMC(
  data = met,
  groupCol = "project_id",
  group1 = "TCGA-GBM",
  group2 = "TCGA-LGG",
  p.cut = 0.05,
  diffmean.cut = 0.15
)
```

### 4. Master Regulator Analysis (ELMER)
`TCGAWorkflowData` provides the `mae` (MultiAssayExperiment) object required for ELMER to identify enhancers and their target genes.

```r
library(ELMER)
# mae is loaded from elmerExample
# Identify distal probes
distal.probes <- get.feature.probe(genome = "hg19", met.platform = "450K")

# Identify Differentially Methylated CpGs (DMCs)
Sig.probes <- get.diff.meth(
  data = mae, 
  group.col = "project_id",
  group1 = "TCGA-GBM", group2 = "TCGA-LGG",
  diff.dir = "hypo"
)
```

### 5. Genomic Alterations (maftools)
Visualize mutations using the provided MAF data.

```r
library(maftools)
data(maf_lgg_gbm)
# Create maftools object
maf_obj <- read.maf(maf = maf)
# Plot summary
plotmafSummary(maf = maf_obj)
# Generate Oncoplot
oncoplot(maf = maf_obj, top = 20)
```

## Tips for Success
- **Data Subsets**: Remember that `TCGAWorkflowData` contains *subsets* (e.g., only chromosome 9 or a few samples) to ensure speed. For real-world discovery, use `TCGAbiolinks` to download full cohorts.
- **Genome Builds**: Most example data in this package refers to `hg19`. Ensure your `ELMER` or `ChIPseeker` parameters match this genome build.
- **Object Access**: Use `assay(se)` for data matrices, `colData(se)` for clinical metadata, and `rowRanges(se)` for genomic coordinates.

## Reference documentation
- [TCGA Workflow: Analyze cancer genomics and epigenomics data using Bioconductor packages](./references/TCGAWorkflow.Rmd)
- [Example data for TCGA Workflow](./references/TCGAWorkflowData.md)