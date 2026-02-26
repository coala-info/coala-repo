---
name: genin2
description: Genin2 assigns genotypes to European H5 clade 2.3.4.4b viruses by classifying genomic segments from FASTA files. Use when user asks to identify virus genotypes, classify influenza segments, or perform genomic surveillance on H5 avian influenza samples.
homepage: https://github.com/izsvenezie-virology/genin2
---


# genin2

## Overview

Genin2 is a high-performance bioinformatics tool designed to assign genotypes to European H5 clade 2.3.4.4b viruses collected since October 2020. It utilizes a prediction model to classify segments (PB2, PB1, PA, NP, NA, MP, NS) and determine the overall genotype based on established epidemiological patterns. The tool is optimized for speed and low resource consumption, making it suitable for large-scale genomic surveillance.

## Installation

Install via Conda (Bioconda) or Pip:

```bash
conda install bioconda::genin2
# OR
pip install genin2
```

## Input Requirements

Genin2 requires a nucleotidic, IUPAC-encoded FASTA file. The most critical requirement is the **FASTA header format**, which the tool uses to group segments by sample and identify the segment type.

### Header Pattern
Headers must start with `>` and end with an underscore (`_`) followed by the segment name.
*   **Format**: `>Sample_Identifier_SEGMENT`
*   **Valid Segments**: `PB2`, `PB1`, `PA`, `NP`, `NA`, `MP`, `NS` (HA is ignored as the clade is assumed).
*   **Example**: `>A/chicken/Italy/12345/2023_PB1`

## Command Line Usage

### Basic Prediction
Run the analysis and save results to a Tab-Separated Values (TSV) file:
```bash
genin2 -o output.tsv input.fasta
```

### Adjusting Coverage Thresholds
By default, Genin2 discards sequences with a coverage ratio below 0.7 (ratio of non-N characters to the internal reference length). You can adjust this sensitivity:
```bash
# Relax the limit for lower quality sequences
genin2 --min-seq-cov 0.5 -o output.tsv input.fasta

# Increase the limit for higher confidence
genin2 --min-seq-cov 0.9 -o output.tsv input.fasta
```

## Interpreting Results

The output TSV contains 11 columns. Key columns include:
*   **Genotype**: The assigned European genotype. If uncertain, it displays `[unassigned]`.
*   **Sub-genotype**: Specific sub-clustering for lineages like EA-2024-DI.
*   **Segment Columns (4-10)**: The specific version classification for each internal segment. A `?` indicates a missing or low-quality segment.
*   **Notes**: Provides reasons for failures, such as "insufficient data" or "low quality."

## Expert Tips

*   **Batch Processing**: You can include multiple samples and multiple segments per sample in a single FASTA file. Genin2 automatically groups them using the text before the final underscore in the header.
*   **Partial Genomes**: The tool does not require all 8 segments to run. It will provide segment-level classifications even if a full genotype cannot be uniquely assigned.
*   **Updating Models**: Genotypes are updated regularly. Ensure you are using the latest version to recognize new emerging clades: `pip install --upgrade genin2`.

## Reference documentation
- [Genin2 Overview](./references/anaconda_org_channels_bioconda_packages_genin2_overview.md)
- [Genin2 GitHub Documentation](./references/github_com_izsvenezie-virology_genin2.md)