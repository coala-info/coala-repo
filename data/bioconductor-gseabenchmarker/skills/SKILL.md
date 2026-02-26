---
name: bioconductor-gseabenchmarker
description: This tool provides a framework for the reproducible evaluation and benchmarking of gene set enrichment analysis methods across transcriptomic data compendia. Use when user asks to load standardized microarray or RNA-seq datasets, perform differential expression across multiple datasets, execute various enrichment methods, or assess method performance based on runtime and phenotype relevance.
homepage: https://bioconductor.org/packages/release/bioc/html/GSEABenchmarkeR.html
---


# bioconductor-gseabenchmarker

name: bioconductor-gseabenchmarker
description: Framework for reproducible evaluation and benchmarking of gene set enrichment analysis (GSEA) methods. Use this skill to load standardized microarray (GEO2KEGG) and RNA-seq (TCGA) compendia, perform differential expression across multiple datasets, execute various enrichment methods (ORA, GSEA, etc.), and assess performance based on runtime, statistical significance, and phenotype relevance.

# bioconductor-gseabenchmarker

## Overview
The `GSEABenchmarkeR` package provides a systematic framework for benchmarking gene set enrichment analysis (GSEA) methods. Unlike tools designed for the biological interpretation of a single dataset, this package is intended for methodological comparison. It allows users to run multiple enrichment algorithms across large compendia of transcriptomic data and evaluate them against gold standards, such as the MalaCards disease relevance database.

## Core Workflow

### 1. Loading Data Compendia
The package provides access to curated collections of human disease datasets.

```r
library(GSEABenchmarkeR)

# Load the GEO2KEGG microarray compendium (42 datasets)
geo2kegg <- loadEData("geo2kegg")

# Load the TCGA RNA-seq compendium (subset to specific number of datasets)
tcga <- loadEData("tcga", nr.datasets = 2)

# Load user-defined data from a directory of RDS files (SummarizedExperiments)
user_data <- loadEData("/path/to/rds/files")
```

### 2. Preprocessing and Differential Expression
Before enrichment, microarray data must be summarized to gene level, and all datasets require differential expression (DE) analysis.

```r
# Preprocess microarray data (probe to gene mapping)
geo2kegg <- maPreproc(geo2kegg[1:5])

# Run Differential Expression analysis across the compendium
# padj.method="flexible" is recommended to ensure ORA suitability
geo2kegg <- runDE(geo2kegg, de.method = "limma", padj.method = "flexible")
```

### 3. Executing Enrichment Analysis
Use `runEA` to apply methods to one or more datasets. This function tracks runtime and can save results to disk for persistence.

```r
library(EnrichmentBrowser)
kegg.gs <- getGenesets(org = "hsa", db = "kegg")

# Run ORA and CAMERA on multiple datasets
res.dir <- tempdir()
res <- runEA(geo2kegg, methods = c("ora", "camera"), 
             gs = kegg.gs, save2file = TRUE, out.dir = res.dir)
```

### 4. Benchmarking Performance
Evaluate methods based on three primary criteria:

#### Runtime
```r
# Read saved runtimes
ea.rtimes <- readResults(res.dir, names(geo2kegg), methods = c("ora", "camera"), type = "runtime")

# Visualize
bpPlot(ea.rtimes, what = "runtime")
```

#### Statistical Significance
Assess the fraction of gene sets identified as significant.
```r
ea.ranks <- readResults(res.dir, names(geo2kegg), methods = c("ora", "camera"), type = "ranking")
sig.sets <- evalNrSigSets(ea.ranks, alpha = 0.05, padj = "BH")
bpPlot(sig.sets, what = "sig.sets")
```

#### Phenotype Relevance
Compare GSEA rankings against MalaCards disease-relevant gene sets.
```r
# Load relevance rankings and mapping
data.dir <- system.file("extdata", package = "GSEABenchmarkeR")
mala.kegg <- readRDS(file.path(data.dir, "malacards", "KEGG.rds"))
d2d.map <- readDataId2diseaseCodeMap(file.path(data.dir, "malacards", "GseId2Disease.txt"))

# Evaluate relevance (observed vs theoretical optimum)
rel.res <- evalRelevance(ea.ranks, mala.kegg, d2d.map[names(geo2kegg)])
bpPlot(rel.res, what = "rel.sets")
```

## Advanced Features

### Caching
Use `cacheResource` to save processed compendia (after `maPreproc` and `runDE`) to avoid recomputing.
```r
cacheResource(geo2kegg, rname = "geo2kegg_processed")
# Restore later
geo2kegg <- loadEData("geo2kegg", cache = TRUE)
```

### Parallelization
Functions like `runDE` and `runEA` automatically use `BiocParallel`. You can customize the backend:
```r
library(BiocParallel)
bp.par <- MulticoreParam(workers = 4, progressbar = TRUE)
geo2kegg <- runDE(geo2kegg, parallel = bp.par)
```

## Reference documentation
- [Reproducible GSEA Benchmarking](./references/GSEABenchmarkeR.md)