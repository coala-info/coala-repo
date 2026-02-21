---
name: bioconductor-asics
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ASICS.html
---

# bioconductor-asics

## Overview
The `ASICS` package provides a complete pipeline for NMR-based metabolomics. It uses a reference library of pure metabolite spectra to automatically identify and quantify compounds in complex biological mixtures. The workflow typically moves from raw data import to preprocessing, quantification, and finally statistical comparison between experimental conditions.

## Core Workflow

### 1. Data Import and Preprocessing
Data can be imported from Bruker directories or structured text/csv files.

```r
library(ASICS)

# Import from Bruker files
spectra_data <- importSpectraBruker(system.file("extdata", "example_spectra", package = "ASICS"))

# Normalization (e.g., PQN or Constant Sum "CS")
spectra_norm <- normaliseSpectra(spectra_data, type.norm = "pqn")

# Alignment to a reference spectrum
spectra_align <- alignSpectra(spectra_norm)

# Create the required Spectra object
spectra_obj <- createSpectra(spectra_align)
```

### 2. Reference Libraries
Quantification requires a `PureLibrary` object. `ASICS` comes with a default library of 191 metabolites.

```r
# View default library metabolites
head(getSampleName(pure_library))

# Create a custom library from pure metabolite Bruker files
pure_spectra <- importSpectraBruker("path/to/pure/files")
new_lib <- createPureLibrary(pure_spectra, nb.protons = c(5, 4))

# Merge libraries
merged_lib <- c(pure_library, new_lib)
```

### 3. Quantification
The `ASICS` function performs the main identification and quantification.

```r
# Define areas to exclude (e.g., water: 4.5-5.1 ppm)
to_exclude <- matrix(c(4.5, 5.1), ncol = 2)

# Run quantification
# joint.align = TRUE and quantif.method = "both" are recommended for multiple spectra
resASICS <- ASICS(spectra_obj, 
                  exclusion.areas = to_exclude, 
                  joint.align = TRUE, 
                  quantif.method = "both")

# Extract quantification matrix (metabolites in rows, samples in columns)
quantif_matrix <- getQuantification(resASICS)
```

### 4. Statistical Analysis
`ASICS` includes wrappers for common metabolomics analyses.

```r
# Prepare data with design information
# design: first column must match sample names
analysis_data <- formatForAnalysis(quantif_matrix, 
                                   design = design_df, 
                                   zero.threshold = 75)

# PCA
resPCA <- pca(analysis_data)
plot(resPCA, graph = "ind", col.ind = "condition")

# OPLS-DA
resOPLSDA <- oplsda(analysis_data, condition = "condition")
plot(resOPLSDA)

# Differential analysis (Kruskal-Wallis)
resTests <- kruskalWallis(analysis_data, "condition")
```

## Tips and Best Practices
- **Exclusion Areas**: Always exclude the water region (approx. 4.5-5.1 ppm) and urea if working with urine samples to avoid quantification artifacts.
- **Parallel Computing**: For large datasets, use the `ncores` argument in `ASICS()` to speed up processing on Unix-like systems.
- **Visualization**: Use `plot(resASICS, idx = 1, add.metab = "Glucose")` to visually verify the fit of a specific metabolite against the original spectrum.
- **Bucket Analysis**: If quantification is not desired, you can perform "bucket-based" analysis by using `binning()` on aligned spectra and passing the result to `formatForAnalysis(..., type.data = "buckets")`.

## Reference documentation
- [ASICS](./references/ASICS.md)
- [ASICS User's Guide](./references/ASICSUsersGuide.md)