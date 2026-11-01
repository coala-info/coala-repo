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

#### Before you trust the counts: three checks
`featureCounts` defaults silently drop reads. Run these on one BAM before counting all samples, and read the `.summary` after every run.

1. **Multi-mapping reads (`-M`, tool input `multi_mapping`).** By default every read with `NH > 1` is skipped as `Unassigned_MultiMapping`. In assemblies with duplicated regions, gene families or paralogs, most reads can be multi-mapped, and the default then counts a minority of reads and misses most expressed genes. Check the `NH` distribution first:
   ```bash
   samtools view -F 256 sample.bam | head -200000 | grep -o 'NH:i:[0-9]*' | sort | uniq -c | sort -rn | head
   ```
   When a large share of reads has `NH > 1`, count them and say how:
   ```bash
   # each multi-mapped read once, at its primary alignment (integer counts for edgeR/DESeq2/limma)
   featureCounts -M --primary -a annotation.gtf -o counts.txt sample.bam
   # or split each multi-mapped read across its alignments (fractional counts)
   featureCounts -M --fraction -a annotation.gtf -o counts.txt sample.bam
   ```
   Keeping the default is a choice too: state it, with the share of reads it discards.

2. **Strandedness (`-s`, tool input `strand`).** Do not assume `-s 0`. Count one BAM with `-s 0`, `-s 1` and `-s 2` and compare `Assigned`: the right setting assigns about as many reads as `-s 0`, and the wrong strand assigns almost none (stranded libraries such as 3'-tag protocols). Use the stranded setting that wins; `-s 0` on a stranded library counts antisense reads to overlapping genes.

3. **Duplicates and UMIs.** If the BAM records carry UMI tags (`UB`, `UR` or `RX`), PCR duplicates are in the file and read counts overstate molecules. Deduplicate first (`umi_tools dedup --umi-tag=UR --extract-umi-method=tag`, or the tag the aligner wrote) or count UMIs per gene (`umi_tools count`), and state which. `--ignoreDup` uses the duplicate flag, not UMIs, and only helps if duplicates were marked.

**Read the `.summary`.** Report `Assigned` as a percentage of all reads per sample. Typical bulk RNA-seq assigns 60-80%. When most samples sit far below that, the problem is the pipeline (multi-mapping, strand, annotation feature type or attribute, reference mismatch), not the samples: find the largest `Unassigned_*` row, fix the parameter behind it, and recount. Do not compensate downstream by dropping samples or relaxing gene filters.

**Gene-level counts from an NCBI RefSeq GFF3:** `-F GFF -t exon -g gene` gives gene symbols and `LOC` IDs (`-g gene_id` is for GTF). For paired-end data add `-p --countReadPairs`.

### 4. SNP Calling (exactSNP)
`exactSNP` discovers SNPs by testing signals against local background noise.
```bash
exactSNP -i mapping_results.bam -g reference.fa -o called_snps.vcf
```

## Expert Tips and Best Practices

*   **Aligner Selection**: Use `subread-align` for standard RNA-seq gene expression quantification (it is faster). Use `subjunc` only if you need to analyze alternative splicing or require the full alignment of exon-spanning reads.
*   **Memory Management**: If working on a memory-constrained system, `subread-buildindex` has been optimized in recent versions (1.6.5+) to reduce its memory footprint.
*   **Multi-threading**: Most subread tools support the `-T` flag. Always utilize this for significant speedups in alignment and counting.
*   **Counting defaults drop reads**: `featureCounts` skips multi-mapped reads unless `-M` is given and counts unstranded unless `-s` is given. Check the `NH` distribution, the strand and the `.summary` before counting all samples (see *Before you trust the counts*).
*   **Annotation Formats**: `featureCounts` supports both GTF/GFF and the Simplified Annotation Format (SAF). SAF is useful for custom features (Columns: GeneID, Chr, Start, End, Strand).
*   **Structural Variants**: To detect structural variants during alignment, add the `--sv` flag to your `subread-align` command.
*   **Long Reads**: For Nanopore or PacBio data, use the `sublong` tool included in the suite.

## Reference documentation

- [Subread Package Overview](./references/subread_sourceforge_net_subread-package.html.md)
- [Subread Aligner Manual](./references/subread_sourceforge_net_subread.html.md)
- [featureCounts Manual](./references/subread_sourceforge_net_featureCounts.html.md)
- [Subjunc Manual](./references/subread_sourceforge_net_subjunc.html.md)
- [exactSNP Manual](./references/subread_sourceforge_net_exactSNP.html.md)