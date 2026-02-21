---
name: bioconductor-genotypeeval
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/bioc/html/genotypeeval.html
---

# bioconductor-genotypeeval

name: bioconductor-genotypeeval
description: Quality control and evaluation of human sequence data in VCF/gVCF files. Use this skill to assess VCF quality metrics, compare variants against gold standards (dbSNP, 1000 Genomes), estimate ancestry proportions (EAS, AFR, EUR), and flag samples based on user-defined thresholds for transition-transversion ratios, read depth, and call counts.

## Overview

The `genotypeeval` package provides tools for QC of VCF files, which are more manageable in size than BAM or FASTQ files. It allows for batch processing and automated flagging of low-quality samples using customizable thresholds. Key features include ancestry estimation via supervised ADMIXTURE and evaluation of variant calls against genomic features like coding regions or masked "self-chain" regions.

## Core Workflow

### 1. Data Loading
Use `ReadVCFData` to load VCF files. It automatically handles seqlevels conversion to "NCBI" style and filters out indels.

```r
library(genotypeeval)
vcffn <- "path/to/your.vcf.gz"
vcf <- ReadVCFData(dirname(vcffn), basename(vcffn), genome = "GRCh38")
```

### 2. Preparing Reference Data (Optional but Recommended)
For comprehensive QC, provide reference tracks:

*   **Coding Regions:** Use `TxDb` objects to calculate Ti/Tv ratios in/out of exons.
*   **Gold Standards:** Use `SNPlocs` or similar to compare calls against known SNPs.
*   **Ancestry Reference:** Requires a GRanges object with allele frequencies for EAS, AFR, and EUR populations.

```r
# Example Gold Standard setup
library(SNPlocs.Hsapiens.dbSNP141.GRCh38)
snps <- SNPlocs.Hsapiens.dbSNP141.GRCh38
gold.param <- GoldDataParam(percent.confirmed = 0.8)
gold <- GoldDataFromGRanges("GRCh38", snplocs(snps, "ch22", as.GRanges=TRUE), gold.param)
```

### 3. Setting Thresholds
Define QC parameters using `VCFQAParam`. Thresholds are only applied to the metrics you specify.

```r
# Define limits for call counts and Ti/Tv ratios
vcfparams <- VCFQAParam(
  count.limits = c(3e9, Inf), 
  titv.noncoding = c(1.99, 4),
  titv.coding = c(2.8, 4)
)
```

### 4. Evaluation
Run the evaluation function. You can run it with or without reference data.

```r
# With references
ev <- VCFEvaluate(vcf, vcfparams, gold.ref = gold, cds.ref = cds, admixture.ref = admix.ref)

# Without references (basic stats only)
ev.basic <- VCFEvaluate(vcf, vcfparams)
```

### 5. Interpreting Results
Check if the sample passed your defined criteria and extract specific metrics.

```r
# Overall status (Pass/Fail)
didSamplePassOverall(ev)

# Detailed pass/fail per metric
didSamplePass(ev)

# Numeric values for all metrics
getResults(ev)

# Visualizations (e.g., variant_type, chr, depth)
plots <- getPlots(ev)
plots$variant_type
```

## Tips for Large Files
*   **Memory:** The package typically requires ~5x the VCF file size in RAM.
*   **Parallelization:** Use `ReadVCFDataChunk` with the `numcores` argument to speed up reading and reduce the memory footprint.
*   **Truncation Detection:** Check the `chr` plot (`getPlots(ev)$chr`). A sudden drop in calls across chromosomes often indicates a truncated VCF file.

## Reference documentation
- [genotypeeval_vignette](./references/genotypeeval_vignette.md)