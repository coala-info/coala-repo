---
name: bioconductor-deseq
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.11/bioc/html/DESeq.html
---

# bioconductor-deseq

name: bioconductor-deseq
description: Differential expression analysis of RNA-Seq and other count data using the negative binomial distribution. Use this skill when you need to perform statistical analysis on biological count tables to identify differentially expressed genes, normalize sequencing data, or visualize sample relationships (PCA, heatmaps).

# bioconductor-deseq

## Overview

The `DESeq` package provides methods to test for differential expression in count data from high-throughput sequencing assays (like RNA-Seq or ChIP-Seq). It models counts using the negative binomial distribution and employs a shrinkage estimator for variance to handle small replicate numbers. 

**Note:** This skill covers the original `DESeq` package. For newer projects, `DESeq2` is often preferred, but `DESeq` remains relevant for maintaining legacy workflows or specific statistical requirements.

## Core Workflow

### 1. Data Preparation
The package requires a count table (raw integers) and metadata describing the experimental design.

```R
library("DESeq")

# Load count data (rows = genes, columns = samples)
countsTable <- read.table("counts.tsv", header=TRUE, row.names=1)

# Define experimental conditions
condition <- factor(c("untreated", "untreated", "treated", "treated"))

# Create the CountDataSet object
cds <- newCountDataSet(countsTable, condition)
```

### 2. Normalization
Estimate size factors to account for differences in sequencing depth.

```R
cds <- estimateSizeFactors(cds)
# View normalized counts
head(counts(cds, normalized=TRUE))
```

### 3. Variance Estimation
Estimate the relationship between mean and dispersion. This is a prerequisite for differential expression testing.

```R
# Default for replicated data
cds <- estimateDispersions(cds)

# Visualization of the fit
plotDispEsts(cds)
```

### 4. Differential Expression Testing
Perform the test to identify genes changing between two conditions.

```R
res <- nbinomTest(cds, "untreated", "treated")

# Filter for significant results (e.g., FDR < 0.1)
resSig <- res[res$padj < 0.1, ]
resSig <- resSig[order(resSig$pval), ]
```

## Advanced Workflows

### Multi-factor Designs
For experiments with multiple variables (e.g., treatment and batch/library type), use GLMs.

```R
# Define design with a data frame
design <- data.frame(
    row.names = colnames(countsTable),
    condition = c("untreated", "untreated", "treated", "treated"),
    libType = c("single", "paired", "single", "paired")
)
cdsFull <- newCountDataSet(countsTable, design)
cdsFull <- estimateSizeFactors(cdsFull)
cdsFull <- estimateDispersions(cdsFull)

# Fit GLMs
fit1 <- fitNbinomGLMs(cdsFull, count ~ libType + condition)
fit0 <- fitNbinomGLMs(cdsFull, count ~ libType)

# Likelihood ratio test
pvalsGLM <- nbinomGLMTest(fit1, fit0)
padjGLM <- p.adjust(pvalsGLM, method="BH")
```

### Working Without Replicates
If no replicates are available, you must use the "blind" method to estimate dispersion.

```R
cds2 <- estimateDispersions(cds2, method="blind", sharingMode="fit-only")
res2 <- nbinomTest(cds2, "untreated", "treated")
```

### Variance Stabilizing Transformation (VST)
Useful for downstream applications like clustering or PCA.

```R
cdsBlind <- estimateDispersions(cds, method="blind")
vsd <- varianceStabilizingTransformation(cdsBlind)

# PCA Plot
plotPCA(vsd, intgroup=c("condition"))
```

## Best Practices
- **Input Data:** Always use raw, non-normalized integer counts. Do not use RPKM/FPKM.
- **Technical Replicates:** Sum technical replicates (same library sequenced multiple times) into a single column before analysis.
- **Independent Filtering:** Remove genes with very low overall counts before multiple testing correction to increase power.
- **Dispersion Fit:** If the default parametric fit fails, try `estimateDispersions(cds, fitType="local")`.

## Reference documentation
- [Differential expression of RNA-Seq data at the gene level – the DESeq package](./references/DESeq.md)