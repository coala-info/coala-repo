---
name: decifer
description: DeCiFer (Descendant Cell Fraction) is a computational method used to analyze the clonal structure of tumors.
homepage: https://github.com/raphael-group/decifer
---

# decifer

## Overview
DeCiFer (Descendant Cell Fraction) is a computational method used to analyze the clonal structure of tumors. It moves beyond standard Cancer Cell Fraction (CCF) analysis by accounting for the loss of mutations due to deleterious copy-number events. Use this skill to prepare the specific multi-line header TSV inputs required by the tool, execute the clustering algorithm, and manage the Single Split Copy Number (SSCN) assumptions used to enumerate potential genotype sets.

## Installation and Environment
The most reliable way to run DeCiFer is via a dedicated Conda environment:
```bash
conda create -n decifer decifer -y -c bioconda
conda activate decifer
```
Note: DeCiFer is primarily written in Python 2.7. If installing manually, ensure dependencies like `numpy`, `scipy`, `pandas`, and `seaborn` are present in a legacy Python environment.

## Input Data Requirements
DeCiFer requires three primary pieces of information formatted in specific tab-separated files.

### 1. Mutation and Copy Number TSV
This file requires a strict three-line header:
- **Line 1**: Number of mutations
- **Line 2**: Number of samples
- **Line 3**: `#sample_index sample_label character_index character_label ref var`

**Data Columns:**
- `sample_index`: Unique integer for the sample.
- `sample_label`: String name for the sample.
- `character_index`: Unique integer for the mutation.
- `character_label`: String name for the mutation.
- `ref`: Count of reference allele reads.
- `var`: Count of alternate (variant) allele reads.
- `A B U`: Allele-specific copy numbers (A, B) and the proportion of cells (U) with that genotype. Multiple genotypes for a single segment must be listed as additional `A B U` triplets.

### 2. Purity File
A two-column TSV file without a header:
- Column 1: `SAMPLE-INDEX`
- Column 2: `TUMOUR-PURITY` (float between 0 and 1)

## Common CLI Patterns

### Basic Execution
Run the main algorithm using the `decifer` command.
```bash
decifer <input_mutation_file> <purity_file> [options]
```

### Using Beta-Binomial Distribution
By default, DeCiFer uses a binomial distribution for clustering. For data with higher variance (overdispersion), use the beta-binomial flag:
```bash
decifer <input_mutation_file> <purity_file> --betabinomial
```

### Preprocessing with vcf_2_decifer.py
Before running the main algorithm, use the provided helper script to convert VCF files into the required DeCiFer format.
- Use `--min_purity_depth` to filter out low-coverage sites in low-purity samples.
- Use `--exclude_list` with a BED file to mask specific genomic regions (e.g., blacklisted regions).

## Expert Tips and Best Practices
- **SSCN Assumption**: DeCiFer operates under the Single Split Copy Number assumption. If your biological model suggests complex, multi-step copy number evolutions at a single locus, results should be interpreted with caution.
- **Low Purity Samples**: Mutations in samples with very low tumor purity (< 0.15) often produce unreliable DCF estimates. Use the `--min_purity_depth` filter during preprocessing to mitigate this.
- **Multiplicity Selection**: DeCiFer simultaneously selects the most likely mutation multiplicity (number of copies of the mutation per cell) while clustering. This is more robust than pre-calculating multiplicities before clustering.
- **Outlier Detection**: Check the output for a separate 'Outliers' file. DeCiFer flags mutations that do not fit well into any cluster, which may indicate sequencing artifacts or violations of the evolutionary model.

## Reference documentation
- [DeCiFer Overview](./references/anaconda_org_channels_bioconda_packages_decifer_overview.md)
- [GitHub Repository and Usage](./references/github_com_raphael-group_decifer.md)