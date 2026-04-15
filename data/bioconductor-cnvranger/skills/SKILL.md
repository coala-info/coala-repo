---
name: bioconductor-cnvranger
description: CNVRanger summarizes individual CNV calls into population-level regions and performs association testing with expression or quantitative traits. Use when user asks to summarize CNV calls into population-level regions, perform CNV-eQTL analysis, conduct CNV-GWAS, or test for enrichment in functional genomic elements.
homepage: https://bioconductor.org/packages/release/bioc/html/CNVRanger.html
---

# bioconductor-cnvranger

## Overview

The `CNVRanger` package provides a comprehensive suite for post-calling CNV analysis. It transforms individual CNV calls into population-level insights by summarizing overlapping regions, assessing enrichment in functional genomic elements, and performing association testing. It is particularly strong in integrating CNV data with RNA-seq (via `edgeR`) and quantitative traits (via linear regression and GDS-backed storage).

## Key Workflows

### 1. Data Import and Representation

CNV calls must be formatted with at least five columns: `chr`, `start`, `end`, `sample_id`, and `state` (integer copy number: 0=hom. del, 1=het. del, 2=normal, 3=1-copy gain, 4=amplification).

```r
library(CNVRanger)
library(GenomicRanges)
library(RaggedExperiment)

# Import from data.frame
calls <- read.csv("cnv_calls.csv")
grl <- makeGRangesListFromDataFrame(calls, split.field="sample_id", keep.extra.columns=TRUE)

# Matrix-like representation
ra <- RaggedExperiment(grl)
```

### 2. Population-level Summarization

Summarize individual calls into CNV Regions (CNVRs) using different logic:

*   **Trimming (CNVRuler style):** Trims low-density margins.
    ```r
    cnvrs <- populationRanges(grl, density=0.1)
    ```
*   **Reciprocal Overlap (RO):** Merges calls meeting a mutual overlap threshold.
    ```r
    ro_cnvrs <- populationRanges(grl, mode="RO", ro.thresh=0.51)
    ```
*   **Recurrence Analysis (GISTIC-like):** Identifies regions aberrant more often than chance.
    ```r
    cnvrs <- populationRanges(grl, density=0.1, est.recur=TRUE)
    recurrent <- subset(cnvrs, pvalue < 0.05)
    plotRecurrentRegions(cnvrs, genome="bosTau6", chr="chr1")
    ```

### 3. Overlap and Enrichment Analysis

Assess if CNVs preferentially overlap functional features (e.g., genes) using permutation tests from `regioneR`.

```r
library(regioneR)
# Find overlaps
olaps <- findOverlaps(genes, cnvrs)

# Permutation test for depletion/enrichment
res <- overlapPermTest(A=cnvrs, B=genes, ntimes=100, genome="hg19", count.once=TRUE)
plot(res)

# Visualization
cnvOncoPrint(grl, genes_of_interest)
```

### 4. CNV-Expression Association (eQTL)

Link CNV states to RNA-seq counts using `edgeR` generalized linear models.

```r
# rse is a RangedSummarizedExperiment of RNA-seq counts
res <- cnvEQTL(cnvrs, grl, rse, window = "1Mbp", filter.by.expr = TRUE)

# Visualize local effects
plotEQTL(cnvr=cnvrs[1], genes=res[[1]], genome="hg19", cn="CN1")
```

### 5. CNV-GWAS

Perform genome-wide association with quantitative phenotypes. This workflow uses CNV segments (fine-grained loci within CNVRs).

```r
# 1. Setup paths and phenotype info
# re is a RaggedExperiment containing CNV calls and colData(re)$phenotype
phen_info <- setupCnvGWAS("my_study", cnv.out.loc=re, map.loc="probes_map.txt")

# 2. Run GWAS (linear regression)
# chr.code.name maps numeric IDs to character chromosome names if needed
gwas_res <- cnvGWAS(phen_info, chr.code.name=chr_map, method.m.test="fdr")

# 3. Visualize
plotManhattan(phen_info$all.paths, gwas_res, chr_size_order)
```

## Tips and Best Practices

*   **Copy State Encoding:** Ensure states are 0-4. If using GISTIC (-2 to 2), add 2 to the values.
*   **TCGA Integration:** Use `TCGAutils` to convert segmented log2 ratios to integer states: `round(2^log_ratio * 2)`.
*   **GDS Storage:** `cnvGWAS` automatically creates a `.gds` file in the `Inputs` folder for memory-efficient processing. Use `produce.gds=FALSE` in subsequent runs to save time.
*   **Signal Intensities:** For SNP-chip data, you can run GWAS on raw Log R Ratio (LRR) values by setting `run.lrr=TRUE` in `cnvGWAS` after importing them with `importLrrBaf`.

## Reference documentation

- [Summarization and quantitative trait analysis of CNV ranges](./references/CNVRanger.md)