---
name: knock-knock
description: The knock-knock toolkit provides a specialized pipeline for characterizing the complex results of genome editing.
homepage: https://github.com/jeffhussmann/knock-knock
---

# knock-knock

## Overview
The knock-knock toolkit provides a specialized pipeline for characterizing the complex results of genome editing. Unlike standard variant callers, it makes minimal assumptions about read structure, instead using a parsimonious subset of local alignments to categorize every read. It is particularly effective for identifying large-scale shufflings, donor integrations, and unintended rearrangements in both short-read (Illumina) and long-read (PacBio CCS) datasets.

## Project Initialization
The tool operates on a centralized project directory structure.

- **Setup a new project**: Initialize a directory with example data to understand the required structure.
  ```bash
  knock-knock install_example_data PROJECT_DIR
  ```
- **Directory Structure**: Ensure your project follows this hierarchy:
  - `PROJECT_DIR/indices/`: Reference genomes and alignment indices.
  - `PROJECT_DIR/targets/`: CSV files defining sgRNAs, primers, and donors.
  - `PROJECT_DIR/data/`: Sequencing files and sample sheets.

## Reference Preparation
Before analysis, you must build indices for the target organism (hg38, mm10, or e_coli).

- **Build indices**:
  ```bash
  knock-knock build-indices PROJECT_DIR ORGANISM --num-threads 8
  ```
- **Custom Indices**: If you already have indices, create `PROJECT_DIR/index_locations.yaml` to point to existing paths instead of rebuilding them.

## Target Specification
Targets are defined by combining genomic locations with specific homology donors. You must populate the CSV files in the `targets/` folder:

1. **sgRNAs.csv**: Register the protospacer sequences.
2. **amplicon_primers.csv**: Define the primer pairs used for the experiment.
3. **donors.csv**: Provide sequences for HDR donors.
4. **targets.csv**: The master file linking the above components. Required columns: `name`, `genome`, `sgRNAs`, `amplicon_primers`, `donor_sequence`.

## Best Practices
- **Data Selection**: Use PacBio CCS data for amplicons in the kilobase range and paired-end Illumina for shorter amplicons (hundreds of base pairs).
- **Alignment Strategy**: knock-knock uses STAR, minimap2, and blastn. Ensure these are in your PATH if you installed via pip rather than conda.
- **Thread Management**: Index building is computationally intensive; always use the `--num-threads` flag on high-performance clusters to reduce processing time from hours to minutes.
- **Visualization**: After processing, use the built-in visualization tools to generate outcome-stratified amplicon length distributions and summary tables.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_jeffhussmann_knock-knock.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_knock-knock_overview.md)