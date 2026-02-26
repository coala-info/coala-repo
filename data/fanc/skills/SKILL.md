---
name: fanc
description: FAN-C is a specialized toolset for processing, analyzing, and visualizing Hi-C data to identify genomic features like TADs and chromatin loops. Use when user asks to process mapped reads into contact matrices, perform matrix normalization, call TADs or compartments, detect loops, and generate multi-track genomic plots.
homepage: https://github.com/vaquerizaslab/fanc
---


# fanc

## Overview
FAN-C (Framework for the ANalysis of C-data) is a specialized toolset for processing and interpreting Hi-C data. It is designed to handle the transition from mapped paired-end sequencing reads to high-level genomic features like chromatin loops and topologically associating domains (TADs). Use this skill to execute standard Hi-C workflows, perform matrix comparisons, and generate complex genomic plots using the `fancplot` utility.

## Core CLI Workflows

### Matrix Generation and Manipulation
FAN-C uses a specialized HDF5-based format for storing contact matrices.
*   **Generating Pairs**: Use `fanc pairs` to process mapped reads into a valid pairs format.
*   **Creating Matrices**: Use `fanc matrix` to bin pairs into contact maps at specific resolutions (e.g., 10kb, 50kb, 1mb).
*   **Normalization**: Apply matrix balancing (like ICE or KR) to remove experimental biases.
*   **Format Conversion**: Use `fanc to-juicer` to export data for use in the Juicer/Straw ecosystem or `fanc to-cool` for the Cooler ecosystem.

### Structural Analysis
*   **TAD Calling**: Use `fanc insulation` to calculate insulation scores across the genome. This is the primary method in FAN-C for identifying domain boundaries.
*   **Compartment Analysis**: Use `fanc compartments` to perform eigenvector decomposition for A/B compartment calling.
*   **Loop Detection**: Use `fanc loops` to identify point interactions. For aggregate analysis, use `fanc apa` (Aggregate Peak Analysis) to validate loop strengths.
*   **Comparison**: Use `fanc compare` to calculate log2 ratios or differences between two Hi-C matrices. Note that matrices should be normalized and scaled before comparison.

### Visualization with fancplot
`fancplot` is a powerful command-line tool for generating multi-track genomic plots.
*   **Basic Plotting**: `fancplot -o output.png chr1:10mb-20mb -p matrix sample.fanc`
*   **Adding Tracks**: You can stack multiple tracks including matrices, insulation scores, and external BED/BigWig files.
*   **Gene Annotation**: Use the `-p gene` parameter with a BED file to display gene models.
*   **Customization**: Use `-vmin` and `-vmax` to manually set the color scale for matrices to ensure comparability between different plots.

## Expert Tips and Best Practices
*   **Resolution Selection**: Always start with a coarse resolution (e.g., 1mb or 500kb) to verify data quality before proceeding to high-resolution (10kb or 5kb) analysis, which is computationally expensive.
*   **Memory Management**: For large genomes or high-resolution matrices, ensure you have sufficient swap space or use the `fanc` split-processing capabilities if available in your environment.
*   **Scaling in Comparisons**: When using `fanc compare`, ensure both input matrices are scaled to the same total number of reads or normalized using a consistent method to avoid artifacts in the fold-change calculation.
*   **Insulation Window**: When calling TADs, the choice of the insulation window size significantly impacts the number of boundaries called. It is often useful to run multiple window sizes to find the one that best matches the expected domain scale for your cell type.

## Reference documentation
- [fanc Overview](./references/anaconda_org_channels_bioconda_packages_fanc_overview.md)
- [fanc GitHub Repository](./references/github_com_vaquerizaslab_fanc.md)
- [fanc Issues and Troubleshooting](./references/github_com_vaquerizaslab_fanc_issues.md)