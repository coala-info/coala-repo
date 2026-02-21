---
name: gqt
description: GQT (Genotype Query Tools) is a high-performance command-line interface for interacting with massive genomic datasets.
homepage: https://github.com/ryanlayer/gqt
---

# gqt

## Overview

GQT (Genotype Query Tools) is a high-performance command-line interface for interacting with massive genomic datasets. Unlike traditional variant-centric tools that scan entire VCF files, GQT uses compressed bitmap indices to represent genotypes. This architecture allows for interactive-speed queries even on datasets with millions of genomes. It excels at "sample-centric" workflows, such as identifying variants that meet specific frequency thresholds within a sub-population defined by external phenotype data.

## Core Workflow

### 1. Indexing Genotype Data
GQT requires a BCF file as input. Before indexing with GQT, the BCF must have a CSI index created by `bcftools`.

```bash
# Step A: Create CSI index
bcftools index input.bcf

# Step B: Create GQT index files (.gqt, .bim, .vid)
gqt convert bcf -i input.bcf
```

### 2. Creating the Sample Database
To query based on sample metadata, you must create a SQLite database. This can be done using only the BCF (for sample names) or by incorporating a PED file for richer metadata.

```bash
# Create database from BCF only
gqt convert ped -i input.bcf

# Create database with metadata from a PED file
gqt convert ped -i input.bcf -p metadata.ped
```
*Note: By default, GQT expects the sample ID in the second column of the PED file. Use `-c` to specify a different column.*

### 3. Querying Variants
The `query` command uses two primary filters:
- `-p`: A SQL-style filter for sample metadata (defined in the `.db` file).
- `-g`: A genotype-based filter (e.g., frequency or zygosity).

```bash
# Example: Find variants with MAF > 10% in the 'GBR' population
gqt query \
  -i input.bcf.gqt \
  -d metadata.ped.db \
  -p "Population = 'GBR'" \
  -g "maf() > 0.1" > output.vcf

# Example: Find variants where at least 2 specific individuals are heterozygous
gqt query \
  -i input.bcf.gqt \
  -p "BCF_Sample in ('ID1','ID2','ID3')" \
  -g "count(HET) >= 2" > output.vcf
```

## Common Query Functions

| Function | Description |
| :--- | :--- |
| `maf()` | Minor Allele Frequency within the selected sample set. |
| `count(HET)` | Number of heterozygous individuals in the set. |
| `count(HOM_ALT)` | Number of homozygous alternate individuals in the set. |
| `count(HOM_REF)` | Number of homozygous reference individuals in the set. |
| `count(ANY)` | Number of individuals with any non-reference genotype. |
| `pct(HET)` | Percentage of heterozygous individuals in the set. |

## Expert Tips

- **Metadata Sanitization**: When creating a database from a PED file, GQT converts spaces in header names to underscores and removes special characters (%, $, :). Ensure your `-p` queries reflect these sanitized column names.
- **Multiple Filters**: You can chain multiple `-p` and `-g` arguments to refine results. GQT returns variants that satisfy the intersection of all provided filters.
- **Performance**: GQT is significantly faster than `bcftools view` for complex genotype-based filtering because it avoids decompressing the entire VCF/BCF record for every query.
- **Output Redirection**: GQT outputs VCF format to `stdout`. Always redirect to a file or pipe into `bgzip`.

## Reference documentation
- [GQT GitHub Repository](./references/github_com_ryanlayer_gqt.md)
- [Bioconda GQT Package](./references/anaconda_org_channels_bioconda_packages_gqt_overview.md)