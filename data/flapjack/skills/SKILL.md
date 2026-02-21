---
name: flapjack
description: Flapjack is a high-performance tool designed for the interactive visualization and analysis of large-scale genotyping data.
homepage: https://ics.hutton.ac.uk/flapjack
---

# flapjack

## Overview
Flapjack is a high-performance tool designed for the interactive visualization and analysis of large-scale genotyping data. It excels at rendering SNP data in real-time, allowing for rapid navigation across lines, markers, and chromosomes. Beyond visualization, it provides specialized analysis modules for plant breeding, including marker-assisted backcrossing (MABC), pedigree verification, and similarity matrix calculations.

## Command Line Usage
Flapjack provides command-line utilities for headless project creation and batch processing, which is essential for integrating Flapjack into automated bioinformatics pipelines.

### Project Creation
Use the `CreateProject` utility to convert raw data files into a Flapjack project format (.flapjack).

- **Basic Input**: Requires map, genotype, and optionally trait/phenotype files.
- **Batch Processing**: Use `CreateProjectBatch` when you have an input file containing paths to multiple map/genotype/trait files for bulk loading.
- **Key Flags**:
  - `-N`: Forces the use of the nucleotide (0/1) color scheme regardless of the underlying data type.
  - `-K`: Advanced loading options (replaces the older `-C` option).
  - `-decimalEnglish`: Forces the use of English-style decimal separators (period instead of comma).

### Data Formats and Integration
- **Genotype Data**: Supports standard tab-delimited formats, VCF (via converter), and direct loading of Intertek-formatted genotype files.
- **QTL Data**: Supports GOBii-QTL file formats. Use the `_#NUM` or `_#CAT` suffixes in column headers to explicitly define trait data types as numerical or categorical.
- **BrAPI**: Supports Breeding API (BrAPI) v2.0 for importing data directly from compliant databases.

## Analysis Modules
Flapjack includes several deterministic analysis modules that can be triggered to generate statistics and decision-support data:

- **MABC (Marker Assisted Back Crossing)**: Generates statistics to help with backcrossing programs, including QTL allele counts.
- **Pedigree Verification (PedVer)**:
  - **PedVerF1s**: Specifically for verifying F1 hybrids. Supports automated selection of "True F1s" based on threshold settings.
  - **PedVerLines**: For verifying the purity of lines.
- **Forward Breeding**: Supports "Indexed Forward Breeding" using GOBii-QTL files to calculate breeding values.
- **PCoA**: Runs Principal Coordinate Analysis to visualize genetic distances between lines.

## Best Practices
- **Memory Management**: For extremely large datasets, use the command-line project creators to generate `.flapjack` files before opening them in the GUI to reduce overhead.
- **Color Schemes**: Use the "Similarity to each Parent" or "Similarity to Either Parent" schemes when performing pedigree or F1 verification to visually identify recombination events.
- **Batch Summaries**: When running batch analyses, Flapjack generates a summary tab; this data can be exported as tab-delimited text for further processing in R or Excel.

## Reference documentation
- [Flapjack Release Notes](./references/ics_hutton_ac_uk_flapjack_download-flapjack_flapjack-release-notes.md)
- [Flapjack Overview](./references/ics_hutton_ac_uk_flapjack.md)
- [Bioconda Flapjack](./references/anaconda_org_channels_bioconda_packages_flapjack_overview.md)