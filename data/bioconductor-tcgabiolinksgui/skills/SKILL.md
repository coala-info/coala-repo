---
name: bioconductor-tcgabiolinksgui
description: TCGAbiolinksGUI provides a graphical interface and R functions for searching, downloading, and performing integrative analysis of cancer genomics data from the Genomic Data Commons. Use when user asks to search or download TCGA data, perform differential expression or methylation analysis, create starburst plots, or conduct ELMER and clinical survival modeling.
homepage: https://bioconductor.org/packages/3.8/bioc/html/TCGAbiolinksGUI.html
---


# bioconductor-tcgabiolinksgui

name: bioconductor-tcgabiolinksgui
description: Expert guidance for using the TCGAbiolinksGUI R package to search, download, and analyze cancer genomics data from the NCI Genomic Data Commons (GDC). Use this skill when performing bioinformatics workflows involving TCGA data, including differential expression analysis (DEA), differential methylation analysis (DMR), integrative starburst plots, ELMER analysis, and clinical survival modeling.

# bioconductor-tcgabiolinksgui

## Overview
TCGAbiolinksGUI provides a graphical user interface and streamlined R functions for the TCGAbiolinks package. It facilitates the end-to-end analysis of The Cancer Genome Atlas (TCGA) data, including data acquisition from the GDC API, preprocessing of SummarizedExperiment objects, and advanced integrative analyses. Key capabilities include transcriptomic analysis (RNA-seq), epigenetic analysis (DNA methylation), genomic analysis (MAF files), and clinical data visualization.

## Core Workflows

### 1. Data Acquisition and Preparation
The package interacts with the GDC to fetch molecular and clinical data.

```r
library(TCGAbiolinksGUI)

# Launch the GUI
TCGAbiolinksGUI()

# Manual data preparation (SummarizedExperiment)
# Typically involves GDCquery, GDCdownload, and GDCprepare from TCGAbiolinks
# TCGAbiolinksGUI provides menus to manage these objects
```

### 2. Epigenetic Analysis (DMR)
Perform Differential Methylated Regions (DMR) analysis using SummarizedExperiment objects.

*   **Input:** `.rda` file containing a `SummarizedExperiment`.
*   **Process:** Background correction and dye-bias correction (via `minfi`), followed by P-value adjustment.
*   **Visualization:** 
    *   **Volcano Plots:** Use `DMR_results_...csv` files to visualize hyper/hypomethylated probes.
    *   **Mean DNA Methylation Plots:** Compare methylation levels across clinical groups.

### 3. Transcriptomic Analysis (DEA)
Analyze gene expression data to identify differentially expressed genes.

*   **Normalization:** Uses `TCGAanalyze_Normalization` (EDASeq) to adjust for GC-content or gene length.
*   **Filtering:** Apply quantile filters to remove low-count genes.
*   **Analysis:** Supports `glmRT` and `exactTest` methods.
*   **Visualization:**
    *   **Heatmaps:** Use `ComplexHeatmap` to visualize expression patterns.
    *   **Pathway Graphs:** Integrate results with `Pathview` to see gene changes on KEGG pathways.
    *   **Enrichment:** Perform Gene Ontology (BP, CC, MF) and Pathway enrichment.

### 4. Integrative Analysis
Combine multiple data types to find biological drivers.

*   **Starburst Plots:** Integrate DMR and DEA results. It plots `-log10(FDR)` for methylation (x-axis) vs. expression (y-axis) to identify genes regulated by epigenetic changes.
*   **ELMER (Enhancer Linking by Methylation/Expression Relationship):**
    1.  Identify distal probes.
    2.  Find differentially methylated distal probes (DMCs).
    3.  Identify putative target genes.
    4.  Perform motif enrichment analysis.
    5.  Identify master regulator Transcription Factors (TFs).

### 5. Genomic and Clinical Analysis
*   **Oncoprint:** Visualize genomic alterations (mutations) from MAF files.
*   **Survival Analysis:** Generate Kaplan-Meier plots using clinical data (days to death/last follow-up).
*   **Glioma Classifier:** Predict molecular subtypes for glioma samples using DNA methylation signatures and RandomForest models.

## Tips for Success
*   **Memory Management:** DNA methylation analysis is resource-intensive. Use the `Cores` parameter in DMR analysis to parallelize if the hardware supports it.
*   **Barcode Logic:** Ensure you understand TCGA barcodes (e.g., `TCGA-G4-6317-02A`). The `02` indicates a recurrent tumor, while `01` is primary.
*   **Object Formats:** Most analysis functions expect a `SummarizedExperiment` (SE) or `MultiAssayExperiment` (MAE). Use the "Manage SummarizedExperiment" menu to inspect metadata before running DEA/DMR.
*   **DLL Limits:** If you encounter "maximal number of DLLs reached," set `options(java.parameters = "-Xmx8000m")` or increase `R_MAX_NUM_DLLS` in your `.Renviron` file.

## Reference documentation
- [Case Studies: Integration and ELMER](./references/Cases.md)
- [Clinical and Epigenetic Analysis](./references/analysis.md)
- [GDC Data Search and Download](./references/data.md)
- [Package Introduction and Installation](./references/index.md)
- [Integrative Analysis and Starburst Plots](./references/integrative.md)