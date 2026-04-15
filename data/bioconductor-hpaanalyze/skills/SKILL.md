---
name: bioconductor-hpaanalyze
description: The bioconductor-hpaanalyze package retrieves and analyzes proteomics and transcriptomics data from the Human Protein Atlas. Use when user asks to download HPA datasets, subset expression data by gene or tissue, visualize protein expression in tissues and cancers, or retrieve detailed XML metadata and histological images.
homepage: https://bioconductor.org/packages/release/bioc/html/HPAanalyze.html
---

# bioconductor-hpaanalyze

## Overview
The `HPAanalyze` package facilitates the retrieval and exploratory analysis of proteomics and transcriptomics data from the Human Protein Atlas (HPA). It bridges the gap between the HPA web interface and R, allowing for tidy data manipulation, visualization of protein expression across tissues and cancers, and automated downloading of histological images.

## Core Workflows

### 1. Working with Full Datasets
The package can download large-scale HPA datasets (Normal Tissue, Pathology, Subcellular Location, and RNA expression).

```r
library(HPAanalyze)

# Download histology datasets (Normal, Pathology, Subcellular)
# Use version = 'example' for a small built-in subset for testing
hpa_data <- hpaDownload(downloadList = 'histology')

# List available parameters (tissues, cell types, cancers) for subsetting
params <- hpaListParam(hpa_data)

# Subset data for specific genes and tissues
genes <- c("TP53", "EGFR", "CD44")
tissues <- c("Breast", "Cerebellum")
subset_data <- hpaSubset(data = hpa_data, 
                         targetGene = genes, 
                         targetTissue = tissues)

# Export to Excel
hpaExport(subset_data, fileName = "hpa_results.xlsx")
```

### 2. Visualization
`HPAanalyze` provides `ggplot2`-based functions to quickly visualize protein expression.

*   **`hpaVisTissue()`**: Generates heatmaps of protein expression in normal tissues.
*   **`hpaVisPatho()`**: Generates bar charts of expression in various cancer types.
*   **`hpaVisSubcell()`**: Visualizes subcellular localization.
*   **`hpaVis()`**: An umbrella function that attempts to create all three plot types.

```r
# Quick visualization of specific genes in glioma
hpaVis(targetGene = c("GCH1", "PTS"),
       targetCancer = "glioma",
       visType = "Patho")
```

### 3. Individual Protein XML Data
For detailed sample-level information (including clinical data and image URLs), use the XML functions. These require Ensembl Gene IDs (ENSG...).

```r
# Get all data for a specific gene
egfr_xml <- hpaXml(inputXml = 'ENSG00000146648')

# Access specific components
prot_class <- egfr_xml$ProtClass
tissue_sum <- egfr_xml$TissueExprSum
sample_details <- egfr_xml$TissueExpr # List of dataframes per antibody
```

### 4. Image Retrieval
You can extract image URLs and download them directly to your local machine.

```r
# Extract sample data for a gene
xml_obj <- hpaXmlGet("ENSG00000134057")
expr_data <- hpaXmlTissueExpr(xml_obj)

# Download the first image from the first antibody dataset
download.file(expr_data[[1]]$imageUrl[1], 
              destfile = "sample_image.jpg", 
              mode = "wb")
```

## Tips and Best Practices
*   **Gene Identifiers**: Use HGNC symbols (e.g., "TP53") for `hpaSubset` and `hpaVis` functions. Use Ensembl IDs (e.g., "ENSG00000141510") for `hpaXml` functions.
*   **Memory Management**: Downloading 'all' datasets via `hpaDownload` requires significant RAM. Prefer downloading only 'histology' or specific datasets.
*   **Offline Usage**: You can save parsed XML objects as `.rds` files for offline work, as the raw `xml_document` objects cannot be easily serialized.
*   **Custom Themes**: All `hpaVis` functions return `ggplot2` objects. You can extend them with `+ theme()` or other ggplot layers. Set `customTheme = FALSE` in the function call to use default ggplot2 styling.

## Reference documentation
- [Quick-start guide: Acquire and visualize HPA data](./references/a_HPAanalyze_quick_start.md)
- [In-depth: Working with HPA data in R](./references/b_HPAanalyze_indepth.md)
- [Tutorial: Combine HPAanalyze with HPA web queries](./references/c_HPAanalyze_case_query.md)
- [Tutorial: Working with HPA xml files offline](./references/d_HPAanalyze_case_offline_xml.md)
- [Tutorial: Export HPA data as JSON](./references/e_HPAanalyze_case_json.md)
- [Tutorial: Download histology images from the HPA](./references/f_HPAanalyze_case_images.md)
- [Code for figures from HPAanalyze paper](./references/z_HPAanalyze_paper_figures.md)