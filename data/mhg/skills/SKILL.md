---
name: mhg
description: MHG identifies and partitions homologous regions across multiple genomes using an annotation-free, graph-based approach. Use when user asks to identify homologous blocks, partition alignment graphs, or find maximal homologous groups across non-coding or poorly annotated sequences.
homepage: https://github.com/NakhlehLab/Maximal-Homologous-Groups
metadata:
  docker_image: "quay.io/biocontainers/mhg:1.1.0--hdfd78af_0"
---

# mhg

## Overview

MHG (Maximal Homologous Group) Finder is a graph-based bioinformatics tool used to identify and partition homologous regions across a set of genomes. Unlike traditional methods that rely on gene annotations, MHG is annotation-free, making it ideal for analyzing non-coding regions or poorly annotated genomes. It processes raw nucleotide sequences through a two-stage pipeline: first, it performs pairwise alignments using BLASTn to build an alignment graph; second, it partitions this graph into maximal groups where each group follows a consistent evolutionary history (a single tree) and is free from internal rearrangements.

## Installation and Environment

The tool is primarily distributed via Bioconda. It is highly recommended to use a dedicated environment to manage dependencies like `networkx`, `biopython`, and `bedtools`.

```bash
conda create --name mhg python=3.7
conda activate mhg
conda install -c bioconda mhg
```

## Core Workflows

### 1. Integrated Pipeline (Recommended)
Use the `MHG` command to run the entire process from raw genomes to final homologous groups.

```bash
MHG -g <genome_directory> -o <output_file.txt> -t <threshold>
```

*   **Input**: A directory containing genome nucleotide sequences (FASTA format).
*   **Output**: A text file where each line represents a single MHG containing identified blocks.

### 2. Decoupled Execution
For large datasets or custom workflows, you can run the alignment and partitioning steps separately.

**Step A: Generate BLASTn Databases and Queries**
```bash
genome-to-blast-db -g genomes/ -db ./blast_db/ -q ./queries/ -T 8
```

**Step B: Partition the Alignment Graph**
```bash
MHG-partition -q ./queries/ -o mhg_results.txt -t 0.95
```

## Command Line Options

| Flag | Description | Default |
| :--- | :--- | :--- |
| `-g, --genome` | Directory containing input genome sequences (Required for MHG/genome-to-blast-db). | N/A |
| `-t, --threshold` | Bitscore threshold for homology (0.0 to 1.0). | 0.4 |
| `-o, --output` | Path for the final partitioned MHG text file. | mhg.txt |
| `-T, --thread` | Number of threads for BLASTn operations. | 1 |
| `-w, --word_size` | BLASTn word size for initial seeds. | 28 |
| `-db, --database` | Directory to store intermediate BLAST databases. | ./blastn_db/ |
| `-q, --query` | Directory to store/read BLASTn XML query results. | ./blastn_against_bank/ |

## Expert Tips and Best Practices

*   **Threshold Tuning**: The `-t` (threshold) parameter is the most critical variable. It represents the bitscore ratio relative to the maximum bitscore. A higher threshold (e.g., `0.95`) is more conservative, ensuring only very high-confidence homologies are grouped, which is useful for closely related strains.
*   **Performance**: The alignment phase is computationally expensive. Always utilize the `-T` flag to match your available CPU cores to significantly speed up the `genome-to-blast-db` stage.
*   **Storage Management**: The intermediate XML files generated in the query directory (`-q`) can become very large. Ensure sufficient disk space before running the integrated `MHG` command on large genome sets.
*   **Input Formatting**: Ensure all files in the genome directory are valid nucleotide FASTA files. The tool uses the filenames as identifiers in the resulting MHG output.



## Subcommands

| Command | Description |
|---------|-------------|
| MHG | Make blastn database & Build blastn queries |
| genome-to-blast-db | Make blastn database & Build blastn queries |

## Reference documentation
- [MHG-Finder README](./references/github_com_NakhlehLab_Maximal-Homologous-Groups_blob_main_README.md)
- [MHG Main Script](./references/github_com_NakhlehLab_Maximal-Homologous-Groups_blob_main_MHG.md)
- [MHG Partitioning Logic](./references/github_com_NakhlehLab_Maximal-Homologous-Groups_blob_main_MHG-partition.md)
- [Genome to BLAST DB Utility](./references/github_com_NakhlehLab_Maximal-Homologous-Groups_blob_main_genome-to-blast-db.md)