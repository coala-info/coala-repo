---
name: bioconductor-ideal
description: The bioconductor-ideal package provides a framework for interactive differential expression analysis of RNA-seq data by wrapping DESeq2 and Shiny. Use when user asks to perform interactive differential expression analysis, visualize RNA-seq results with MA or volcano plots, or generate reproducible reports from transcriptomic data.
homepage: https://bioconductor.org/packages/release/bioc/html/ideal.html
---

# bioconductor-ideal

## Overview
The `ideal` package provides a comprehensive framework for Interactive Differential Expression Analysis. It serves as a bridge between raw RNA-seq counts and biological interpretation by wrapping `DESeq2` for statistical testing and providing interactive visualizations. It is designed to facilitate both exploratory data analysis and formal reporting, supporting workflows that transition from interactive discovery to reproducible R code.

## Core Workflow

### 1. Data Preparation
To use `ideal`, you typically need a `DESeqDataSet` object. You can also provide precomputed results and annotations to speed up the interface.

```R
library(ideal)
library(DESeq2)
library(airway)

# Load example data
data("airway")
dds <- DESeqDataSet(airway, design = ~ cell + dex)
dds <- DESeq(dds)

# Optional: Precompute results
res <- results(dds, contrast = c("dex", "trt", "untrt"), alpha = 0.05)

# Optional: Create annotation data frame
library(org.Hs.eg.db)
anno <- data.frame(
  gene_id = rownames(dds),
  gene_name = mapIds(org.Hs.eg.db, keys = rownames(dds), column = "SYMBOL", keytype = "ENSEMBL"),
  row.names = rownames(dds),
  stringsAsFactors = FALSE
)
```

### 2. Launching the App
The `ideal()` function starts the Shiny dashboard. It can be called with varying levels of precomputed data.

*   **Full initialization:** `ideal(dds_obj = dds, res_obj = res, annotation_obj = anno)`
*   **Minimal initialization:** `ideal(dds_obj = dds)` (results will be computed inside the app)
*   **From raw counts:** `ideal(countmatrix = counts, expdesign = design)`

### 3. Standalone Functions
`ideal` exports several functions for use in standard R scripts outside the interactive app:

*   **Visualization:**
    *   `plot_ma(res_obj)`: Generates an enhanced MA plot with optional gene labeling.
    *   `plot_volcano(res_obj)`: Creates a volcano plot for effect size vs. significance.
    *   `mosdef::gene_plot(dds, gene)`: (Replaces `ggplotCounts`) Plots normalized counts for a specific gene across groups.
*   **Result Processing:**
    *   `mosdef::deresult_to_df(res)`: (Replaces `deseqresult2tbl`) Converts DESeqResults to a tidy data frame.
    *   `sepguesser(file_path)`: Heuristically determines the delimiter of a text file.
*   **Functional Analysis:**
    *   `mosdef::run_goseq(de_genes, all_genes)`: (Replaces `goseqTable`) Performs GO enrichment accounting for gene length bias.

## Key Features & Tips

*   **Interactive Reporting:** Use the "Report Editor" tab within the app to generate an HTML report. This captures the current state of the analysis into a reproducible R Markdown document.
*   **Gene Signatures:** The "Signatures Explorer" allows uploading `.gmt` files (e.g., from MSigDB) to visualize the behavior of specific gene sets via heatmaps.
*   **Functional Analysis:** The app supports three GO methods: `limma::goana`, `topGO`, and `goseq`. Clicking a GO term in the results table automatically generates a heatmap of the genes in that pathway.
*   **State Saving:** Use the cog icon in the top right to "Exit ideal & save" or "Save State as .RData". This allows you to resume an interactive session later or inspect reactive values in the R console.
*   **Integration:** If coming from `edgeR` or `limma-voom`, use the `DEFormats` package to convert objects to `DESeqDataSet` before calling `ideal()`.

## Reference documentation
- [ideal User's Guide](./references/ideal-usersguide.md)