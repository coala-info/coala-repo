---
name: bioconductor-selex
description: This tool analyzes SELEX-seq data to discover motifs and calculate transcription factor binding affinities. Use when user asks to build Markov models of background distributions, identify optimal binding site lengths, or calculate K-mer affinities from high-throughput sequencing data.
homepage: https://bioconductor.org/packages/release/bioc/html/SELEX.html
---

# bioconductor-selex

name: bioconductor-selex
description: Analysis of SELEX-seq data for motif discovery and transcription factor binding affinity. Use this skill when analyzing high-throughput sequencing data from Systematic Evolution of Ligands by Exponential Enrichment (SELEX) experiments to build Markov models of background distributions, identify optimal binding site lengths, and calculate K-mer affinities.

## Overview

The `SELEX` package provides tools for the analysis of SELEX-seq data. It focuses on characterizing the non-randomness of the initial pool (Round 0) using Markov models and using that background to accurately estimate the binding affinities of transcription factors from subsequent selection rounds.

## Workflow and Key Functions

### 1. Initialization and Configuration
The package requires `rJava`. You must set the Java memory limit before loading the library.

```R
options(java.parameters="-Xmx1500M")
library(SELEX)

# Configure working directory for caching results
selex.config(workingDir="./cache/", maxThreadNumber=4)
```

### 2. Loading Samples
Samples can be defined individually or loaded via an XML annotation file.

```R
# Load from XML
selex.loadAnnotation("annotation.xml")

# Or define manually
selex.defineSample(seqName="MyLib", sampleName="R0", round=0, 
                   leftBarcode="CCACGTC", rightBarcode="TGG",
                   seqFile="R0.fastq.gz")

# View available samples
selex.sampleSummary()

# Create sample handles for analysis
r0 = selex.sample(seqName="MyLib", sampleName="R0", round=0)
r2 = selex.sample(seqName="MyLib", sampleName="R2", round=2)
```

### 3. Markov Model Construction
To account for library bias, build a Markov model using Round 0 data. Use `selex.kmax` to find the longest K-mer length where all sequences appear at least 100 times for robust estimation.

```R
# Find kmax for cross-validation
kmax.value = selex.kmax(sample=r0_test)

# Build optimal Markov Model
mm = selex.mm(sample=r0_train, order=NA, crossValidationSample=r0_test, Kmax=kmax.value)

# Check model performance (R2 values)
selex.mmSummary()
```

### 4. Identifying Optimal Motif Length
Use Information Gain (Kullback-Leibler divergence) to determine the optimal length $K$ for the binding site.

```R
# Calculate information gain across lengths
selex.infogain(sample=r2, markovModel=mm)

# View results to find K with highest Information Gain
selex.infogainSummary()
```

### 5. Calculating Affinities
Once the optimal length $K$ is determined, calculate the relative affinities and standard errors for all K-mers.

```R
# Calculate affinities for a specific K
aff = selex.affinities(sample=r2, k=10, markovModel=mm)

# Results include: Kmer, ObservedCount, Probability, ExpectedCount, Affinity, SE
head(aff)
```

### 6. Data Inspection
You can extract raw K-mer counts adjusted by the Markov model at any time.

```R
counts = selex.counts(sample=r2, k=10, markovModel=mm)
```

## Tips for Success
- **Memory Management**: SELEX-seq datasets are large. Always set `java.parameters` before loading the library.
- **Sample Splitting**: For Markov model construction, it is best practice to split your Round 0 data into a training set and a testing set (cross-validation) to avoid overfitting.
- **Caching**: The package caches results in the `workingDir`. If you change parameters but use the same filenames, ensure the cache is managed or cleared if necessary.

## Reference documentation
- [Motif Discovery from SELEX-seq data](./references/SELEX.md)