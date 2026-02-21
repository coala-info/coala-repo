---
name: bppsuite
description: The Bio++ Program Suite (bppsuite) is a collection of command-line tools designed for molecular evolution studies.
homepage: https://github.com/BioPP/bppsuite
---

# bppsuite

## Overview
The Bio++ Program Suite (bppsuite) is a collection of command-line tools designed for molecular evolution studies. It leverages the Bio++ libraries to provide high-performance implementations of phylogenetic methods. Use this skill to navigate the various executables within the suite, manage library dependencies, and execute common bioinformatics workflows such as tree building, parameter estimation, and sequence manipulation.

## CLI Usage and Best Practices

### Environment Configuration
The bppsuite executables rely on dynamic Bio++ libraries (bpp-core, bpp-seq, bpp-phyl, bpp-popgen). Before execution, ensure the library path is correctly exported to avoid "library not found" errors.

```bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/path/to/bpp/lib
```

### Core Executables
The suite consists of several specialized tools. Common patterns include:

*   **bppml**: Used for Maximum Likelihood estimation of model parameters and phylogenetic trees.
*   **bppseqgen**: Simulates molecular sequences along a given tree using specific evolutionary models.
*   **bppancestor**: Performs ancestral state reconstruction at internal nodes of a phylogeny.
*   **bppbranchlik**: Calculates likelihoods for specific branches, often used for model testing or site-specific analysis.
*   **bppPopStats**: Computes various population genetics statistics from sequence data.
*   **SeqMan**: A utility for sequence file manipulation and indexing.

### General Command Pattern
Most bppsuite tools follow a standard execution pattern using a parameter file (typically with a `.bpp` or `.params` extension) to define data inputs, models, and output paths.

```bash
bppml param=my_params.bpp
```

### Expert Tips
*   **Node Identification**: When using `bppancestor`, ensure your input tree has defined node IDs if you need to map specific ancestral sequences to internal branches.
*   **Precision**: For likelihood calculations in `bppbranchlik`, the tool supports high-precision output (up to 12 decimal places) which is critical for comparing nested models.
*   **Library Versions**: Ensure that the installed versions of `bpp-core` and `bpp-phyl` are compatible with the suite version (e.g., Suite v3.0.0 requires updated sonames and potentially Eigen 3).
*   **Documentation Generation**: If local help is needed, run `make pdf` or `make html` within the source directory to generate the full technical manual.

## Reference documentation
- [Bio++ Program Suite Overview](./references/github_com_BioPP_bppsuite.md)
- [Commit History and Tool Updates](./references/github_com_BioPP_bppsuite_commits_master.md)
- [Release Tags and Versioning](./references/github_com_BioPP_bppsuite_tags.md)