---
name: tiptoft
description: TipToft is a specialized tool designed to predict plasmid content without the need for prior genome assembly.
homepage: https://github.com/andrewjpage/tiptoft
---

# tiptoft

## Overview
TipToft is a specialized tool designed to predict plasmid content without the need for prior genome assembly. By utilizing k-mer matching against the PlasmidFinder database, it identifies plasmid replicons and incompatibility groups even in high-error long reads. This approach is significantly faster than assembly-based methods and helps validate assembly completeness or guide targeted plasmid reconstruction.

## Database Preparation
Before running the main analysis, you must have the PlasmidFinder database. While a snapshot is often bundled, it is best practice to download the latest version.

```bash
# Download the latest PlasmidFinder database
tiptoft_database_downloader
```
This generates `plasmid_files.fa` in your current directory.

## Common CLI Patterns

### Basic Analysis
Run TipToft on a single FASTQ file (can be gzipped) to output results to the terminal:
```bash
tiptoft my_reads.fastq.gz
```

### Saving Results and Extracting Reads
To save the tabular results to a file and extract the specific reads that matched plasmid sequences (useful for downstream targeted assembly):
```bash
tiptoft -o plasmid_predictions.txt -f matching_reads.fastq my_reads.fastq.gz
```

### Using a Custom Database
If you have a specific or updated database file:
```bash
tiptoft --plasmid_data path/to/plasmid_files.fa my_reads.fastq.gz
```

## Expert Tips and Parameter Tuning

### Adjusting Sensitivity
*   **Coverage Threshold (`-c` / `--min_perc_coverage`):** The default is 85%. If you suspect highly divergent plasmids or are working with extremely noisy data, you might lower this (e.g., `-c 70`), though this increases the risk of false positives.
*   **K-mer Size (`-k` / `--kmer`):** The default is 13. Smaller k-mers increase sensitivity but significantly increase memory usage and runtime. Larger k-mers increase specificity but may fail on very high-error reads.

### Handling High Error Rates
If the default settings fail to detect expected plasmids in very noisy Nanopore data:
*   Decrease `--min_fasta_hits` (default 10) to allow detection with fewer k-mer matches.
*   Decrease `--min_kmers_for_onex_pass` (default 10) to make the initial filtering pass less stringent.

### Performance Optimization
TipToft is highly efficient (~80MB RAM for 800MB of data). For large datasets, use the `-p` (print interval) flag to monitor progress:
```bash
tiptoft -p 1000 my_reads.fastq.gz
```

## Reference documentation
- [TipToft GitHub Repository](./references/github_com_andrewjpage_tiptoft.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_tiptoft_overview.md)