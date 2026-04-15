---
name: svim
description: SVIM identifies and classifies structural variants from long-read sequencing data by analyzing signatures of large-scale genomic variations. Use when user asks to call structural variants from aligned BAM files, detect genomic variations from raw PacBio or Nanopore reads, or distinguish between tandem and interspersed duplications.
homepage: https://github.com/eldariont/svim
metadata:
  docker_image: "quay.io/biocontainers/svim:2.0.0--pyhdfd78af_0"
---

# svim

## Overview

SVIM (Structural Variant Identification Method) is a specialized tool for analyzing third-generation sequencing data to identify large-scale genomic variations (>50bp). It excels at distinguishing between similar events, such as tandem versus interspersed duplications, by integrating information across the genome. The tool follows a four-stage pipeline: collecting signatures from individual reads, clustering those signatures, combining clusters into classified SVs, and finally genotyping the candidates.

## Core Workflows

### 1. Calling SVs from Aligned Reads (BAM)
The most common entry point is using an existing, coordinate-sorted, and indexed BAM file.

```bash
svim alignment <working_dir> <input.bam> <reference.fasta>
```

### 2. Calling SVs from Raw Reads
SVIM can handle the alignment step automatically if `minimap2` or `ngmlr` is installed.

```bash
# For PacBio reads (default)
svim reads <working_dir> <reads.fq> <reference.fasta>

# For Nanopore reads
svim reads --nanopore <working_dir> <reads.fq> <reference.fasta>
```

## Expert Tips and Best Practices

### Filtering Results
SVIM is designed to be highly sensitive and does not filter its output by default. The `variants.vcf` file will contain many low-confidence calls (e.g., supported by only 1-2 reads).
*   **Always filter by QUAL score**: The QUAL column in the VCF represents a score (0-100) based on read support and cluster consistency.
*   **Recommended Filter**: A common starting point is to filter for variants with a score $\ge 10$ or $\ge 15$, depending on your coverage.

### Handling Duplications
By default, SVIM classifies duplications as `DUP:TANDEM` or `DUP:INT`. If you are comparing results against truth sets (like GiaB) that only use `INS` labels:
*   Use `--tandem_duplications_as_insertions`
*   Use `--interspersed_duplications_as_insertions`

### Adjusting Sensitivity
*   **Minimum Size**: Use `--min_sv_size` (default 40) to adjust the detection threshold. For high-quality HiFi data, you might lower this; for noisy Nanopore data, you might increase it.
*   **Mapping Quality**: Use `--min_mapq` (default 20) to ignore reads in repetitive regions that may cause false positives.

### Output Customization
*   **Sequence Alleles**: To get actual sequences in the ALT field instead of symbolic tags (e.g., `<DEL>`), ensure you are using version 2.0+ where this is often default, or check `--symbolic_alleles` settings.
*   **Read Names**: Use `--read_names` to include the IDs of reads supporting each variant in the VCF INFO field, which is essential for manual curation in IGV.

## Common CLI Patterns

| Task | Command Option |
| :--- | :--- |
| **High Sensitivity** | `--min_sv_size 20 --min_mapq 10` |
| **High Precision** | `--min_mapq 30 --minimum_score 15` |
| **Translocation Focus** | Ensure `--max_sv_size` is set appropriately (default 100kb); variants larger than this are treated as translocations (`BND`). |
| **Skip Genotyping** | `--skip_genotyping` (saves time if only discovery is needed). |



## Subcommands

| Command | Description |
|---------|-------------|
| svim alignment | SVIM alignment |
| svim_reads | SVIM is a structural variant caller for long reads. |

## Reference documentation
- [SVIM Wiki Home](./references/github_com_eldariont_svim_wiki.md)
- [Command-line parameters](./references/github_com_eldariont_svim_wiki_Command-line-parameters.md)
- [SVIM Main README](./references/github_com_eldariont_svim.md)