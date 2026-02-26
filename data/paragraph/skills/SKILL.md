---
name: paragraph
description: Paragraph genotypes structural variants by realigning short-read data to directed acyclic graphs representing genomic variations. Use when user asks to genotype structural variants from a VCF, perform graph-based read realignment, or prepare sample manifests for population-scale genomic analysis.
homepage: https://github.com/Illumina/paragraph
---


# paragraph

## Overview

Paragraph is a specialized genotyping suite that addresses the limitations of linear reference mapping for structural variants (SVs). By constructing a directed acyclic graph (DAG) for each variant and realigning reads to these graphs, it provides more accurate genotyping than traditional methods, especially in complex or repetitive genomic regions. It is designed for short-read data and supports both single-sample and population-scale analysis.

## Core Workflows

### 1. Standard Genotyping from VCF
The primary entry point for most users is `multigrmpy.py`, which automates the genotyping of variants listed in a VCF file across one or more samples.

```bash
python3 bin/multigrmpy.py \
    -i candidates.vcf \
    -m samples_manifest.txt \
    -r reference.fa \
    -o output_directory \
    -t 8 \
    -M 600
```

### 2. Manifest File Preparation
The manifest file is a tab-delimited or comma-delimited file required for multi-sample runs.

**Required Columns:**
- `id`: Unique sample identifier.
- `path`: Full path to the BAM or CRAM file.
- `depth`: Average genomic depth.
- `read length`: Average read length in base pairs.

**Optional Columns:**
- `depth sd`: Standard deviation of depth (defaults to `sqrt(5 * depth)`).
- `sex`: "male"/"M" or "female"/"F"; affects sex chromosome genotyping.

### 3. Custom Graph Genotyping
For complex events not easily represented in VCF, use a custom JSON graph with the `grmpy` or `paragraph` tools.

```bash
# Genotype a specific graph JSON
bin/grmpy \
    -m samples_manifest.txt \
    -r reference.fa \
    -i variant_graph.json \
    -o output.json \
    -E 1
```

## Input Requirements

### VCF Format (4.0+)
Paragraph supports indel-style (full sequence) and symbolic alleles.
- **`<DEL>`**: Must include `END` in the INFO field.
- **`<INS>`**: Must include an INFO key for the sequence (default: `SEQ`).
- **`<DUP>`**: Must include `END` in the INFO field; assumes sequence between POS and END is duplicated.
- **`<INV>`**: Must include `END` in the INFO field; assumes sequence between POS and END is reverse-complemented.

## Expert Tips and Best Practices

- **Depth Calculation**: Use the included `bin/idxdepth` tool to calculate average genome depth. it is significantly faster than standard `samtools` depth calculations for manifest preparation.
- **Handling High-Depth Regions**: Use the `-M` (maximum allowed read count) option to skip variants in low-complexity regions with abnormal pileups. A recommended value is **20 times the mean sample depth**.
- **Population Genotyping**: For large cohorts, run `multigrmpy.py` in single-sample mode for each individual and then merge the resulting VCFs using `bcftools merge`. This is more efficient than running a single massive manifest.
- **Thread Management**: Use the `-t` flag to enable multithreading, which is critical for processing large VCFs or population-scale data.
- **Output Interpretation**:
    - `genotypes.vcf.gz`: Standard VCF output containing individual genotypes.
    - `genotypes.json.gz`: Detailed JSON output containing alignment counts and model scores for every path in the graph.

## Reference documentation
- [Illumina Paragraph GitHub Repository](./references/github_com_Illumina_paragraph.md)
- [Paragraph Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_paragraph_overview.md)