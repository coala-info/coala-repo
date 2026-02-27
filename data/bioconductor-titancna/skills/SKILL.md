---
name: bioconductor-titancna
description: TitanCNA performs statistical inference of subclonal copy number alterations and loss of heterozygosity in tumor whole genome and exome sequencing data. Use when user asks to estimate tumor purity, determine ploidy, or identify clonal and subclonal clusters in cancer genomics datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/TitanCNA.html
---


# bioconductor-titancna

name: bioconductor-titancna
description: Statistical analysis and subclonal copy number alteration (CNA) and loss of heterozygosity (LOH) inference for whole genome and exome sequencing of tumors. Use this skill when analyzing cancer genomics data to estimate tumor purity, ploidy, and clonal cluster cellular fractions using the TitanCNA R package.

# bioconductor-titancna

## Overview
TitanCNA is an R package designed to analyze subclonal copy number alterations (CNA) and loss of heterozygosity (LOH) in tumor samples. It uses a Hidden Markov Model (HMM) to jointly segment the genome and predict the state of each segment, accounting for tumor purity (normal cell contamination) and aneuploidy (ploidy). It is particularly effective for identifying clonal and subclonal events in high-throughput sequencing data (WGS and WES).

## Core Workflow

### 1. Data Preparation
TitanCNA requires two main inputs:
- **Read Counts**: Generated from tumor and matched-normal BAM files (usually via `HMMcopy`).
- **Allele Counts**: Specifically, the counts of the reference and non-reference alleles at germline heterozygous SNP sites (usually generated using `samtools mpileup` or `bcftools`).

```r
library(TitanCNA)

# Load allele counts (standard format: chr, pos, ref, refCount, nonRef, nonRefCount)
data <- loadAlleleCounts(infile)

# Load tumor and normal read depth (wiggle files)
# Usually pre-processed with HMMcopy to get logR
```

### 2. Model Initialization
You must define the parameters for the HMM, including the number of clonal clusters and initial estimates for purity and ploidy.

```r
# Set up parameters
params <- loadDefaultParameters(copyNumber = 5, numberClonalClusters = 1, skew = 0)

# Common practice: Run multiple restarts with different initial purity/ploidy
# to find the global optimum.
```

### 3. Running the HMM
The `runTitanGetter` function is the primary interface for model fitting.

```r
convergeParams <- runTitanGetter(data, params, 
                                 purity = 0.5, 
                                 ploidy = 2, 
                                 numClusters = 1, 
                                 nIter = 20, 
                                 checkPoint = NULL)
```

### 4. Results Extraction and Visualization
After convergence, extract the results and plot the profiles.

```r
# Extract results
results <- outputTitanResults(data, convergeParams, filename = NULL)

# Plotting
plotSparseCCNE(results)
plotTranscriptSize(results)
# Plotting chromosome-specific profiles
plotTitanLines(results, chr = 1)
```

## Key Functions
- `loadAlleleCounts()`: Imports the SNP-level allele counts.
- `correctReadDepth()`: Corrects GC content and mappability biases in read depth.
- `filterData()`: Filters SNPs based on depth and position (e.g., removing centromeres).
- `runTitanGetter()`: The main EM algorithm to estimate parameters and latent states.
- `viterbiClonalSetter()`: Assigns the final state sequences using the Viterbi algorithm.

## Best Practices
- **Ploidy Initialization**: If the tumor is known to be tetraploid, initialize ploidy at 4. Otherwise, test both 2 and 4.
- **Clonal Clusters**: Start with `numClusters = 1`. Increase to 2 or 3 if subclonal populations are suspected.
- **WES vs WGS**: For Whole Exome Sequencing, ensure the `targetedSequence` argument is used in filtering and that the appropriate transition probabilities are set to account for non-contiguous regions.
- **Model Selection**: Use S_Dbw validity index or Bayesian Information Criterion (BIC) to select the best model across different purity/ploidy/cluster initializations.

## Reference documentation
- [TitanCNA Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/TitanCNA.html)
- [TitanCNA GitHub Repository](https://github.com/gavinha/TitanCNA)