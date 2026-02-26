---
name: kraken
description: Kraken is a high-speed taxonomic classifier that assigns DNA sequences to taxonomic labels using exact k-mer matches against a genomic database. Use when user asks to classify metagenomic reads, build custom taxonomic databases, or generate reports on the taxonomic distribution of sequencing data.
homepage: http://ccb.jhu.edu/software/kraken/
---


# kraken

## Overview
Kraken is a high-speed taxonomic classifier that uses exact k-mer matches against a genomic database to identify the origin of DNA sequences. It is particularly effective for metagenomic analysis where high throughput is required without sacrificing precision. This skill provides the necessary command-line patterns for database construction, sequence classification, and results processing.

## Core Workflows

### 1. Database Preparation
Kraken requires a database to function. You can use a pre-built "MiniKraken" database or build a custom one.

**Standard Database Build:**
```bash
# Download taxonomy and genomic libraries (Bacteria, Archaea, Viral)
kraken-build --standard --db $DBNAME

# Clean up intermediate files after build
kraken-build --clean --db $DBNAME
```

**Custom Database Build:**
```bash
# 1. Install taxonomy
kraken-build --download-taxonomy --db $DBNAME

# 2. Add specific FASTA files to library
kraken-build --add-to-library sequence.fasta --db $DBNAME

# 3. Build the database (set k-mer and minimizer lengths if needed)
kraken-build --build --db $DBNAME
```

### 2. Classifying Sequences
Classify FASTA or FASTQ files against a built database.

**Basic Classification:**
```bash
kraken --db $DBNAME sequences.fastq > output.kraken
```

**Common Options:**
- `--threads N`: Use multiple CPU cores.
- `--fastq-input`: Explicitly define input as FASTQ format.
- `--gzip-compressed`: Process gzipped input files directly.
- `--paired`: For paired-end reads (provide two files).
- `--output-dir`: Direct output to a specific directory.

### 3. Generating Reports
The raw output is a tab-delimited file. Use `kraken-report` to create a human-readable summary of the taxonomic distribution.

```bash
kraken-report --db $DBNAME output.kraken > report.txt
```

## Expert Tips & Best Practices

- **Memory Management**: Kraken loads the entire database into RAM. If you have limited memory, use the pre-built 4GB or 8GB "MiniKraken" databases.
- **Low-Complexity Filtering**: To reduce false positives, it is strongly recommended to run the `dust` program on genomes before building a custom database to mask low-complexity regions (e.g., long poly-A tails).
- **Quick Operation**: Use the `--quick` flag during classification to stop at the first k-mer hit, significantly increasing speed with a minor trade-off in sensitivity.
- **Downstream Analysis**: 
    - Use **Bracken** for more accurate species-level abundance estimation based on Kraken's initial classifications.
    - Use **Pavian** for interactive visualization of the classification results.
    - Use **KrakenTools** for filtering and manipulating Kraken output files.

## Reference documentation
- [Kraken Software Overview](./references/ccb_jhu_edu_software_kraken.md)
- [Bioconda Kraken Package](./references/anaconda_org_channels_bioconda_packages_kraken_overview.md)