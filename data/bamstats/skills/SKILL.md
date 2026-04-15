---
name: bamstats
description: bamstats extracts detailed mapping metrics and genomic region coverage from BAM files. Use when user asks to generate mapping statistics, compute coverage across genomic features, or calculate insert size distributions.
homepage: https://github.com/guigolab/bamstats
metadata:
  docker_image: "quay.io/biocontainers/bamstats:0.3.5--he881be0_0"
---

# bamstats

## Overview
bamstats is a high-performance command-line tool written in Go that extracts detailed mapping metrics from BAM files. It provides a comprehensive breakdown of alignment quality, including general mapping statistics, genomic region coverage (essential for RNA-seq), and IHEC-compliant quality metrics. The tool is particularly effective for identifying the distribution of reads across genomic features and calculating insert size statistics for paired-end libraries.

## Installation
The most reliable way to install bamstats is via Bioconda:
```bash
conda install bioconda::bamstats
```
Alternatively, pre-compiled binaries are available for Linux and macOS via GitHub releases.

## Core Command Line Usage

### Basic Mapping Statistics
To generate general mapping statistics (total reads, mapped/unmapped counts, multimapping tags, and insert sizes):
```bash
bamstats -i input.bam
```

### Genomic Coverage Analysis
To compute coverage across genomic regions (exon, intron, intergenic, etc.), you must provide an annotation file:
```bash
bamstats -i input.bam -a annotation.gtf
```

### Filtering for Unique Mappings
To report genome coverage statistics specifically for uniquely mapped reads (reported as an additional `coverageUniq` JSON object):
```bash
bamstats -i input.bam -a annotation.gtf --uniq
```

## Statistics Categories

| Category | Metrics Included |
| :--- | :--- |
| **General** | Total reads, unmapped/mapped counts, multimap counts (NH tag), mapping ratios, and insert size distribution (for paired-end). |
| **Genome Coverage** | Counts for exons, introns, exonic-intronic boundaries, and intergenic regions for both continuous and split reads. |
| **RNA-seq (IHEC)** | Intergenic counts, ribosomal RNA (rRNA) counts, and duplicate fractions. |

## Expert Tips and Best Practices

- **JSON Processing**: bamstats outputs data in JSON format. For automated workflows or quick CLI inspections, pipe the output to `jq`:
  ```bash
  bamstats -i input.bam | jq '.general'
  ```
- **Ulimit Constraints**: If processing BAM files with a very high number of references (chromosomes/contigs), the tool may fail if it exceeds the system's open file limit. Increase the limit before running: `ulimit -n 2048`.
- **Annotation Compatibility**: While the tool supports GTF/GFF, ensure your annotation's chromosome names exactly match the BAM header. Note that some Ensembl GTF attributes (like `gene_biotype`) may occasionally cause parsing issues in older versions; prefer standard `gene_type` tags where possible.
- **Multimapping**: bamstats relies on the `NH` tag in the BAM file to calculate multimapping statistics. Ensure your aligner (e.g., STAR, HISAT2) populates this tag if you require multimapping ratios.

## Reference documentation
- [Bamstats GitHub Repository](./references/github_com_guigolab_bamstats.md)
- [Bioconda bamstats Overview](./references/anaconda_org_channels_bioconda_packages_bamstats_overview.md)
- [Known Issues and Limitations](./references/github_com_guigolab_bamstats_issues.md)