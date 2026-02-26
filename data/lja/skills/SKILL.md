---
name: lja
description: LJA is a genome assembly tool that uses high k-mer de Bruijn graphs to resolve repeats in PacBio HiFi reads. Use when user asks to assemble genomes from HiFi data, resolve complex genomic repeats, or perform homopolymer-compressed assembly and polishing.
homepage: https://github.com/AntonBankevich/LJA
---


# lja

## Overview
LJA (La Jolla Assembler) is a genome assembly tool optimized specifically for PacBio HiFi reads. Unlike traditional assemblers, LJA utilizes very high k-mer values within a de Bruijn graph framework to automatically resolve repeats that are typically difficult to navigate in mammalian genomes. The tool employs a specialized pipeline that includes homopolymer compression to mitigate common HiFi errors, followed by a dedicated polishing stage to restore the final sequence accuracy.

## Installation and Setup
LJA is primarily distributed via Bioconda. To install the tool and its dependencies, use the following command:

```bash
conda install bioconda::lja
```

## Core Modules and Workflow
LJA operates through three primary computational modules, followed by a polishing step:

1.  **jumboDBG**: Handles de Bruijn graph construction for arbitrarily large values of k. This is the foundation for resolving long repeats.
2.  **mowerDBG**: Performs near-perfect error correction tailored to the HiFi read profile.
3.  **multiDBG**: Utilizes variable k-mer values across different genomic regions and leverages the full length of HiFi reads for repeat resolution.
4.  **LJApolisher**: A mandatory final step. Because LJA compresses homopolymers during the assembly process to avoid errors, this tool is required to uncompress and polish the final contigs.

## CLI Usage and Best Practices

### Basic Execution
While specific input flags depend on the version, the standard entry point is the `lja` command. For users only interested in the graph construction phase, `jumboDBG` can be run as a standalone script.

### Handling Error Correction
If you have pre-corrected reads or wish to bypass the internal error correction phase for debugging or specific workflows, use the following flag:

```bash
lja --noec [other_parameters]
```

### Working with Diploid Genomes
Note that diploid assembly is currently considered an experimental feature in LJA. When assembling diploid organisms, expect potential variations in contig headers and assembly consistency.

### Homopolymer Management
LJA's internal logic relies on homopolymer compression. If your downstream analysis requires uncompressed sequences, ensure the `LJApolisher` module has completed its run on the `assembly.fasta` or equivalent output.

### Expert Tips
*   **Technology Limitation**: LJA is strictly for PacBio HiFi reads. It cannot currently combine HiFi data with ONT (Oxford Nanopore) or Illumina reads.
*   **Memory Management**: Because LJA uses very high k-mer values for large genomes, ensure your environment has sufficient RAM for the `jumboDBG` module, which builds the initial large-scale graph.
*   **Output Verification**: Check for inconsistencies between the graphical representation (`mdbg.gfa`) and the final sequence file (`assembly.fasta`), as the polishing step may alter headers or sequence lengths.

## Reference documentation
- [La Jolla Assembler GitHub Overview](./references/github_com_AntonBankevich_LJA.md)
- [Bioconda LJA Package Details](./references/anaconda_org_channels_bioconda_packages_lja_overview.md)