---
name: ale
description: ALE evaluates the quality of a genome assembly by calculating a likelihood score based on how well sequenced reads support the assembly. Use when user asks to assess assembly quality without a reference, calculate assembly likelihood scores, or identify base-level inconsistencies in a genome.
homepage: https://github.com/sc932/ALE
---


# ale

## Overview
ALE (Assembly Likelihood Estimator) is a tool designed to assess the quality of a genome assembly without a reference genome. It uses a probabilistic framework to determine how well a set of sequenced reads (provided as a BAM file) supports a given assembly (provided as a FASTA file). The tool generates a likelihood score that accounts for various factors including insert size distributions, read orientations, and base-level accuracy.

## Usage Guidelines

### Primary Workflow
The standard workflow for ALE involves mapping your reads to the assembly and then running the estimator.

1.  **Map Reads**: Use a standard aligner (like BWA or Bowtie2) to map your reads to the assembly FASTA. Ensure the output is a sorted BAM file.
2.  **Run ALE**: Execute the main tool by providing the alignment and the assembly.
    ```bash
    ALE mapping.bam assembly.fasta output.ale
    ```
3.  **Visualization**: Convert the raw ALE scores into a format compatible with genome browsers.
    ```bash
    python ale2wiggle.py output.ale
    ```

### Key CLI Options and Flags
*   `--realign`: Use this flag to perform a local realignment of reads, which can improve the accuracy of the likelihood score in complex regions.
*   `--SNPreport`: Generates a report on potential SNPs and base-level inconsistencies identified during the evaluation.
*   `--pl`: Used to specify or adjust parameters related to the library's insert size distribution.

### Visualization and Interpretation
*   **IGV Integration**: The authors recommend using the Integrative Genomics Viewer (IGV). You should load the assembly FASTA, the BAM file, and the generated `.wig` files.
*   **Wiggle Conversion**: Use `ale2wiggle.py` to transform the `.ale` output. For very large genomes, it is a best practice to convert the resulting `.wig` files into the `BigWig` format for better performance in browsers.
*   **Plotting**: For advanced statistical plotting, `plotter4.py` is available but requires a specific Python environment including `numpy`, `matplotlib`, and `pymix`.

### Expert Tips
*   **Secondary Alignments**: Recent versions of ALE (20180904+) are configured to ignore secondary alignments and focus on validating mate pairs to ensure the structural integrity of the assembly is accurately reflected in the score.
*   **Input Validation**: Ensure your BAM file is indexed and sorted. If the tool encounters minor issues with MD tags or mate pair consistency, it will typically issue a warning rather than aborting, but these warnings should be reviewed to ensure the validity of the likelihood score.
*   **Legacy Note**: This tool is no longer in active development. If you encounter segfaults when running without arguments or with missing files, ensure you are using the latest bioconda release (v20180904) which addressed several of these stability issues.

## Reference documentation
- [github_com_sc932_ALE.md](./references/github_com_sc932_ALE.md)
- [anaconda_org_channels_bioconda_packages_ale_overview.md](./references/anaconda_org_channels_bioconda_packages_ale_overview.md)
- [github_com_sc932_ALE_commits_master.md](./references/github_com_sc932_ALE_commits_master.md)