---
name: ntroot
description: ntroot is a scalable framework for rapid ancestry prediction in human cohorts using k-mer based variant identification. Use when user asks to predict ancestry from sequencing reads, infer super-population origins from genome assemblies, perform local ancestry inference, or generate ancestry profiles from VCF files.
homepage: https://github.com/bcgsc/ntroot
---


# ntroot

## Overview

ntroot is a scalable framework designed for rapid ancestry prediction in human cohorts. It bypasses traditional, computationally expensive alignment steps by using k-mer based editing (via ntEdit) to identify variants and infer super-population origins. This skill provides the necessary command-line patterns to process raw reads, draft assemblies, or pre-existing VCF files to generate ancestry profiles suitable for population genetics and association studies.

## Core Workflows

### 1. Ancestry from Sequencing Reads
When starting with raw WGS data, provide the file prefix for the reads. ntroot will use these to detect SNVs against a reference.

```bash
ntroot -k 55 \
  --reference GRCh38.fa.gz \
  --reads SAMPLE_PREFIX_ \
  -l 1000GP_integrated_snv_v2a_27022019.GRCh38.phased_gt1.vcf.gz \
  -t 16
```

### 2. Ancestry from Genome Assemblies
If you have a draft or complete genome assembly (FASTA), use the `--genome` flag instead of `--reads`.

```bash
ntroot --reference GRCh38.fa.gz \
  --genome assembly.fasta \
  -l 1000GP_integrated_snv_v2a_27022019.GRCh38.phased_gt1.vcf.gz
```

### 3. Local Ancestry Inference (LAI)
To obtain ancestry predictions per genomic tile rather than a single global estimate, use the `--lai` flag. You can adjust the resolution with `--tile`.

```bash
ntroot --lai --tile 5000000 [other-required-args]
```

### 4. Using Pre-existing VCFs
If SNVs have already been called, you can skip the internal discovery step (ntEdit) and predict ancestry directly from a VCF.

```bash
ntroot -r GRCh38.fa.gz \
  --custom_vcf input_variants.vcf \
  -l 1000GP_integrated_snv_v2a_27022019.GRCh38.phased_gt1.vcf.gz
```

## Expert Tips and Best Practices

- **Input Mutual Exclusivity**: Never specify both `--reads` and `--genome` in the same command.
- **K-mer Selection**: A k-mer size (`-k`) of 55 is generally recommended for human genomic data to balance specificity and sensitivity.
- **Stringency Tuning**: The `-Y` parameter (default 0.55) controls the ratio of k-mers required to accept an edit. Increase this value for higher stringency if dealing with noisy data.
- **Resource Management**: Use the `-t` flag to specify threads. ntroot is designed for scale and benefits significantly from multi-threading during the k-mer processing phase.
- **Data Preparation**: Ensure the reference genome (`-r`) matches the coordinate system of the annotated variant file (`-l`). For human ancestry, the 1000 Genomes Project (1kGP) integrated variant call set is the standard reference.
- **Dry Runs**: Use the `-n` or `--dry-run` flag to preview the Snakemake pipeline commands before execution.

## Reference documentation
- [ntRoot GitHub Repository](./references/github_com_bcgsc_ntRoot.md)
- [ntroot Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ntroot_overview.md)