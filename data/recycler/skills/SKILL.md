---
name: recycler
description: Recycler identifies circular genomic elements like plasmids and phages by analyzing assembly graph topology and read coverage. Use when user asks to identify circularity in genomic assemblies, recover plasmids from metagenomic samples, or find cycles in assembly graphs.
homepage: https://github.com/Shamir-Lab/Recycler
---

# recycler

## Overview

Recycler is a specialized tool for identifying circularity in genomic assemblies. It works by analyzing the topology of an assembly graph—specifically looking at contig overlaps and lengths—combined with coverage information and paired-end read alignments. Unlike simple circularity checks, Recycler uses a greedy algorithm to find cycles that are consistent with the observed read coverage, making it effective for recovering plasmids and phages that might otherwise be overlooked in complex metagenomic samples.

## Installation and Requirements

Recycler requires Python 2.7+ and the following dependencies:
- NumPy, NetworkX (2.0+), PySAM, and nose.
- External tools for preprocessing: BWA, samtools, and SPAdes (3.6+ recommended).

## Core Workflow

### 1. Prepare the BAM Input
Recycler requires a BAM file containing only the best primary alignments of your paired-end reads to the assembly nodes.

```bash
# 1. Generate a fasta file from the assembly graph
make_fasta_from_fastg.py -g assembly_graph.fastg -o assembly_graph.nodes.fasta

# 2. Index and align reads
bwa index assembly_graph.nodes.fasta
bwa mem assembly_graph.nodes.fasta R1.fastq.gz R2.fastq.gz | samtools view -buS - > reads_pe.bam

# 3. Filter for primary alignments (CRITICAL)
samtools view -bF 0x0800 reads_pe.bam > reads_pe_primary.bam

# 4. Sort and index
samtools sort reads_pe_primary.bam -o reads_pe_primary.sort.bam
samtools index reads_pe_primary.sort.bam
```

### 2. Run Recycler
The command differs slightly based on whether your sample is a single isolate or a metagenome.

**For Isolate Data:**
```bash
recycle.py -g assembly_graph.fastg -k 55 -b reads_pe_primary.sort.bam -i True
```

**For Metagenome/Plasmidome Data:**
```bash
recycle.py -g assembly_graph.fastg -k 55 -b reads_pe_primary.sort.bam
```

## Command Line Arguments

| Argument | Description |
| :--- | :--- |
| `-g` | **Required.** Path to the assembly graph FASTG file (e.g., `assembly_graph.fastg`). |
| `-k` | **Required.** The maximum k-mer length used during the assembly process. |
| `-b` | **Required.** Path to the filtered, sorted, and indexed BAM file. |
| `-i` | Set to `True` for isolated strains; default is `False` (metagenomes). |
| `-l` | Minimum length for reporting a circular sequence (default: 1000). |
| `-m` | Max coefficient of variation for pre-selection (default: 0.5). Higher is less restrictive. |
| `-o` | Output directory. Defaults to the directory containing the FASTG file. |

## Best Practices and Tips

- **Graph Compatibility**: While designed for SPAdes FASTG files, Recycler can work with other assemblers like MEGAHIT if the output is converted to the expected FASTG format.
- **K-mer Selection**: Always use the *maximum* k-mer value used by the assembler to ensure the graph overlaps are interpreted correctly.
- **Filtering BAMs**: The step `samtools view -bF 0x0800` is essential. Recycler's logic depends on primary alignments to calculate coverage accurately; including secondary or supplementary alignments will introduce noise.
- **Output Interpretation**: 
    - `.cycs.fasta`: Contains the actual sequences of predicted circular elements.
    - `.cycs.paths_w_cov.txt`: Provides the path through the original graph nodes, which is useful for visualization in tools like Bandage.



## Subcommands

| Command | Description |
|---------|-------------|
| recycle.py | Recycler extracts likely plasmids (and other circular DNA elements) from de novo assembly graphs |
| recycler_make_fasta_from_fastg.py | make_fasta_from_fastg converts fastg assembly graph to fasta format |
| samtools | Tools for alignments in the SAM format |

## Reference documentation
- [Recycler GitHub Repository](./references/github_com_Shamir-Lab_Recycler.md)