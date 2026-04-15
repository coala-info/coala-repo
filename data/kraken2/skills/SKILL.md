---
name: kraken2
description: Kraken 2 is a high-speed taxonomic classifier that assigns biological labels to DNA sequences by matching k-mers against a genomic database. Use when user asks to build a taxonomic database, classify metagenomic reads, or generate taxonomic reports for downstream abundance estimation.
homepage: http://ccb.jhu.edu/software/kraken/
metadata:
  docker_image: "quay.io/biocontainers/kraken2:2.17.1--pl5321h077b44d_0"
---

# kraken2

## Overview
Kraken 2 is a high-speed taxonomic classifier that assigns biological labels to DNA sequences by matching k-mers against a genomic database. This skill helps you navigate the command-line interface for the entire workflow: from initial database construction (standard or custom) to the classification of FASTQ/FASTA files and the generation of standardized reports. It is particularly useful for metagenomic studies where rapid, memory-efficient identification of species, genera, or higher taxa is required.

## Core Workflows

### 1. Database Construction
Kraken 2 requires a database to function. You can either use a pre-built "MiniKraken" database or build a standard one.

**Standard Database Build:**
Requires significant disk space and RAM (typically >100GB).
```bash
# Download taxonomy and libraries (bacteria, viral, archaea)
kraken2-build --standard --threads 16 --db $DBNAME
```

**Custom Database Build:**
To include specific genomes (e.g., fungal, protozoan, or human):
```bash
# 1. Install taxonomy
kraken2-build --download-taxonomy --db $DBNAME

# 2. Add specific libraries
kraken2-build --download-library fungi --db $DBNAME
kraken2-build --download-library protozoa --db $DBNAME

# 3. Build the database
kraken2-build --build --threads 16 --db $DBNAME
```

### 2. Sequence Classification
Classify your reads against the prepared database.

**Basic Classification (Paired-end):**
```bash
kraken2 --db $DBNAME \
        --threads 16 \
        --paired \
        --check-names \
        --report sample_report.txt \
        --output sample_output.out \
        read1.fastq read2.fastq
```

**Key Flags:**
- `--report`: Generates a human-readable summary (essential for Bracken or Pavian).
- `--use-names`: Adds scientific names to the output file instead of just TaxIDs.
- `--memory-mapping`: Reduces RAM usage by mapping the DB from disk (slower).
- `--confidence`: Set a threshold (0.0 to 1.0) to reduce false positives. A value of 0.1–0.2 is often recommended for high-divergence samples.

### 3. Handling Low-Complexity Sequences
To minimize false positives caused by simple repeats (e.g., poly-A tails), it is a best practice to "dust" genomes during database builds.
- Ensure the `dustmasker` binary (from NCBI BLAST+) is in your PATH during the `--build` step.

## Expert Tips
- **Memory Management:** If the database is larger than your available RAM, Kraken 2 will struggle. Use the `--memory-mapping` flag or ensure your system has enough swap space, though physical RAM is always preferred for speed.
- **Downstream Analysis:** Always generate a report file (`--report`). This file is the required input for **Bracken** (to estimate species-level abundance) and **Pavian** (for visualization).
- **Long Reads:** For Nanopore or PacBio data, Kraken 2 works well, but consider adjusting the k-mer requirements if error rates are high.

## Reference documentation
- [Kraken CCB Software Overview](./references/ccb_jhu_edu_software_kraken.md)
- [Kraken2 Bioconda Package Summary](./references/anaconda_org_channels_bioconda_packages_kraken2_overview.md)