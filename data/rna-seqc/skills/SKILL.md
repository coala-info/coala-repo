---
name: rna-seqc
description: RNA-SeQC is a high-performance tool designed for rapid quality control and quantification of RNA-Seq data.
homepage: https://github.com/broadinstitute/rnaseqc
---

# rna-seqc

## Overview

RNA-SeQC is a high-performance tool designed for rapid quality control and quantification of RNA-Seq data. It is particularly useful for processing large cohorts where computational efficiency is critical. The tool provides comprehensive metrics to evaluate library quality, including transcript coverage, fragment size distribution, and strand specificity, while simultaneously producing gene-level expression estimates (TPM or RPKM).

## Core Usage

The basic command structure requires a collapsed GTF annotation, an aligned BAM/SAM/CRAM file, and an output directory:

```bash
rnaseqc <gtf> <bam> <output_dir> [options]
```

### Essential Requirements
*   **GTF Preparation**: RNA-SeQC 2 requires a "collapsed" GTF where overlapping transcripts on the same strand are merged into a single representative transcript per gene. Use the GTEx collapse script to prepare your annotation.
*   **Sample Naming**: By default, the BAM filename is used. Use `-s <sample_name>` to specify a custom ID for output files.

## Common CLI Patterns

### Standard QC and Quantification
Generate metrics, gene counts, and TPMs for a paired-end library:
```bash
rnaseqc genes.collapsed.gtf aligned_reads.bam ./qc_results \
  --sample Sample_01 \
  --bed exons.bed
```

### Single-End Libraries
You must explicitly allow unpaired reads for single-end data:
```bash
rnaseqc genes.collapsed.gtf single_end.bam ./qc_results -u
```

### Strand-Specific Data
Specify the library type to ensure metrics like "Mapped Reads to Correct Strand" are calculated accurately:
*   **dUTP/Forward-Reverse (RF)**: `--stranded RF`
*   **Ligation/Reverse-Forward (FR)**: `--stranded FR`

### Detailed Coverage Analysis
To generate a full table of mean coverage per transcript (in addition to summary metrics), use the `--coverage` flag:
```bash
rnaseqc genes.collapsed.gtf aligned_reads.bam ./output --coverage
```

## Expert Tips & Best Practices

*   **Fragment Size Calculation**: To get fragment size metrics, you **must** provide a BED file containing non-overlapping exons via the `--bed` option.
*   **CRAM Support**: When processing CRAM files, provide the reference genome using `--fasta <ref.fa>`.
*   **Filtering Reads**: 
    *   Adjust mapping quality thresholds with `-q` (default is 255, which is the "unique mapping" flag for STAR).
    *   Control mismatch tolerance with `--base-mismatch` (default 6).
*   **Bias Calculation**: RNA-SeQC calculates 3'/5' bias using windows at the ends of genes. If your library has specific characteristics (e.g., very short fragments), you may need to adjust `--offset` (default 150bp) or `--window-size` (default 100bp).
*   **Chimeric Reads**: If using STAR, the tool defaults to the `ch` tag for chimeric reads. You can exclude these from counts using `--exclude-chimeric`.

## Output Files
The tool produces several key files in the output directory:
*   `{sample}.metrics.tsv`: Summary of all QC statistics.
*   `{sample}.gene_reads.gct`: Raw read counts per gene (suitable for DESeq2/EdgeR).
*   `{sample}.gene_tpm.gct`: Normalized expression values (TPM).
*   `{sample}.exon_reads.gct`: Coverage counts at the exon level.

## Reference documentation
- [RNA-SeQC GitHub Repository](./references/github_com_getzlab_rnaseqc.md)