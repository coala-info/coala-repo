---
name: krakenhll
description: KrakenUniq (formerly KrakenHLL) is a metagenomics classifier that improves upon the original Kraken algorithm by adding an assessment of unique k-mer coverage.
homepage: https://github.com/fbreitwieser/krakenhll
---

# krakenhll

## Overview

KrakenUniq (formerly KrakenHLL) is a metagenomics classifier that improves upon the original Kraken algorithm by adding an assessment of unique k-mer coverage. While standard Kraken counts total k-mer matches, KrakenUniq uses the HyperLogLog probabilistic estimator to count how many distinct k-mers from a reference genome are present in the query. This allows researchers to differentiate between a true positive (where k-mers are spread across the genome) and a false positive (where many reads match a single repetitive or non-specific region).

## Installation

Install via Bioconda:
```bash
conda install -c bioconda krakenuniq
```

## Common CLI Patterns

### Basic Classification
KrakenUniq automatically detects input formats (FASTA/FASTQ) and compression (GZIP/BZIP2).
```bash
krakenuniq --db <database_path> reads.fastq.gz > output.kraken
```

### Paired-End Reads
Use the `--paired` flag for paired-end data.
```bash
krakenuniq --db <database_path> --paired forward.fastq reverse.fastq > output.kraken
```

### Memory Management
KrakenUniq offers three modes for handling large databases:

1.  **Standard (Memory Mapping)**: Default mode. Uses less RAM but is slower due to disk I/O.
2.  **Full Preload**: Use when RAM is larger than the database size. Dramatically increases speed (often 20x).
    ```bash
    krakenuniq --db <database_path> --preload reads.fastq
    ```
3.  **Chunked Preload**: Use on low-memory machines (e.g., laptops with 16GB RAM). Processes the database in chunks.
    ```bash
    krakenuniq --db <database_path> --preload-size 8G reads.fastq
    ```

## Database Building

Building a database requires Jellyfish version 1.
```bash
# Standard build command
krakenuniq-build --db <db_name> --threads <num>
```

**Expert Tips for Building:**
- Use the `-j` switch during installation or building to ensure Jellyfish 1 is correctly linked.
- If building large databases, ensure `--work-on-disk` is used if temporary RAM is limited.
- Pre-built databases (Standard RefSeq or Eukaryotic Pathogens) are available via the Amazon cloud (Ben Langmead's indexes).

## Best Practices

- **Interpret Unique K-mer Counts**: When reviewing reports, look at the `unique_kmers` column. A high number of total reads but a very low number of unique k-mers often indicates a false positive caused by a contaminant or a low-complexity region.
- **Performance**: Always prefer `--preload` if the server has sufficient RAM. If the process hangs or "swaps" excessively, switch to `--preload-size`.
- **Version Consistency**: Ensure the database version matches the KrakenUniq version, especially when moving between v0.x and v1.x.

## Reference documentation
- [KrakenUniq GitHub Repository](./references/github_com_fbreitwieser_krakenuniq.md)
- [Bioconda KrakenHLL Overview](./references/anaconda_org_channels_bioconda_packages_krakenhll_overview.md)