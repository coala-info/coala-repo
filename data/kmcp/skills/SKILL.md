---
name: kmcp
description: KMCP performs high-performance metagenomic profiling and pathogen detection using a k-mer-based pseudo-mapping approach. Use when user asks to compute k-mer sketches, build searchable genome indexes, search sequences against a database, or generate taxonomic abundance profiles.
homepage: https://github.com/shenwei356/kmcp
metadata:
  docker_image: "quay.io/biocontainers/kmcp:0.9.4--h9ee0642_1"
---

# kmcp

## Overview

KMCP is a high-performance tool designed for metagenomic analysis. It utilizes a "pseudo-mapping" approach where reference genomes are split into chunks and stored in an optimized Compact Bit-Sliced Signature index (COBS). This allows for a unique combination of k-mer similarity and genome coverage information, significantly reducing false-positive rates compared to traditional k-mer profilers. It is particularly effective for detecting pathogens in low-depth clinical samples and profiling viral populations.

## Core Workflow

The standard KMCP workflow consists of four primary stages: computing k-mers, indexing, searching, and profiling.

### 1. Compute K-mers
Generate k-mer sketches from reference FASTA/Q files.
```bash
# Standard parameters for metagenomic profiling (k=21, 10 chunks)
kmcp compute -k 21 --split-number 10 --split-overlap 150 \
    --in-dir genomes/ --out-dir genomes-k21-n10
```
*   **Expert Tip**: Use `--circular` for circular genomes (like many viruses/plasmids) to ensure k-mers are captured across the origin.

### 2. Build Index
Construct the searchable database from the computed k-mer files.
```bash
# -n 1 (number of hashes), -f 0.3 (false positive rate)
kmcp index --false-positive-rate 0.3 --num-hash 1 \
    --in-dir genomes-k21-n10/ --out-dir genomes.kmcp
```

### 3. Search
Search query sequences against the database.
```bash
# Single-end mode is often recommended for paired-end reads for higher sensitivity
kmcp search --db-dir genomes.kmcp/ sample_1.fq.gz sample_2.fq.gz \
    --out-file search.tsv.gz
```
*   **Memory Management**: 
    *   Default: Uses `mmap` (fastest if RAM is sufficient).
    *   `--load-whole-db`: Faster for small databases or when using Network Attached Storage (NAS).
    *   `--low-mem`: Use this if the database exceeds available RAM (significantly slower).

### 4. Profile
Generate taxonomic abundance estimates from search results.
```bash
kmcp profile search.tsv.gz \
    --taxid-map taxid.map \
    --taxdump taxdump/ \
    --mode 0 \
    --out-file sample.profile
```

## Profiling Modes

KMCP provides preset modes for different scenarios:
*   **Mode 0 (Default)**: Balanced mode for general metagenomic profiling.
*   **Mode 1**: Higher sensitivity, suitable for pathogen detection.
*   **Mode 2**: High specificity, requiring higher genome coverage.
*   **Mode 3**: For searching against large scales of genomes (e.g., GTDB).

## Expert Tips and Common Patterns

### Handling Large Databases
If you lack sufficient RAM to load a massive database (like the full GTDB), split the reference genomes into partitions, build smaller databases for each, search against them individually, and then use `kmcp merge`:
```bash
# Merge results from multiple database searches
kmcp merge search.db1.tsv.gz search.db2.tsv.gz -o merged_search.tsv.gz
```

### Genome Similarity Estimation
For fast similarity estimation (similar to Mash or Sourmash), use FracMinHash (Scaled MinHash):
```bash
# Compute with scaling (e.g., scale=1000)
kmcp compute -k 31 --scale 1000 -I genomes/ -O sketches
```

### Contamination Detection
To detect contaminated sequences in an assembly, generate sliding window "reads" from your contigs and profile them:
```bash
seqkit sliding -s 50 -W 200 assembly.fasta | kmcp search -d gtdb.kmcp | kmcp profile ...
```

### Taxonomy Support
KMCP supports custom taxonomies (GTDB, ICTV) by using `taxonkit create-taxdump` to generate the required `taxdump` directory and `taxid.map` file.



## Subcommands

| Command | Description |
|---------|-------------|
| kmcp autocompletion | Generate shell autocompletion script |
| kmcp compute | Generate k-mers (sketches) from FASTA/Q sequences |
| kmcp index | Construct a database from k-mer files |
| kmcp profile | Generate the taxonomic profile from search results |
| kmcp search | Search sequences against a database |
| kmcp utils | Some utilities |
| kmcp version | Print version information and check for update |
| kmcp_merge | Merge search results from multiple databases |

## Reference documentation
- [KMCP Usage Guide](./references/bioinf_shenwei_me_kmcp_usage.md)
- [Taxonomic Profiling Tutorial](./references/bioinf_shenwei_me_kmcp_tutorial_profiling.md)
- [Database Building Guide](./references/bioinf_shenwei_me_kmcp_database.md)
- [Pathogen Detection Tutorial](./references/bioinf_shenwei_me_kmcp_tutorial_detecting-pathogens.md)