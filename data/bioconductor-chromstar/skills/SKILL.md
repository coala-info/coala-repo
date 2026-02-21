---
name: bioconductor-chromstar
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.6/bioc/html/chromstaR.html
---

# bioconductor-chromstar

name: bioconductor-chromstar
description: Expert guidance for the chromstaR Bioconductor package for joint analysis of multiple ChIP-seq samples. Use this skill when performing peak calling (narrow or broad), multivariate analysis of replicates, detecting differentially modified regions, or identifying combinatorial chromatin states from BAM/BED files.

# bioconductor-chromstar

## Overview
The `chromstaR` package is designed for the joint analysis of multiple ChIP-seq samples. It uses Hidden Markov Models (HMMs) to perform peak calling for transcription factor binding and histone modifications with either narrow (e.g., H3K4me3) or broad (e.g., H3K27me3) profiles. Its primary strength lies in its ability to integrate multiple replicates and conditions to identify combinatorial chromatin states and differential enrichment patterns.

## Core Workflow

### 1. Data Preparation and Binning
All analyses begin by partitioning the genome into non-overlapping bins and counting reads.
- **Narrow marks**: Use bin sizes 200bp–1000bp.
- **Broad marks**: Use bin sizes 500bp–2000bp.

```r
library(chromstaR)
# For BAM files, assembly info is handled automatically
# For BED files, provide a data.frame with chromosome lengths
binned.data <- binReads(file, assembly=rn4_chrominfo, binsizes=1000, 
                        stepsizes=500, chromosomes='chr12')
```

### 2. Univariate Peak Calling
Used for analyzing a single sample to identify enriched regions.
```r
model <- callPeaksUnivariate(binned.data)
# Check fit: The 'modified' component should fit the tail of the distribution
plotHistogram(model)
# Adjust strictness if necessary
model <- changeFDR(model, fdr=1e-4)
```

### 3. Multivariate Analysis Modes
The `Chromstar()` function is the main interface for complex workflows. It supports four modes:
- **full**: Best for < 8 total experiments (marks * conditions).
- **differential**: Optimized for finding significant differences between conditions.
- **combinatorial**: Best for finding chromatin states (e.g., [H3K4me3+H3K27me3]) across many marks.
- **separate**: Replicates are processed multivariately, but states are combined post-hoc.

```r
# Define experiment table
exp <- data.frame(file=files, mark=c('H3K4me3', 'H3K27me3'), 
                  condition='SHR', replicate=c(1,1),
                  pairedEndReads=FALSE, controlFiles=NA)

Chromstar(inputfolder, experiment.table=exp, outputfolder=outputfolder, 
          mode='differential', binsize=1000, stepsize=500)
```

### 4. Integrating Replicates
To ensure quality, check correlation between replicates before final peak calling.
```r
# Run on replicates to check correlation
multi.model <- callPeaksReplicates(models, max.time=60)
print(multi.model$replicateInfo$correlation)

# Force replicates to agree
multi.model <- callPeaksReplicates(models, force.equal=TRUE)
```

### 5. Downstream Analysis and Visualization
- **Genomic Frequencies**: `genomicFrequencies(model)`
- **Enrichment at TSS**: `plotEnrichment(model, annotation=genes, region='start')`
- **Heatmaps**: `heatmapCountCorrelation(model)` or `heatmapTransitionProbs(model)`
- **Expression**: `plotExpression(model, expression.data)`

## Troubleshooting and Tips
- **Fit Convergence**: Always check `PLOTS/univariate-distributions`. If the "modified" component (red) has lower read counts than the "unmodified" component (gray), the fit has failed. Try adjusting the bin size or downsampling.
- **Strictness**: If peak calls are too lenient, use `changeFDR()` to set a stricter cutoff (e.g., 1e-4).
- **Differential Scores**: In differential mode, use the `differential.score` metadata column in the segments to filter for high-confidence changes (score >= 1.9 for two-mark differences).

## Reference documentation
- [The chromstaR user's guide](./references/chromstaR.md)