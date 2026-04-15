---
name: bioconductor-screenr
description: ScreenR provides a pipeline for analyzing barcode screening data from pooled shRNA or CRISPR libraries. Use when user asks to analyze barcode screening data, perform quality control on CRISPR or shRNA libraries, or identify high-confidence hits using multiple statistical methods.
homepage: https://bioconductor.org/packages/release/bioc/html/ScreenR.html
---

# bioconductor-screenr

## Overview

The **ScreenR** package provides a pipeline for the analysis of barcode screening data. It is designed to handle count tables from pooled shRNA or CRISPR libraries, offering tools for data preprocessing, visualization, and robust hit identification. The package's strength lies in its "cross-statistical" approach, which combines three different methods to minimize false positives and identify high-confidence hits.

## Typical Workflow

### 1. Data Preparation and Object Creation
The input must be a count table with genes/barcodes in rows and samples in columns. Column names should follow the format: `Timepoint_Treatment_Replicate`.

```r
library(ScreenR)
library(dplyr)

# Load data
data(count_table)
data(annotation_table)

# Create the ScreenR object
# groups: a factor defining the experimental groups
groups <- factor(c("T0", "T0", "T3_TRT", "T3_TRT", "T3_CTRL", "T3_CTRL"))
object <- create_screenr_object(table = count_table, 
                                annotation = annotation_table, 
                                groups = groups)

# Preprocessing
object <- remove_all_zero_row(object)
object <- normalize_data(object)      # CPM normalization
object <- compute_data_table(object)  # Tidy data format
```

### 2. Quality Control
Visually inspect the data to ensure sequencing depth and barcode representation are adequate.

```r
# Plot total mapped reads
plot_mapped_reads(object, palette = my_palette)

# Check for barcode loss (barcodes with zero counts)
plot_barcode_lost(object, palette = my_palette)

# Multidimensional Scaling (MDS) to check sample clustering
plot_mds(object, groups = groups)
```

### 3. Statistical Analysis (Hit Identification)
ScreenR uses three methods to identify hits. It is recommended to run all three.

**Method A: Z-score**
```r
# Compute metrics (Log2FC)
metrics <- compute_metrics(object, control = "CTRL", treatment = "TRT", day = "Time3")

# Find hits based on Z-score
zscore_hits <- find_zscore_hit(metrics, number_barcode = 6, metric = "median")
```

**Method B: CAMERA**
```r
design <- model.matrix(~ groups)
colnames(design) <- levels(groups)
camera_hits <- find_camera_hit(object, matrix_model = design, contrast = "T3_TRT")
```

**Method C: ROAST**
```r
roast_hits <- find_roast_hit(object, matrix_model = design, contrast = "T3_TRT")
```

### 4. Integrating Results
Identify common hits across the methods to increase stringency.

```r
# Find hits present in all 3 methods (stringent) or at least 2
common_hits <- find_common_hit(zscore_hits, camera_hits, roast_hits, common_in = 3)

# Visualize the overlap
plot_common_hit(zscore_hits, camera_hits, roast_hits)

# Visualize the trend of specific candidate genes
plot_trend(object, genes = common_hits[1:2], group_var = c("T0", "CTRL", "TRT"))
```

## Key Functions
- `create_screenr_object()`: Initializes the analysis container.
- `normalize_data()`: Performs Counts Per Million (CPM) normalization.
- `compute_metrics()`: Calculates Log2 Fold Change and Z-scores.
- `find_zscore_hit()`, `find_camera_hit()`, `find_roast_hit()`: The three core statistical engines.
- `find_common_hit()`: Intersects results from the statistical engines.
- `plot_trend()`: Visualizes the abundance of barcodes for specific genes across conditions.

## Reference documentation
- [ScreenR Example Analysis](./references/Analysis_Example.Rmd)
- [ScreenR Example Analysis (Markdown Version)](./references/Analysis_Example.md)