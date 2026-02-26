---
name: abundancebin
description: AbundanceBin is a metagenomic binning tool that classifies sequences into clusters based on their abundance levels. Use when user asks to bin metagenomic sequences, perform recursive clustering on FASTA files, or classify sequences without pre-specifying the number of clusters.
homepage: https://github.com/movingpictures83/AbundanceBin
---


# abundancebin

## Overview
AbundanceBin is a metagenomic binning tool that classifies sequences into different bins based on their abundance levels. This skill facilitates the use of the AbundanceBin tool (specifically version 1.0.1) to process FASTA files. The primary advantage of this tool is its recursive clustering capability, which allows it to operate without requiring the user to pre-specify the expected number of clusters, making it ideal for complex environmental samples with unknown microbial diversity.

## Usage Instructions

### Environment Requirements
*   Ensure the `abundancebin` executable is installed and available in your system `PATH`.
*   The tool is compatible with GCC 4.8.4 and has been tested within the PluMA (Plugin-based Metagenomic Analysis) framework.

### Core Workflow
1.  **Input Preparation**: Prepare your metagenomic sequences in a standard FASTA format.
2.  **Execution**: Run the tool by providing the FASTA file. The tool typically requires an input file and an output prefix.
3.  **Recursive Clustering**: Always utilize the recursive option when the number of species in the sample is unknown. This allows the algorithm to split clusters until a statistical equilibrium is reached.
4.  **Output Handling**: The tool generates multiple output files. All generated files will use the specified output prefix (often derived from the input filename) to organize the resulting bins.

### Best Practices
*   **Input Quality**: Ensure FASTA headers are unique and sequences are pre-processed for quality, as the abundance-based binning relies on accurate k-mer frequency distributions.
*   **Resource Management**: Since the tool is written in C++, ensure sufficient memory is available for the recursive clustering of large datasets, as the k-mer counting and distribution modeling can be memory-intensive.
*   **Output Organization**: Because the tool produces multiple files per run, execute the command within a dedicated output directory or use a distinct prefix to prevent file clutter.

## Reference documentation
- [AbundanceBin README](./references/github_com_movingpictures83_AbundanceBin.md)