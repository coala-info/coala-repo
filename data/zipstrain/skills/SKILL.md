---
name: zipstrain
description: ZipStrain is a high-performance bioinformatics tool designed for strain-level metagenomics.
homepage: https://github.com/OlmLab/ZipStrain
---

# zipstrain

## Overview

ZipStrain is a high-performance bioinformatics tool designed for strain-level metagenomics. It enables researchers to move beyond species-level identification by profiling specific nucleotide variations across microbial genomes. The tool follows a structured workflow: preparing reference data, profiling alignment (BAM) files into compact Parquet formats, and executing comparative analyses to detect fine-grained differences between samples.

## Installation and Setup

ZipStrain requires Python 3.12 or higher.

```bash
# Install via Conda
conda install bioconda::zipstrain

# Install via Pip
pip install zipstrain

# Verify installation
zipstrain test
```

## Core Workflow

### 1. Preparation
Before profiling, you must generate required metadata from your reference files.

```bash
zipstrain run prepare-profiling \
    --reference-fasta <path/to/ref.fasta> \
    --gene-fasta <path/to/genes.fasta> \
    --stb-file <path/to/stb_file> \
    --output-dir <output_directory>
```
**Required Outputs:** `genomes_bed_file.bed`, `genome_lengths.parquet`, and `gene_range_table.tsv`.

### 2. Profiling Samples
Profiling converts BAM files into nucleotide-level coverage tables. You must first create an input CSV with the header `sample_name,bamfile`.

```bash
zipstrain run profile \
    --input-table <path/to/samples.csv> \
    --stb-file <path/to/stb_file> \
    --gene-range-table <path/to/gene_range_table.tsv> \
    --bed-file <path/to/genomes_bed_file.bed> \
    --genome-length-file <path/to/genome_lengths.parquet> \
    --run-dir <output_directory>
```

### 3. Comparative Analysis
To compare strains across multiple samples, you must build a profile database and a comparison configuration.

**Build the Profile Database:**
Create a CSV with columns: `profile_name`, `profile_location`, `scaffold_location`, `reference_db_id`, `gene_db_id`.

```bash
zipstrain utilities build-profile-db \
    --profile-db-csv <path/to/profiles.csv> \
    --output-db <path/to/profile_db.parquet>
```

**Generate Comparison Configuration:**
This step defines the parameters for the comparison (e.g., minimum coverage).

```bash
zipstrain utilities build-comparison-config \
    --profile-db <path/to/profile_db.parquet> \
    --gene-db-id <gene_id> \
    --reference-db-id <ref_id> \
    --scope "all" \
    --min-cov 5 \
    --min-gene-compare-len 200 \
    --stb-file-loc <path/to/stb_file> \
    --output-file <path/to/config.json>
```

**Run Comparison:**
```bash
zipstrain run compare_genomes \
    --genome-comparison-object <path/to/config.json> \
    --run-dir <output_directory> \
    --max-concurrent-batches 1
```

## Expert Tips and Best Practices

- **Data Formats**: ZipStrain uses Parquet for its primary outputs (`.parquet`). These are highly compressed and faster to read than CSVs for large-scale metagenomic data.
- **STB Files**: Ensure your Scaffold-to-Bin (`.stb`) file correctly maps every scaffold in your reference FASTA to a genome ID; missing mappings will result in incomplete profiling.
- **Memory Management**: When running `compare_genomes`, use the `--max-concurrent-batches` flag to control memory usage. Increasing this number speeds up analysis but requires significantly more RAM.
- **Incremental Comparisons**: If you have already performed a comparison and added new samples, provide the `--current-comp-table` argument to `build-comparison-config` to only calculate the new pairs.

## Reference documentation
- [ZipStrain GitHub Repository](./references/github_com_OlmLab_ZipStrain.md)
- [Bioconda ZipStrain Overview](./references/anaconda_org_channels_bioconda_packages_zipstrain_overview.md)