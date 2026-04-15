---
name: metawrap-assembly
description: The metawrap-assembly module provides a unified interface for performing metagenomic assembly using either metaSPAdes or MegaHit. Use when user asks to assemble metagenomic reads into contigs, run metaSPAdes or MegaHit through MetaWRAP, or generate a final assembly fasta file for downstream binning.
homepage: https://github.com/bxlab/metaWRAP
metadata:
  docker_image: "quay.io/biocontainers/metawrap-assembly:1.3.0--hdfd78af_3"
---

# metawrap-assembly

## Overview
The `metawrap assembly` module is a streamlined wrapper designed to handle the complex task of metagenomic assembly. It provides a unified interface for two primary assemblers: **metaSPAdes**, which is generally preferred for its high-quality assemblies and sensitivity, and **MegaHit**, which is optimized for speed and handling extremely large datasets. Beyond just assembly, the module integrates quality control steps to ensure the resulting contigs are ready for downstream binning and analysis.

## Usage Instructions

### Core Command Pattern
The basic syntax for running the assembly module is:
```bash
metawrap assembly -1 R1.fastq -2 R2.fastq -m [megahit/metaspades] -o output_dir
```

### Assembler Selection
*   **metaSPAdes**: Use for most standard datasets where accuracy is the priority. It is more computationally intensive and requires significant RAM.
*   **MegaHit**: Use for very large datasets (e.g., hundreds of millions of reads) or when computational resources (specifically RAM) are limited.

### Resource Management
Assembly is the most resource-heavy step in the MetaWRAP pipeline.
*   **Memory**: Ensure at least **64GB of RAM** is available. metaSPAdes may require significantly more depending on the complexity of the community.
*   **Cores**: A minimum of **8 cores** is recommended to maintain reasonable processing times.
*   **Monitoring**: If the process fails without a clear error message, it is almost always due to an Out-Of-Memory (OOM) event.

### Best Practices
*   **Pre-processing**: Always run the `metawrap read_qc` module before assembly to remove host contamination and low-quality reads.
*   **Output**: The module produces a `final_assembly.fasta` file. This file is the required input for subsequent modules like `metawrap binning` or `metawrap blobology`.
*   **Long Reads**: While primarily designed for Illumina paired-end data, recent updates to the pipeline have introduced support for hybrid assembly or nanopore-specific workflows in related modules.

### Troubleshooting
*   **CheckM Errors**: If downstream binning fails due to CheckM errors, verify that the assembly produced valid, non-empty contigs.
*   **Installation**: If the `metawrap` command is not found, ensure the `bin/` directory of the MetaWRAP installation is in your `$PATH` or use the specific Conda environment: `conda activate metawrap-env`.

## Reference documentation
- [MetaWRAP GitHub Repository](./references/github_com_bxlab_metaWRAP.md)
- [MetaWRAP Assembly Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_metawrap-assembly_overview.md)