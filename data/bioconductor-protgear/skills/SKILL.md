---
name: bioconductor-protgear
description: This tool processes protein microarray data through a workflow of background correction, normalization, and technical replicate management. Use when user asks to import GPR files, perform background correction, calculate coefficients of variation for replicates, or normalize protein microarray data.
homepage: https://bioconductor.org/packages/release/bioc/html/protGear.html
---


# bioconductor-protgear

name: bioconductor-protgear
description: Protein microarray data processing using the protGear Bioconductor package. Use this skill to import .gpr or .txt files, perform background correction (local, global, normexp, etc.), merge sample identifiers, calculate Coefficient of Variation (CV) for technical replicates, perform TAG subtraction, and normalize data (vsn, loess, rlm).

# bioconductor-protgear

## Overview
The `protGear` package is designed for the pre-processing of protein microarray data. It provides a structured workflow to transform raw fluorescence intensity files (typically from GenePix) into analysis-ready data. Key features include spatial visualization of slides, multiple background correction methods, robust CV estimation for selecting the best technical replicates, and various normalization techniques.

## Analysis Setup and Parameters
Before processing, define the experimental parameters using `array_vars()`. This function centralizes metadata required for the workflow.

```r
library(protGear)

genepix_vars <- array_vars(
  channel = "635", # Fluorescence channel (e.g., 635, 532)
  chip_path = "path/to/gpr_files", # Folder containing .gpr or .txt files
  totsamples = 21, # Number of samples per slide
  blockspersample = 2, # Blocks occupied by one sample
  sampleID_path = "path/to/sample_ids", # Folder with matching .csv ID files
  machine = 1, # Optional machine identifier
  date_process = "2023-10-30"
)
```

## Data Import and Quality Control
1. **Check IDs**: Ensure every data file has a corresponding sample ID file using `check_sampleID_files()`.
2. **Spatial Visualization**: Inspect slides for spatial bias using `visualize_slide(infile, MFI_var)` or `visualize_slide_2d()`.
3. **Read Files**: Use `read_array_files()` to load data. It is common to use `purrr::map` for batch processing.

```r
filenames <- list.files(genepix_vars$paths[[1]], pattern = "*.txt$|*.gpr$")
data_files <- purrr::map(filenames, read_array_files, 
                         data_path = "path/to/data/", 
                         genepix_vars = genepix_vars)
```

## Background Correction
Extract background values with `extract_bg()` and apply correction with `bg_correct()`. Supported methods include `subtract_local`, `subtract_global`, `moving_min`, `normexp`, and `edwards`.

```r
# Merge sample IDs and correct background
sample_ID_merged_dfs <- purrr::map(names(data_files), merge_sampleID, 
                                  data_files = data_files, 
                                  genepix_vars = genepix_vars, 
                                  method = "subtract_local")
```

## Replicate Management (CV)
`protGear` excels at handling technical replicates.
- **CV Estimation**: Use `cv_estimation()` to calculate CVs across replicates.
- **Best Replicates**: If you have >2 replicates, `best_CV_estimation()` automatically selects the pair with the lowest CV to minimize variability.

```r
dataCV <- purrr::map(sample_ID_merged_dfs, cv_estimation, 
                     lab_replicates = 3, cv_cut_off = 20)

dataCV_best2 <- purrr::map(dataCV, best_CV_estimation, 
                           lab_replicates = 3, cv_cut_off = 20)
```

## TAG Subtraction and Normalization
- **TAG Subtraction**: For antigens with purification tags (e.g., GST, MBP), use `tag_subtract()` with a mapping file to remove tag-specific signals.
- **Normalization**: Use `matrix_normalise()` to apply `vsn`, `loess`, `rlm`, or `log2` methods.

```r
# Normalization example
norm_list <- matrix_normalise(matrix_antigen, 
                              method = "vsn", 
                              array_matrix = array_matrix, 
                              return_plot = TRUE)
# Access normalized matrix
normalized_data <- norm_list$matrix_antigen_normalised
```

## Interactive Dashboard
To launch the Shiny-based GUI for a guided step-by-step processing experience:
```r
protGear::launch_protGear_interactive()
```

## Reference documentation
- [protGear vignette (Rmd)](./references/vignette.Rmd)
- [protGear vignette (Markdown)](./references/vignette.md)