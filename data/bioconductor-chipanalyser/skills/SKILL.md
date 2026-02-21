---
name: bioconductor-chipanalyser
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ChIPanalyser.html
---

# bioconductor-chipanalyser

name: bioconductor-chipanalyser
description: Predicts and explains Transcription Factor (TF) binding using a statistical thermodynamic framework. Use this skill to model TF binding affinity, compute Position Weight Matrices (PWM), infer optimal binding parameters (number of bound molecules and scaling factors), and generate ChIP-seq-like profiles from DNA sequence and chromatin accessibility data.

# bioconductor-chipanalyser

## Overview
ChIPanalyser is an R package that models the binding of proteins to DNA based on four main factors: DNA accessibility, binding energy (PWM), a scaling factor ($\lambda$), and the number of bound molecules ($N$). Unlike machine learning approaches, it uses a thermodynamic framework to produce base-pair level ChIP-like profiles. It includes a Genetic Algorithm (GA) to infer optimal parameters by maximizing the fit between predicted profiles and experimental ChIP-seq data.

## Core Workflow

### 1. Data Preparation
Load the package and required genomic data (BSgenome, PFMs, and ChIP-seq scores).

```r
library(ChIPanalyser)
library(BSgenome.Dmelanogaster.UCSC.dm6)

# Load DNA sequence
dna <- getSeq(BSgenome.Dmelanogaster.UCSC.dm6)

# Load PFM (supports RAW, JASPAR, Transfac, or matrix)
pfm_path <- system.file("extdata", "BEAF-32.pfm", package="ChIPanalyser")

# Process experimental ChIP data
# 'chip' can be a GRanges, data.frame, or path to wig/bigWig
chip_scored <- processingChIP(profile = chip_data, loci = regions_of_interest)
```

### 2. Initializing Genomic Profiles
The `genomicProfiles` object stores parameters and intermediate results.

```r
# PFMs are automatically converted to PWMs
gp <- genomicProfiles(PFM = pfm_path, 
                      PFMFormat = "JASPAR", 
                      BPFrequency = dna)
```

### 3. Parameter Inference (Two Methods)

#### Method A: Grid Search (`computeOptimal`)
Use this to test a discrete set of $\lambda$ and $N$ values.

```r
optimal_res <- computeOptimal(genomicProfiles = gp,
                              DNASequenceSet = dna,
                              ChIPScore = chip_scored,
                              chromatinState = access_granges) # Optional

# Extract best parameters (e.g., based on MSE or Pearson)
best_params <- optimal_res$Optimal$OptimalParameters$MSE
```

#### Method B: Genetic Algorithm (`evolve`)
Use this for complex optimization, including chromatin state affinities.

```r
# Define custom ranges for optimization
params_range <- list(N = c(1, 1e6, 5), lambda = c(1, 5, 5))

evo_res <- evolve(population = 20,
                  generations = 10,
                  DNASequenceSet = dna,
                  ChIPScore = training_set,
                  genomicProfiles = gp,
                  parameters = params_range,
                  chromatinState = cs_granges,
                  method = "MSE")
```

### 4. Generating and Ploting Profiles
Once parameters are known, generate the final occupancy and ChIP-like profiles.

```r
# Run single combination
final_run <- searchSites(optimal_res, lambdaPWM = 1.25, BoundMolecules = 10000)

# Plot results
plotOccupancyProfile(predictedProfile = final_run$ChIPProfiles,
                     ChIPScore = chip_scored,
                     chromatinState = access_granges,
                     occupancy = final_run$Occupancy,
                     geneRef = gene_annotations)
```

## Key Parameters
- `lambdaPWM` ($\lambda$): Scales the specificity of the TF.
- `boundMolecules` ($N$): The number of TF molecules available for binding.
- `noiseFilter`: Options include "zero", "mean", "median", or "sigmoid" to clean experimental ChIP data.
- `strandRule`: How to handle scores on both strands ("max", "sum", or "mean").

## Tips for Success
- **Genome Alignment**: Ensure all input data (ChIP, Accessibility, BSgenome) are aligned to the same genome version (e.g., dm6).
- **Loci Selection**: If no loci are provided to `processingChIP`, use the `reduce` argument to select the top $n$ regions based on signal intensity.
- **Memory Management**: For large genomes, use the `cores` argument in processing functions to enable parallel computing.

## Reference documentation
- [The ChIPanalyser User's Guide](./references/ChIPanalyser.md)
- [ChIPanalyser: Genetic Algorithm and Chromatin States](./references/GA_ChIPanalyser.md)