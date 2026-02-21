---
name: rnabloom
description: RNA-Bloom is a fast, memory-efficient Java-based tool designed for the de novo assembly of transcript sequences.
homepage: https://github.com/bcgsc/RNA-Bloom
---

# rnabloom

## Overview

RNA-Bloom is a fast, memory-efficient Java-based tool designed for the de novo assembly of transcript sequences. It is highly versatile, supporting single-end and paired-end bulk RNA-seq, single-cell RNA-seq (specifically Smart-seq2/SMARTer protocols), and long-read technologies like ONT and PacBio. It can operate in a completely reference-free mode or utilize a reference transcriptome to guide the assembly process.

## Installation and Environment

RNA-Bloom requires Java SE Development Kit (JDK) 11 or higher (JDK 17 is recommended for performance). It also relies on `minimap2`, `Racon`, and `ntCard` being available in your PATH.

The most reliable way to install RNA-Bloom and its dependencies is via Conda:
```bash
conda install -c bioconda rnabloom
```

## Short-Read Assembly Patterns

### Bulk RNA-seq
For standard paired-end Illumina data, specify left and right reads. Note that RNA-Bloom requires explicit orientation flags for non-stranded data.

```bash
# Standard paired-end assembly
rnabloom -left R1.fastq.gz -right R2.fastq.gz -revcomp-right -t 16 -outdir assembly_out
```

### Single-Cell or Multi-Sample (Pooled Mode)
Use the `-pool` option for single-cell datasets (e.g., Smart-seq2). This requires a tab-separated file (`samples.txt`) with a header:
`#name left right sef ser`

```bash
# Pooled assembly for multiple samples/cells
rnabloom -pool samples.txt -revcomp-right -t 32 -outdir pooled_out
```

### Reference-Guided Assembly
To improve assembly quality using a known transcriptome:
```bash
rnabloom -left R1.fastq -right R2.fastq -revcomp-right -ref reference_transcriptome.fasta -outdir guided_out
```

## Long-Read Assembly Patterns

### Oxford Nanopore (ONT)
Default long-read settings are optimized for ONT. It is strongly recommended to trim adapters (e.g., using Porechop) before assembly.

```bash
# ONT cDNA assembly
rnabloom -long ont_reads.fastq.gz -t 16 -outdir ont_out

# ONT Direct RNA (Stranded)
rnabloom -long direct_rna.fastq -stranded -uracil -outdir drna_out
```

### PacBio
For PacBio HiFi/cDNA reads, you must include the `-lrpb` flag.

```bash
rnabloom -long pacbio_reads.fastq -lrpb -t 16 -outdir pacbio_out
```

### Hybrid Assembly
You can polish long-read assemblies using short-read data for higher accuracy:
```bash
rnabloom -long long_reads.fastq -left R1.fastq -right R2.fastq -revcomp-right -t 24 -outdir hybrid_out
```

## Expert Tips and Best Practices

*   **Memory Management**: RNA-Bloom is memory-efficient, but for very large datasets, ensure your Java heap size is sufficient if running the JAR directly (e.g., `java -Xmx64G -jar RNA-Bloom.jar ...`).
*   **Read IDs**: For long-read assembly, ensure your read IDs are not purely integers (e.g., "1", "2"), as these conflict with internal ID mapping. Use `seqtk rename` if necessary.
*   **Strand Specificity**: If your library is strand-specific (typically F2R1 orientation), use the `-stranded` flag and ensure `-left` points to the sense reads and `-right` to the antisense reads.
*   **Output Files**:
    *   `rnabloom.transcripts.fa`: The primary assembly (transcripts > 200bp by default).
    *   `rnabloom.transcripts.nr.fa`: A non-redundant version of the assembly, useful for downstream analysis.
*   **Input Compression**: RNA-Bloom natively supports GZIP-compressed FASTQ/FASTA files.

## Reference documentation
- [RNA-Bloom GitHub Repository](./references/github_com_bcgsc_RNA-Bloom.md)
- [Bioconda RNA-Bloom Package](./references/anaconda_org_channels_bioconda_packages_rnabloom_overview.md)