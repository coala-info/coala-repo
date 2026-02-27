---
name: bioconductor-mitch
description: "bioconductor-mitch implements a rank-MANOVA approach to detect enriched gene sets across multi-dimensional biological data. Use when user asks to integrate multiple differential expression contrasts, perform multi-omics pathway enrichment analysis, or identify gene sets consistently altered across different experimental layers."
homepage: https://bioconductor.org/packages/release/bioc/html/mitch.html
---


# bioconductor-mitch

## Overview

The `mitch` package implements a rank-MANOVA approach to detect enriched gene sets in multi-dimensional space. Unlike traditional enrichment methods that handle one contrast at a time, `mitch` can integrate multiple contrasts (e.g., RNA-seq and Proteomics, or multiple treatment conditions) to identify pathways that are consistently altered across different "layers" of biological data.

## Core Workflow

### 1. Import Gene Sets
Import gene sets from GMT files or use provided example data.
```r
library(mitch)
# From a GMT file
genesets <- gmt_import("pathways.gmt")

# Example data
data(genesetsExample)
```

### 2. Import and Preprocess Profiling Data
`mitch_import` converts differential expression tables (from limma, edgeR, DESeq2, etc.) into a scored format. By default, it calculates a score $D = \text{sgn}(\text{logFC}) \times -\log_{10}(p\text{-value})$.

**Standard Multi-contrast Import:**
```r
# x is a list of dataframes from upstream tools
x <- list("rna" = rna_df, "prot" = protein_df)
y <- mitch_import(x, DEtype = "edgeR", joinType = "full")
```

**Methylation Array Import:**
For Infinium arrays (450k/EPIC), you must provide a `geneTable` to map probes to genes.
```r
# gt1 is a 2-column dataframe: gene, probe
y <- mitch_import(meth_de_table, DEtype = "limma", geneTable = gt1)
```

### 3. Calculate Enrichment
Use `mitch_calc` to perform the rank-MANOVA test.
```r
# priority="effect" prioritizes by s.dist (enrichment score)
# priority="significance" prioritizes by p-value
res <- mitch_calc(y, genesets, priority = "effect", cores = 2)

# View top results
head(res$enrichment_result)
```

### 4. Visualization and Reporting
`mitch` provides automated reporting and high-level visualization functions.

```r
# Generate interactive HTML report
mitch_report(res, "pathway_report.html")

# Generate PDF charts
mitch_plots(res, outfile = "pathway_plots.pdf")

# Network visualization of gene set similarities
networkplot(res, FDR = 0.05, n_sets = 20)

# Get specific genes driving the enrichment
drivers <- network_genes(res, FDR = 0.05)
```

## Key Parameters and Tips

- **joinType**: In `mitch_import`, use `"inner"` (default) to keep only genes found in all contrasts, or `"full"` to keep all genes (filling missing values with zero).
- **minsetsize**: In `mitch_calc`, the default is 10. Adjust this based on your gene set library.
- **Priority**: Use `priority = "effect"` when you want to find pathways with the largest magnitude of change, even if p-values are slightly higher due to small gene set sizes.
- **Gene Symbols**: Ensure gene symbols in your profiling data match those in your GMT file. For methylation data, use `HGNChelper` to update deprecated symbols before running `mitch_import`.

## Reference documentation

- [Applying mitch to pathway analysis of Infinium Methylation array data](./references/infiniumMethArrayWorkflow.md)
- [mitch Workflow](./references/mitchWorkflow.md)