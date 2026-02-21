---
name: parascopy
description: Parascopy is a specialized bioinformatics suite designed to resolve the complexities of duplicated genomic regions.
homepage: https://github.com/tprodanov/parascopy
---

# parascopy

## Overview
Parascopy is a specialized bioinformatics suite designed to resolve the complexities of duplicated genomic regions. In standard WGS analysis, reads from highly similar paralogs are often mismapped or assigned low mapping quality. Parascopy overcomes this by using a multi-locus approach to estimate copy numbers and identify variants specific to individual paralogs. Use this skill when you need to process BAM/CRAM files to distinguish between gene copies (e.g., SMN1/SMN2) or analyze regions with high homology.

## Installation and Environment
Parascopy requires Python ≥ 3.6 and several external tools (samtools, tabix, bgzip, bwa). For variant calling, a modified version of Freebayes is required.

```bash
# Recommended installation via Bioconda
conda install -c bioconda parascopy
```

## Core Workflow

### 1. Constructing a Homology Table
Before analysis, you must define the duplicated regions. The reference genome must be indexed with `samtools faidx` and `bwa index`.

```bash
# Step 1: Generate pre-table
parascopy pretable -f genome.fa -o pretable.bed.gz

# Step 2: Generate final homology table
parascopy table -i pretable.bed.gz -f genome.fa -o table.bed.gz
```
*Tip: For human data (GRCh37, GRCh38, CHM13), use precomputed homology tables to save time.*

### 2. Background Read Depth Calculation
Calculate the expected depth to normalize copy number estimations.

```bash
# -I accepts a text file with one BAM/CRAM path per line
parascopy depth -I input.list -g hg38 -f genome.fa -o depth_output
```

### 3. Estimating Copy Number (agCN and psCN)
This is the primary analysis step to determine the total and paralog-specific copy numbers.

```bash
parascopy cn -I input.list -t table.bed.gz -f genome.fa -R regions.bed -d depth_output -o cn_analysis
```

### 4. Variant Calling
Variant calling is performed on top of a completed copy number analysis.

```bash
parascopy call -p cn_analysis -f genome.fa -t table.bed.gz
```

## Expert Tips and Best Practices

### Handling Sex Chromosomes
By default, Parascopy treats X and Y as regular autosomes. Use the `--modify-ref` argument with a BED file to specify correct reference copy numbers for male/female samples.
*   **Format**: `CHROM START END SAMPLES CN`
*   **Example**: `chrX 0 inf SAMPLE_MALE 1`

### Working with ALT Contigs
If your BAM/CRAM files were mapped to a reference containing ALT contigs, you must:
1. Use a homology table constructed on that specific reference.
2. Use `--modify-ref` to set the reference copy number of all ALT contigs to 0.

### Reusing Model Parameters
For large cohorts or clinical pipelines, you can speed up analysis by using model parameters from a previous run:
```bash
parascopy cn-using previous_analysis/model -I new_samples.list -t table.bed.gz -f genome.fa -d new_depth -o new_analysis
```

### Input Handling
*   **Sample Naming**: Override or provide sample names using the syntax `path/to/file.bam::SampleName` in your input list.
*   **File Formats**: Both BAM and CRAM are supported; ensure they are sorted and indexed.

## Reference documentation
- [Parascopy Main Documentation](./references/github_com_tprodanov_parascopy.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_parascopy_overview.md)