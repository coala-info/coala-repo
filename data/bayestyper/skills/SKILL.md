---
name: bayestyper
description: BayesTyper genotypes a wide range of genomic variations using a k-mer-based variant graph approach to reduce reference bias. Use when user asks to genotype SNPs and structural variants, cluster variants for genotyping, or estimate genotypes from k-mer counts.
homepage: https://github.com/bioinformatics-centre/BayesTyper
---


# bayestyper

## Overview

BayesTyper is a specialized tool for genotyping a wide spectrum of genomic variations, ranging from single nucleotide polymorphisms (SNPs) to large structural variants (SVs). Unlike traditional callers that rely on linear read alignments, BayesTyper uses a variant graph approach. It decomposes candidate variants and the reference sequence into k-mers and uses a probabilistic model to estimate genotypes based on k-mer counts. This method is particularly effective at reducing reference bias and improving sensitivity for non-SNP variants.

## Installation and Setup

The most efficient way to install BayesTyper is via Bioconda:

```bash
conda install bioconda::bayestyper
```

**Note on k-mer size:** The default k-mer size is typically 55. If your research requires a different k-mer size, the tool must be compiled from source as the k-mer size is determined at compile-time.

## Core Workflow

The BayesTyper pipeline generally consists of three main stages: k-mer counting, variant clustering, and genotyping.

### 1. K-mer Counting
Before genotyping, you must generate k-mer counts from your raw sequencing reads (FASTQ/BAM). While BayesTyper is k-mer source agnostic, it is designed to work with counts from tools like KMC.

### 2. Variant Clustering (`bayesTyper cluster`)
This stage groups variants into clusters based on their proximity and k-mer sharing. This is a prerequisite for the genotyping engine.

### 3. Genotyping (`bayesTyper genotype`)
The final stage performs the actual inference.

**Standard Pattern:**
```bash
bayesTyper genotype --variant-clusters <clusters.bin> --kmer-counts <counts.bloom> --output-prefix <sample_id> --reference <ref.fa>
```

## Expert CLI Patterns and Tips

### Handling Complex Organisms and Ploidy
By default, BayesTyper assumes human ploidy levels. For other organisms or specific sex chromosomes, use a ploidy file:

```bash
bayesTyper genotype ... --chromosome-ploidy-file <ploidy.txt>
```
*The ploidy file should define the ploidy of each chromosome for both male and female individuals.*

### Optimizing for Small Variant Sets or Small Genomes
If your variant set contains very few SNVs (common when genotyping only specific SVs), use the noise genotyping mode to jointly estimate noise parameters and genotypes:

```bash
bayesTyper genotype ... --noise-genotyping
```
*Note: This mode is more computationally intensive but provides better posterior estimates when noise parameters are unstable.*

### Managing Complex Clusters
For regions with high variant density, you can adjust the maximum number of candidate haplotypes per sample. The default is 32, but increasing it can improve accuracy for complex clusters at the cost of runtime:

```bash
bayesTyper genotype ... --max-number-of-sample-haplotypes 64
```

### Filtering and Utility Operations
Use `bayesTyperTools` for pre- and post-processing tasks:

*   **Convert Alleles:** Use `convertAllele` to prepare SV insertions for genotyping. It supports sequences stored in `SEQ` or `SVINSSEQ` attributes.
*   **Filter by Origin:** Use the `filterAlleleCallsetOrigin` script to filter alleles based on their source (ACO attribute) if you are merging multiple candidate callsets.

## Reference documentation
- [BayesTyper GitHub Overview](./references/github_com_bioinformatics-centre_BayesTyper.md)
- [Bioconda BayesTyper Package](./references/anaconda_org_channels_bioconda_packages_bayestyper_overview.md)