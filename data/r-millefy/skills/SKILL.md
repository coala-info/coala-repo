---
name: r-millefy
description: millefy is an R package for visualizing single-cell RNA-seq read coverage at specific genomic loci using locus-specific pseudotime to reorder cells. Use when user asks to visualize scRNA-seq read distribution, display individual cell coverage tracks, or reorder cells by transcriptional similarity at a specific gene locus.
homepage: https://cran.r-project.org/web/packages/millefy/index.html
---


# r-millefy

## Overview
millefy is an R package designed for the visualization of scRNA-seq read coverage. Unlike standard genome browsers that aggregate signals, millefy displays individual cell coverage and uses "locus-specific pseudotime" to dynamically reorder cells, making it easier to visualize splicing variations, alternative polyadenylation, and transcriptional heterogeneity at specific genomic loci.

## Installation
To install the package from GitHub:

```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c('Rsamtools', 'GenomicRanges', 'rtracklayer', 'destiny'))

install.packages(c("data.table", "dtplyr", "proxy", "viridisLite"))
devtools::install_github("yuifu/millefy")
```

## Main Functions and Workflow

### 1. Prepare Input Data
millefy requires BAM files (indexed) and a gene annotation (GTF or BED).

```R
library(millefy)

# Define paths to BAM files
bam_files <- c("cell1.bam", "cell2.bam", "cell3.bam")
# Define genomic interval of interest
param <- ScanBamParam(which = GRanges("chr1", IRanges(100000, 110000)))
```

### 2. Create Millefy Object
The core workflow involves creating a `millefy` object which handles the extraction of coverage data.

```R
# Initialize the object
mlf <- millefy::millefy_load(bam_files, param)
```

### 3. Visualization
The `millefy_plot` function generates the visualization. It can automatically calculate pseudotime to order the cells.

```R
# Basic plot
millefy_plot(mlf, 
             gene_id = "Pou5f1", 
             annotation_file = "genes.gtf",
             sc_order = "pseudotime")
```

### 4. Adjusting Plots
Use `millefy_adjust()` to refine the last generated plot without re-calculating the entire coverage matrix.

```R
millefy_adjust(heights = c(1, 4, 1))
```

## Key Features
- **Locus-specific Pseudotime**: Automatically reorders cells based on the similarity of read distribution within the specific genomic window being viewed.
- **Annotation Integration**: Displays gene structures (exons/introns) alongside scRNA-seq tracks.
- **Color Customization**: Supports various color maps (e.g., viridis) to represent expression intensity.

## Tips for Success
- **Indexing**: Ensure all BAM files are indexed (.bai files must be in the same directory).
- **Memory Management**: When visualizing large regions or many cells, subset the `ScanBamParam` to the specific coordinates of interest to save memory.
- **Group Comparison**: You can provide group labels to the cells to visualize coverage differences between known cell types or clusters.

## Reference documentation
- [Quick_example.md](./references/Quick_example.md)
- [README.md](./references/README.md)
- [Tutorial.md](./references/Tutorial.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)