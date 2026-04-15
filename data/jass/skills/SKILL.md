---
name: jass
description: JASS performs joint analysis of GWAS summary statistics to identify pleiotropic effects and connect disease variants with biological mechanisms. Use when user asks to create an HDF5 database of harmonized statistics, perform multi-trait omnibus or SumZ tests, and generate Manhattan or quadrant plots for joint genetic analyses.
homepage: http://statistical-genetics.pages.pasteur.fr/jass/
metadata:
  docker_image: "quay.io/biocontainers/jass:2.3--pyhca03a8a_0"
---

# jass

## Overview
JASS (Joint Analysis of Summary Statistics) is designed to connect disease variants with biological mechanisms by analyzing multiple traits simultaneously. It operates primarily on GWAS summary statistics, allowing researchers to identify pleiotropic effects and boost statistical power without requiring individual-level genotype data. The workflow typically involves preparing an "inittable" (an HDF5 database of harmonized statistics) and then creating "worktables" for specific project-based joint analyses.

## Data Preparation
Before running joint analyses, you must consolidate your GWAS results into a single HDF5 initial table.

### 1. Input Requirements
- **GWAS Results**: Tab-separated files per chromosome. Naming must follow `z_{CONSORTIUM}_{TRAIT}_chr{n}.txt`. Columns required: `rsID`, `pos`, `A0` (effect allele), `A1`, and `Z`.
- **Description File**: A TSV mapping consortium/trait names to metadata (Nsample, Type, etc.).
- **Region File**: A BED file defining independent LD blocks (e.g., Berisa & Pickrell 2015).
- **Covariance (Optional)**: A TSV of trait correlations under H0. If omitted, JASS estimates this from low-signal Z-scores.

### 2. Creating the Inittable
```bash
jass create-inittable \
  --input-data-path "path/to/z_files/*.txt" \
  --init-covariance-path covariance.csv \
  --regions-map-path regions.bed \
  --description-file-path metadata.tsv \
  --init-table-path my_database.hdf5
```

## Joint Analysis Workflows
Use `create-project-data` to perform the actual multi-trait tests and generate plots in one step.

### Omnibus Test (Default)
Best for detecting any association across the selected traits.
```bash
jass create-project-data \
  --init-table-path my_database.hdf5 \
  --phenotypes z_CONSORTIUM_TRAIT1 z_CONSORTIUM_TRAIT2 \
  --worktable-path project_results.hdf5 \
  --manhattan-plot-path manhattan.png \
  --quadrant-plot-path quadrant.png
```

### SumZ Test (Linear Combination)
Best when you have a specific hypothesis about the direction of effects.
```bash
jass create-project-data \
  --init-table-path my_database.hdf5 \
  --phenotypes z_TRAIT1 z_TRAIT2 \
  --worktable-path sumz_results.hdf5 \
  --sumz \
  --custom-loadings weights.csv
```
*Note: `weights.csv` should be a two-column CSV with `trait` and `weight` headers.*

## Result Extraction and Visualization
JASS outputs are stored in HDF5 format. You can extract specific tables to TSV for downstream analysis.

### Extracting Tables
Common keys for `--table-key`:
- `SumStatTab`: SNP-level joint results.
- `Regions`: Lead SNPs and summary statistics per LD region.
- `summaryTable`: Comparison of univariate vs. joint test significance.

```bash
jass extract-tsv \
  --hdf5-table-path project_results.hdf5 \
  --tsv-path output_results.tsv \
  --table-key SumStatTab
```

### Specialized Plots
If you already have a worktable, you can generate plots individually:
- **Quadrant Plot**: `jass plot-quadrant --worktable-path <path> --plot-path <path>` (Compares joint p-values vs. best univariate p-values).
- **QQ Plot**: `jass qq-plot --worktable-path <path> --plot-path <path>` (Note: Memory intensive).

## Expert Tips
- **Outlier Filtering**: By default, `--post-filtering` is True. This removes SNPs with aberrant Z-scores that might inflate joint statistics.
- **Local Analysis**: Use `--chromosome-number`, `--start-position`, and `--end-position` with `create-worktable` to focus on a specific genomic locus rather than the whole genome.
- **Memory Management**: For large datasets, adjust `--chunk-size` (default 50) to control how many LD regions are loaded into memory simultaneously.



## Subcommands

| Command | Description |
|---------|-------------|
| jass add-gene-annotation | Add gene annotation to an initial table. |
| jass clean-project-data | Cleans project data by removing files that have not been accessed for a specified number of days. |
| jass create-inittable | Creates an initial table for JASS based on input data and configuration. |
| jass create-project-data | Create project data for JASS |
| jass create-worktable | Create a worktable for JASS analysis. |
| jass extract-tsv | Extracts data from an HDF5 table to a TSV file. |
| jass list-phenotypes | List available phenotypes |
| jass plot-manhattan | Generates a Manhattan plot from a JASS worktable. |
| jass plot-quadrant | Generates a quadrant plot from a worktable. |
| jass qq-plot | Generates a QQ plot from a worktable. |

## Reference documentation
- [Command line reference](./references/statistical-genetics_pages_pasteur_fr_jass_command_line_usage.html.md)
- [Data preparation](./references/statistical-genetics_pages_pasteur_fr_jass_data_import.html.md)
- [Compute Multi-trait GWAS with JASS](./references/statistical-genetics_pages_pasteur_fr_jass_generating_joint_analysis.html.md)