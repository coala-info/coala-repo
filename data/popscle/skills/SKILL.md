---
name: popscle
description: The popscle suite provides a robust framework for demultiplexing pooled single-cell libraries by leveraging genetic variation.
homepage: https://github.com/statgen/popscle
---

# popscle

## Overview
The popscle suite provides a robust framework for demultiplexing pooled single-cell libraries by leveraging genetic variation. It allows researchers to identify which individual a specific cell belongs to and detect "doublets" (droplets containing cells from two different individuals). The workflow typically involves a two-step process: first, generating a pileup of genetic variants across barcodes using `dsc-pileup`, and second, performing the actual deconvolution using either `demuxlet` (if reference genotypes are available) or `freemuxlet` (if they are not).

## Core Workflow

### 1. Generating Pileups (dsc-pileup)
Before running demultiplexing, you must generate pileup files. This step extracts base calls at known variant sites for each cell barcode.

```bash
popscle dsc-pileup \
    --sam input.bam \
    --vcf reference_variants.vcf.gz \
    --out output_prefix
```

**Key Parameters:**
- `--sam`: Aligned reads (BAM/SAM/CRAM).
- `--vcf`: Reference VCF containing population allele frequencies (e.g., 1000 Genomes).
- `--group-list`: (Recommended) A text file of valid barcodes (e.g., `barcodes.tsv` from CellRanger) to restrict analysis to high-quality cells and speed up processing.

### 2. Demultiplexing with Genotypes (demuxlet)
Use this when you have external genotype data (e.g., from a SNP array) for the individuals in the pool.

```bash
popscle demuxlet \
    --plp output_prefix \
    --vcf external_genotypes.vcf.gz \
    --field GT \
    --out demux_results
```

**Key Parameters:**
- `--plp`: The prefix used in the `dsc-pileup` step.
- `--field`: The VCF field to use for genotypes (`GT`, `GP`, or `PL`). `GT` is standard for hard calls.
- `--alpha`: (Default 0.5) Assumed proportion of genetic mixture in doublets.

### 3. Genotype-Free Demultiplexing (freemuxlet)
Use this when external genotypes are unavailable. It clusters cells based on shared genetic variants.

```bash
popscle freemuxlet \
    --plp output_prefix \
    --nsample 4 \
    --out free_results
```

**Key Parameters:**
- `--nsample`: The exact number of individuals expected in the pool.

## Best Practices and Tips
- **VCF Filtering**: For `dsc-pileup`, use a VCF filtered for common variants (AF > 0.05) in transcribed regions to maximize the number of informative reads while minimizing noise.
- **Memory Management**: When working with large CRAM files, ensure `htslib` is properly configured in your environment, as `popscle` relies on it for stream processing.
- **Output Interpretation**:
    - **SNG (Singlet)**: High confidence single-sample droplet.
    - **DBL (Doublet)**: Droplet containing two different genotypes.
    - **AMB (Ambiguous)**: Insufficient data to confidently assign a type.
- **Direct BAM Input**: While `dsc-pileup` is recommended for speed in iterative runs, `demuxlet` can take a `--sam` file directly if you only plan to run the analysis once.

## Reference documentation
- [popscle GitHub README](./references/github_com_statgen_popscle.md)
- [popscle Wiki and Tutorial](./references/github_com_statgen_popscle_wiki.md)