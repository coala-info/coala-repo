---
name: bioconductor-adamgui
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ADAMgui.html
---

# bioconductor-adamgui

name: bioconductor-adamgui
description: Graphical User Interface for the ADAM package (Activity and Diversity Analysis Module). Use this skill to launch Shiny-based applications for visualizing Gene Functional Associated Groups (GFAG) analysis, including path-level heatmaps and target-level differential expression plots. Ideal for interactive exploration of GSEA results, gene diversity, and activity across comparative samples.

# bioconductor-adamgui

## Overview
ADAMgui provides a graphical interface for the ADAM package, which performs Gene Set Enrichment Analysis (GSEA) to group genes into Groups of Functionally Associated Genes (GFAGs) based on Gene Ontology or KEGG pathways. The package calculates p-values and q-values for gene diversity and activity between control and experimental samples. ADAMgui allows for interactive visualization of these statistical outputs through two primary Shiny modules.

## Installation
Install the package using BiocManager:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ADAMgui")
```

## Launching the GUIs
The package provides two main functions to launch interactive applications. These can be run in the R session or a web browser.

### GFAG Path Viewer: GFAGpathUi()
Use this module to construct heatmaps for q-values across different paths (e.g., GO terms or KEGG pathways).

```r
library(ADAMgui)
# Launch in default browser
GFAGpathUi(TRUE)
# Launch in local R session
GFAGpathUi(FALSE)
```

**Workflow in GFAGpathUi:**
1. **Data Input:** Upload the `GFAGAnalysis` output file (typically a .txt file).
2. **Data Selection:** Select the ID (Path) column and the P-value/Q-value columns to plot.
3. **Data Formatting:** Reorder or rename columns for the heatmap.
4. **Plot:** Customize font sizes, families, and plot dimensions, then download as .eps.

### GFAG Target Viewer: GFAGtargetUi()
Use this module to analyze specific targets (genes/proteins) within a selected GFAG. It visualizes differential expression and fold change.

```r
library(ADAMgui)
# Launch in default browser
GFAGtargetUi(TRUE)
```

**Required Input Files for Target Viewer:**
To use this module, you must provide four specific files:
1. **GFAG Data:** The output from `GFAGAnalysis`.
2. **Target Expression Data:** The raw or normalized expression values used in the analysis.
3. **Path-to-Target Data:** The relationship file (Gene-Function mapping).
4. **Differential Expression Data:** A file containing Target IDs, logFC values, and p-values/q-values.

## Data Preparation Example
If you need to generate sample input files from the built-in Aedes dataset:

```r
library(ADAMgui)
data("ResultAnalysisAedes")
data("ExpressionAedes")
data("GeneFunctionAedes")
data("DiffAedes")

# Save a subset for testing
write.table(ResultAnalysisAedes[1:10,], "ResultAnalysisAedes.txt", sep="\t", quote=FALSE, row.names=FALSE)
write.table(ExpressionAedes, "ExpressionAedes.txt", sep="\t", quote=FALSE, row.names=FALSE)
write.table(GeneFunctionAedes, "GeneFunctionAedes.txt", sep="\t", quote=FALSE, row.names=FALSE)
write.table(DiffAedes, "DiffAedes.txt", sep="\t", quote=FALSE, row.names=FALSE)
```

## Tips for Effective Use
- **Column Matching:** When using `GFAGpathUi` to merge multiple files, ensure the ID (Path) columns are identical across all files.
- **Differential Expression:** ADAMgui does not perform differential expression analysis itself; you must provide results from tools like limma, DESeq2, or edgeR as input to the Target Viewer.
- **Plot Export:** All plots generated in the GUIs can be exported in .eps format for high-quality publication figures.

## Reference documentation
- [Using ADAMgui](./references/ADAMgui.Rmd)
- [ADAMgui: Activity and Diversity Analysis Module Graphical User Interface](./references/ADAMgui.md)