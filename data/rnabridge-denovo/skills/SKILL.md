---
name: rnabridge-denovo
description: rnabridge-denovo is a bioinformatics tool designed to solve the fragment reconstruction problem in RNA-seq analysis.
homepage: https://github.com/Shao-Group/rnabridge-denovo
---

# rnabridge-denovo

## Overview
rnabridge-denovo is a bioinformatics tool designed to solve the fragment reconstruction problem in RNA-seq analysis. While paired-end sequencing provides data from both ends of a transcript fragment, the middle portion often remains unsequenced. This tool implements an efficient algorithm to find the sequences of these entire fragments by leveraging de Bruijn graphs. It is particularly useful for researchers who require the full sequence of RNA fragments for precise transcript characterization or de novo assembly workflows.

## Installation and Setup
The most reliable way to install the tool is via Bioconda:

```bash
conda install bioconda::rnabridge-denovo
```

If compiling from source, the tool requires the **Bifrost** library for de Bruijn graph construction. If Bifrost is installed in a non-standard directory, you must export the following environment variables before compilation and execution:

```bash
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/path/to/bifrost/include/
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/path/to/bifrost/include/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/path/to/bifrost/lib/
export LIBRARY_PATH=$LIBRARY_PATH:/path/to/bifrost/lib/
export PATH=$PATH:/path/to/bifrost/bin/
```

## Usage Instructions
The tool operates on standard FASTQ input and produces a FASTA output containing the reconstructed (bridged) sequences.

### Basic Command Line Pattern
```bash
rnabridge-denovo <read1.fq> <read2.fq> <output_bridge.fa>
```

### Parameters
- **read1.fq**: The path to the first file of the paired-end RNA-seq reads.
- **read2.fq**: The path to the second file of the paired-end RNA-seq reads.
- **output_bridge.fa**: The destination path for the resulting bridged sequences in FASTA format.

## Expert Tips and Best Practices
- **Argument Verification**: Users have reported that the command-line arguments may occasionally differ from the documentation in certain versions. If the standard three-argument command fails, always check the internal help menu by running the executable without arguments or with `-h`.
- **Read Synchronization**: Ensure that your input FASTQ files are properly synchronized (the $i$-th read in file 1 must correspond to the $i$-th read in file 2).
- **Library Dependencies**: If you encounter "shared library not found" errors during execution, verify that the `LD_LIBRARY_PATH` points to the directory containing `libbifrost.so`.
- **Complementary Tools**: For users who already have alignments (BAM/SAM) and wish to determine the alignments of full fragments rather than just the sequences, use the sister tool `rnabridge-align`.

## Reference documentation
- [rnabridge-denovo Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rnabridge-denovo_overview.md)
- [rnabridge-denovo GitHub Repository](./references/github_com_Shao-Group_rnabridge-denovo.md)
- [rnabridge-denovo Known Issues](./references/github_com_Shao-Group_rnabridge-denovo_issues.md)