---
name: microphaser
description: Microphaser is a specialized bioinformatics tool designed for tumor neoantigen discovery.
homepage: https://github.com/koesterlab/microphaser
---

# microphaser

## Overview

Microphaser is a specialized bioinformatics tool designed for tumor neoantigen discovery. It phases small DNA sequences in linear time to accurately represent the mutated peptidome of a tumor. By integrating tumor BAM files with variant calls and transcript annotations, it produces the specific amino acid sequences resulting from somatic mutations. This is a critical step for downstream MHC-binding affinity predictions, as it accounts for the local genomic context of mutations.

## Installation

Install microphaser via Bioconda:

```bash
conda install -c bioconda microphaser
```

## Core Workflow

### 1. Somatic Phasing
Generate neopeptides by phasing tumor reads against somatic and germline variants.

**Required Inputs:**
- Sorted and indexed tumor BAM file.
- Reference genome (FASTA).
- VCF/BCF file containing variants (Somatic variants must have the `SOMATIC` tag in the INFO field).
- Gene/Transcript annotation (GTF) provided via STDIN.

```bash
microphaser somatic tumor.bam \
  -r reference.fasta \
  -b all_variants.bcf \
  -t neopeptides.info.tsv \
  -n peptides.wt.fasta \
  < annotation.gtf > peptides.mt.fasta
```

### 2. Healthy Peptidome Generation
To filter out neopeptides that might match the patient's normal peptidome, first generate the healthy sequences.

```bash
microphaser normal normal.bam \
  -r reference.fasta \
  -b germline_variants.bcf \
  < annotation.gtf > healthy_peptides.fasta
```

### 3. Build Reference Binary
Convert the healthy peptides into a binary format for efficient comparison during filtering.

```bash
microphaser build_reference \
  -r healthy_peptides.fasta \
  -o peptides.bin > peptides.translated.fasta
```

### 4. Candidate Filtering
Filter the somatic neopeptides against the healthy reference to remove self-similar candidates.

```bash
microphaser filter \
  -r peptides.bin \
  -t neopeptides.info.tsv \
  -o neopeptides.filtered.info.tsv \
  -n normal_peptides.filtered.fasta \
  > neopeptides.filtered.fasta
```

## Best Practices and Tips

- **VCF Tagging**: Ensure somatic variants are explicitly flagged with `SOMATIC` in the INFO column. Microphaser relies on this tag to distinguish between germline background and tumor-specific mutations.
- **GTF Requirements**: Use standard Ensembl or GENCODE GTF files. Ensure the chromosome names in the GTF match those in your FASTA and BAM files (e.g., "chr1" vs "1").
- **Memory Management**: For very large datasets, monitor memory usage during the `somatic` submodule execution, as phasing complex regions with high depth can be resource-intensive.
- **Output Interpretation**: The `.info.tsv` file contains critical metadata including allele frequency (`freq`), read depth (`depth`), and the specific amino acid changes (`somatic_aa_change`). Use these metrics to prioritize candidates for MHC-binding assays.

## Reference documentation
- [Microphaser GitHub Repository](./references/github_com_koesterlab_microphaser.md)
- [Bioconda Microphaser Overview](./references/anaconda_org_channels_bioconda_packages_microphaser_overview.md)