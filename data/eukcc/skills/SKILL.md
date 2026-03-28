---
name: eukcc
description: EukCC estimates the completeness and contamination of eukaryotic genomes using marker gene sets. Use when user asks to set up the EukCC2 database, analyze single or batch genomic bins, adjust prevalence thresholds, or interpret quality reports for metagenome-assembled genomes.
homepage: https://github.com/Finn-Lab/EukCC/
---


# eukcc

## Overview

EukCC is a bioinformatics tool designed to estimate the completeness and contamination of microbial eukaryotic genomes, specifically those assembled from metagenomic data. It utilizes marker gene sets to provide quality metrics and taxonomic lineage assignments. Use this skill to guide users through database setup, single-bin analysis, batch processing of genomic bins, and interpreting quality reports to ensure the integrity of eukaryotic metagenome-assembled genomes (MAGs).

## Database Setup

EukCC requires a specific database (EukCC2) to function. Before running analysis, ensure the database is downloaded and the environment variable is set.

```bash
# Download and extract the database
wget http://ftp.ebi.ac.uk/pub/databases/metagenomics/eukcc/eukcc2_db_ver_1.2.tar.gz
tar -xzvf eukcc2_db_ver_1.2.tar.gz

# Set the required environment variable
export EUKCC2_DB=$(realpath eukcc2_db_ver_1.2)
```

## Common CLI Patterns

### Analyzing a Single Bin
Use the `single` subcommand when you have a specific FASTA file to evaluate.

```bash
eukcc single --out <output_dir> --db $EUKCC2_DB <input_bin.fasta>
```

### Batch Processing a Folder
Use the `folder` subcommand to process multiple bins stored in a single directory.

```bash
eukcc folder --out <output_dir> --db $EUKCC2_DB <input_folder>
```

### Adjusting Strictness
In EukCC v2, you can modify the prevalence threshold for marker sets. Increasing this value makes the completeness estimate more conservative.

```bash
# Example: Setting a specific prevalence threshold
eukcc single --prevalence 100 --out <output_dir> <input_bin.fasta>
```

## Interpreting Outputs

*   **eukcc.csv**: The primary results table containing completeness (%), contamination (%), and assigned taxonomy.
*   **merged_bins.csv**: (Folder mode only) Details on refined bins that were merged during the process.
*   **bad_quality.csv**: Contains bins where the marker gene set is supported by less than 50% of alignments; these results should be treated with caution.
*   **missing_marker_genes.txt**: Lists bins for which no appropriate marker gene set could be identified.

## Expert Tips and Best Practices

*   **Avoid Circularity**: Do not use EukCC on genomes that were used to train the marker gene sets. Check the database file `db_base/backbone/base_taxinfo.csv` to see if your accessions were part of the training data.
*   **Debugging**: If a run fails, use the `--debug` flag to generate a detailed log. This is essential for troubleshooting exit codes like `201` (No marker set defined) or `204` (Zero proteins predicted).
*   **Resource Management**: EukCC relies on several heavy dependencies (metaEUK, HMMER, pplacer). Ensure these are in your PATH. Using the official Docker/Singularity containers is the recommended way to avoid dependency conflicts.
*   **Exit Code Reference**:
    *   `200`: File not found.
    *   `201`: No Marker gene set could be defined.
    *   `204`: Predicted zero proteins (check if input is actually eukaryotic or if gene prediction failed).



## Subcommands

| Command | Description |
|---------|-------------|
| eukcc define_set | Define sets of genomes based on marker prevalence. |
| eukcc folder | eukcc folder: error: the following arguments are required: binfolder |
| eukcc single | eukcc single: error: the following arguments are required: fasta |

## Reference documentation
- [EukCC GitHub Repository](./references/github_com_EBI-Metagenomics_EukCC.md)
- [EukCC README](./references/github_com_EBI-Metagenomics_EukCC_blob_master_README.md)