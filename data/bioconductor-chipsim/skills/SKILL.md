---
name: bioconductor-chipsim
description: This tool simulates ChIP-seq experiments to generate synthetic data for nucleosome positioning and transcription factor binding. Use when user asks to generate synthetic ChIP-seq data, simulate nucleosome positioning, or create FASTQ files to test analysis pipelines.
homepage: https://bioconductor.org/packages/release/bioc/html/ChIPsim.html
---


# bioconductor-chipsim

name: bioconductor-chipsim
description: Simulation of ChIP-seq experiments, including nucleosome positioning and transcription factor binding. Use when you need to generate synthetic ChIP-seq data (FASTQ files or R objects) to test analysis pipelines, evaluate peak callers, or estimate required sequencing depth.

## Overview

`ChIPsim` provides a flexible framework for simulating ChIP-seq experiments. It models the process in six distinct stages: generating genomic features (via Markov chains), computing binding site densities, calculating strand-specific read densities, sampling read start sites, naming reads, and finally generating sequences with quality scores and errors. While it includes built-in support for nucleosome positioning, it is highly extensible for other experiment types like transcription factor (TF) binding.

## Core Workflow

The primary interface is the `simChIP` function, which orchestrates the entire simulation.

### 1. Basic Nucleosome Simulation
To run a simulation with default settings (nucleosome positioning):

```r
library(ChIPsim)

# 1. Prepare a genome (DNAStringSet)
chrLen <- c(2e5, 1e5)
chromosomes <- sapply(chrLen, function(n) paste(sample(DNA_BASES, n, replace = TRUE), collapse = ""))
names(chromosomes) <- c("CHR1", "CHR2")
genome <- Biostrings::DNAStringSet(chromosomes)

# 2. Run simulation
# nReads: number of reads to generate
# file: prefix for output files (e.g., "my_sim"). Use "" for no file output.
simulated <- simChIP(nReads = 1000, genome = genome, file = "sim_output")
```

### 2. Customizing Parameters
Use `defaultControl()` to modify specific stages of the simulation without rewriting the whole pipeline.

```r
# Change mean fragment length to 150bp
control_params <- defaultControl(readDensity = list(meanLength = 150))

simulated <- simChIP(1000, genome, file = "", control = control_params)
```

### 3. Simulating Transcription Factor (TF) Binding
Simulating TF binding requires defining a Markov chain for feature generation.

```r
# 1. Define state transitions
transition <- list(Binding = c(Background = 1), 
                   Background = c(Binding = 0.05, Background = 0.95))
transition <- lapply(transition, "class<-", "StateDistribution")

# 2. Define initial state
init <- c(Binding = 0, Background = 1)
class(init) <- "StateDistribution"

# 3. Define feature generators (functions named [state]Feature)
backgroundFeature <- function(start, length=1000, shape=1, scale=20){
  weight <- rgamma(1, shape=shape, scale=scale)
  params <- list(start = start, length = length, weight = weight)
  class(params) <- c("Background", "SimulatedFeature")
  params
}

bindingFeature <- function(start, length=50, weight=50){
  params <- list(start = start, length = length, weight = weight)
  class(params) <- c("Binding", "SimulatedFeature")
  params
}

# 4. Setup arguments and run
featureArgs <- list(generator = list(Binding=bindingFeature, Background=backgroundFeature),
                    transition = transition, init = init, experimentType = "TFExperiment")

simulated_tf <- simChIP(1000, genome, file = "", 
                        control = defaultControl(features = featureArgs))
```

## Key Functions

- `simChIP()`: The main wrapper function for the full simulation.
- `makeFeatures()` / `placeFeatures()`: Generates the sequence of genomic features (nucleosomes, TF sites).
- `feat2dens()`: Converts features into a binding site density.
- `bindDens2readDens()`: Converts binding density into strand-specific read densities based on fragment length distributions.
- `sampleReads()`: Samples read start positions from the read densities.
- `readSequence()`: Extracts DNA sequences from the genome at specified positions.
- `readError()`: Introduces sequencing errors based on quality scores.

## Tips for Success

- **Reproducibility**: Always use `set.seed()` before running `simChIP` to ensure the stochastic Markov chain and read sampling are reproducible.
- **Intermediate Results**: If `file` is provided, `ChIPsim` saves `.rdata` files for each stage. You can skip stages in subsequent runs by setting `load = TRUE` in `simChIP()`.
- **Memory Management**: For large genomes or high coverage, the density vectors can become very large. Consider simulating one chromosome at a time if memory is an issue.
- **Custom Quality Scores**: By default, the package expects real quality scores. If unavailable, provide a custom function to the `readSequence` slot in `defaultFunctions()`.

## Reference documentation
- [Simulating ChIP-seq experiments](./references/ChIPsimIntro.md)