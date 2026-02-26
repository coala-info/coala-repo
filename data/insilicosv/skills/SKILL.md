---
name: insilicosv
description: "insilicoSV is a framework for simulating simple and complex structural variants using a flexible grammatical notation. Use when user asks to simulate structural variants, define custom genomic rearrangements, or create synthetic benchmarks for bioinformatic pipelines."
homepage: https://github.com/PopicLab/insilicoSV
---


# insilicosv

## Overview
insilicoSV is a specialized framework for simulating structural variants ranging from simple deletions to highly complex, multi-breakpoint rearrangements. It distinguishes itself by using a flexible "SV grammar" that allows users to define custom rearrangements (e.g., inversions, duplications, and translocations) through string-based representations. The tool provides fine-grained control over variant placement, allowing users to target specific genomic regions or avoid "blacklisted" areas, making it ideal for creating realistic synthetic benchmarks for bioinformatic pipelines.

## Installation and Setup
The tool can be installed via Conda or Pip. It is recommended to use a dedicated environment due to its Python 3.9+ requirement.

- **Conda**: `conda install bioconda::insilicosv`
- **Pip**: `pip install .` (from the source directory)

## Command Line Usage
The primary interface for insilicoSV is a single command-line execution that points to a configuration file.

- **Basic Execution**: `insilicosv -c <path/to/config.yaml>`
- **Workflow Pattern**:
    1. Create a dedicated project directory for the simulation.
    2. Place your reference genome and any region files (BED format) in accessible paths.
    3. Execute the tool from within the project directory; insilicoSV generates output files relative to the configuration file's location.

## Structural Variant Grammar
The core of the tool's flexibility lies in its grammatical notation. When defining custom SVs, use the following logic:
- **Segments**: Represented by letters (e.g., `A`, `B`, `C`).
- **Inversions**: Indicated by lowercase letters (e.g., `a` is the inversion of `A`).
- **Deletions**: Omit the segment letter from the right side of the transformation.
- **Duplications**: Repeat the segment letter (e.g., `ABB` represents a tandem duplication of segment B).
- **Example**: A complex rearrangement defined as `ABC -> aBBBc` indicates segment A is inverted, segment B is tripled, and segment C is preserved in its original orientation.

## Placement and Constraints
insilicoSV allows for sophisticated placement logic beyond random distribution:
- **Region Targeting**: You can constrain SVs or specific breakpoints to overlap with regions defined in BED files.
- **Placement Modes**: The tool supports different modes to specify *how* a variant overlaps a region (e.g., terminal overlaps or whole-chromosome constraints).
- **Blacklisting**: Use category-specific blacklists to prevent variants from being placed in problematic regions like centromeres or high-complexity repeats.

## Best Practices
- **Directory Isolation**: Always run simulations in a fresh directory. The tool produces multiple output files (VCFs, BEDPEs, and simulated fasta files) and does not automatically clean up previous runs.
- **Size Simulation**: Configure inter-breakpoint distances independently for complex SVs to ensure the simulated biology matches the intended use case (e.g., mimicking chromothripsis vs. simple insertions).
- **Haploid vs. Diploid**: Be mindful of the simulation mode. The tool supports haploid modes and can also handle overlapping heterozygous SVs across distinct haplotypes.
- **Validation**: Use the generated BEDPE files to verify "novel adjacencies" before proceeding to heavy read simulation or alignment steps.

## Reference documentation
- [insilicoSV GitHub Repository](./references/github_com_PopicLab_insilicoSV.md)
- [insilicoSV Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_insilicosv_overview.md)