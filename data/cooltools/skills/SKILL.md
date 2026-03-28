---
name: cooltools
description: cooltools is a Python-based suite for analyzing genome folding data and characterizing chromatin architecture from Hi-C contact matrices. Use when user asks to calculate contact frequency vs. distance, identify A/B compartments, find TAD boundaries via insulation scores, or perform aggregate peak analysis.
homepage: https://github.com/mirnylab/cooltools
---


# cooltools

## Overview
cooltools is a specialized Python-based suite developed by the Open2C ecosystem for the rigorous analysis of genome folding data. It bridges the gap between raw contact matrices and biological discovery by providing deterministic tools for characterizing genome architecture. Use this skill to guide the execution of standard Hi-C workflows, from basic visualization prep to complex multi-scale feature calling, ensuring results are consistent with 4D Nucleome and ENCODE standards.

## Core Workflows and CLI Patterns

The cooltools CLI follows a consistent pattern: `cooltools <command> [options] <input.cool>`.

### 1. Contact Frequency vs. Distance (Scaling)
To understand how often genomic loci interact as a function of their linear distance:
- **Command**: `cooltools expected-cis` (for intra-chromosomal) or `expected-trans` (for inter-chromosomal).
- **Key Output**: A table of "expected" contact frequencies, essential for normalizing other analyses (like enrichment/pileups).
- **Tip**: Always provide a genome regions file (via `bioframe`) to ensure calculations respect chromosome boundaries and gaps.

### 2. Compartment Analysis (A/B Identity)
To identify active (A) and inactive (B) chromatin compartments:
- **Command**: `cooltools eigs-cis`
- **Workflow**:
    1. Generate the eigenvectors (usually the first EV corresponds to compartments).
    2. Use `cooltools saddle` to create saddleplots, visualizing the preference of A-A, B-B, and A-B interactions.
- **Expert Tip**: Use a track of gene density or GC content to "flip" the sign of the eigenvector so that positive values consistently represent the A compartment.

### 3. Insulation and TAD Boundaries
To find Topologically Associating Domain (TAD) boundaries:
- **Command**: `cooltools insulation`
- **Parameters**: Requires a "window" size (e.g., 10kb, 25kb, 50kb).
- **Logic**: The tool calculates the insulation score; local minima in this score represent high-insulation points (potential boundaries).
- **Refinement**: Use the resulting boundary strengths to filter for "robust" boundaries across different cell states.

### 4. Aggregate Peak Analysis (Pileups)
To visualize the average local neighborhood around specific genomic features (e.g., CTCF sites, promoters):
- **Command**: `cooltools pileup`
- **Requirement**: A `.cool` file and a BED file of coordinates.
- **Normalization**: Use the "expected" table generated in Step 1 to calculate "Observed/Expected" pileups, which highlight enrichment over the genomic background.

## Expert Best Practices
- **Data Format**: Ensure all input data is in the `.cool` or `.mcool` format. If you have paired-end reads, use `cooler cload` or `pairtools` first to generate the matrix.
- **Resolution Selection**: 
    - Use **low resolution** (100kb - 1Mb) for compartments and saddleplots.
    - Use **medium resolution** (10kb - 40kb) for insulation and TAD boundaries.
    - Use **high resolution** (1kb - 5kb) for loops and fine-scale pileups.
- **Parallelization**: Most cooltools commands support the `-p` or `--nproc` flag. Always utilize multiple cores for `expected` and `pileup` calculations to reduce processing time.
- **Genomic Intervals**: cooltools relies heavily on `bioframe`. When defining "chromosomes" or "arms," ensure your TSV/BED files match the exact chromosome names in the `.cool` file header.



## Subcommands

| Command | Description |
|---------|-------------|
| cooltools expected-trans | Calculate expected Hi-C signal for trans regions of chromosomal interaction map: average of interactions in a rectangular block defined by a pair of regions, e.g. inter-chromosomal blocks. |
| cooltools saddle | Calculate saddle statistics and generate saddle plots for an arbitrary signal track on the genomic bins of a contact matrix. |
| coverage | Calculate the sums of cis and genome-wide contacts (aka coverage aka marginals) for a sparse Hi-C contact map in Cooler HDF5 format. Note that the sum(tot_cov) from this function is two times the number of reads contributing to the cooler, as each side contributes to the coverage. |
| dots | Call dots on a Hi-C heatmap that are not larger than max_loci_separation. |
| eigs-cis | Perform eigen value decomposition on a cooler matrix to calculate compartment signal by finding the eigenvector that correlates best with the phasing track. |
| eigs-trans | Perform eigen value decomposition on a cooler matrix to calculate compartment signal by finding the eigenvector that correlates best with the phasing track. |
| expected-cis | Calculate expected Hi-C signal for cis regions of chromosomal interaction   map: average of interactions separated by the same genomic distance, i.e.   are on the same diagonal on the cis-heatmap. |
| genome | Utilities for binned genome assemblies. |
| insulation | Calculate the diamond insulation scores and call insulating boundaries. |
| pileup | Perform retrieval of the snippets from .cool file. |
| random-sample | Pick a random sample of contacts from a Hi-C map. |
| rearrange | Rearrange data from a cooler according to a new genomic view |
| virtual4c | Generate virtual 4C profile from a contact map by extracting all interactions of a given viewpoint with the rest of the genome. |

## Reference documentation
- [cooltools: enabling high-resolution Hi-C analysis in Python](./references/github_com_open2c_cooltools.md)
- [Releasing and Versioning Guidelines](./references/github_com_open2c_cooltools_wiki_Releasing.md)