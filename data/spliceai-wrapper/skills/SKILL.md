---
name: spliceai-wrapper
description: This tool accelerates SpliceAI variant annotation by using a caching layer and a precomputed SQLite3 database to avoid redundant computations. Use when user asks to annotate VCF files with splice site predictions, prepare a precomputed database of scores, or speed up variant interpretation pipelines.
homepage: https://github.com/bihealth/spliceai-wrapper
metadata:
  docker_image: "quay.io/biocontainers/spliceai-wrapper:0.1.0--0"
---

# spliceai-wrapper

## Overview

The `spliceai-wrapper` is a performance-focused utility designed to wrap Illumina's SpliceAI. Because raw SpliceAI predictions are computationally intensive (often limited to a few hundred variants per hour on a CPU), this wrapper introduces a caching layer. It works by first checking a precomputed SQLite3 database of known scores and a local session cache. Only variants not found in these resources are passed to the actual SpliceAI tool for prediction. This workflow significantly accelerates variant interpretation pipelines in clinical and research genomics.

## Installation

The recommended method for installation is via Bioconda:

```bash
conda install spliceai-wrapper
```

Ensure that `bcftools` and `spliceai` are also installed and available in your system PATH.

## Core Workflows

### 1. Preparing the Precomputed Database
Before annotating, you must convert the genome-wide precomputed scores (provided by the SpliceAI project) into a SQLite3 database for fast lookups.

```bash
spliceai-wrapper prepare \
    --release GRCh37 \
    --precomputed-db-path path/to/precomputed.sqlite3 \
    --precomputed-vcf-path path/to/spliceai_scores.vcf.gz
```

**Expert Tip:** Use the genome-wide files filtered to a score >= 0.1 to save significant disk space and improve lookup speed.

### 2. Annotating a VCF
To annotate your variants, provide the input VCF, the precomputed database created in the previous step, and a path for a local cache.

```bash
spliceai-wrapper annotate \
    --input-vcf INPUT.vcf.gz \
    --output-vcf OUTPUT.vcf.gz \
    --genes-tsv path/to/grch37.txt \
    --precomputed-db-path path/to/precomputed.sqlite3 \
    --cache-db-path path/to/cache.sqlite3 \
    --path-reference path/to/hs37d5.fa \
    --release GRCh37
```

## CLI Best Practices

- **Testing:** Use the `--head 500` parameter to run the tool on the first 500 variants of your file to verify the configuration and paths before committing to a full run.
- **Output Formats:** The tool determines the output format based on the file extension:
    - `.bcf`: Compressed BCF
    - `.vcf.gz` or `.vcf.bgz`: bgzipped VCF
    - All other extensions: Plain text VCF
- **Permissions:** The precomputed database (`--precomputed-db-path`) is accessed in read-only mode, allowing it to be shared across multiple users or processes. However, the cache database (`--cache-db-path`) must be in a directory where the user has write permissions.
- **Gene Filtering:** Variants located outside the genes defined in your `--genes-tsv` file are ignored. Ensure your gene list matches your reference genome release (GRCh37 vs GRCh38).
- **SNV Handling:** If an SNV is within a defined gene but is not found in the precomputed database, the wrapper assumes its score is < 0.1 (the standard threshold for the precomputed files) and will not trigger a new SpliceAI prediction for it.

## Reference documentation
- [spliceai-wrapper - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_spliceai-wrapper_overview.md)
- [GitHub - bihealth/spliceai-wrapper: Wrapper for Illumina SpliceAI that caches results](./references/github_com_bihealth_spliceai-wrapper.md)