---
name: krakenuniq
description: "KrakenUniq is a specialized metagenomics classifier that builds upon the speed of the original Kraken tool while adding a critical layer of validation: unique k-mer counting."
homepage: https://github.com/fbreitwieser/krakenuniq
---

# krakenuniq

## Overview

KrakenUniq is a specialized metagenomics classifier that builds upon the speed of the original Kraken tool while adding a critical layer of validation: unique k-mer counting. In metagenomic samples, false positives often occur when a few highly conserved k-mers are matched to a taxon. KrakenUniq solves this by tracking how many *distinct* k-mers from a reference genome are found in your sample. This allows you to distinguish between a true positive (high unique k-mer count) and a false positive caused by contamination or low-complexity sequences (low unique k-mer count).

## Installation

The recommended way to install KrakenUniq is via Bioconda:

```bash
conda install -c bioconda krakenuniq
```

## Classification Workflows

KrakenUniq automatically detects input formats (FASTA/FASTQ) and compression (Gzip/Bzip2).

### Standard Classification
For most users with sufficient RAM to hold the database:

```bash
krakenuniq --db <path_to_db> --threads 16 --report-file report.tsv reads.fastq.gz > classification.out
```

### Memory-Optimized Classification
If your database is larger than your available RAM, use the `--preload-size` option to process the database in chunks. This is significantly faster than relying on system swap space.

```bash
# Example for a machine with 16GB RAM
krakenuniq --db <path_to_db> --preload-size 12G --threads 8 reads.fastq.gz > classification.out
```

### Paired-End Reads
Use the `--paired` flag for paired-end data. KrakenUniq handles the pairing logic automatically.

```bash
krakenuniq --db <path_to_db> --paired read_1.fq read_2.fq --report-file report.tsv > classification.out
```

## Database Management

### Downloading Pre-built Databases
Avoid building large databases from scratch if possible. Standard databases (RefSeq bacteria, archaea, viruses, human) are available via the Langmead lab indexes.

### Building a Custom Database
If you must build a database, ensure Jellyfish 1.x is installed, as KrakenUniq requires it for k-mer counting.

```bash
# 1. Download taxonomy and genomic data
krakenuniq-download --db custom_db taxonomy
krakenuniq-download --db custom_db refseq/bacteria

# 2. Build the database (forcing preload for speed)
krakenuniq-build --db custom_db --threads 24 --preload
```

## Interpreting Results

The KrakenUniq report (`--report-file`) contains columns not found in standard Kraken:

1.  **taxReads**: Number of reads assigned to this taxon.
2.  **kmers**: Total number of k-mer matches.
3.  **unique**: Number of unique k-mers found (the most important metric for specificity).
4.  **dup**: Average number of times each unique k-mer was seen.
5.  **cov**: Fraction of the target genome covered by unique k-mers.

**Expert Tip**: When analyzing low-abundance pathogens, look for a high "unique" k-mer count relative to the "taxReads". If a taxon has many reads but very few unique k-mers, it is likely a false positive.

## Performance Optimization

*   **RAM vs. Disk**: Always use `--preload` if your RAM is larger than the database file. This can result in a 20x speedup compared to memory-mapping from disk.
*   **Thread Scaling**: KrakenUniq scales well with threads, but performance gains often plateau after 16-24 threads depending on disk I/O speeds.
*   **Temporary Files**: If building a database, use `--work-on-disk` if you are constrained by RAM during the build phase.

## Reference documentation
- [KrakenUniq GitHub Repository](./references/github_com_fbreitwieser_krakenuniq.md)
- [Bioconda KrakenUniq Overview](./references/anaconda_org_channels_bioconda_packages_krakenuniq_overview.md)