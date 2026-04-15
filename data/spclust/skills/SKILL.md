---
name: spclust
description: SpCLUST clusters divergent biological sequences using a Gaussian Mixture Model and MUSCLE-based distance matrices. Use when user asks to cluster divergent sequences, calculate distance matrices with specific substitution matrices, or perform parallel sequence clustering using MPI.
homepage: https://github.com/johnymatar/SpCLUST/
metadata:
  docker_image: "quay.io/biocontainers/spclust:28.5.19--h425c490_1"
---

# spclust

## Overview
SpCLUST is a specialized tool for clustering divergent biological sequences. While traditional clustering methods often prioritize speed for highly similar sequences, SpCLUST focuses on the accuracy of clustering divergent sequences by utilizing a Machine Learning Gaussian Mixture Model. It integrates the MUSCLE alignment module to calculate distance matrices and supports both serial and parallel computation via MPI.

## Command Line Usage

### Basic Execution
The tool provides two primary executables: `spclust` for serial processing and `mpispclust` for parallel processing.

**Serial execution:**
```bash
spclust -in <input_fasta> -out <output_folder> -mdist <matrix> -alignMode <mode>
```

**Parallel execution (requires MPI):**
```bash
mpirun -np <num_procs> mpispclust -in <input_fasta> -out <output_folder> -mdist <matrix> -alignMode <mode>
```

### Core Arguments
- `-in`: Path to the input FASTA file containing biological sequences.
- `-out`: Path to the output directory where results and clusters will be stored.
- `-mdist`: The substitution matrix used for distance calculation.
    - Options: `EDNAFULL` (default for nucleotides), `BLOSUM62`, `PAM250`.
- `-alignMode`: The precision level for the MUSCLE alignment step.
    - Options: `fast`, `moderate`, `maxPrecision`.
- `-gapOpen`: Gap open penalty (optional).
- `-gapExtend`: Gap extension penalty (optional).

## Best Practices and Expert Tips

### Handling Divergent Sequences
For highly divergent sequences where evolutionary distance is significant, always use `-alignMode maxPrecision`. While this increases computation time, it is necessary for the spectral clustering algorithm to receive an accurate distance matrix.

### Performance Optimization
- **Parallelization**: The distance matrix calculation is the most computationally expensive step. Use `mpispclust` with as many cores as available to significantly reduce runtime.
- **Memory Management**: Ensure your environment has sufficient memory for the Gaussian Mixture Model (GMM) step, especially when dealing with a large number of clusters.

### Environment Requirements
- **Dependencies**: SpCLUST requires the `muscle` executable and the `spclustGMM` module to be present in the same directory or within the system PATH.
- **Linux Installation**: If using the standalone version, ensure you are calling the binaries from their specific directory (e.g., `./spclust`) or that they are properly installed via `make install`.
- **Conda**: The easiest way to manage dependencies is via bioconda: `conda install bioconda::spclust`.

### Troubleshooting
- **Alignment Failure**: SpCLUST includes internal tests for alignment failure. If the tool exits early, check the input FASTA for non-standard characters or extremely short sequences that MUSCLE might reject.
- **Python Sub-module**: On Linux, the `spclustGMM` python sub-module is often converted to a standalone executable for easier use. Ensure this file has execution permissions (`chmod +x spclustGMM`).

## Reference documentation
- [GitHub Repository Overview](./references/github_com_johnymatar_SpCLUST.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_spclust_overview.md)