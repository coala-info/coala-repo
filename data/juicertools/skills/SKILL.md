---
name: juicertools
description: JuicerTools is a command-line toolkit for processing Hi-C data into the .hic format and identifying genomic structural features like TADs and chromatin loops. Use when user asks to create .hic files, calculate normalization vectors, identify chromatin loops with HiCCUPS, or call contact domains with Arrowhead.
homepage: https://github.com/aidenlab/Juicebox
---


# juicertools

## Overview
JuicerTools is a specialized command-line toolkit for the analysis of Hi-C (High-throughput Chromosome Conformation Capture) data. It provides the necessary procedures to transform raw contact data into the compressed, multi-resolution .hic format and offers a suite of algorithms for identifying structural features of the genome, such as Topologically Associating Domains (TADs) and chromatin loops. It is the command-line counterpart to the Juicebox visualization software.

## Command Line Usage
The tools are distributed as a Java executable. The primary entry point for command-line analysis is the HiCTools class within the provided jar file.

### Basic Execution Pattern
```bash
java -Xms512m -Xmx2048m -jar juicertools.jar [command] [options]
```
*Note: Replace `juicertools.jar` with the specific versioned jar name (e.g., juicertools_2.20.00.jar) or the path to your local installation.*

### Core Commands
- **pre**: Creates a .hic file from a list of contacts (typically a "merged_nodups" file).
- **addnorm**: Calculates and adds normalization vectors (e.g., KR, VC, Balanced) to an existing .hic file.
- **hiccups**: An algorithm for identifying chromatin loops (peaks) in Hi-C maps.
- **arrowhead**: A tool for identifying contact domains (TADs).
- **apa**: Aggregate Peak Analysis to measure the aggregate enrichment of a set of putative peaks.
- **stats**: Generates statistics from the Hi-C dataset.

## Expert Tips and Best Practices

### Memory Management
Hi-C data processing is extremely memory-intensive, especially at high resolutions (e.g., 1kb or 5kb).
- **Heap Size**: Always set the maximum heap size (`-Xmx`) to at least 2GB for small tasks. For large human or mammalian datasets, this should be increased to 16GB, 64GB, or more depending on the resolution.
- **OutOfMemory Errors**: If the tool crashes with a memory error, it is almost always due to the `-Xmx` flag being set too low for the resolution requested.

### Normalization
- **Balanced/KR**: Use Balanced or KR (Knight-Ruiz) normalization for most visualization and feature-calling tasks to account for experimental biases.
- **Post-processing**: If a .hic file was created without normalization, use the `addnorm` command to calculate them without rebuilding the entire file.

### Resolution Selection
- Hi-C maps are multi-resolution. When calling features:
    - Use **Arrowhead** at 5kb or 10kb for domain calling.
    - Use **HiCCUPS** at 5kb or 10kb for loop calling.
- Ensure your .hic file was built with these resolutions included during the `pre` step.

### File Preparation
- For the `pre` command, ensure the input contact list is properly formatted and sorted.
- Ensure the execution environment has sufficient disk space for temporary files, as the tool performs large-scale sorting of contact pairs during file creation.

## Reference documentation
- [Juicebox GitHub README](./references/github_com_aidenlab_Juicebox.md)
- [Juicebox Wiki Overview](./references/github_com_aidenlab_Juicebox_wiki.md)
- [Bioconda Juicertools Overview](./references/anaconda_org_channels_bioconda_packages_juicertools_overview.md)