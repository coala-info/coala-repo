---
name: wepp
description: WEPP is a pathogen-agnostic pipeline that uses phylogenetic placements to estimate lineage abundances and identify novel variants in wastewater sequencing data. Use when user asks to analyze wastewater surveillance data, map sequencing reads to a phylogeny, estimate haplotype proportions, or identify unaccounted alleles.
homepage: https://github.com/TurakhiaLab/WEPP
---


# wepp

## Overview

WEPP (Wastewater-Based Epidemiology using Phylogenetic Placements) is a pathogen-agnostic pipeline designed to enhance wastewater surveillance. Instead of relying on a small set of signature mutations, WEPP leverages the full phylogeny of a pathogen to map sequencing reads parsimoniously. It provides detailed reports on haplotype and lineage abundances and identifies "Unaccounted Alleles"—mutations observed in the sample that are not explained by known haplotypes—which can serve as early indicators of novel variants.

## CLI Usage and Best Practices

The primary interface for the pipeline is the `run-wepp` command.

### Basic Commands

- **Display Help**: View all available arguments and subcommands.
  ```bash
  run-wepp help --cores 1 --use-conda
  ```

- **Execute Pipeline**: Run the standard analysis on your dataset.
  ```bash
  run-wepp --cores <number_of_cores> --use-conda
  ```

- **Launch Dashboard**: Start the interactive visualization tool to analyze results.
  ```bash
  run-wepp dashboard
  ```

### Workflow Requirements

1. **Data Organization**: Place your input sequencing files (FASTQ) and reference files (FASTA, MAT) within a `data` directory in the project root before execution.
2. **Environment Management**: Always include the `--use-conda` flag. This allows WEPP to manage its internal Snakemake-based dependencies automatically.
3. **Resource Optimization**: When running multiple samples across different directories, use the `--conda-prefix` argument pointing to an existing `.snakemake` directory to avoid redundant environment creation.
4. **Pathogen Agnosticism**: While often used for SARS-CoV-2, WEPP can be applied to any pathogen (e.g., RSV-A) provided a Mutation-Annotated Tree (MAT) and a reference genome are supplied.

### Analyzing Results

- **Haplotype Abundances**: Check the output files for estimated proportions of specific strains.
- **Unaccounted Alleles**: Pay close attention to the outlier detection results. Alleles with high residue values often indicate the presence of a lineage or variant not yet represented in the reference tree.
- **Read Mapping**: Use the dashboard to inspect how individual reads are parsimoniously placed on the tree to validate low-abundance detections.



## Subcommands

| Command | Description |
|---------|-------------|
| wepp_detectpeaks | Detects Peaks from the MAT |
| wepp_sam2pb | Applies QC before running WEPP |

## Reference documentation
- [WEPP README](./references/github_com_TurakhiaLab_WEPP_blob_main_README.md)
- [WEPP Usage Guide](./references/turakhia_ucsd_edu_WEPP_usage.html.md)