---
name: deacon
description: Deacon is a high-performance bioinformatics tool for the rapid classification, extraction, or depletion of DNA sequences using SIMD-accelerated minimizer comparisons. Use when user asks to classify DNA sequences without alignment, remove host contamination from metagenomic datasets, or search for specific target sequences within large genomic catalogs.
homepage: https://github.com/bede/deacon
---


# deacon

## Overview
Deacon is a high-performance bioinformatics tool designed for the rapid classification of DNA sequences without the need for full alignment. By utilizing SIMD-accelerated minimizer comparisons, it can process gigabases of sequence data per second. Its primary function is to either extract sequences that match a reference index (search mode) or filter them out (deplete mode). This makes it an essential tool for "cleaning" metagenomic datasets by removing host contamination or identifying specific targets within massive sequence catalogs.

## Installation
Deacon can be installed via Conda or built from source using Cargo:

```bash
# Via Conda
conda install -c bioconda deacon

# Via Cargo (requires Rust 1.88+)
RUSTFLAGS="-C target-cpu=native" cargo install deacon
```

## Indexing
Before filtering, you must either build a custom index or fetch a pre-built one.

### Fetching Pre-built Indexes
Deacon provides validated pangenome indexes for common hosts:
- `panhuman-1`: Human pangenome (HPRC + CHM13 + GRCh38)
- `panmouse-1`: Mouse genome (GRCm39)

```bash
deacon index fetch panhuman-1
```

### Building Custom Indexes
To search for specific genes or genomes, build an index from a FASTA file:
```bash
deacon index build targets.fa > targets.idx
```
*Note: Indexing a 3Gbp genome takes ~30s and requires ~18GB RAM, but filtering only uses ~5GB.*

## Filtering Operations
The `filter` command is the core of the tool. It detects compression (gz, zst, xz) automatically by file extension.

### Host Depletion (Removing Matches)
Use the `-d` or `--deplete` flag to output only sequences that **do not** match the index.

```bash
# Single-end reads
deacon filter -d panhuman-1.k31w15.idx reads.fq.gz -o clean_reads.fq.gz

# Paired-end reads
deacon filter -d panhuman-1.k31w15.idx r1.fq.gz r2.fq.gz -o clean.r1.fq.gz -O clean.r2.fq.gz
```

### Sequence Search (Keeping Matches)
Omit the `-d` flag to output only sequences that match the index.

```bash
deacon filter amr-genes.idx metagenome.fa.zst > hits.fa
```

## Tuning Sensitivity and Specificity
Matching is controlled by two thresholds. A sequence matches if it exceeds **both**:
1.  **Absolute Threshold (`-a`)**: Number of shared distinct minimizers (default: 2).
2.  **Relative Threshold (`-r`)**: Fraction of shared distinct minimizers (default: 0.01 or 1%).

### Expert Patterns
- **Maximum Sensitivity**: Set thresholds to the lowest possible values to catch any trace of the target.
  `deacon filter -d -a 1 -r 0 ...`
- **High Specificity**: Increase the relative threshold to ensure only strong matches are filtered.
  `deacon filter -d -r 0.1 ...` (Requires 10% shared minimizers)

## Performance and Workflow Integration
- **Piping**: Deacon fully supports stdin and stdout for integration into pipelines.
  `zcat reads.fq.gz | deacon filter -d human.idx - > clean.fq`
- **Summary Output**: Generate a JSON report of filtering statistics using `-s`.
  `deacon filter -d human.idx reads.fq -o clean.fq -s summary.json`
- **Privacy**: Use `--rename` to anonymize sequence headers in the output.

## Reference documentation
- [Deacon GitHub Repository](./references/github_com_bede_deacon.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_deacon_overview.md)