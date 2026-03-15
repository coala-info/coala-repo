---
name: diamond
description: DIAMOND is a high-performance sequence alignment tool used for protein-protein and translated DNA-protein searches. Use when user asks to align protein or DNA sequences to a reference database, perform blastp or blastx searches, or cluster large-scale protein datasets.
homepage: https://github.com/bbuchfink/diamond
---


# diamond

## Overview
DIAMOND is a high-performance sequence alignment tool optimized for large-scale proteomics and genomics data. It serves as a highly efficient alternative to NCBI-BLAST for protein-protein (blastp) and translated DNA-protein (blastx) searches. Beyond simple alignment, it supports advanced features like frameshift-aware alignment for long reads and massive-scale protein clustering. It is designed to run effectively on everything from standard laptops to high-performance computing clusters.

## Core CLI Workflows

### 1. Database Preparation
Before searching, you must convert your reference FASTA file into a specialized DIAMOND database format (.dmnd).

```bash
diamond makedb --in reference.fasta -d reference_db
```

### 2. Protein Alignment (blastp)
Used for searching protein queries against a protein reference database.

```bash
diamond blastp -d reference_db -q queries.fasta -o results.tsv
```

### 3. Translated DNA Alignment (blastx)
Used for searching DNA queries (translated in all 6 frames) against a protein reference database.

```bash
diamond blastx -d reference_db -q reads.fasta -o results.tsv
```

### 4. Sequence Clustering
DIAMOND provides two main modes for clustering protein sequences:
- **linclust**: Linear scaling clustering, ideal for massive datasets (tens of billions of sequences).
- **cluster**: Sensitive clustering using all-vs-all alignment.

```bash
# Fast clustering at 30% identity
diamond linclust -d reference.fasta -o clusters.tsv --approx-id 30 -M 64G
```

## Expert Tips and Best Practices

### Managing Memory and Performance
- **Block Size (`-b`)**: This is the most important parameter for memory usage. It defines the number of query letters (in billions) processed in one iteration. 
    - Default is 2.0. 
    - If the program crashes due to memory limits, decrease this (e.g., `-b 0.5`).
    - On high-RAM systems, increasing this can improve performance.
- **Temporary Space**: DIAMOND uses significant disk space for temporary files. Use `--tmpdir /path/to/fast/disk` to point to an SSD or RAM disk for faster processing.

### Adjusting Sensitivity
DIAMOND offers several sensitivity modes. Choosing the right one is a trade-off between speed and the ability to find distant homologs:
- `--fast` (Default): Fastest mode, best for closely related sequences.
- `--mid-sensitive`: Good balance.
- `--sensitive`: Recommended for most general use cases.
- `--more-sensitive`, `--very-sensitive`, `--ultra-sensitive`: Use these for finding very distant evolutionary relationships, though they are significantly slower.

### Handling Repeat Masking
By default, DIAMOND applies repeat masking to both query and reference sequences to avoid spurious hits in low-complexity regions.
- To disable masking (e.g., if you are looking for specific low-complexity motifs), use `--masking 0`.

### Output Customization
Use the `-f` or `--outfmt` flag to change the output format:
- `0`: BLAST pairwise
- `5`: BLAST XML
- `6`: Tabular (Default). You can customize columns: `-f 6 qseqid sseqid pident length evalue bitscore`
- `100`: DIAMOND archive (DAA). This format stores all alignment information and can be converted to other formats later using the `view` command.

### Frameshift Alignment
For long-read sequencing data (like Oxford Nanopore or PacBio) that may contain indels causing frameshifts, use the range-culling or frameshift options:
- `--range-culling`: Better for long-read analysis.
- `-F 15`: Allows for frameshifts in the alignment (penalty of 15).



## Subcommands

| Command | Description |
|---------|-------------|
| blastp | DIAMOND is a sequence aligner for protein and translated DNA searches, designed for high performance analysis of big sequence data. |
| blastx | DIAMOND is a sequence aligner for protein and translated DNA searches. The blastx command aligns translated DNA queries against a protein reference database. |
| cluster | Clustering sequences using DIAMOND |
| diamond dbinfo | Display information about a DIAMOND database file |
| diamond_getseq | Display sequences from a DIAMOND database file by their sequence numbers. |
| greedy-vertex-cover | Greedy vertex cover clustering tool for DIAMOND |
| linclust | Linear-time clustering of protein sequences |
| makedb | Build a DIAMOND database from a FASTA file |
| makeidx | Build an index for a DIAMOND database file. |
| merge-daa | Merge DAA files |
| realign | Realign sequences using the DIAMOND algorithm |
| reassign | Reassign sequences to clusters or representatives using the DIAMOND protein aligner. |
| recluster | Recluster sequences using the DIAMOND algorithm |
| view | View and convert DIAMOND alignment archives (DAA) |

## Reference documentation
- [DIAMOND Wiki Home](./references/bbuchfink_diamond_wiki.md)
- [Command Line Options](./references/github_com_bbuchfink_diamond_wiki_3.-Command-line-options.md)
- [Clustering Guide](./references/github_com_bbuchfink_diamond_wiki_Clustering.md)
- [File Formats](./references/github_com_bbuchfink_diamond_wiki_File-formats.md)