---
name: subread
description: Subread is a high-performance bioinformatics suite used for mapping next-generation sequencing reads and quantifying genomic features. Use when user asks to build a genome index, align DNA or RNA-seq reads, detect splice junctions, count reads mapping to features, or call SNPs.
homepage: https://subread.sourceforge.net
metadata:
  docker_image: "quay.io/biocontainers/subread:2.1.1--h577a1d6_0"
---

# subread

## Overview

The Subread suite is a collection of high-performance bioinformatics tools designed for the analysis of next-generation sequencing (NGS) data. It utilizes a unique "seed-and-vote" paradigm that allows for rapid and accurate mapping of both short and long reads. The suite provides a comprehensive workflow for RNA-seq and DNA-seq analysis, including genome indexing, read alignment, exon-exon junction detection, read summarization (quantification), and mutation discovery.

## Core Command Line Patterns

### 1. Genome Indexing
Before alignment, you must build an index for your reference genome.
```bash
subread-buildindex -o my_index reference_genome.fa
```
*   **Tip**: You can provide multiple FASTA files (e.g., individual chromosomes) in a single command.

### 2. Read Alignment
The suite provides two primary aligners for short reads: `subread-align` and `subjunc`.

**For Gene Expression (RNA-seq) or DNA-seq:**
Use `subread-align` for maximum speed when full exon-spanning mapping isn't the primary goal.
```bash
# Single-end alignment with 8 threads
subread-align -T 8 -i my_index -r reads.fastq -o output.bam

# Paired-end alignment
subread-align -d 50 -D 600 -i my_index -r reads_R1.fastq -R reads_R2.fastq -o output_PE.bam
```

**For Junction Discovery and Full RNA-seq Mapping:**
Use `subjunc` to accurately map exon-spanning reads and discover splice junctions.
```bash
subjunc -T 8 -i my_index -r reads.fastq -o output_junctions.bam
```

### 3. Read Quantification (featureCounts)
`featureCounts` is a highly efficient tool for counting how many reads map to genomic features (genes, exons, etc.).

```bash
# Basic counting using a GTF annotation
featureCounts -T 8 -a annotation.gtf -o counts.txt mapping_results.bam

# Counting for paired-end data (counting fragments instead of individual reads)
featureCounts -p --countReadPairs -a annotation.gtf -o counts.txt mapping_results.bam

# Strand-specific counting (1 for stranded, 2 for reversely stranded)
featureCounts -s 1 -a annotation.gtf -o counts.txt mapping_results.bam
```

### 4. SNP Calling (exactSNP)
`exactSNP` discovers SNPs by testing signals against local background noise.
```bash
exactSNP -i mapping_results.bam -g reference.fa -o called_snps.vcf
```

## Expert Tips and Best Practices

*   **Aligner Selection**: Use `subread-align` for standard RNA-seq gene expression quantification (it is faster). Use `subjunc` only if you need to analyze alternative splicing or require the full alignment of exon-spanning reads.
*   **Memory Management**: If working on a memory-constrained system, `subread-buildindex` has been optimized in recent versions (1.6.5+) to reduce its memory footprint.
*   **Multi-threading**: Most subread tools support the `-T` flag. Always utilize this for significant speedups in alignment and counting.
*   **Annotation Formats**: `featureCounts` supports both GTF/GFF and the Simplified Annotation Format (SAF). SAF is useful for custom features (Columns: GeneID, Chr, Start, End, Strand).
*   **Structural Variants**: To detect structural variants during alignment, add the `--sv` flag to your `subread-align` command.
*   **Long Reads**: For Nanopore or PacBio data, use the `sublong` tool included in the suite.

## Reference documentation

- [Subread Package Overview](./references/subread_sourceforge_net_subread-package.html.md)
- [Subread Aligner Manual](./references/subread_sourceforge_net_subread.html.md)
- [featureCounts Manual](./references/subread_sourceforge_net_featureCounts.html.md)
- [Subjunc Manual](./references/subread_sourceforge_net_subjunc.html.md)
- [exactSNP Manual](./references/subread_sourceforge_net_exactSNP.html.md)