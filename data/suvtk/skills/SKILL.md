---
name: suvtk
description: The suvtk toolkit streamlines the process of preparing and formatting uncultivated viral genomes for GenBank submission. Use when user asks to submit viral genomic assemblies to GenBank, predict genes in viral sequences using Pyrodigal-rv, or format metadata for uncultivated viral samples.
homepage: https://github.com/LanderDC/suvtk
---

# suvtk

## Overview
The Submission of Uncultivated Viral genomes toolkit (`suvtk`) is a specialized command-line utility designed to streamline the transition from viral genomic assemblies to formal GenBank submissions. It automates the technical hurdles of NCBI submission by integrating gene prediction (via Pyrodigal-rv) and metadata formatting, ensuring that uncultivated viral data meets the specific structural requirements of the GenBank database.

## Installation and Setup
Install `suvtk` via Bioconda for the most stable environment:
```bash
conda install bioconda::suvtk
```
For development or testing the latest features, install from the repository:
```bash
pip install -e .
```

## Core CLI Usage
The primary entry point for the tool is the `suvtk` command.

### Getting Help
Access the full list of subcommands and options:
```bash
suvtk --help
# OR
python -m suvtk --help
```

### ORF Prediction Patterns
`suvtk` uses `pyrodigal-rv` for robust gene calling in viral genomes. 
- **Phage Genomics**: When working with bacteriophages, ensure you utilize the phage-specific ORF prediction logic.
- **Translation Tables**: Recent versions (v0.1.6+) automatically determine the appropriate translation table via `pyrodigal-rv`, so manual specification is typically no longer required.

### Performance Optimization
- **Threading**: The tool defaults to `auto` for thread counts, which optimizes performance based on the available CPU resources. You do not need to manually specify thread counts unless you need to restrict the tool's footprint on a shared cluster.

### Data Preparation Best Practices
- **Metadata Validation**: `suvtk` includes a `safe_read_csv` function that validates ASCII characters. Ensure your metadata CSV files are encoded in standard ASCII to avoid submission errors.
- **Sequence Input**: Ensure your viral sequences are in standard FASTA format before processing.

## Expert Tips
- **Uncultivated Viruses**: The tool is specifically tuned for "uncultivated" viral genomes. If your sequences are from isolated cultures, verify if standard GenBank submission tools (like Table2asn) might be more appropriate, though `suvtk` handles the metadata overhead for environmental samples more efficiently.
- **Version Checking**: Use `suvtk --version` to ensure you are on at least v0.1.6, as this version includes critical updates to the ORF prediction engine and threading logic.



## Subcommands

| Command | Description |
|---------|-------------|
| suvtk download-database | Download and extract the TAR archive from the fixed Zenodo DOI. |
| suvtk gbk2tbl | This script converts a GenBank file (.gbk or .gb) into a Sequin feature table (.tbl), which is an input file of table2asn used for creating an ASN.1 file (.sqn). |
| suvtk table2asn | This command generates a .sqn file that you can send to gb-sub@ncbi.nlm.nih.gov |
| suvtk taxonomy | This command uses MMseqs2 to assign taxonomy to sequences using protein sequences from ICTV taxa in the nr database. |
| suvtk virus-info | This command provides info on potentially segmented viruses based on the taxonomy and also outputs a file with the genome type and genome structure for the MIUVIG structured comment. |
| suvtk_co-occurrence | Identify co-occurring sequences in an abundance table based on specified   thresholds. |
| suvtk_comments | Generate a structured comment file based on MIUVIG standards. |
| suvtk_features | Create feature tables for sequences from an input fasta file. |

## Reference documentation
- [suvtk Overview](./references/anaconda_org_channels_bioconda_packages_suvtk_overview.md)
- [suvtk GitHub Repository](./references/github_com_LanderDC_suvtk.md)
- [suvtk Commit History](./references/github_com_LanderDC_suvtk_commits_main.md)