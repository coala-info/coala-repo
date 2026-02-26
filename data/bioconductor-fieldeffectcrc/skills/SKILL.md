---
name: bioconductor-fieldeffectcrc
description: This tool provides access to harmonized colorectal cancer transcriptome datasets and workflows for differential expression analysis. Use when user asks to retrieve CRC RNA-seq data from ExperimentHub, prepare tximport-compatible objects, or perform surrogate variable analysis to account for batch effects in colorectal tissue studies.
homepage: https://bioconductor.org/packages/release/data/experiment/html/FieldEffectCrc.html
---


# bioconductor-fieldeffectcrc

name: bioconductor-fieldeffectcrc
description: Access and analyze colorectal cancer (CRC) transcriptome data from the FieldEffectCrc package. Use this skill to retrieve harmonized bulk RNA-seq datasets (Tumor, Adjacent Normal, and Healthy) from ExperimentHub and perform differential expression workflows using DESeq2 and SVA.

## Overview

The `FieldEffectCrc` package provides access to a large, harmonized collection of human colorectal tissue transcriptomes. The data is stored as `SummarizedExperiment` objects on `ExperimentHub`, representing three cohorts (A, B, and C) categorized by library format (paired-end vs. single-end). This skill facilitates data retrieval and provides a standard workflow for differential expression analysis that accounts for latent batch effects.

## Data Retrieval

To access the datasets, use `ExperimentHub` to query and download the specific cohorts.

```r
library(FieldEffectCrc)
library(ExperimentHub)
library(SummarizedExperiment)

hub <- ExperimentHub()
# Query for FieldEffectCrc records
crc_query <- query(hub, "FieldEffectCrc")

# Retrieve Cohort A (EH3524)
se <- hub[["EH3524"]]

# Inspect sample types (CRC: Tumor, NAT: Normal Adjacent, HLT: Healthy)
table(colData(se)$sampType)
```

## Core Functions

- `make_txi(se)`: A convenience function to convert the `SummarizedExperiment` object into a `tximport`-compatible list, preserving transcript length information for `DESeq2`.
- `reorder_assays(se)`: Reorders assays within the `SummarizedExperiment` to ensure `counts` is the first assay, facilitating direct use with `DESeqDataSet()`.

## Differential Expression Workflow

The recommended workflow involves using `DESeq2` for modeling and `sva` for surrogate variable analysis to handle technical artifacts across studies.

### 1. Prepare DESeqDataSet
```r
library(DESeq2)
txi <- make_txi(se)
dds <- DESeqDataSetFromTximport(txi, colData(se), design = ~ sampType)
```

### 2. Estimate Latent Factors (SVA)
Because the data is harmonized from multiple sources, estimating surrogate variables is critical.
```r
library(sva)
# Normalize counts for SVA
dat <- counts(dds, normalized=FALSE) # Or use normalized=TRUE after initial DESeq run
idx <- rowSums(dat) > 1
dat <- dat[idx, ]
mod <- model.matrix(~sampType, data=colData(dds))
mod0 <- model.matrix(~1, data=colData(dds))

# Estimate surrogate variables
svs <- svaseq(dat, mod, mod0)

# Add SVs to dds and update design
for (i in 1:svs$n.sv) {
    colData(dds)[[paste0("sv", i)]] <- svs$sv[, i]
}
design(dds) <- as.formula(paste("~", paste0("sv", 1:svs$n.sv, collapse="+"), "+ sampType"))
```

### 3. Run Analysis and Extract Results
```r
dds <- DESeq(dds)

# Compare Healthy (HLT) vs Tumor (CRC)
res_hlt_crc <- results(dds, contrast=c("sampType", "HLT", "CRC"), alpha=0.05)
```

## Tips and Best Practices

- **Cohort Selection**: Use Cohorts A and B for paired-end analysis and Cohort C for single-end analysis. Do not mix them without careful batch correction.
- **Assay Access**: The `SummarizedExperiment` objects contain three assays: `abundance`, `counts`, and `length`. Use `assay(se, "counts")` to access raw estimates.
- **Filtering**: Always perform pre-filtering (e.g., `rowSums(counts(dds) > 10) >= (1/3)*ncol(dds)`) to remove low-count genes before running the full DESeq2/SVA pipeline to save memory and improve power.

## Reference documentation

- [FieldEffectCrc](./references/FieldEffectCrc.md)