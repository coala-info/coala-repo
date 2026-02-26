---
name: focus
description: FOCUS characterizes the microbial composition of metagenomic samples using k-mer frequencies for agile profiling. Use when user asks to profile metagenomic samples, generate taxonomic summaries, or identify the relative abundance of organisms in a dataset.
homepage: https://edwards.sdsu.edu/FOCUS
---


# focus

## Overview
FOCUS (Find Abundance of Composition Usage) is a computational tool used to characterize the microbial composition of metagenomic samples. Unlike traditional alignment-based methods that rely on sequence length and homology, FOCUS utilizes k-mer frequencies and a specialized database to provide agile profiling. It is particularly effective for researchers needing quick taxonomic summaries of large datasets where computational efficiency is a priority.

## Usage Guidelines

### Installation and Setup
The tool is primarily distributed via Bioconda. Ensure your environment is configured with the necessary channels before installation.
```bash
conda install -c bioconda focus
```

### Basic Command Structure
The primary execution involves providing a directory of input sequences (FASTA/FASTQ) and specifying an output directory.
```bash
focus -i <input_directory> -o <output_directory>
```

### Key Parameters and Best Practices
- **Database Selection**: FOCUS relies on a pre-built database of k-mer frequencies. Ensure you are pointing to the correct database path if it is not in the default location using the `-db` flag.
- **K-mer Size**: The default k-mer size is typically optimized for general metagenomic samples, but specific research questions may require adjustments if the tool version supports it.
- **Input Formats**: While FOCUS is agile with sequence lengths, ensure input files are decompressed or in a format explicitly supported by your specific version (1.8 is the current stable release).
- **Memory Management**: Since FOCUS loads composition models into memory, ensure the execution environment has sufficient RAM relative to the complexity of the reference database being used.

### Interpreting Results
The output typically includes:
- A tabular report of organisms identified.
- Relative abundance percentages for each taxon.
- Profiles at different taxonomic ranks (Kingdom through Species).

## Reference documentation
- [FOCUS Overview](./references/anaconda_org_channels_bioconda_packages_focus_overview.md)