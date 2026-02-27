---
name: bioconductor-sparsedossa
description: This tool provides a Bayesian hierarchical model for characterizing and simulating realistic microbiome datasets. Use when user asks to simulate microbiome data, fit models to reference microbial datasets, or generate synthetic metagenomic datasets with specific correlation structures for benchmarking statistical methods.
homepage: https://bioconductor.org/packages/3.8/bioc/html/sparseDOSSA.html
---


# bioconductor-sparsedossa

name: bioconductor-sparsedossa
description: A Bayesian hierarchical model for characterizing and simulating microbiome data. Use this skill to fit models to reference microbial datasets (parameterization) or to generate synthetic metagenomic datasets with specific population structures, including known feature-feature (microbe-microbe) and feature-metadata correlation structures for benchmarking statistical methods.

# bioconductor-sparsedossa

## Overview

`sparseDOSSA` (Sparse Data Observations for the Simulation of Synthetic Abundances) provides a model-based Bayesian method to simulate realistic microbiome data. It captures the complex nature of microbiome measurements—such as sparsity, zero-inflation, and log-normal distributions—by fitting a hierarchical model to reference datasets. It is primarily used to create "gold standard" synthetic datasets where the underlying correlation structures are known, enabling the benchmarking of metagenomic statistical tools (e.g., differential abundance testing or normalization methods).

## Core Workflow

### 1. Basic Simulation
By default, `sparseDOSSA` generates a synthetic community based on the PRISM dataset template.

```r
library(sparseDOSSA)

# Run with default parameters (300 microbes, 50 samples, 20 random metadata)
sparseDOSSA::sparseDOSSA()
```

### 2. Customizing Community Properties
You can control the dimensions and depth of the simulated data. If providing a calibration file, it must be in QIIME OTU table format (features in rows, samples in columns).

```r
sparseDOSSA::sparseDOSSA(
  number_features = 150,
  number_samples = 100,
  read_depth = 10000,
  number_metadata = 5,
  calibrate = "path/to/your_otu_table.txt" # Optional: template dataset
)
```

### 3. Spiking Correlations (Feature-Metadata)
To simulate differential abundance or associations with metadata, use the `spike` parameters.

```r
sparseDOSSA::sparseDOSSA(
  percent_spiked = 0.05,   # 5% of features will be correlated with metadata
  spikeStrength = "2.0",   # Magnitude of the linear association
  spikeCount = "1"         # Number of metadata variables used for spiking
)
```

### 4. Spiking Correlations (Feature-Feature)
To simulate microbe-microbe interactions, you must enable the `runBugBug` flag.

```r
sparseDOSSA::sparseDOSSA(
  runBugBug = TRUE,        # Required for microbe-microbe correlation
  bugBugCorr = "0.5",      # Correlation strength (off-diagonal elements)
  bugs_to_spike = 10       # Number of inter-correlated microbes
)
```

## Output Files

The function generates three primary text files in the working directory:
1. `SyntheticMicrobiome.pcl`: Normalized abundance data.
2. `SyntheticMicrobiome-Counts.pcl`: Raw count data (integer).
3. `SyntheticMicrobiomeParameterFile.txt`: Records of model parameters, diagnostics, and which features were spiked.

To customize output paths:
```r
sparseDOSSA::sparseDOSSA(
  strNormalizedFileName = "results_norm.pcl",
  strCountFileName = "results_counts.pcl",
  parameter_filename = "results_params.txt"
)
```

## Tips for Benchmarking
- **Calibration**: Always use a reference dataset similar to your target biological system (e.g., human gut vs. soil) using the `calibrate` argument to ensure the synthetic data has a realistic distribution.
- **Reproducibility**: Check the `ParameterFile.txt` to verify which specific microbes were assigned correlations.
- **Normalization**: Use the generated count file to test different Bioconductor normalization methods (like `metagenomeSeq::cumNorm`) and compare results against the known spikes defined in the simulation.

## Reference documentation
- [sparseDOSSA Vignette](./references/sparsedossa-vignette.md)