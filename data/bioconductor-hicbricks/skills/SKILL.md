---
name: bioconductor-hicbricks
description: HiCBricks provides an HDF5-based framework for the efficient storage, management, and analysis of large-scale Hi-C contact matrices. Use when user asks to initialize a BrickContainer, load Hi-C data from text or mcool files, retrieve sub-matrices by genomic coordinates, or call Topologically Associated Domains using the LSD algorithm.
homepage: https://bioconductor.org/packages/release/bioc/html/HiCBricks.html
---


# bioconductor-hicbricks

## Overview
HiCBricks is a Bioconductor package designed for efficient handling of large-scale Hi-C data. It uses an HDF5-based data structure called a **Brick** to store contact matrices, bin tables, and annotations. This allows for fast data access without loading entire matrices into memory. The primary interface is the **BrickContainer**, which manages multiple resolutions and chromosomes within a project.

## Core Workflow

### 1. Initializing a BrickContainer
To start a project, you must create a directory and initialize the Brick structure using a bin table (genomic intervals).

```r
library(HiCBricks)

# Define output directory and bin table path
out_dir <- "my_hic_project"
bintable_path <- "path/to/bintable.txt"

# Create the project structure
Create_many_Bricks(
    BinTable = bintable_path,
    bin_delim = " ",
    output_directory = out_dir,
    file_prefix = "my_experiment",
    experiment_name = "Hi-C Analysis",
    resolution = 100000,
    remove_existing = TRUE
)

# Load the container for use
My_BrickContainer <- load_BrickContainer(project_dir = out_dir)
```

### 2. Loading Contact Data
HiCBricks supports several input formats.

**From 2D Text Matrices:**
```r
Brick_load_matrix(
    Brick = My_BrickContainer,
    chr1 = "chr1", chr2 = "chr1",
    resolution = 100000,
    matrix_file = "matrix.txt.gz",
    delim = " ",
    remove_prior = TRUE
)
```

**From .mcool Files:**
```r
# List available resolutions/normalizations
Brick_list_mcool_resolutions("data.mcool")

# Create Bricks from mcool metadata
Create_many_Bricks_from_mcool(
    output_directory = out_dir,
    mcool = "data.mcool",
    resolution = 10000
)

# Load the actual data
Brick_load_data_from_mcool(
    Brick = My_BrickContainer,
    mcool = "data.mcool",
    resolution = 10000,
    norm_factor = "Iterative-Correction"
)
```

### 3. Accessing Data
Data can be retrieved by genomic coordinates, distance from diagonal, or specific indices.

```r
# Get the bin table as GRanges
bins <- Brick_get_bintable(My_BrickContainer, resolution = 100000)

# Fetch a sub-matrix using human-readable coordinates
sub_mat <- Brick_get_matrix_within_coords(
    Brick = My_BrickContainer,
    x_coords = "chr1:1:5000000",
    y_coords = "chr1:1:5000000",
    resolution = 100000
)

# Get values at a specific diagonal distance (in bins)
diag_vals <- Brick_get_values_by_distance(
    Brick = My_BrickContainer,
    chr = "chr1",
    distance = 5,
    resolution = 100000
)
```

### 4. TAD Calling (LSD Algorithm)
HiCBricks includes the Local Score Differentiator (LSD) for calling Topologically Associated Domains.

```r
TAD_ranges <- Brick_local_score_differentiator(
    Brick = My_BrickContainer,
    chrs = c("chr1", "chr2"),
    resolution = 100000,
    di_window = 10,
    lookup_window = 30,
    fill_gaps = TRUE
)

# Save TADs back into the Brick for future use
Brick_add_ranges(
    Brick = My_BrickContainer,
    ranges = TAD_ranges,
    rangekey = "LSD_TADs",
    resolution = 100000
)
```

### 5. Visualization
The `Brick_vizart_plot_heatmap` function is highly flexible, supporting rotations and bipartite (two-sample) comparisons.

```r
# Custom log10 function for better contrast
Failsafe_log10 <- function(x) {
    x[is.na(x) | is.nan(x) | is.infinite(x)] <- 0
    return(log10(x + 1))
}

Brick_vizart_plot_heatmap(
    File = "heatmap.pdf",
    Bricks = list(My_BrickContainer),
    x_coords = "chr1:1:10000000",
    y_coords = "chr1:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    palette = "Reds",
    rotate = TRUE,
    distance = 50 # Limit distance from diagonal
)
```

## Tips and Best Practices
- **Coordinate Format:** Always use the `chr:start:end` format with colons as delimiters for coordinate strings.
- **Memory Management:** Use `Brick_get_values_by_distance` or `Brick_fetch_row_vector` to process large matrices in chunks rather than loading the full matrix.
- **Overwriting:** Functions like `Create_many_Bricks` and `Brick_load_matrix` require `remove_existing = TRUE` or `remove_prior = TRUE` to overwrite existing HDF5 data.
- **Metadata:** Use `Brick_get_matrix_mcols` to retrieve pre-computed statistics like row sums or bin coverage.

## Reference documentation
- [Introduction To HiCBricks](./references/IntroductionToHiCBricks.md)