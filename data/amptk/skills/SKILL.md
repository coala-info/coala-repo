---
name: amptk
description: AMPtk is a specialized suite designed to automate the preprocessing, clustering, and taxonomic classification of amplicon sequencing data. Use when user asks to process raw amplicon reads, remove chimeras, generate OTUs or ASVs using DADA2 or UNOISE3, and assign taxonomy to fungal or bacterial datasets.
homepage: https://github.com/nextgenusfs/amptk
---


# amptk

## Overview

AMPtk (Amplicon ToolKit) is a specialized suite designed to handle the complexities of amplicon sequencing analysis. It automates the transition from raw sequencing data to biological insights by providing tools for data preprocessing, chimera removal, and taxonomic classification. It is particularly well-regarded for its handling of fungal datasets and its ability to integrate various clustering algorithms like DADA2 and UNOISE3 into a unified workflow.

## Core CLI Workflows

### Installation and Setup
Install the toolkit via Bioconda and initialize the necessary reference databases.
- Install: `conda install -c bioconda amptk`
- Setup databases: `amptk database` (Required for taxonomic assignment and region extraction).

### Data Preprocessing and Filtering
Clean raw reads and prepare them for clustering.
- Use `amptk filter` to perform quality trimming and remove low-quality reads.
- Use the `-i` flag for input files and `-o` for the output prefix.
- If working with negative controls, utilize the `--negatives` flag to identify and manage potential contaminants.

### Clustering and Denoising
Generate Operational Taxonomic Units (OTUs) or Amplicon Sequence Variants (ASVs).
- **DADA2**: Use for high-resolution ASV generation. Supports `--pseudopooling` for increased sensitivity in detecting rare variants across samples.
- **UNOISE3**: Use for rapid denoising and dereplication.
- Adjust the `--minsize` parameter (default is often 2) to filter out rare sequences that may be artifacts.

### Taxonomic Assignment
Assign biological identities to your sequences.
- Use `amptk taxonomy` (or the `tax` alias) to run the classification pipeline.
- Specify custom databases using the `--sintax_db` option if the default UNITE or SILVA databases are insufficient for your specific study.
- Ensure the `amptk database` step was completed successfully to avoid "NoneType" errors during classification.

## Expert Tips and Best Practices

- **Database Maintenance**: If you encounter errors calling `amptk-extract_region.py`, verify your installation path or re-run the `amptk database` command to ensure all helper scripts are correctly linked.
- **Mock Communities**: Validate your pipeline's accuracy by including mock community samples (e.g., `amptk_mock2.fa`) and comparing the output against known compositions.
- **Multiprocessing**: For large datasets, ensure your environment supports Python 3.7+ multiprocessing to take advantage of parallel processing during the filtering and clustering stages.
- **SRA Submission**: Use the `amptk sra` command with the `-p illumina3` option to format your data correctly for submission to the NCBI Sequence Read Archive.

## Reference documentation

- [AMPtk Overview](./references/anaconda_org_channels_bioconda_packages_amptk_overview.md)
- [AMPtk GitHub Repository](./references/github_com_nextgenusfs_amptk.md)
- [Known Issues and Troubleshooting](./references/github_com_nextgenusfs_amptk_issues.md)
- [Development History and Feature Updates](./references/github_com_nextgenusfs_amptk_commits_master.md)