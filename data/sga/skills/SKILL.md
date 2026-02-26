---
name: sga
description: SGA is a modular toolkit for the de novo assembly of genomic data using a memory-efficient string graph formulation. Use when user asks to index reads, perform error correction, filter low-complexity sequences, compute overlaps, or assemble contigs from sequencing data.
homepage: https://github.com/jts/sga
---


# sga

## Overview
SGA (String Graph Assembler) is a modular toolkit designed for the de novo assembly of genomic data. Unlike traditional de Bruijn graph assemblers, SGA is based on the string graph formulation and utilizes the Burrows-Wheeler Transform (BWT) and FM-index to maintain a very low memory footprint. This makes it particularly effective for assembling large genomes on standard hardware. The tool operates as a pipeline of discrete subprograms, allowing for fine-grained control over error correction, filtering, and contig construction.

## Core Workflow and CLI Patterns

### 1. Data Exploration (Pre-assembly)
Before starting an assembly, use the `preqc` module to understand the characteristics of your dataset (e.g., error rates, genome size, and repetitiveness).
```bash
sga preqc --threads 8 input.fastq > output.preqc
```

### 2. Indexing
The foundation of SGA is the FM-index. You must index your reads before most other operations.
```bash
sga index -a ropebwt -t 8 reads.fastq
```
*Tip: Use `-a ropebwt` for most modern datasets as it is generally faster and more memory-efficient than the default.*

### 3. Error Correction
SGA performs k-mer based error correction. This is a multi-step process involving indexing the corrected reads.
```bash
# Perform correction
sga correct -k 41 -t 8 reads.fastq -o reads.corrected.fastq

# Re-index the corrected reads
sga index -a ropebwt -t 8 reads.corrected.fastq
```

### 4. Filtering and Overlap
Filter out low-complexity reads and then compute the overlaps required for the string graph.
```bash
# Filter duplicate and low-complexity reads
sga filter -x 2 -t 8 reads.corrected.fastq

# Compute overlaps (default min overlap is 45)
sga overlap -m 55 -t 8 reads.corrected.filter.pass.fa
```

### 5. Assembly
Construct the string graph and perform the final assembly into contigs.
```bash
sga assemble -m 55 -o assembly.contigs.fa reads.corrected.filter.pass.asqg.gz
```

## Expert Tips and Best Practices
- **Memory Management**: SGA is designed for low memory, but the `index` and `overlap` steps are the most intensive. Ensure you specify the `--threads` parameter to match your hardware.
- **K-mer Selection**: For `preqc` and `correct`, the k-mer size (`-k`) should typically be around 31-41 for Illumina data. Larger k-mers increase specificity but reduce sensitivity.
- **Overlap Length**: The overlap parameter (`-m`) in `sga overlap` and `sga assemble` is critical. Increasing this value can resolve more repeats but may lead to more fragmented assemblies if coverage is low.
- **Scaffolding**: SGA produces contigs. For scaffolding, you typically need to map paired-end/mate-pair reads back to the contigs using `sga-align` and then use modules like `sga-bam2de.pl` to estimate distance distributions.

## Reference documentation
- [SGA Overview](./references/anaconda_org_channels_bioconda_packages_sga_overview.md)
- [SGA GitHub Repository](./references/github_com_jts_sga.md)
- [SGA Wiki and Documentation](./references/github_com_jts_sga_wiki.md)