---
name: dudes
description: DUDes is a taxonomic profiler that converts sequence alignment data into microbial community compositions using a distribution-based approach. Use when user asks to perform metagenomic profiling from SAM files, analyze metaproteomic data from protein alignments, or create custom taxonomic databases.
homepage: https://github.com/pirovc/dudes
metadata:
  docker_image: "quay.io/biocontainers/dudes:0.10.0--pyhdfd78af_0"
---

# dudes

## Overview
DUDes is a top-down taxonomic profiler that transforms sequence alignment data into biological insights. It processes read mappings against a reference database to determine the taxonomic composition of metagenomic or metaproteomic samples. By utilizing a distribution-based approach, it effectively handles the ambiguity of reads that map to multiple organisms, providing a more accurate representation of the microbial community.

## Installation
Install via Bioconda for the most stable environment:
```bash
conda install -c bioconda dudes
```

## Core CLI Usage

### Metagenomic Profiling (SAM Input)
When using DNA read mappers like Bowtie2, ensure the SAM file contains header information (`@SQ`) and mismatch tags (`NM:i`).
```bash
dudes -s mapping_output.sam -d database.npz -o results_prefix
```

### Metaproteomic Profiling (Custom BLAST/Diamond Input)
For protein-level alignments, use the `-c` flag. The input must be a TSV with specific columns: `qseqid`, `sseqid`, `slen`, `sstart`, `evalue`.
```bash
# Example using Diamond to generate compatible input
diamond blastp -q peptides.fasta -d db.dmnd --outfmt 6 qseqid sseqid slen sstart evalue -o mapping.tsv

# Run DUDes
dudes -c mapping.tsv -d database.npz -o results_prefix
```

## Database Management with dudesdb
To create a custom database, you need the reference FASTA and NCBI taxonomy files (`nodes.dmp`, `names.dmp`, and an accession-to-taxid mapping file).

```bash
dudesdb -m 'av' -f references.fasta -n nodes.dmp -a names.dmp -g nucl_gb.accession2taxid -t 8 -o custom_db
```

**Header Modes (`-m`):**
- `av`: New NCBI headers (Accession.Version)
- `gi`: Legacy NCBI headers (GI numbers)
- `up`: UniProt headers

## Expert Tips & Parameters
- **Taxonomic Depth**: Use `-l` to set the lowest rank (e.g., `genus`, `family`, `species`, `strain`). The default is `species`.
- **Filtering Multi-matches**: Use `-m` to filter reads based on the number of matches. A value between 0 and 1 acts as a percentile; values >= 1 act as a hard count.
- **Sensitivity**: Adjust `-a` (minimum reference matches) to filter out low-confidence hits. The default is 0.001 (0.1% of matches).
- **SAM Format**: If your SAM file uses extended CIGAR strings instead of the NM flag for mismatches, use `-i ex`.
- **Starting Rank**: Use `-x` to specify a starting TaxID if you only want to analyze a specific subtree (default is 1 for root).

## Reference documentation
- [DUDes GitHub Repository](./references/github_com_pirovc_dudes.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_dudes_overview.md)