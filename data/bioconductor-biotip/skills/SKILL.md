---
name: bioconductor-biotip
description: BioTIP identifies critical transition states and tipping points in biological systems using transcriptomic data. Use when user asks to detect tipping points in disease progression, identify critical transition signals, or analyze gene modules for state transitions in bulk or single-cell RNA-seq data.
homepage: https://bioconductor.org/packages/release/bioc/html/BioTIP.html
---


# bioconductor-biotip

name: bioconductor-biotip
description: BioTIP (Biological Tipping-Point) is an R package for identifying critical transition states and signals in biological systems using transcriptomic data. Use this skill when you need to detect tipping points in disease progression or developmental processes from bulk or single-cell RNA-seq data, identify non-random Critical Transition Signals (CTS), or classify transcripts into biotypes.

# bioconductor-biotip

## Overview
BioTIP provides a robust computational framework to characterize biological tipping points—abrupt and irreversible changes in a system's state. It addresses two main challenges: accurately detecting the timing of tipping points and identifying non-chaotic Critical Transition Signals (CTS). The package utilizes correlation-based models, refined by shrinkage estimation for large-scale matrices, and network graph-based clustering to identify gene modules (Dynamic Network Biomarkers) that signal an impending state transition.

## Core Workflow

The standard BioTIP analysis follows a five-step pipeline:
1. **Data Preprocessing**: Normalization (log2 transformation) and grouping samples by state/phenotype.
2. **Transcript Pre-selection**: Identifying highly oscillating genes across states using `sd_selection()` or `optimize.sd_selection()`.
3. **Network Partition**: Building co-expression networks with `getNetwork()` and clustering them into modules using `getCluster_methods()`.
4. **Identifying Putative CTS**: Calculating the Module-Criticality Index (MCI) with `getMCI()` to find modules with high instability.
5. **Finding Tipping Points**: Calculating the Index of Criticality (Ic) with `getIc()` and validating significance through permutation tests.

## Key Functions and Usage

### 1. Gene Selection
For bulk data, use standard deviation selection. For single-cell data, use the optimization approach to handle sparsity and noise.
```r
# Bulk data selection
test <- sd_selection(data_matrix, samples_list, cutoff = 0.01)

# Single-cell optimization (repeated sub-sampling)
subcounts <- optimize.sd_selection(counts, samplesL, cutoff = 0.2, percent = 0.8, B = 100)
```

### 2. Network and Clustering
Construct an igraph object and partition it into communities (e.g., using random walk).
```r
igraphL <- getNetwork(test, fdr = 0.1)
cluster <- getCluster_methods(igraphL)
```

### 3. MCI and CTS Identification
The MCI score identifies modules that are highly correlated within themselves but poorly correlated with the rest of the network.
```r
# Calculate MCI for all clusters
membersL <- getMCI(cluster, test)

# Identify the module with the highest MCI (the biomodule)
maxMCIms <- getMaxMCImember(membersL[[1]], membersL[[2]], min = 10)
CTS <- getCTS(topMCI, maxMCIms[[2]])
```

### 4. Tipping Point Prediction (Ic Score)
The Ic score (Index of Criticality) measures the ratio of average correlation within the CTS module to the average correlation between the module and other genes. A peak in Ic indicates a tipping point.
```r
# Calculate Ic score
IC <- getIc(df, samplesL, CTS[[1]], PCC_sample.target = 'average')

# Plot the results
plotIc(IC, las = 2)
```

### 5. Significance Testing
Always validate results using permutation tests to ensure the signal is not random.
```r
# Feature shuffling (gene permutation)
simuIC <- simulation_Ic(length(CTS[[1]]), samplesL, df, B = 100)
plot_Ic_Simulation(IC, simuIC)

# Sample shuffling (label permutation)
sample_Ic <- simulation_Ic_sample(df, sampleNo = 3, genes = CTS[[1]], plot = TRUE)
```

## Single-Cell Specific Considerations
* **Shrinkage Estimation**: When working with scRNA-seq, use `fun = 'BioTIP'` in `getIc()` and `getMCI()` to trigger the shrinkage estimation of correlation matrices, which corrects for bias in small-sized populations.
* **Trajectory Integration**: BioTIP is often applied to clusters ordered by pseudotime (e.g., from STREAM or Monocle).

## Transcript Annotation
BioTIP can classify transcripts into 11 biotypes (e.g., CPC, lincRNA, antisense) based on GENCODE overlaps.
```r
# Classify query transcripts
biotypes <- getBiotypes(query_GRanges, gencode_GRanges, intron_GRanges)

# Identify read-through transcripts
rdthrough <- getReadthrough(query_GRanges, coding_GRanges)
```

## Reference documentation
- [BioTIP: an R-package for Characterization of Biological Tipping-Points](./references/BioTIP.Rmd)
- [BioTIP Vignette](./references/BioTIP.md)