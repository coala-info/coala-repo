---
name: malva
description: MALVA (Mapping-free ALternate-allele detection of known VAriants) is a specialized tool for genotyping individuals using a k-mer based approach.
homepage: https://algolab.github.io/malva/
---

# malva

## Overview

MALVA (Mapping-free ALternate-allele detection of known VAriants) is a specialized tool for genotyping individuals using a k-mer based approach. Instead of aligning reads to a reference genome, it extracts k-mers from the sample and compares them against k-mers representing the reference and alternate alleles of known variants. This process is significantly faster than traditional alignment-based pipelines and is particularly effective for well-characterized variant sets.

## Installation and Setup

The most reliable way to deploy MALVA is via Bioconda:

```bash
conda create -n malva_env -c bioconda malva
conda activate malva_env
```

## Core Workflows

### 1. The Integrated Pipeline (Recommended)
The `MALVA` bash script provides a convenient wrapper that handles both k-mer counting (via KMC) and genotyping.

```bash
MALVA [options] <reference.fa> <variants.vcf> <sample.fastq> > output.vcf
```

### 2. Manual Multi-step Execution
For more control or when integrating into custom pipelines, run the components individually:

1.  **K-mer Counting (KMC):**
    ```bash
    mkdir -p kmc_tmp
    kmc -k43 -fm <sample.fastq> kmc_output kmc_tmp
    ```
2.  **Indexing:**
    ```bash
    malva-geno index -k 35 -r 43 <reference.fa> <variants.vcf> kmc_output
    ```
3.  **Genotyping:**
    ```bash
    malva-geno call -k 35 -r 43 <reference.fa> <variants.vcf> kmc_output > genotyped.vcf
    ```

## Expert Tips and Best Practices

### Parameter Tuning
- **K-mer Sizes (`-k`, `-r`):** The default values (`-k 35`, `-r 43`) are optimized for the human genome. For smaller or less complex genomes, smaller k-mers may be used, but ensure `-r` (reference k-mer size) is larger than `-k`.
- **Bloom Filter Size (`-b`):** The default is 4GB. For very large variant sets or high-depth samples, increase this to reduce false positive k-mer matches (e.g., `-b 8` or `-b 16`).
- **A Priori Frequencies (`-f`):** MALVA uses allele frequencies to improve genotyping accuracy. Ensure the `-f` flag matches the specific INFO key in your input VCF (e.g., `-f AF` or `-f EUR_AF`). Use `-u` to ignore frequencies and use uniform probabilities.

### Specialized Modes
- **Haploid Genotyping:** Use the `-1` or `--haploid` flag when working with bacterial, viral, or organellar DNA, or when genotyping male sex chromosomes.
- **Memory Management:** When using the wrapper script, use `-m` to limit the RAM used by KMC (default is 4GB).

### Input Requirements
- **Reference:** FASTA format (can be gzipped).
- **Variants:** VCF format (can be gzipped). It must contain the frequency information specified by the `-f` flag unless `-u` is used.
- **Sample:** FASTA or FASTQ format (can be gzipped).

## Reference documentation
- [MALVA: genotyping by Mapping-free ALternate-allele detection of known VAriants](./references/algolab_github_io_malva.md)
- [malva - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_malva_overview.md)