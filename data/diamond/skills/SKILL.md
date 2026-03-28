---
name: diamond
description: DIAMOND is a high-performance sequence aligner designed for large-scale protein and translated DNA searches against protein databases. Use when user asks to align protein sequences, perform translated DNA searches, create reference databases, or cluster massive protein datasets.
homepage: https://github.com/bbuchfink/diamond
---

# diamond

## Overview

DIAMOND is a sequence aligner designed for massive protein datasets, offering BLAST-compatible functionality at speeds 100x to 10,000x faster than traditional BLAST. It is specifically optimized for large-scale analysis of big sequence data, such as metagenomic samples or large protein databases. Use this skill to prepare reference databases, perform sensitive protein searches, or cluster billions of sequences with low resource requirements.

## Core Workflows

### 1. Database Preparation
Before searching, you must create a DIAMOND-formatted database from a FASTA file.

```bash
diamond makedb --in reference.fasta -d reference
```

### 2. Sequence Alignment
DIAMOND supports two primary alignment modes:
- **blastp**: Align protein queries against a protein reference database.
- **blastx**: Align translated DNA queries (e.g., NGS reads) against a protein reference database.

```bash
# Protein search
diamond blastp -d reference -q queries.fasta -o matches.tsv

# Translated DNA search
diamond blastx -d reference -q reads.fasta -o matches.tsv
```

### 3. Sequence Clustering
For reducing redundancy or grouping similar proteins, use the clustering commands.
- **linclust**: Fast clustering with linear scaling, ideal for massive datasets.
- **cluster**: More sensitive clustering using all-vs-all alignment.

```bash
# Fast clustering (30% identity threshold)
diamond linclust -d reference.fasta -o clusters.tsv --approx-id 30 -M 64G
```

## Expert Tips and Best Practices

### Managing Memory and Performance
- **Block Size (`-b`)**: This is the most important parameter for memory usage. It defines the number of query letters (in billions) processed in one block. The default is 2.0. If the program crashes due to memory limits, decrease this value (e.g., `-b 0.5`).
- **Sensitivity Levels**: DIAMOND defaults to a "fast" mode. Adjust sensitivity based on your needs:
  - `--fast`, `--mid-sensitive`, `--sensitive`, `--more-sensitive`, `--very-sensitive`, `--ultra-sensitive`.
  - Use `--very-sensitive` for results most comparable to BLASTP.

### Handling Large Inputs
- DIAMOND is optimized for files with >1 million proteins. While it works for smaller files, it reaches peak efficiency with large-scale data.
- **Repeat Masking**: Enabled by default. If you are working with sequences where low-complexity regions are biologically significant, disable it using `--masking 0`.

### Output Formats
Use the `-f` flag to specify output:
- `0`: BLAST pairwise
- `6`: BLAST tabular (default)
- `100`: DAA (DIAMOND alignment archive), a proprietary binary format that can be later converted to other formats using the `view` command.

### Frameshift Alignment
For long-read analysis (like Nanopore or PacBio) where frameshifts are common, use the `--range-culling` and `--top` options to better handle fragmented alignments.



## Subcommands

| Command | Description |
|---------|-------------|
| diamond blastp | DIAMOND is a sequence aligner for protein and translated DNA searches, designed for high performance analysis of big sequence data. |
| diamond blastx | DIAMOND is a sequence aligner for protein and translated DNA searches, designed for high performance analysis of big sequence data. |
| diamond cluster | Clustering sequences using the DIAMOND algorithm |
| diamond dbinfo | Display information about a DIAMOND database file |
| diamond getseq | Retrieve sequences from a DIAMOND database file. |
| diamond greedy-vertex-cover | Greedy vertex cover clustering using DIAMOND |
| diamond linclust | Clustering of protein sequences using the DIAMOND linclust algorithm. |
| diamond makedb | Build a DIAMOND database from a FASTA file |
| diamond makeidx | Create an index for a DIAMOND database |
| diamond merge-daa | Merge DAA files into a single file |
| diamond realign | Realign sequences using the DIAMOND engine |
| diamond reassign | Reassign sequences to closest representatives in clustering |
| diamond recluster | Recluster sequences using the DIAMOND algorithm |
| diamond view | View and convert DIAMOND alignment archive (DAA) files |

## Reference documentation
- [DIAMOND Wiki Home](./references/bbuchfink_diamond_wiki.md)
- [Command Line Options](./references/github_com_bbuchfink_diamond_wiki_3.-Command-line-options.md)
- [Clustering Guide](./references/github_com_bbuchfink_diamond_wiki_Clustering.md)