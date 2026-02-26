---
name: cassis
description: Cassis refines the boundaries of genomic rearrangements by pinpointing the precise locations of breakpoints between syntenic blocks. Use when user asks to refine genomic breakpoint regions, identify precise rearrangement locations, or achieve base-pair resolution for synteny boundaries.
homepage: http://pbil.univ-lyon1.fr/software/Cassis/
---


# cassis

## Overview
Cassis is a specialized bioinformatics tool designed to refine the boundaries of genomic rearrangements. While many synteny tools provide large-scale blocks, Cassis focuses on the "breakpoint regions" between these blocks, using sequence alignment and statistical methods to pinpoint the most likely location of the rearrangement event.

## Usage Patterns

### Core Workflow
The tool typically operates on a set of orthologous genomic regions. The general process involves:
1. Defining the coarse breakpoint regions based on synteny block boundaries.
2. Providing the genomic sequences for the species being compared.
3. Running the detection algorithm to narrow down the breakpoint to the highest possible resolution.

### CLI Best Practices
- **Input Preparation**: Ensure that input sequences are in FASTA format and that coordinate files match the assembly versions used.
- **Refinement**: Use Cassis when you have identified large-scale syntenic regions but need base-pair resolution for downstream analysis like motif searching or structural variant characterization.
- **Comparative Context**: The tool is most effective when comparing closely related species where sequence homology is still detectable within the breakpoint regions.

## Expert Tips
- **Breakpoint Regions**: The size of the initial breakpoint region significantly impacts performance. If the region is too large, the search space may lead to false positives; if too small, the true breakpoint might be excluded.
- **Sequence Alignment**: Since Cassis relies on local alignments to find the "switch" point between syntenic blocks, ensure your alignment parameters are tuned to the evolutionary distance of the species.

## Reference documentation
- [Cassis Overview](./references/anaconda_org_channels_bioconda_packages_cassis_overview.md)