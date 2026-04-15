---
name: bioconductor-segmentseq
description: This tool performs simultaneous segmentation of high-throughput sequencing data from multiple samples to identify small RNA and cytosine methylation loci. Use when user asks to detect methylation loci, identify small RNA loci, perform consensus segmentation across replicates, or conduct differential methylation and expression analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/segmentSeq.html
---

# bioconductor-segmentseq

name: bioconductor-segmentseq
description: Methods for detecting methylation loci and small RNA loci from high-throughput sequencing data. Use this skill to perform simultaneous segmentation of data from multiple samples, identify consensus loci, and conduct differential methylation or expression analysis using empirical Bayesian methods.

# bioconductor-segmentseq

## Overview
The `segmentSeq` package provides methods for the simultaneous segmentation of high-throughput sequencing data from multiple samples. It is primarily used to identify small RNA (sRNA) loci and cytosine methylation loci. By using empirical Bayesian methods, it accounts for replicate data to create consensus segmentation maps and identifies regions of biological significance that differ from background noise or neighboring regions.

## Core Workflow

### 1. Data Loading and Preparation
The package uses different functions depending on the data type:
- **Methylation Data:** Use `readMeths` to read YAMA output or similar bisulphite sequencing calls.
- **Small RNA/Generic Data:** Use `readGeneric` (for tab-delimited files) or `readBAM` (for BAM files).

```r
library(segmentSeq)
library(parallel)

# Setup parallel processing (recommended for large datasets)
cl <- makeCluster(min(8, detectCores()))

# Example: Loading methylation data
mD <- readMeths(files = files, dir = datadir, libnames = libs, 
                replicates = reps, nonconversion = nc_rates)

# Example: Loading sRNA data
aD <- readGeneric(files = libfiles, dir = datadir, replicates = reps, 
                  libnames = libs, polyLength = 10)
```

### 2. Processing Alignment Data
Convert `alignmentData` (or `methData`) into a `segData` object to identify potential segments based on overlapping alignments.

```r
sD <- processAD(mD, cl = cl)
```

### 3. Segmentation Methods
There are two primary ways to define loci:

- **Heuristic Segmentation (`heuristicSeg`):** A faster method. For methylation, it uses a binomial distribution with a beta prior. For sRNA, it exploits the bimodality of tag densities.
- **Empirical Bayesian Classification (`classifySeg`):** More computationally intensive but more accurate. It models biological variation within replicates to refine segment boundaries.

```r
# Heuristic approach
hS <- heuristicSeg(sD = sD, aD = mD, prop = 0.2, cl = cl)

# Empirical Bayesian approach (often uses heuristic results as a starting point)
cS <- classifySeg(sD = sD, aD = aD, cD = hS, cl = cl)
```

### 4. Refinement and Likelihoods
For methylation data, use `mergeMethSegs` to join fragments split by unmethylated cytosines and `lociLikelihoods` to assign posterior probabilities. For sRNA, use `selectLoci` to filter by FDR.

```r
# Methylation refinement
hS <- mergeMethSegs(hS, mD, gap = 5000, cl = cl)
hSL <- lociLikelihoods(hS, mD, cl = cl)

# sRNA filtering
loci <- selectLoci(cS, FDR = 0.05)
```

## Differential Analysis
`segmentSeq` integrates with `baySeq` for differential expression/methylation analysis.

1.  **Define Groups:** Specify the models (e.g., Non-Differential Expression vs. Differential Expression).
2.  **Estimate Priors:** Use `getPriors`.
3.  **Calculate Likelihoods:** Use `getLikelihoods`.

```r
groups(hSL) <- list(NDE = c(1,1,1,1), DE = c("A", "A", "B", "B"))
hSL <- methObservables(hSL) # Specific to methylation
densityFunction(hSL) <- bbNCDist # Beta-binomial with non-conversion
hSL <- getPriors(hSL, cl = cl)
hSL <- getLikelihoods(hSL, cl = cl)

# View results
topCounts(hSL, "DE")
```

## Visualization
- `plotMethDistribution`: Visualizes methylation levels across the genome.
- `plotMeth`: Plots specific methylation loci with coverage and methylation ratios.
- `plotGenome`: Plots sRNA tag densities and identified segments.

```r
plotMeth(mD, hSL, chr = "Chr1", limits = c(1, 50000), cap = 10)
plotGenome(aD, cS, chr = "Chr1", limits = c(1, 1e5))
```

## Tips
- **Parallelization:** Always use a cluster (`cl`) for `processAD`, `heuristicSeg`, and `classifySeg` as these operations are computationally demanding.
- **Memory:** For very large datasets, use the `largeness` parameter in segmentation functions to manage memory usage.
- **Non-conversion:** In methylation analysis, providing accurate `nonconversion` rates to `readMeths` is critical for the beta-binomial model.

## Reference documentation
- [segmentSeq: methods for detecting methylation loci and differential methylation](./references/methylationAnalysis.md)
- [segmentSeq: methods for identifying small RNA loci from high-throughput sequencing data](./references/segmentSeq.md)