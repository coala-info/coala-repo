---
name: fineradstructure
description: fineradstructure is a specialized tool designed for population genomics that leverages the linkage information present in RADseq data.
homepage: http://cichlid.gurdon.cam.ac.uk/fineRADstructure.html
---

# fineradstructure

## Overview
fineradstructure is a specialized tool designed for population genomics that leverages the linkage information present in RADseq data. Unlike traditional methods that treat SNPs as independent, this tool uses a "co-ancestry matrix" approach to identify subtle population subdivisions. It is particularly effective for detecting recent common ancestry and fine-scale structure that might be missed by standard PCA or ADMIXTURE analyses.

## Core Workflow
The standard pipeline involves three primary stages: calculating the co-ancestry matrix, performing MCMC clustering, and tree building.

### 1. Co-ancestry Matrix Calculation (RADpainter)
The first step uses `RADpainter` to calculate the shared ancestry between individuals.
- **Input**: A standard RADseq file (typically in `.alleles` or similar format).
- **Command**: `RADpainter paint input_file.alleles`
- **Output**: A `.chunkcounts.out` file representing the co-ancestry matrix.

### 2. MCMC Clustering (fineRADstructure)
The clustering stage assigns individuals to populations based on the matrix.
- **Command**: `finestructure -x 100000 -y 100000 -z 1000 input_chunks.out output_mcmc.xml`
- **Parameters**:
    - `-x`: Number of burn-in iterations (e.g., 100,000).
    - `-y`: Number of runtime iterations (e.g., 100,000).
    - `-z`: Thinning interval (how often to sample the MCMC).

### 3. Tree Building
To visualize relationships between the identified clusters:
- **Command**: `finestructure -m T -x 10000 input_chunks.out output_mcmc.xml output_tree.xml`
- **Note**: The `-m T` flag specifies the tree-building mode.

## Best Practices
- **Data Quality**: Ensure your RADseq data is filtered for high-quality SNPs and low missingness before running `RADpainter`, as noise in the alleles file can lead to spurious clustering.
- **Convergence**: For complex datasets, increase the burn-in (`-x`) and runtime (`-y`) iterations to ensure the MCMC chain has converged.
- **Visualization**: The resulting `.xml` files are typically visualized using the `finestructure GUI` or R scripts (like `fineRADstructurePlot.R`) to generate heatmaps and dendrograms.

## Reference documentation
- [fineradstructure Overview](./references/anaconda_org_channels_bioconda_packages_fineradstructure_overview.md)