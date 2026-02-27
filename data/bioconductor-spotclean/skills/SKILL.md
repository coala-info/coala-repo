---
name: bioconductor-spotclean
description: "bioconductor-spotclean decontaminates spatial transcriptomics data by correcting for mRNA bleed and spot swapping between neighboring spots. Use when user asks to decontaminate 10x Visium data, estimate spot contamination rates, or reassign contaminating UMIs to their spots of origin."
homepage: https://bioconductor.org/packages/release/bioc/html/SpotClean.html
---


# bioconductor-spotclean

name: bioconductor-spotclean
description: Decontaminate spatial transcriptomics data by adjusting for spot swapping (mRNA bleed) between neighboring spots. Use when working with 10x Visium data to improve marker gene detection, tissue annotation, and differential expression analysis by reassigning contaminating UMIs to their spots of origin.

# bioconductor-spotclean

## Overview

SpotClean is a computational tool designed to correct for "spot swapping" in spatial transcriptomics (ST) experiments, particularly 10x Visium. Spot swapping occurs when mRNA bleeds from its spot of origin to neighboring spots during the permeabilization step, leading to contamination that can confound downstream analyses like clustering and differential expression. SpotClean estimates per-spot contamination rates and provides decontaminated expression levels.

## Installation

Install the package using BiocManager:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("SpotClean")
library(SpotClean)
```

## Core Workflow

### 1. Load Data
SpotClean requires two components: the raw gene-by-spot count matrix and the slide metadata (spatial folder from Space Ranger).

```r
# Load raw matrix (path to folder containing barcodes.tsv.gz, features.tsv.gz, matrix.mtx.gz)
raw_counts <- read10xRaw("/path/to/raw_feature_bc_matrix")

# Load slide metadata
slide_info <- read10xSlide(
    tissue_csv_file = "/path/to/spatial/tissue_positions_list.csv",
    tissue_img_file = "/path/to/spatial/tissue_lowres_image.png",
    scale_factor_file = "/path/to/spatial/scalefactors_json.json"
)
```

### 2. Create Slide Object
Combine the counts and metadata into a `SummarizedExperiment` object.

```r
slide_obj <- createSlide(count_mat = raw_counts, slide_info = slide_info)
```

### 3. Visualization
Visualize the tissue image, spot labels, or gene expression heatmaps before or after decontamination.

```r
# Visualize the H&E image
visualizeSlide(slide_obj)

# Visualize tissue vs background spots
visualizeLabel(slide_obj, "tissue")

# Visualize raw gene expression
visualizeHeatmap(slide_obj, "Mbp")
```

### 4. Decontamination
Run the main `spotclean()` function. By default, it evaluates candidate radii and iterates to reach convergence.

```r
# Run decontamination
# maxit: maximum iterations (default 30)
# candidate_radius: specific radius or vector of radii to test
decont_obj <- spotclean(slide_obj, maxit = 10)

# Access decontaminated counts
decont_counts <- assays(decont_obj)$decont
```

### 5. Evaluate Contamination
Check the estimated contamination rates and the Ambient RNA Contamination (ARC) score.

```r
# Per-spot contamination rates
summary(metadata(decont_obj)$contamination_rate)

# ARC score (lower bound of contamination)
arcScore(slide_obj)
```

## Integration with Other Classes

### SpatialExperiment
SpotClean can be applied directly to `SpatialExperiment` objects. Ensure the object contains the raw data (including background spots).

```r
library(SpatialExperiment)
se_obj <- read10xVisium(samples = "/path/to/spaceranger/output/", data = "raw")
decont_se <- spotclean(se_obj)
```

### Seurat
Convert the decontaminated object to a Seurat object for standard downstream pipelines.

```r
seurat_obj <- convertToSeurat(decont_obj, image_dir = "/path/to/spatial/folder")
```

## Usage Tips and Constraints

- **Background Spots**: SpotClean requires background spots (those not covered by tissue) to estimate the contamination profile. It is recommended that at least 25% of the spots on the slide are background spots.
- **Gene Selection**: By default, SpotClean filters for highly expressed or highly variable genes. Decontaminating lowly expressed genes is often ineffective due to high sparsity and lack of signal.
- **Normalization**: SpotClean reassigns UMIs, which changes the estimated sequencing depth of tissue spots. This process can be viewed as a form of normalization and may conflict with other depth-normalization methods.
- **Speed**: For a typical dataset (~2,000 tissue spots), the process usually takes less than 15 minutes and does not require high-performance computing resources.

## Reference documentation

- [SpotClean adjusts for spot swapping in spatial transcriptomics data](./references/SpotClean.md)
- [SpotClean Vignette (RMarkdown)](./references/SpotClean.Rmd)