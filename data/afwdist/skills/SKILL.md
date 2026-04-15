---
name: afwdist
description: afwdist calculates pairwise distance metrics between groups of genetic variants using allele frequencies. Use when user asks to calculate genetic distances between samples, compare intra-patient viral populations, or measure distances against a reference genome.
homepage: https://github.com/PathoGenOmics-Lab/afwdist
metadata:
  docker_image: "quay.io/biocontainers/afwdist:1.0.0--h4349ce8_0"
---

# afwdist

A lightweight tool for calculating pairwise distance metrics between groups of genetic variants. It accounts for both fixed and non-fixed (minority) allele frequencies, making it ideal for intra-patient viral population analysis.

## Installation

Install via Bioconda:
```bash
conda install bioconda::afwdist
```

## Input Requirements

### 1. Variant Table (CSV)
The input CSV must contain the following columns:
- `sample`: Unique identifier for the group/patient.
- `position`: Integer coordinate of the variant.
- `sequence`: The alternate allele sequence.
- `frequency`: Real number (0.0 to 1.0) representing the relative frequency of the variant.

### 2. Reference Genome (FASTA)
The reference sequence used for variant calling. `afwdist` uses this to infer the frequency of reference alleles (assuming `1 - sum(variant_frequencies)` at each site).

## Core Usage

### Basic Distance Calculation
Calculate distances between all pairs of samples listed in the input CSV:
```bash
afwdist --input variants.csv --reference genome.fasta --output distances.csv
```

### Including the Reference as a Baseline
To calculate the distance of every sample against the reference genome (treating the reference as a sample with 100% fixed reference alleles):
```bash
afwdist -i variants.csv -r genome.fasta -o distances.csv --include-reference
```

## Command Line Options

| Option | Description |
|--------|-------------|
| `-i, --input <FILE>` | Path to the input CSV variant table. |
| `-r, --reference <FILE>` | Path to the reference FASTA file. |
| `-o, --output <FILE>` | Path for the output CSV distance matrix. |
| `-s, --include-reference` | Includes the reference sequence as a virtual sample in the comparison. |
| `-v, --verbose` | Enables debug logging. |

## Output Format

The output is a CSV file with three columns:
1. `sample_m`: Identifier of the first sample.
2. `sample_n`: Identifier of the second sample.
3. `distance`: The calculated pairwise distance metric.

## Best Practices

- **Reference Consistency**: Ensure the FASTA file provided is the exact same version used during the mapping and variant calling process to avoid coordinate mismatches.
- **Data Preparation**: If starting from VCF files, you must first convert them to the required 4-column CSV format. Ensure frequencies are normalized between 0 and 1.
- **Sample Naming**: Ensure sample identifiers are unique. The tool will issue a warning if non-unique sample names are detected.
- **Memory Efficiency**: `afwdist` is implemented in Rust and is highly efficient, but for extremely large datasets (millions of variants), ensure sufficient RAM is available for the internal frequency vectors.