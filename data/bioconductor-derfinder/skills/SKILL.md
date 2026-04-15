---
name: bioconductor-derfinder
description: This tool performs annotation-agnostic differential expression analysis of RNA-seq data at base-pair resolution. Use when user asks to identify differentially expressed regions, find expressed regions from BAM or BigWig files, or perform single base-level F-statistics without relying on existing gene models.
homepage: https://bioconductor.org/packages/release/bioc/html/derfinder.html
---

# bioconductor-derfinder

name: bioconductor-derfinder
description: Annotation-agnostic differential expression analysis of RNA-seq data at base-pair resolution. Use this skill to identify differentially expressed regions (DERs) or expressed regions (ERs) from BAM or BigWig files without relying on existing gene models.

# bioconductor-derfinder

## Overview
The `derfinder` package implements the DER Finder approach for RNA-seq data analysis. It identifies contiguous genome regions showing differential expression signal, providing an alternative to feature-counting or transcript assembly. It supports two main workflows: (1) Expressed regions-level analysis, which summarizes coverage and identifies regions passing a mean coverage cutoff, and (2) Single base-level F-statistics, which fits models at every base to identify regions with significant statistical differences.

## Installation
```R
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("derfinder")
```

## Core Workflows

### 1. Expressed Regions (ER) Level Analysis
This is the recommended starting point. It identifies regions based on mean coverage across samples and then performs differential expression on the resulting matrix.

```R
library(derfinder)

# 1. Locate and load coverage data (BigWig or BAM)
files <- rawFiles(system.file("extdata", "AMY", package = "derfinderData"), samplepatt = "bw")
fullCov <- fullCoverage(files = files, chrs = "chr21")

# 2. Identify Expressed Regions (ERs) and generate a coverage matrix
# L = read length; cutoff = mean coverage threshold
regionMat <- regionMatrix(fullCov, cutoff = 30, L = 76)

# 3. Perform Differential Expression (e.g., using DESeq2)
library(DESeq2)
counts <- round(regionMat$chr21$coverageMatrix)
dse <- DESeqDataSetFromMatrix(counts, pheno, ~ group + gender)
dse <- DESeq(dse, test = "LRT", reduced = ~gender)
results <- results(dse)

# 4. Attach results back to genomic ranges
ers <- regionMat$chr21$regions
mcols(ers) <- cbind(mcols(ers), results)
```

### 2. Single Base-Level F-statistics
Use this for high-resolution discovery. It calculates F-statistics for every base and uses permutations to assign empirical p-values to regions.

```R
# 1. Prepare models
sampleDepths <- sampleDepth(collapseFullCoverage(fullCov), 1)
models <- makeModels(sampleDepths, testvars = pheno$group, adjustvars = pheno$gender)

# 2. Analyze chromosome
# nPermute should be higher (e.g., 100+) for publication-quality p-values
results <- analyzeChr(
    chr = "chr21", 
    coverageInfo = filteredCov$chr21, 
    models = models,
    groupInfo = pheno$group, 
    cutoffFstat = 0.05,
    nPermute = 20, 
    writeOutput = TRUE
)
```

## Key Functions
- `rawFiles()`: Helper to find input files (BAM or BigWig).
- `fullCoverage()`: Loads coverage data into memory for specified chromosomes.
- `filterData()`: Filters bases based on a coverage cutoff.
- `regionMatrix()`: Identifies ERs and creates a summarized coverage matrix for downstream DE tools.
- `railMatrix()`: Optimized version of `regionMatrix` for use with Rail-RNA output.
- `analyzeChr()`: High-level function for base-level F-statistics and permutation testing.
- `makeModels()`: Helper to create alternative and null model matrices.

## Tips for Success
- **Memory Management**: `fullCoverage` loads data into memory. For large genomes/many samples, process one chromosome at a time or use `railMatrix` with pre-computed summary files.
- **Normalization**: If data isn't pre-normalized, use `totalMapped` and `targetSize` arguments in `fullCoverage` or `filterData`.
- **Visualization**: Use the companion package `derfinderPlot` (specifically `plotRegionCoverage`) to visualize base-level coverage for candidate DERs.
- **Annotation**: Use `annotateRegions()` to compare discovered DERs against known gene models (exons, introns, intergenic).

## Reference documentation
- [derfinder quick start guide](./references/derfinder-quickstart.md)
- [derfinder users guide](./references/derfinder-users-guide.md)