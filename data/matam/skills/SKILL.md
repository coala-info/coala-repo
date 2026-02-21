---
name: matam
description: MATAM (Mapping-Assisted Targeted-Assembly for Metagenomics) is a specialized bioinformatic tool designed to reconstruct complete marker genes from short-read metagenomic datasets.
homepage: https://github.com/bonsai-team/matam
---

# matam

## Overview

MATAM (Mapping-Assisted Targeted-Assembly for Metagenomics) is a specialized bioinformatic tool designed to reconstruct complete marker genes from short-read metagenomic datasets. While standard metagenomic assemblers often struggle with closely related species or conserved regions, MATAM uses a reference-guided approach to recruit reads belonging to specific markers and then performs a targeted assembly. This results in high-quality, full-length sequences suitable for precise taxonomic identification and abundance estimation.

## Installation and Setup

The recommended way to install MATAM is via Conda using the Bioconda channel:

```bash
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda install matam
```

## Database Preparation

Before running an assembly, you must prepare a reference database. MATAM provides a default SSU rRNA database based on SILVA 128.

### Using the Default Database
To index the provided SSU rRNA database, specify a directory for storage and the memory limit (in MB):

```bash
index_default_ssu_rrna_db.py -d /path/to/db_dir --max_memory 10000
```

### Using a Custom Database
If working with markers other than 16S rRNA, prepare a custom FASTA database:

```bash
matam_db_preprocessing.py -i ref_db.fasta -d /path/to/db_dir --cpu 4 --max_memory 10000 -v
```

## Assembly Workflows

The core functionality is handled by `matam_assembly.py`.

### Standard De-novo Assembly
To reconstruct full-length sequences from a FASTQ file:

```bash
matam_assembly.py -d /path/to/db_dir/SILVA_128_SSURef_NR95 -i reads.fastq --cpu 8 --max_memory 10000 -v
```
*Note: The `-d` argument requires the common prefix of the database files (e.g., `SILVA_128_SSURef_NR95` for the default).*

### Assembly with Taxonomic Assignment
To include taxonomic classification and abundance estimation (using the RDP classifier):

```bash
matam_assembly.py -d /path/to/db_dir/prefix -i reads.fastq --cpu 8 --max_memory 10000 -v --perform_taxonomic_assignment
```

## Sample Comparison

If you have processed multiple samples with taxonomic assignment enabled, you can generate a contingency table to compare abundances:

```bash
matam_compare_samples.py -s samples_list.tsv -t contingency_table.tsv -c comparison_table.tsv
```
The `samples_list.tsv` should be a tab-separated file containing:
`SampleName    /path/to/final_assembly.fa    /path/to/rdp.tab`

## Expert Tips and Best Practices

- **Memory Management**: MATAM recommends at least 10GB of RAM. If running on a resource-constrained system, use `--max_memory 4000` (4GB), but be aware that performance and assembly quality may degrade.
- **Input Requirements**: Ensure FASTQ identifiers are unique and scores are Phred+33 encoded.
- **Parallelization**: Use the `--cpu` flag to match your hardware; many steps in the MATAM pipeline are highly parallelized.
- **Taxonomy Limitations**: The `--perform_taxonomic_assignment` flag uses the RDP classifier with the "16srrna" model by default. If you are using a custom database for a different marker, the taxonomic assignment step may not be appropriate.
- **Output Files**: The primary output is `final_assembly.fa`, which contains the reconstructed marker sequences.

## Reference documentation
- [MATAM GitHub Repository](./references/github_com_bonsai-team_matam.md)
- [Bioconda MATAM Overview](./references/anaconda_org_channels_bioconda_packages_matam_overview.md)