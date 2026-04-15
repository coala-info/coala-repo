---
name: fufihla
description: FuFiHLA is a bioinformatics pipeline that generates high-accuracy HLA allele calls and consensus sequences from long-read sequencing data. Use when user asks to perform HLA typing, prepare IMGT reference data, or generate consensus sequences from PacBio or Nanopore reads.
homepage: https://github.com/jingqing-hu/FuFiHLA
metadata:
  docker_image: "quay.io/biocontainers/fufihla:0.2.4--hdfd78af_0"
---

# fufihla

## Overview
FuFiHLA (Full Field HLA typing for Long reads) is a specialized bioinformatics pipeline that generates high-accuracy HLA allele calls and consensus sequences without requiring a specific reference genome like GRCh38. It is particularly effective for clinical research involving transplant-related genes. This skill provides the necessary procedures for preparing reference data, executing the pipeline on different long-read platforms, and interpreting the resulting allele calls.

## Reference Preparation
Before running the pipeline for the first time or when updated IMGT/HLA data is required, you must prepare the reference allele sequences.

```bash
# Downloads and prepares the latest IMGT reference allele sequences
fufihla-ref-prep
```
This command creates a `ref_data` directory containing `ref.gene.fa.gz`.

## Core CLI Usage

### Standard Execution (PacBio HiFi)
By default, the tool assumes PacBio HiFi input.
```bash
fufihla --fa input_reads.fa.gz --out output_directory
```

### Oxford Nanopore (ONT) Execution
When using Nanopore data, explicitly set the technology flag to adjust the internal mapping and consensus parameters.
```bash
fufihla --fa input_reads.fq.gz --out output_directory --ont
```

### Advanced Options
- `--refdir <path>`: Use a specific version of reference data instead of the default bundled set.
- `--debug`: Retain all intermediate files (useful for troubleshooting or inspecting alignments). By default, only consensus results are kept.

## Workflow Best Practices

### Targeted Extraction from WGS BAM
If you have whole-genome sequencing (WGS) data in BAM format, extract the relevant HLA regions first to significantly speed up processing and reduce noise.

```bash
# 1. Create a BED file for the six target genes (GRCh38 coordinates)
echo "chr6 29942254 29945755
chr6 31268254 31272571
chr6 31353362 31357442
chr6 32578769 32589848
chr6 32636717 32643200
chr6 32660031 32667132" > hla_regions.bed

# 2. Extract and compress reads
samtools view -bh input.bam --region-file hla_regions.bed | samtools fasta | gzip -c > hla_reads.fa.gz

# 3. Run FuFiHLA
fufihla --fa hla_reads.fa.gz --out hla_results
```

### Interpreting Results
The primary output is found in `<output_dir>.out`. It uses a PAF-like format with a `cs` tag to indicate match quality.

- **Perfect Match**: A `cs:Z::[length]` tag (e.g., `cs:Z::3503`) indicates a perfect match to a known allele over the specified length.
- **Novel Alleles**: If the `cs:Z` tag contains substitutions (`*`), insertions (`+`), or deletions (`-`), the sample likely contains a novel allele or a variant not present in the current IMGT database.
- **Consensus Sequences**: Located in `<outdir>/consensus/*_asm*.fa`. These are the reconstructed sequences for each detected allele.

## Reference documentation
- [FuFiHLA GitHub Repository](./references/github_com_jingqing-hu_FuFiHLA.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_fufihla_overview.md)