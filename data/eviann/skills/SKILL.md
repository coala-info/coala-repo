---
name: eviann
description: EviAnn (Evidence Annotation) is a high-performance pipeline designed for the rapid annotation of eukaryotic genomes.
homepage: https://github.com/alekseyzimin/EviAnn_release
---

# eviann

## Overview

EviAnn (Evidence Annotation) is a high-performance pipeline designed for the rapid annotation of eukaryotic genomes. Unlike ab initio predictors, it relies strictly on empirical evidence—such as RNA-seq reads, transcripts, and protein alignments from related species—to identify protein-coding genes and long non-coding RNAs (lncRNAs). It is optimized for speed, capable of annotating mammalian-sized genomes in under an hour, and produces GFF3 outputs that are fully compliant with NCBI GenBank specifications.

## Installation and Environment

The recommended way to install EviAnn is via Bioconda to ensure all dependencies (minimap2, HISAT2, StringTie, etc.) are correctly managed.

```bash
conda create -n eviann
conda activate eviann
conda install bioconda::eviann
```

## Core Usage Patterns

The primary entry point is the `eviann.sh` script.

### Mandatory Arguments
- `-g FILE`: The genome sequence in FASTA format.
- `-r FILE`: A configuration file listing the evidence data (RNA-seq/transcripts).

### The Evidence List File (`-r`)
This file is the most critical input. Each line represents a single experiment or sample. Fields are space-separated:

**Format:** `/path/to/file1.ext [/path/to/file2.ext] tag`

**Supported Tags:**
- `fastq`: Illumina RNA-seq in FASTQ format (supports single or paired-end).
- `fasta`: Illumina RNA-seq in FASTA format.
- `bam`: Pre-aligned RNA-seq data in BAM format.

**Example `-r` file content:**
```text
/data/sample1_R1.fastq /data/sample1_R2.fastq fastq
/data/aligned_sample2.bam bam
/data/transcripts_related_species.fasta fasta
```

## Execution Best Practices

### Performance Tuning
EviAnn is highly parallelizable. Use the `-t` flag to match your server's capabilities.
```bash
eviann.sh -g genome.fasta -r evidence_list.txt -t 24
```

### Functional Annotation
To automatically add functional descriptions using the UniProt-SwissProt database, include the `-f` switch. This is highly recommended for generating submission-ready files.

### Annotating Without RNA-seq
If you lack RNA-seq data but have a very close relative (>95% DNA similarity), you can run EviAnn using only the transcripts and proteins from that relative genome listed in the `-r` file.

### Organelle Annotation
EviAnn supports the annotation of mitochondria and chloroplasts. Ensure the genome FASTA contains these sequences and the evidence file includes relevant organelle-specific transcripts.

## Expert Tips
- **Repeat Masking:** EviAnn does not require the genome to be soft-masked or hard-masked before running; it handles repeats internally.
- **Large Chromosomes:** The tool supports genomes up to 32Gbp and individual chromosomes exceeding 4Gbp.
- **NCBI Submission:** The output GFF3 is designed for direct use with the NCBI `table2asn` tool.
- **Pseudo-genes:** EviAnn automatically identifies and labels processed pseudo-genes, excluding their CDS from the final report to maintain annotation quality.

## Reference documentation
- [EviAnn GitHub Repository](./references/github_com_alekseyzimin_EviAnn_release.md)
- [Bioconda EviAnn Package Overview](./references/anaconda_org_channels_bioconda_packages_eviann_overview.md)