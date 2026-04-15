---
name: ncbitk
description: ncbitk automates the retrieval, synchronization, and curation of bacterial genomic data from GenBank. Use when user asks to download bacterial sequences, update local genome collections, or check the status of genomic datasets.
homepage: https://github.com/andrewsanchez/NCBITK
metadata:
  docker_image: "quay.io/biocontainers/ncbitk:1.0a17--py_0"
---

# ncbitk

## Overview
`ncbitk` (NCBI Tool Kit) is a specialized command-line utility for bioinformaticians managing local repositories of bacterial genomic data. It automates the process of retrieving sequences from GenBank via rsync, ensuring that local collections remain synchronized with the most recent NCBI assembly versions. Beyond simple downloads, it provides curation features that rename FASTA files using descriptive information from assembly summaries and taxonomy dumps, making large-scale genomic datasets more manageable and human-readable.

## Installation and Requirements
The tool is primarily distributed via Bioconda and requires `rsync` (tested with version 3.1.2, protocol 31) for data transfer.

```bash
# Installation via Conda
conda install bioconda::ncbitk

# Installation via Pip
pip install ncbitk
```

## Common CLI Patterns

### Initializing or Updating a Collection
To download all available GenBank bacteria or to synchronize an existing local directory with the latest NCBI releases:

```bash
ncbitk [target_directory] --update
```
*Note: This command will remove deprecated genomes that are no longer present in the NCBI assembly summary and replace them with current versions.*

### Targeted Species Retrieval
To download genomes for a specific bacterial species, use the `--species` flag. The species name must match the directory naming convention used on the NCBI FTP server (using underscores).

```bash
ncbitk [target_directory] --species Escherichia_coli --update
```

### Collection Auditing
To check the current state of your local genome collection without performing any downloads or deletions:

```bash
ncbitk [target_directory] --status
```
This provides a summary including:
- Total number of genomes currently stored.
- Number of missing genomes compared to the latest assembly summary.
- Number of deprecated genomes that should be updated or removed.

## Expert Tips and Best Practices
- **Species Name Accuracy**: When using the `--species` flag, ensure the string matches the exact directory name found at `ftp://ftp.ncbi.nlm.nih.gov/genomes/genbank/bacteria/`. Incorrect casing or spacing will result in failed lookups.
- **Rsync Dependency**: Since `ncbitk` relies on `rsync` for synchronization, ensure your environment has a stable network connection to NCBI's servers and that `rsync` is in your system PATH.
- **Curation Logic**: The tool automatically renames FASTA files to be more descriptive. This is highly beneficial for downstream pipelines where generic NCBI accession numbers (e.g., GCA_000...) are difficult to track.
- **Bacterial Focus**: Currently, `ncbitk` is strictly optimized for bacterial genomes. Do not attempt to use it for viral, fungal, or eukaryotic datasets as the internal logic relies on the bacterial assembly summary structure.

## Reference documentation
- [ncbitk - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ncbitk_overview.md)
- [GitHub - andrewsanchez/NCBITK: A tool kit for curating genomes from NCBI](./references/github_com_andrewsanchez_NCBITK.md)