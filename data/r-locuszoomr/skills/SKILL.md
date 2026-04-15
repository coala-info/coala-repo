---
name: r-locuszoomr
description: The r-locuszoomr package creates publication-ready gene locus plots with gene annotations, linkage disequilibrium overlays, and recombination rates in R. Use when user asks to visualize GWAS results, create regional locus plots, overlay LD information, or plot eQTL data with Ensembl gene tracks.
homepage: https://cran.r-project.org/web/packages/locuszoomr/index.html
---

# r-locuszoomr

name: r-locuszoomr
description: Create publication-ready gene locus plots with gene annotations, linkage disequilibrium (LD) overlays, and recombination rates. Use this skill when you need to visualize GWAS results, eQTL data, or genomic regions with Ensembl gene tracks using R (base graphics, ggplot2, or plotly).

## Overview

`locuszoomr` is an R package for generating regional gene locus plots similar to the 'locuszoom' web tool but running locally. It integrates GWAS summary statistics with Ensembl gene annotations and can overlay LD information from LDlink and recombination rates from UCSC.

## Installation

The package requires Bioconductor dependencies for gene annotations.

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("ensembldb", "EnsDb.Hsapiens.v75")) # Example database
install.packages("locuszoomr")
```

## Core Workflow

### 1. Create a Locus Object
The `locus()` function is the entry point. It subsets your data and fetches gene annotations.

```r
library(locuszoomr)
library(EnsDb.Hsapiens.v75)

# data: dataframe with chrom, pos, p (or logP)
# gene: gene symbol to center on
# flank: distance in bp around the gene
loc <- locus(data = my_gwas_results, 
             gene = 'UBE2L3', 
             flank = 1e5, 
             ens_db = "EnsDb.Hsapiens.v75")
```

### 2. Add LD and Recombination Data
- **LD**: Use `link_LD()` (requires an LDlink API token) or provide an `r2` column in your data.
- **Recombination**: Use `link_recomb()` to fetch data from UCSC.

```r
# Using LDlink API
loc <- link_LD(loc, token = "your_token")

# Adding recombination rate
loc <- link_recomb(loc)
```

### 3. Plotting
The package supports three plotting engines:

- **Base Graphics**: `locus_plot(loc)` (Best for complex layouts/layering)
- **ggplot2**: `locus_ggplot(loc)` (Best for customization with `+ theme()`)
- **Plotly**: `locus_plotly(loc)` (Best for interactive exploration)

## Advanced Usage

### Customizing Labels and Points
In `locus_plot()`, use the `labels` argument. `"index"` automatically labels the top SNP.

```r
locus_plot(loc, labels = c("index", "rs12345"), label_x = c(4, -5))
```

### Layering Multiple Plots
Use `set_layers()` to stack multiple association plots (e.g., GWAS and eQTL) over a single gene track.

```r
oldpar <- set_layers(2)
scatter_plot(loc, xticks = FALSE) # Top plot
line_plot(loc, xticks = FALSE)    # Middle plot
genetracks(loc)                   # Bottom gene track
par(oldpar)
```

### Working with eQTLs
Use `link_eqtl()` to fetch GTEx data and `overlay_plot()` to visualize it against GWAS data.

```r
loc <- link_eqtl(loc, token = "your_token")
overlay_plot(loc, eqtl_gene = "IRF5")
```

### Finding Peaks Automatically
Use `quick_peak()` to identify lead SNPs across a whole GWAS dataset for batch plotting.

```r
pks <- quick_peak(my_gwas_data, pcut = 5e-08, dist = 1e6)
top_snps <- my_gwas_data$rsid[pks]
```

## Tips
- **Ensembl Databases**: For newer versions (e.g., v106+), use `AnnotationHub` to fetch the `EnsDb` object and pass it to the `ens_db` argument.
- **Gene Filtering**: Use `filter_gene_biotype = "protein_coding"` in plotting functions to declutter the gene track.
- **Y-axis**: Change the plotted variable using `yvar` (e.g., `yvar = "beta"`).

## Reference documentation
- [locuszoomr](./references/locuszoomr.Rmd)