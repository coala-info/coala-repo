---
name: bleties
description: BleTIES (Basic Long-read Enabled Toolkit for Interspersed DNA Elimination Studies) is a specialized bioinformatics suite designed for ciliate genomics.
homepage: https://github.com/Swart-lab/bleties
---

# bleties

## Overview
BleTIES (Basic Long-read Enabled Toolkit for Interspersed DNA Elimination Studies) is a specialized bioinformatics suite designed for ciliate genomics. It facilitates the discovery and targeted assembly of sequences that are removed during the transition from the germline micronucleus (MIC) to the somatic macronucleus (MAC). By analyzing long-read alignments against a MAC reference, BleTIES identifies insertion signals that represent IESs and provides tools for their reconstruction and visualization.

## Installation and Setup
The recommended way to install BleTIES is via Bioconda:

```bash
conda create -c conda-forge -c bioconda -n bleties bleties
conda activate bleties
```

To verify the installation and check the version:
```bash
bleties --version
```

## Core Modules and CLI Usage
BleTIES operates through several sub-commands tailored to specific stages of IES analysis.

### MILRAA (Main IES Reconstruction)
The primary module for predicting and assembling non-scrambled IESs.
*   **Trigger**: Use when you have a BAM file of long reads mapped to a MAC genome.
*   **Command**: `bleties milraa [options]`
*   **Requirement**: Input BAM must have valid CIGAR strings and NM tags (mismatch count).

### MILTEL (Breakpoint Analysis)
Used for identifying chromosome breakpoints and telomere addition sites.
*   **Command**: `bleties miltel [options]`

### INSERT
Used to modify a reference assembly by inserting or removing sequences based on a feature table, effectively creating a predicted MIC-like assembly from a MAC reference.
*   **Command**: `bleties insert [options]`

### Other Sub-commands
*   `miser`: IES retention analysis.
*   `milret`: IES retention scoring.
*   `milcor`: Correlation analysis of IES retention.

To view specific options for any module, use the help flag:
```bash
bleties <module> --help
```

## Best Practices and Expert Tips
*   **Mapping Quality**: The accuracy of BleTIES depends heavily on the initial mapping. Use a long-read mapper (like Winnowmap2 or Minimap2) that produces accurate CIGAR strings.
*   **Input Validation**: Ensure your BAM file is sorted and indexed. BleTIES relies on the NM tag; if your mapper does not produce it by default, you may need to use `samtools fillmd` or a similar utility.
*   **Visualization**: After running `milraa` or `milcor`, use the provided auxiliary plotting scripts located in the package's script directory:
    *   `milraa_plot.py`: Visualizes IES reconstruction results.
    *   `milcor_plot.py`: Visualizes correlations between IESs.
*   **Non-Scrambled Focus**: Note that the current version of `milraa` is optimized for non-scrambled IESs. For complex rearrangements, manual inspection of the output GFF3 and BAM files may be required.

## Reference documentation
- [BleTIES Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bleties_overview.md)
- [BleTIES GitHub Repository](./references/github_com_Swart-lab_bleties.md)