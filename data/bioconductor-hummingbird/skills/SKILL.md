---
name: bioconductor-hummingbird
description: The hummingbird package identifies differentially methylated regions between case and control groups using a Bayesian Hidden Markov Model. Use when user asks to identify differentially methylated regions, infer methylation states across genomic bins, or refine and visualize detected regions.
homepage: https://bioconductor.org/packages/release/bioc/html/hummingbird.html
---


# bioconductor-hummingbird

## Overview
The `hummingbird` package identifies differentially methylated regions (DMRs) between case and control groups. It utilizes a Bayesian Hidden Markov Model (HMM) to model methylation states (hypermethylated, hypomethylated, or normal) across genomic bins. The workflow typically involves preparing data into `SummarizedExperiment` objects, running the EM algorithm to infer states, refining DMRs with post-processing constraints, and visualizing specific genomic regions.

## Data Preparation
Input data must be organized into two `SummarizedExperiment` objects (one for Control, one for Case). Both objects must share the same CpG positions.

1.  **Required Matrices**: For each group, provide a matrix of Methylated counts (`M`) and Unmethylated counts (`UM`). Rows represent CpG sites; columns represent biological replicates.
2.  **Genomic Positions**: A vector of genomic coordinates for the CpGs.
3.  **Construction**:
    ```r
    library(SummarizedExperiment)
    library(hummingbird)

    # Control Group
    assaysControl <- list(normM = normM_matrix, normUM = normUM_matrix)
    seControl <- SummarizedExperiment(assaysControl, rowRanges = GPos("chrN", pos_vector))

    # Case Group
    assaysCase <- list(abnormM = caseM_matrix, abnormUM = caseUM_matrix)
    seCase <- SummarizedExperiment(assaysCase, rowRanges = GPos("chrN", pos_vector))
    ```

## Core Workflow

### 1. Infer Methylation States (EM Algorithm)
Use `hummingbirdEM` to execute the Bayesian HMM.
- **binSize**: Default is 40bp. Smaller bins increase resolution but take longer; larger bins are faster.
```r
emInfo <- hummingbirdEM(experimentInfoControl = seControl, 
                        experimentInfoCase = seCase, 
                        binSize = 40)
```
The output is a `GRanges` object containing bin-wise methylation rates and the predicted `direction` (1: hyper, -1: hypo, 0: normal).

### 2. Post-Adjustment and DMR Detection
Refine the raw HMM output into distinct DMRs using `hummingbirdPostAdjustment`.
- **minCpGs**: Minimum number of CpGs required in a DMR (default: 10).
- **minLength**: Minimum length in base pairs (default: 500).
- **maxGap**: Maximum distance allowed between adjacent CpGs within a DMR (default: 300).
```r
postAdjInfo <- hummingbirdPostAdjustment(experimentInfoControl = seControl,
                                         experimentInfoCase = seCase,
                                         emInfo = emInfo, 
                                         minCpGs = 10, 
                                         minLength = 500, 
                                         maxGap = 300)

# Access detected DMRs
dmrs <- postAdjInfo$DMRs
```

### 3. Visualization
Generate observation and prediction plots for specific coordinates.
```r
hummingbirdGraph(experimentInfoControl = seControl,
                 experimentInfoCase = seCase,
                 postAdjInfoDMRs = postAdjInfo$DMRs,
                 coord1 = start_pos, 
                 coord2 = end_pos)
```
- **Observation Plot**: Shows bin-wise average methylation rates for both groups.
- **Prediction Plot**: Shows the predicted state (-1, 0, 1) for each bin.

## Tips for Success
- **Replicates**: The package supports unequal numbers of replicates between groups and can function with a single replicate per group.
- **Shared CpGs**: Ensure that the input matrices only contain CpGs that are shared across all biological replicates; non-shared sites should be filtered out during preprocessing.
- **Chromosome-wise**: The HMM is typically fitted one chromosome at a time.

## Reference documentation
- [The hummingbird](./references/hummingbird.md)