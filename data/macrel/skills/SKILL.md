---
name: macrel
description: Macrel is a comprehensive pipeline designed for the classification and retrieval of antimicrobial peptides (AMPs) from (meta)genomic data.
homepage: https://github.com/BigDataBiology/macrel
---

# macrel

## Overview

Macrel is a comprehensive pipeline designed for the classification and retrieval of antimicrobial peptides (AMPs) from (meta)genomic data. It employs machine learning models to predict whether a sequence functions as an AMP and further assesses its potential hemolytic activity. The tool is versatile, handling inputs ranging from raw sequencing reads to assembled contigs and protein FASTA files. Beyond prediction, Macrel facilitates the discovery of known peptides by interfacing with the AMPSphere database, making it a vital tool for researchers in drug discovery and microbiome analysis.

## Command Line Usage

Macrel uses a subcommand-based interface. The general syntax is `macrel COMMAND [OPTIONS]`.

### 1. Peptide Prediction
Use this when you have a set of amino acid sequences and want to predict their AMP potential and hemolytic activity.

```bash
macrel peptides --fasta input_peptides.faa --output out_peptides
```

### 2. Contig Analysis
Use this for assembled nucleotide sequences. Macrel will predict small genes (≤ 100 amino acids) and then classify them.

```bash
macrel contigs --fasta assembly.fna --output out_contigs
```

### 3. Metagenomic Reads
Use this to process raw short reads. This mode performs assembly/gene prediction internally before classification.

```bash
# For paired-end reads
macrel reads -1 R1.fq.gz -2 R2.fq.gz --output out_metag --outtag sample_name

# For single-end reads
macrel reads -1 single.fq.gz --output out_metag
```

### 4. Abundance Profiling
Use this to map short reads against a reference set of peptides to determine their abundance in a sample.

```bash
macrel abundance -1 reads.fq.gz --fasta reference_peptides.faa --output out_abundance
```

### 5. Querying AMPSphere
Use this to check if your sequences match known AMPs in the AMPSphere database.

```bash
# Exact matching via API (requires internet)
macrel query-ampsphere --fasta peptides.faa --output out_query

# Approximate matching using MMSeqs2 or HMMER
macrel query-ampsphere --query-mode mmseqs --fasta peptides.faa --output out_query

# Local execution (downloads database on first run)
macrel query-ampsphere --local --fasta peptides.faa --output out_query
```

## Expert Tips and Best Practices

- **Probability Interpretation**: Macrel considers any peptide with a probability (p) > 0.5 as an AMP. However, for high-confidence candidates, prioritize sequences with probabilities closer to 1.0.
- **Hemolytic Activity**: Always check the hemolytic activity prediction columns in the output table to filter out peptides that might be toxic to host cells.
- **Resource Management**: For large metagenomic datasets, ensure you have sufficient disk space for intermediate files generated during the `reads` and `contigs` subcommands.
- **Database Updates**: When using `query-ampsphere --local`, Macrel caches the database. If you need to ensure you are using the latest version of AMPSphere, check the documentation for cache clearing or redownload triggers.
- **Input Formats**: Macrel natively supports compressed FASTA and FASTQ files (.gz, .bz2, .xz), which saves significant disk space when handling large-scale metagenomic data.

## Reference documentation
- [Macrel GitHub Repository](./references/github_com_BigDataBiology_macrel.md)
- [Macrel Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_macrel_overview.md)
- [Macrel Version History](./references/github_com_BigDataBiology_macrel_tags.md)