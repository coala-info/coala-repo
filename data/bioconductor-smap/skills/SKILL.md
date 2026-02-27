---
name: bioconductor-smap
description: bioconductor-smap performs copy number profiling of array-CGH data using a Segmental Maximum A Posteriori approach based on Hidden Markov Models. Use when user asks to analyze genomic copy number variations, identify segments of gain or loss, or visualize profiling results from array-CGH experiments.
homepage: https://bioconductor.org/packages/3.5/bioc/html/SMAP.html
---


# bioconductor-smap

name: bioconductor-smap
description: A tool for copy number profiling of array-CGH data using a Segmental Maximum A Posteriori (SMAP) approach based on Hidden Markov Models (HMM). Use this skill to analyze genomic copy number variations, identify segments of gain or loss, and visualize profiling results from array-CGH experiments.

# bioconductor-smap

## Overview
The `SMAP` package provides a method for copy number profiling of array-CGH data. It uses a Hidden Markov Model (HMM) to assign genomic segments to specific copy number states (e.g., deletions, normal, gains, amplifications). The core algorithm, Segmental Maximum A Posteriori (SMAP), optimizes both the state sequence and the HMM parameters simultaneously using a combination of the Viterbi algorithm and gradient descent.

## Typical Workflow

### 1. Data Preparation
Data must be converted into a `SMAPObservations` object. This requires log-ratios, chromosome identifiers, and genomic positions.

```R
library(SMAP)
data(GBM) # Example dataset

# Create observations object
obs <- SMAPObservations(
  value = as.numeric(GBM[,2]),
  chromosome = as.character(GBM[,3]),
  startPosition = as.numeric(GBM[,4]),
  endPosition = as.numeric(GBM[,5]),
  name = "Sample_Name",
  reporterId = as.character(GBM[,1])
)

# Visualize raw observations
plot(obs)
```

### 2. Defining the HMM
Initialize a `SMAPHMM` object by specifying the number of states and their initial distribution parameters (means and standard deviations). A 6-state model is often recommended to represent: homozygous deletion, heterozygous deletion, normal, one-copy gain, two-copy gain, and amplification.

```R
# Define initial means and standard deviations for 6 states
init.means <- c(0.4, 0.7, 1.0, 1.3, 1.6, 3.0)
init.sds <- rep(0.1, 6)
phi <- cbind(init.means, init.sds)

# Create HMM object
# initTrans is the probability of changing state (default 0.2 / (noStates-1))
hmm <- SMAPHMM(noStates=6, Phi=phi, initTrans=0.02)
```

### 3. Running the SMAP Algorithm
The `smap` function performs the profiling. It alternates between finding the best state sequence and updating model parameters.

```R
# Run the profiling
# overlap: considers genomic overlap of clones
# distance: uses genomic distance for transition probabilities
# chrom.wise: if FALSE (recommended), fits one HMM to the whole genome
profile <- smap(hmm, obs, verbose=2, overlap=TRUE, distance=TRUE, chrom.wise=FALSE)
```

### 4. Extracting and Visualizing Results
After running `smap`, you can extract the predicted states and the optimized HMM parameters.

```R
# Get the predicted state sequence
predicted_states <- Q(profile)

# Get the optimized HMM parameters (means and SDs)
optimized_phi <- Phi(HMM(profile))

# Plot the profile results
plot(profile, ylab="ratio", ylim=c(0, 2))

# Plot specific chromosomes
chrom_9_ids <- which(chromosome(obs) == "9")
plot(profile[chrom_9_ids], main="Chromosome 9 Profile")
```

## Key Parameters and Tips
*   **eta**: The initial learning rate for gradient descent. If the model fails to converge or fits poorly, adjusting `eta` (default 0.005) may help.
*   **chrom.wise**: Setting this to `FALSE` is generally recommended as it allows the model to learn from the entire genome, providing better stability against local non-biological trends.
*   **initTrans**: A very high value may lead to over-segmentation (finding too much variation), while a very low value may result in under-segmentation (missing true variations).
*   **Subsetting**: `SMAPObservations` and `SMAPProfile` objects can be subsetted using standard R indexing (e.g., `profile[1:100]`) to focus on specific regions.

## Reference documentation
- [SMAP](./references/SMAP.md)