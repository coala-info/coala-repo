---
name: dicey
description: Dicey is a bioinformatics tool used for simulating PCR reactions, designing molecular probes, and performing rapid sequence searches against indexed reference genomes. Use when user asks to simulate in-silico PCR, design padlock probes for mRNA imaging, search for specific nucleotide sequences, or predict off-target primer binding.
homepage: https://github.com/gear-genomics/dicey
metadata:
  docker_image: "quay.io/biocontainers/dicey:0.3.4--h4d20210_0"
---

# dicey

## Overview

Dicey is a high-performance bioinformatics tool used for simulating PCR reactions and designing molecular probes. It allows for rapid sequence searching within large, indexed reference genomes at specific edit or Hamming distances. By modeling primer melting temperatures and binding kinetics, it predicts both intended amplicons and unintended off-target products. Additionally, it supports specialized workflows like padlock probe design for in-situ sequencing and mRNA imaging.

## Command Line Usage

### Genome Indexing
Searching large genomes requires a pre-built index. This step is performed once per reference.
- **Requirement**: The genome must be bgzip compressed.
- **Command**: `dicey index -o <output.fm9> <reference.fa.gz>`
- **Note**: Ensure you also have a FAI index (`samtools faidx reference.fa.gz`) in the same directory.

### Sequence Searching (Hunt)
Use the `hunt` command to find specific nucleotide sequences.
- **Basic Search**: `dicey hunt -g <reference.fa.gz> <sequence>`
- **Output Handling**: Dicey outputs JSON by default. Use the provided helper script for human-readable text:
  `dicey hunt -g <reference.fa.gz> <sequence> | python scripts/json2txt.py`

### In-Silico PCR (Search)
Simulate PCR for a pair or set of primers to find amplicons and off-targets.
- **Input**: A FASTA file containing primer sequences.
- **Command**: `dicey search -c 45 -g <reference.fa.gz> <primers.fa>`
- **Parameters**:
  - `-c`: Specifies the annealing temperature (e.g., 45°C).
  - `-i`: If the tool cannot find the primer3 configuration, point it to the source directory: `-i dicey/src/primer3_config/`.

### Padlock Probe Design
Design probes for imaging mRNA in single cells.
- **Requirements**: An indexed reference genome, a matching GTF annotation file, and a barcode FASTA file.
- **Command**: `dicey padlock -g <reference.fa.gz> -t <annotation.gtf.gz> -b <barcodes.fa.gz> <GENE_ID>`

## Expert Tips and Best Practices

- **Compression**: Always use `.fa.gz` (bgzip) files. Standard gzip may work for some operations but bgzip is required for efficient random access during indexing and searching.
- **Memory Management**: For very large genomes (like Human GRCh38), ensure the system has sufficient RAM to load the `.fm9` index.
- **Off-Target Analysis**: When running `search`, always check the JSON output for "off-target" hits. These are binding sites that do not result in a clean amplicon but may interfere with reaction efficiency.
- **JSON Processing**: Since the native output is JSON, you can use `jq` for complex filtering of results (e.g., filtering amplicons by a specific size range or melting temperature).



## Subcommands

| Command | Description |
|---------|-------------|
| dicey blacklist | Generates a blacklist file for a given genome. |
| dicey chop | Generic options: |
| dicey hunt | Finds matches of a given sequence in a genome file. |
| dicey index | Index a genome FASTA file |
| dicey mappability2 | Calculate mappability of a BAM file |
| dicey search | Generic options: |
| dicey_padlock | Probes for one gene, one transcript, a set of genes, or custom FASTA input. |

## Reference documentation
- [Dicey GitHub README](./references/github_com_gear-genomics_dicey_blob_main_README.md)
- [Dicey Project Overview](./references/github_com_gear-genomics_dicey.md)