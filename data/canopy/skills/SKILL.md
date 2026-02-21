---
name: canopy
description: The `canopy` skill (based on the `canopy2` implementation) provides a high-performance, memory-efficient approach to the canopy clustering algorithm.
homepage: https://github.com/hildebra/canopy2/
---

# canopy

## Overview
The `canopy` skill (based on the `canopy2` implementation) provides a high-performance, memory-efficient approach to the canopy clustering algorithm. It is optimized for metagenomics workflows where gene catalogues must be organized into clusters based on co-abundance or sequence similarity. This implementation is significantly faster and more resource-effective than the original versions, making it ideal for processing massive datasets that would otherwise exceed system memory.

## Installation and Setup
The tool can be acquired via Bioconda or compiled from source:

- **Conda**: `conda install bioconda::canopy`
- **Source**: 
  ```bash
  git clone https://github.com/hildebra/canopy2.git
  cd canopy2
  make
  ```
  The compilation produces the binary `cc.bin`.

## Command Line Usage
The primary interface for the tool is the `cc.bin` executable.

### Basic Execution
```bash
./cc.bin [options]
```

### Key CLI Flags
- `-v`: Enables verbose mode for detailed logging during the clustering process.
- `--seed [int]`: Sets a specific seed for the random number generator to ensure reproducible clustering results (available in version 0.24 and later).
- `--help`: Displays the full list of available parameters and distance thresholds.

### Input and Output Handling
- **Compression**: The tool natively supports `.gz` input and output files. It is highly recommended to use compressed files to manage the large data volumes typical of gene catalogues.
- **Data Profiles**: The implementation supports various profiles including stability tracking and deep tracking of genes within clusters.

## Best Practices
- **Reproducibility**: Always specify a `--seed` when running clusters for publication or pipeline integration to ensure that results can be replicated.
- **Memory Management**: While `canopy2` is memory-efficient, clustering extremely large catalogues still requires significant RAM. Monitor system resources and use the verbose flag (`-v`) to track progress.
- **Environment**: Prefer the Bioconda installation for production environments to ensure all dependencies (like `zlib` for `.gz` support) are correctly linked.

## Reference documentation
- [Bioconda Canopy Overview](./references/anaconda_org_channels_bioconda_packages_canopy_overview.md)
- [Canopy2 GitHub Repository](./references/github_com_hildebra_canopy2.md)