---
name: gqt
description: The Genotype Query Tool (GQT) converts large genotype datasets into compressed bitmap indices to enable high-speed, sample-centric queries integrated with metadata. Use when user asks to index BCF files, create sample databases from PED files, or perform complex genotype filtering based on population phenotypes and allele frequencies.
homepage: https://github.com/ryanlayer/gqt
metadata:
  docker_image: "quay.io/biocontainers/gqt:1.1.3--h0263287_3"
---

# gqt

## Overview
The Genotype Query Tool (GQT) is a specialized command-line interface designed to handle massive genotype datasets by converting them into compressed bitmap indices. Unlike traditional variant-centric indexing, GQT enables interactive-speed queries by focusing on sample-level data. It integrates genotype information with sample metadata (phenotypes and pedigrees) stored in a SQLite database, allowing for complex multi-dimensional filtering that would be computationally prohibitive using standard tools.

## Core Workflow

### 1. Indexing Genotype Data
GQT requires a BCF file as input. If you have a VCF, convert it to BCF and index it with `bcftools` first.

```bash
# Create the GQT index
gqt convert bcf -i input.bcf
```
This produces three essential files:
- `.gqt`: The compressed bitmap index.
- `.bim`: Compressed variant metadata.
- `.vid`: Variant order information.

### 2. Creating the Sample Database
To query based on metadata (Population, Gender, etc.), you must create a SQLite database.

```bash
# Create database from BCF samples and a PED file
gqt convert ped -i input.bcf -p metadata.ped
```
**Note:** The PED file must have a header row. Column 2 is matched to BCF sample IDs by default (change with `-c`).

### 3. Querying the Index
The `query` command uses two primary filters:
- `-p`: A SQL-style string to filter samples based on the database.
- `-g`: A genotype-based filter string.

#### Common Query Patterns
- **Filter by Population and Frequency:**
  Find variants with a Minor Allele Frequency (MAF) > 10% in the GBR population.
  ```bash
  gqt query -i input.bcf.gqt -d metadata.db -p "Population = 'GBR'" -g "maf()>0.1"
  ```

- **Filter by Specific Individuals and Zygosity:**
  Find variants where at least two out of three specific individuals are heterozygous.
  ```bash
  gqt query -i input.bcf.gqt -p "BCF_Sample in ('ID1','ID2','ID3')" -g "count(HET)>1"
  ```

## Expert Tips and Best Practices

### Genotype Filter Functions (`-g`)
GQT supports several built-in functions for genotype filtering:
- `maf()`: Calculates the minor allele frequency within the sample set defined by `-p`.
- `count(TYPE)`: Counts occurrences of a genotype. Valid types: `HET`, `HOM_REF`, `HOM_ALT`, `UNKNOWN`, `ANY`.
- `pct(TYPE)`: Calculates the percentage of a genotype type.
- `is_het()`, `is_hom_ref()`, `is_hom_alt()`: Boolean checks for individual-level queries.

### Metadata Handling
- **Sanitization:** GQT automatically converts spaces in PED header fields to underscores and strips special characters (%, $, :).
- **Default Database:** If no PED file is provided during conversion, GQT creates a basic database (`.db`) containing only the sample names from the BCF.

### Performance Optimization
- **Pre-indexing:** Always ensure your BCF has a corresponding `.csi` index (via `bcftools index`) before running `gqt convert bcf` to allow GQT to automatically detect row and column counts.
- **Output Redirection:** GQT outputs VCF records to stdout. Always redirect to a file or pipe to `bgzip` for large result sets.



## Subcommands

| Command | Description |
|---------|-------------|
| gqt | gqt, v1.1.3 |
| gqt calpha | Calculates alpha diversity statistics between subpopulations. |
| gqt convert | Convert VCF/BCF to GQT index or sample phenotype database |
| gqt fst | Calculate Fst between populations. |
| gqt gst | Calculates GST and FST statistics for subpopulations. NOTE: gst and fst assume that variants are biallelic. If your data contains multiallelic sites, we recommend decomposing your VCF (see A. Tan, Bioinformatics 2015) prior to indexing. |
| gqt pca-shared | Performs Principal Component Analysis (PCA) on shared genotypes between populations. |
| gqt query | A GQT query returns a set of variants that meet some number of population and genotype conditions. Conditions are specified by a population query and genotype query pair, where the population query defines the set of individuals to consider and the genotype query defines a filter on that population. The result is the set of variants within that sub-population that meet the given conditions. |

## Reference documentation
- [GQT GitHub Repository](./references/github_com_ryanlayer_gqt.md)