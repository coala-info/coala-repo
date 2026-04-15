---
name: subread-data
description: The subread-data suite provides high-performance tools for indexing reference genomes, aligning sequencing reads, quantifying gene expression, and calling variants. Use when user asks to build a genome index, align DNA or RNA reads, count reads mapped to genomic features using featureCounts, or identify SNPs.
homepage: https://subread.sourceforge.net
metadata:
  docker_image: "biocontainers/subread-data:v1.6.3dfsg-1-deb_cv1"
---

# subread-data

## Overview

The `subread-data` suite is a high-performance toolkit designed for the efficient processing of next-generation sequencing (NGS) data. Based on the "seed-and-vote" paradigm, it provides tools that are significantly faster than many traditional aligners while maintaining high sensitivity. This skill guides the use of the core CLI tools: `subread-buildindex` for genome preparation, `subread-align` and `subjunc` for mapping, `featureCounts` for quantification, and `exactSNP` for variant calling.

## Core CLI Workflows

### 1. Genome Indexing
Before alignment, you must build an index for the reference genome.
```bash
subread-buildindex -o <index_basename> <reference.fasta>
```
*   **Tip**: You can provide multiple FASTA files (e.g., individual chromosomes) in a space-separated list.

### 2. Read Alignment
Choose the aligner based on your specific biological objective.

#### Subread (General Purpose / Gene Expression)
Best for DNA-seq or RNA-seq where the primary goal is gene-level quantification.
```bash
# Single-end
subread-align -i <index_basename> -r <reads.fastq> -t 0 -T <threads> -o <output.bam>

# Paired-end
subread-align -i <index_basename> -r <R1.fastq> -R <R2.fastq> -d <min_dist> -D <max_dist> -o <output.bam>
```

#### Subjunc (Junction-Aware)
Required for RNA-seq when you need to discover exon-exon junctions or perform full-length read mapping (e.g., for variant calling in RNA).
```bash
subjunc -i <index_basename> -r <R1.fastq> -R <R2.fastq> -o <output.bam>
```

### 3. Read Summarization (featureCounts)
`featureCounts` is highly efficient for counting reads mapped to genomic features.

#### Standard Gene Counting
```bash
featureCounts -T <threads> -a <annotation.gtf> -o <counts.txt> <input.bam>
```

#### Common Parameter Patterns
*   **Paired-end data**: Always include `-p` and `--countReadPairs`.
*   **Strand-specific**: Use `-s 1` (forward) or `-s 2` (reverse/ortholog).
*   **Multi-mapping**: By default, multi-mapping reads are excluded. Use `-M` to count them.
*   **Fractional counting**: Use `--fraction` in conjunction with `-M` to assign a fraction of a count to each location for multi-mapping reads.

### 4. SNP Calling (exactSNP)
Discovers SNPs by testing signals against local background noise.
```bash
exactSNP -i <input.bam> -g <reference.fasta> -o <output.vcf>
```

## Expert Tips and Best Practices

*   **Memory Management**: `subread-buildindex` can be memory-intensive. If working on a memory-constrained system, ensure you have enough RAM (typically 8GB+ for the human genome).
*   **Output Formats**: Most tools default to SAM. Use the `-o` flag with a `.bam` extension or specify output formats where available to save disk space and skip manual conversion.
*   **Multi-threading**: Use the `-T` flag across all tools to significantly decrease processing time.
*   **SAF Format**: If you don't have a GTF, `featureCounts` supports a Simplified Annotation Format (SAF). This is a tab-delimited format with columns: `GeneID`, `Chr`, `Start`, `End`, `Strand`. Use `-F SAF` to specify this input.
*   **Structural Variants**: For `subread-align`, use the `--sv` flag to detect structural variants during the alignment process.

## Reference documentation
- [The Subread package](./references/subread_sourceforge_net_index.md)
- [featureCounts: read summarization](./references/subread_sourceforge_net_featureCounts.html.md)
- [Subread aligner](./references/subread_sourceforge_net_subread.html.md)
- [Subjunc: junction detection](./references/subread_sourceforge_net_subjunc.html.md)
- [exactSNP: SNP calling](./references/subread_sourceforge_net_exactSNP.html.md)