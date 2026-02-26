---
name: diamond-aligner
description: DIAMOND is a high-throughput sequence aligner for protein and translated DNA searches that serves as a fast alternative to BLAST. Use when user asks to index protein databases, perform blastp or blastx alignments, or cluster large-scale protein datasets.
homepage: https://github.com/bbuchfink/diamond
---


# diamond-aligner

## Overview

DIAMOND is a high-throughput sequence aligner designed for protein and translated DNA searches. It serves as a drop-in replacement for many BLAST workflows, offering speed improvements of 100x to 10,000x while maintaining high sensitivity. Use this skill to manage the full lifecycle of sequence analysis, including database indexing, alignment execution, and large-scale protein clustering. It is particularly effective for metagenomic analysis, environmental sequencing, and any task involving tens of millions of protein sequences.

## Core Workflows

### 1. Database Preparation
Before searching, format a protein reference FASTA file into a DIAMOND-indexed database.

```bash
diamond makedb --in reference.fasta -d reference_db
```

### 2. Sequence Alignment
Perform searches using either protein queries (blastp) or DNA queries (blastx).

*   **Protein vs. Protein (blastp):**
    ```bash
    diamond blastp -d reference_db -q queries.fasta -o results.tsv
    ```
*   **Translated DNA vs. Protein (blastx):**
    ```bash
    diamond blastx -d reference_db -q reads.fasta -o results.tsv
    ```

### 3. Sequence Clustering
DIAMOND provides specialized modes for clustering massive protein datasets.

*   **Linear Clustering (linclust):** Best for very large datasets with a specific identity threshold.
    ```bash
    diamond linclust -d reference.fasta -o clusters.tsv --approx-id 30 -M 64G
    ```
*   **DeepClust (cluster):** More sensitive clustering using all-vs-all alignment.
    ```bash
    diamond cluster -d reference.fasta -o clusters.tsv --approx-id 30 -M 64G
    ```

## Expert Tips and Best Practices

### Managing Memory and Performance
DIAMOND is optimized for large files (>1 million proteins). For smaller datasets, it may not reach peak efficiency.
*   **Block Size (-b):** This is the most important parameter for memory management. It defines the number of query letters (in billions) processed in one block. If the program crashes due to memory limits, decrease this value (default is 2.0).
*   **Temporary Space:** Use `--tmpdir` to point to a high-speed SSD if the default `/tmp` is small or slow.

### Adjusting Sensitivity
Choose a sensitivity level based on the evolutionary distance of your sequences:
*   `--fast` or `--faster`: Best for high-identity matches.
*   `--mid-sensitive`: A balance between speed and sensitivity.
*   `--sensitive` (default): Good for most general use cases.
*   `--more-sensitive`, `--very-sensitive`, `--ultra-sensitive`: Use these for finding distant homologs or when accuracy is more critical than speed.

### Handling Masking
By default, DIAMOND applies repeat masking to both query and reference sequences.
*   To disable masking for specific low-complexity requirements, use `--masking 0`.

### Output Formats
DIAMOND supports multiple output formats via the `-f` or `--outfmt` flag:
*   `0`: BLAST pairwise
*   `5`: BLAST XML
*   `6`: BLAST tabular (default)
*   `100`: DIAMOND alignment archive (DAA). This is a proprietary binary format that can be later converted to other formats using the `view` command.

### Working with BLAST Databases
DIAMOND (v2.1.14+) can directly use NCBI BLAST databases if they are version 5.
```bash
diamond blastp -d swissprot -q queries.fasta -o matches.tsv
```

## Reference documentation
- [DIAMOND GitHub Wiki](./references/github_com_bbuchfink_diamond_wiki.md)
- [DIAMOND Main Repository](./references/github_com_bbuchfink_diamond.md)