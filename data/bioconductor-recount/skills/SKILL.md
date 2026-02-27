---
name: bioconductor-recount
description: This tool provides access to pre-processed RNA-seq data from the recount project, including gene, exon, and junction-level counts for thousands of human samples. Use when user asks to download RangedSummarizedExperiment objects from SRA or GEO, scale counts for differential expression analysis, perform annotation-agnostic analysis with expressed regions, or query exon-exon junctions via Snaptron.
homepage: https://bioconductor.org/packages/release/bioc/html/recount.html
---


# bioconductor-recount

name: bioconductor-recount
description: Access and analyze RNA-seq data from the recount project, including gene, exon, and junction-level counts for over 70,000 human samples. Use this skill when the user needs to download RangedSummarizedExperiment objects from SRA/GEO studies, scale counts for differential expression, perform annotation-agnostic analysis with expressed regions, or query exon-exon junctions via Snaptron.

# bioconductor-recount

## Overview
The `recount` package provides an interface to the recount project, offering secondary analysis-ready RNA-seq data. It allows users to download pre-processed expression data (gene, exon, and junction levels) that has been processed with a uniform pipeline (Rail-RNA). The package is designed to work seamlessly with `SummarizedExperiment` and downstream differential expression tools like `DESeq2` and `edgeR`.

## Core Workflow

### 1. Finding and Downloading Data
Search for studies using keywords or accessions, then download the `RangedSummarizedExperiment` (RSE) objects.

```r
library(recount)

# Search for a study (e.g., by GEO ID)
project_info <- abstract_search("GSE32465")

# Download gene-level data (creates a directory with the project ID)
download_study("SRP009615", type = "rse-gene")

# Load the data
load(file.path("SRP009615", "rse_gene.Rdata"))
```

### 2. Pre-processing and Scaling
Recount stores raw base-pair coverage. These must be scaled to library size (e.g., 40 million reads) before differential expression analysis.

```r
# Scale counts to a target library size (default 40 million)
rse <- scale_counts(rse_gene)

# Alternatively, get raw read counts
rse_reads <- read_counts(rse_gene)
```

### 3. Phenotype Metadata
Enhance the `colData` with curated characteristics or predicted phenotypes.

```r
# Extract GEO characteristics into a usable data frame
geochar <- lapply(split(colData(rse_gene), seq_len(nrow(colData(rse_gene)))), geo_characteristics)
geochar <- do.call(rbind, geochar)

# Add predicted phenotypes (e.g., tissue, sex)
rse <- add_predictions(rse)
```

### 4. Differential Expression (DESeq2 Example)
Integrate directly with `DESeq2` for statistical testing.

```r
library(DESeq2)

# Create DESeqDataSet from RSE
dds <- DESeqDataSet(rse, design = ~ condition)

# Run DE analysis
dds <- DESeq(dds, test = "LRT", reduced = ~ 1)
res <- results(dds)
```

## Advanced Features

### Annotation-Agnostic Analysis
Identify "expressed regions" (ERs) directly from BigWig files without relying on gene models.

```r
# Define regions on a specific chromosome
regions <- expressed_regions("SRP009615", "chrY", cutoff = 5L)

# Compute a coverage matrix for these regions
rse_ER <- coverage_matrix("SRP009615", "chrY", regions)
```

### Exon-Exon Junctions and Snaptron
Query specific junctions across thousands of samples using the Snaptron API.

```r
library(GenomicRanges)
junctions <- GRanges(seqnames = "chr2", IRanges(start = 28971711, end = 29462418))

# Query Intropolis/GTEx/TCGA via Snaptron
snap_res <- snaptron_query(junctions)
```

### FANTOM-CAT and Brain Metadata
Access specialized quantifications or curated brain metadata.

```r
# Download FANTOM-CAT quantifications
download_study("DRP000366", type = "rse-fc")

# Add curated brain metadata
rse <- add_metadata(rse, source = 'recount_brain_v2')
```

## Tips for Success
- **Memory Management**: RSE objects for large studies (e.g., GTEx) can be massive. Use `SciServer` or high-memory environments if downloading "all" data.
- **Coordinate Systems**: Note that `recount2` uses Gencode v25 (GRCh38) by default. Ensure your custom annotations match this assembly.
- **Scaling**: Always use `scale_counts()` or `read_counts()` before DE; do not use the raw `assays(rse)$counts` directly as they represent area-under-coverage (AUC).

## Reference documentation
- [Basic DESeq2 results exploration](./references/SRP009615-results.md)
- [recount quick start guide (Rmd)](./references/recount-quickstart.Rmd)
- [recount quick start guide (md)](./references/recount-quickstart.md)