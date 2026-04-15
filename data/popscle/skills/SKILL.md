---
name: popscle
description: Popscle identifies the sample origin of individual cells in multiplexed single-cell experiments by comparing sequencing reads against genetic variants. Use when user asks to generate variant pileups from BAM files, demultiplex cells using external genotypes, or cluster cells by genetic identity when genotypes are unavailable.
homepage: https://github.com/statgen/popscle
metadata:
  docker_image: "quay.io/biocontainers/popscle:0.1--ha0d7e29_1"
---

# popscle

## Overview

The `popscle` suite provides high-performance tools for identifying the sample origin of individual cells in multiplexed single-cell experiments. It operates by comparing the genetic variants observed in single-cell sequencing reads against known or inferred genotypes. The workflow typically involves a two-step process: first, generating a pileup of variants across barcodes using `dsc-pileup`, and second, assigning identities using either `demuxlet` (when external genotypes are available) or `freemuxlet` (when they are not).

## Core Workflow and CLI Patterns

### 1. Data Preparation (dsc-pileup)
Before demultiplexing, you must generate pileup files. This avoids re-scanning large BAM files if you need to re-run the deconvolution with different parameters.

```bash
popscle dsc-pileup \
  --sam input.bam \
  --vcf reference_panel.vcf.gz \
  --out output_prefix
```

**Expert Tips:**
- **Speed up processing**: Use `--group-list` to provide a `barcodes.tsv` file (e.g., from CellRanger). This limits analysis to valid cells and significantly reduces runtime.
- **Reference Panel**: Use a high-quality reference VCF (like 1000 Genomes or HapMap) containing allele frequencies (AF).

### 2. Genotype-Based Demultiplexing (demuxlet)
Use this when you have a VCF containing the specific genotypes of the individuals pooled in the experiment.

```bash
popscle demuxlet \
  --plp output_prefix \
  --vcf sample_genotypes.vcf.gz \
  --field GT \
  --out demux_results
```

**Key Parameters:**
- `--field`: Specify whether to use hard genotypes (`GT`), posterior probabilities (`GP`), or genotype likelihoods (`PL/GL`). `GT` is most common for high-quality SNP arrays.
- `--alpha`: (Default 0.5) Adjusts the expected proportion of genetic mixture in doublets.

### 3. Genotyping-Free Demultiplexing (freemuxlet)
Use this when external genotypes are unavailable. It clusters cells based on shared genetic variations.

```bash
popscle freemuxlet \
  --plp output_prefix \
  --nsample 5 \
  --out freemux_results
```

**Key Parameters:**
- `--nsample`: The exact number of unique individuals expected in the pool.

## Interpreting Results

### The .best (demuxlet) and .clust1.samples.gz (freemuxlet) files
These are the primary output files. Key columns include:
- **BARCODE**: The cell barcode.
- **DROPLET.TYPE**: Classified as `SNG` (Singlet), `DBL` (Doublet), or `AMB` (Ambiguous).
- **BEST.GUESS**: The assigned sample ID(s). For singlets, it shows the ID twice (e.g., `ID1,ID1`). For doublets, it shows both contributors (e.g., `ID1,ID2`).
- **BEST.POSTERIOR**: The confidence score of the assignment.

## Best Practices
- **Memory Management**: For very large datasets, ensure `htslib` is properly configured and use the pileup workflow rather than running `demuxlet --sam` directly to save time on iterations.
- **Filtering**: Ensure your input VCF is filtered for high-confidence SNPs. Including too many low-quality variants can increase noise and lead to `AMB` (Ambiguous) calls.
- **ATAC-seq**: While designed for RNA-seq, `popscle` can be used for scATAC-seq demultiplexing provided the BAM file has proper barcode tags (default `--tag-group CB` and `--tag-UMI UB`).



## Subcommands

| Command | Description |
|---------|-------------|
| popscle_demuxlet | Deconvolute sample identify of droplet-based sc-RNAseq |
| popscle_digital-pileup | Produce pileup of dsc-RNAseq (old version of dsc-pileup) |
| popscle_dsc-dump | Produce a file dump of dsc-RNAseq |
| popscle_dsc-dump2plp | Produce a pileup from a dump of dsc-RNAseq |
| popscle_dsc-pileup | Produce pileup of dsc-RNAseq |
| popscle_freemuxlet | Genotype-free deconvolution of sc-RNAseq |
| popscle_freemuxlet-old | Genotype-free deconvolution of sc-RNAseq (deprecated) |
| popscle_plp-make-dge-matrix | Make Digital Expression Matrix from Digital Pileups |

## Reference documentation
- [popscle GitHub Overview](./references/github_com_statgen_popscle.md)
- [popscle Wiki and Tutorial](./references/github_com_statgen_popscle_wiki.md)