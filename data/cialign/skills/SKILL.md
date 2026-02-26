---
name: cialign
description: CIAlign is a command-line toolkit for cleaning, visualizing, and interpreting multiple sequence alignments. Use when user asks to clean multiple sequence alignments, remove divergent sequences or insertions, crop alignment ends, generate sequence logos, or create position weight matrices.
homepage: https://github.com/KatyBrown/CIAlign
---


# cialign

## Overview
CIAlign is a command-line toolkit that automates the post-alignment processing of biological sequences. It addresses common issues in Multiple Sequence Alignments (MSAs) such as poorly aligned ends, rare insertions that disrupt the majority consensus, and highly divergent sequences that may represent sequencing errors or contamination. Beyond cleaning, it provides tools to interpret alignments through position weight matrices (PWMs) and visualizes the data to ensure transparency in how the alignment was modified.

## Core Capabilities and CLI Usage

### 1. Alignment Cleaning
CIAlign provides several modules to remove "noise" from an MSA. Common patterns include:
- **Remove Divergent Sequences**: Filter out sequences that exceed a specific percentage of divergence from the majority.
- **Remove Insertions**: Strip out insertions that are not present in the majority of the sequences.
- **Crop Ends**: Trim poorly aligned sequence ends where data is sparse or low quality.
- **Remove Gaps**: Automatically delete columns containing only gap characters.
- **Filter by Length**: Remove sequences that fall below a minimum length threshold.

### 2. Visualization and Statistics
Use CIAlign to generate visual summaries of your data:
- **Alignment Plots**: Create image files representing the entire alignment to see the distribution of residues and gaps.
- **Markup Maps**: Generate images that highlight exactly which parts of the alignment were removed by the cleaning functions.
- **Sequence Logos**: Draw standard sequence logos to visualize conservation.
- **Coverage/Conservation Plots**: Plot statistics for each position in the alignment.

### 3. Interpretation and Formatting
- **Consensus Sequences**: Generate a consensus sequence based on the cleaned alignment.
- **Motif Analysis**: Create Position Frequency (PFM), Probability (PPM), and Weight Matrices (PWM). These can be formatted specifically for use in downstream tools like MEME or BLAMM.
- **Similarity Matrices**: Calculate percentage identity between all pairs of sequences in the alignment.

### 4. Editing Tasks
- **Unalign**: Convert an MSA back into unaligned sequences.
- **Nucleotide Conversion**: Replace U with T (or vice versa) for RNA/DNA consistency.
- **Extraction**: Extract specific sub-sections of a larger alignment.

## Best Practices
- **Check the Log**: CIAlign is designed for transparency. Always review the generated log file and alignment markup to verify that the cleaning parameters (like divergence thresholds) are not overly aggressive for your specific dataset.
- **Iterative Refinement**: Start with default settings and use the visualization plots to determine if further cropping or filtering is required.
- **Input Format**: Ensure your input is in a standard alignment format (typically FASTA).

## Reference documentation
- [github_com_KatyBrown_CIAlign.md](./references/github_com_KatyBrown_CIAlign.md)
- [anaconda_org_channels_bioconda_packages_cialign_overview.md](./references/anaconda_org_channels_bioconda_packages_cialign_overview.md)