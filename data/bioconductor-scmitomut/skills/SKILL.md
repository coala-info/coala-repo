---
name: bioconductor-scmitomut
description: This tool identifies and visualizes lineage-related mitochondrial DNA somatic mutations from single-cell sequencing data using beta-binomial models. Use when user asks to identify somatic mutations in mtDNA, fit beta-binomial models to allele frequency data, filter mutations by quality metrics, or generate mutation heatmaps.
homepage: https://bioconductor.org/packages/release/bioc/html/scMitoMut.html
---


# bioconductor-scmitomut

name: bioconductor-scmitomut
description: Analysis of single-cell mitochondrial DNA (mtDNA) somatic mutations using the scMitoMut R package. Use this skill to identify lineage-related mutations, fit beta-binomial models to allele frequency data, filter mutations based on quality metrics, and visualize results via heatmaps.

# bioconductor-scmitomut

## Overview

`scMitoMut` is a Bioconductor package designed to identify and visualize lineage-related somatic mutations in mitochondrial DNA from single-cell sequencing data. It typically processes allele count data (e.g., from `mgatk`) by storing it in an HDF5-based "mtmutObj" to manage memory efficiently. The package uses a beta-binomial distribution model to distinguish true somatic mutations from sequencing noise.

## Workflow and Key Functions

### 1. Data Initialization
The package uses HDF5 files as a backend. You can parse raw tables or direct `mgatk` output.

```r
library(scMitoMut)

# Parse a table or mgatk output to create an H5 file
f_h5 <- parse_table("path/to/counts.tsv.gz", h5_file = "data.h5")
# Or: f_h5 <- parse_mgatk("path/to/mgatk_output/", h5_file = "data.h5")

# Open the H5 file to create the mtmutObj
x <- open_h5_file(f_h5)
```

### 2. Subsetting
Filter for high-quality cells or specific loci of interest to reduce computation time.

```r
# Subset by cell barcodes (e.g., from Seurat metadata)
x <- subset_cell(x, cell_ids)

# Subset by specific mitochondrial loci
x <- subset_locus(x, loc_ids)
```

### 3. Mutation Calling
The package fits a beta-binomial model to the allele frequency distribution to calculate p-values for each locus in each cell.

```r
# Run model fitting (supports multi-core)
run_model_fit(x, mc.cores = 4)
```

### 4. Filtering and Exporting
Filter mutations based on the number of mutant cells and significance thresholds (FDR).

```r
# Filter loci
x <- filter_loc(x, min_cell = 5, model = "bb", p_threshold = 0.05, p_adj_method = "fdr")

# Export data to standard R formats
af_matrix <- export_af(x)      # Allele Frequency matrix
pval_matrix <- export_pval(x)  # P-value matrix
df_long <- export_df(x)        # Long-format data.frame
```

### 5. Visualization
Generate heatmaps for binary mutation status, p-values, or allele frequencies.

```r
# Define annotation colors for the heatmap
ann_colors <- list(CellType = c("TypeA" = "red", "TypeB" = "blue"))

# Plot heatmap (type can be "binary", "p", or "af")
plot_heatmap(x, cell_ann = metadata, ann_colors = ann_colors, type = "binary")
```

## Technical Tips
- **Memory Management**: Since data is stored in HDF5, the `mtmutObj` does not load the entire dataset into RAM. Use `h5ls(x$h5f)` to inspect the file structure.
- **Interpolation**: In `plot_heatmap`, `percent_interp` helps order cells by assuming mutations in the same lineage are correlated. Set `percent_interp = 1` to disable this behavior.
- **Mutation Definition**: A locus is called a mutation if the reference allele frequency is significantly lower than expected based on the wild-type model.

## Reference documentation

- [Analysis of colon cancer dataset](./references/Analysis_colon_cancer_dataset.md)