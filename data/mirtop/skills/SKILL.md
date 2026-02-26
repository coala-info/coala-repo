---
name: mirtop
description: mirtop is a command-line utility that provides a unified naming convention for miRNAs and their variants by converting alignment data into standardized GFF3 files. Use when user asks to annotate miRNA sequence variations, convert BAM files to mirGFF3 format, or export miRNA annotations to FASTA and text tables.
homepage: http://github.com/mirtop/mirtop
---


# mirtop

## Overview

mirtop is a command-line utility designed to provide a unified naming convention for miRNAs and their variants (isomiRs). By taking alignment data and reference annotations, it produces a standardized GFF3 output (mirGFF3) that describes the exact sequence variations—such as 5' and 3' trimming or additions—relative to the reference miRNA. This skill helps you navigate the tool's CLI to transform raw bioinformatics data into biologically meaningful annotations.

## Installation

The recommended way to install mirtop is via Bioconda:

```bash
conda install -c bioconda mirtop
```

## Core CLI Usage

The primary command for annotation is `mirtop gff`. This command converts BAM alignment files into the mirGFF3 format.

### Basic Command Structure

```bash
mirtop gff --sps <species> --hairpin <hairpin_fasta> --gtf <miRNA_gtf> -o <output_directory> <input_bam>
```

### Required Arguments

- `--sps`: The three-letter species code (e.g., `hsa` for Homo sapiens, `mmu` for Mus musculus).
- `--hairpin`: Path to the FASTA file containing hairpin sequences (usually from miRBase).
- `--gtf`: Path to the GFF3 or GTF file containing miRNA coordinates.
- `-o`: The output directory where results will be stored.
- `<input_bam>`: The BAM file containing reads aligned to the genome or precursors.

## Common Workflow Patterns

### 1. Annotating a Single Sample
To annotate a single BAM file and generate a GFF3 file:
```bash
mirtop gff --sps hsa --hairpin hairpin.fa --gtf hsa.gff3 -o annotation_results sample1.bam
```

### 2. Processing Multiple Samples
mirtop can accept multiple BAM files at once to create a multi-sample GFF3:
```bash
mirtop gff --sps hsa --hairpin hairpin.fa --gtf hsa.gff3 -o multi_sample_results sample1.bam sample2.bam sample3.bam
```

### 3. Exporting to Other Formats
Once you have a GFF3 file, you can use the `export` command to convert it to other formats like FASTA or text tables:
```bash
mirtop export --format fasta -o export_dir input.gff
```

## Expert Tips

- **Reference Consistency**: Ensure that the chromosome/sequence names in your BAM file exactly match those in your `--hairpin` FASTA and `--gtf` files. Mismatched headers are the most common cause of empty output files.
- **BAM Requirements**: While mirtop is flexible, it is best practice to use BAM files that are sorted and indexed.
- **IsomiR Identification**: mirtop is specifically optimized to detect non-templated additions (NTA) and shifts in the 5' or 3' ends. If your research focuses on miRNA isoforms, always use the `gff` command to ensure these variations are captured in the mirGFF3 output.
- **Species Codes**: Always use the official miRBase three-letter codes for the `--sps` parameter to ensure compatibility with downstream tools.

## Reference documentation

- [GitHub Repository](./references/github_com_miRTop_mirtop.md)
- [Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mirtop_overview.md)