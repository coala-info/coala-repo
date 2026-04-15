---
name: bioconductor-rgsepd
description: This tool automates an RNA-Seq pipeline that integrates differential expression analysis and gene set enrichment to create projection displays for sample classification. Use when user asks to perform differential expression with DESeq2, conduct functional enrichment with GOSeq, or generate projection displays to score samples between conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/rgsepd.html
---

# bioconductor-rgsepd

name: bioconductor-rgsepd
description: RNA-Seq Gene Set Enrichment and Projection Display (rgsepd) for streamlining differential expression (DESeq2) and functional analysis (GOSeq). Use this skill to automate the pipeline from transcript counts to novel 'projection displays' that score samples on an axis between conditions, particularly useful for complex human tissue samples with low replicate counts.

# bioconductor-rgsepd

## Overview

The `rgsepd` package automates a bioinformatics pipeline for RNA-Seq data. It integrates differential expression analysis (via `DESeq2`) and gene set enrichment (via `goseq`) to create "Projection Displays." These displays project samples into a multidimensional space defined by gene sets (GO Terms), allowing for the scoring of samples along a trajectory from "control" to "treatment." This is especially effective for identifying outliers or classifying unknown samples based on their functional expression profiles.

## Core Workflow

### 1. Initialization
Prepare a count matrix (rows as RefSeq IDs, columns as samples) and a metadata data frame.

```R
library(rgsepd)

# counts: matrix of integer read counts (RefSeq NM/NR identifiers)
# sampleMeta: data frame with 'Condition' and 'SHORTNAME' columns
G <- GSEPD_INIT(Output_Folder = "results_dir",
                finalCounts = counts,
                sampleMeta = metadata,
                COLORS = c(blue="#4DA3FF", gold="#FFFF4D"))
```

### 2. Defining Comparisons
Specify which conditions in the metadata should be compared.

```R
# Compare condition "A" vs "B"
G <- GSEPD_ChangeConditions(G, c("A", "B"))
```

### 3. Parameter Tuning (Optional)
Adjust thresholds before running the pipeline to control figure generation and sensitivity.

```R
G$MAX_Genes_for_Heatmap <- 50  # Max rows in gene heatmaps
G$MaxGenesInSet <- 30          # Max genes allowed in a GO term to be processed
G$LIMIT$LFC <- 1               # Log2 Fold Change threshold (default 1 = 2x)
G$LIMIT$HARD <- FALSE          # If FALSE, forces plots even if results aren't significant
```

### 4. Execution
Run the full automated pipeline. This generates CSVs and PDFs in the output folder.

```R
G <- GSEPD_Process(G)
# Or to run all possible pairwise comparisons:
# G <- GSEPD_ProcessAll(G)
```

## Visualization and Results

### Automated Outputs
The `GSEPD_Process` function populates the output folder with:
*   `DESEQ.RES...csv`: Differential expression results.
*   `GOSEQ.RES...csv`: Enriched GO terms.
*   `GSEPD.HMA...pdf`: The primary Projection Display (Alpha scores). Blue/Gold indicates similarity to condition A or B.
*   `HM...pdf`: Heatmaps of significant genes with variance-stabilized counts.
*   `GSEPD.PCA...pdf`: PCA plots for all genes and DEGs.

### Manual Plotting
You can trigger specific plots using the G object after processing.

```R
# Plot PCA
GSEPD_PCA_Plot(G)

# Plot Heatmap for specific genes
isoform_ids <- Name_to_RefSeq(c("GAPDH", "EGFR"))
GSEPD_Heatmap(G, isoform_ids)
```

## Key Concepts for Interpretation

*   **Alpha Score:** A sample's position on the axis between two conditions for a specific gene set. 0 is perfectly like the control, 1 is perfectly like the treatment.
*   **Beta Score:** The distance of a sample from the axis. High Beta scores indicate the sample's expression pattern for that gene set does not fit the linear transition between conditions.
*   **Segregation P-value:** Used to determine if a GO Term significantly separates the groups in the projection space.

## Tips
*   **Naming:** Ensure sample names in the count matrix match the metadata. Avoid spaces or special characters in condition names, as R converts these to periods, which can break matching.
*   **Identifiers:** The package expects RefSeq identifiers (NM_ or NR_). Use `Name_to_RefSeq()` for conversions.
*   **Performance:** Calculating projections for very large gene sets is slow. Use `G$MaxGenesInSet` to filter out overly broad categories.

## Reference documentation
- [rgsepd](./references/rgsepd.md)