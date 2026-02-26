---
name: bioconductor-hivcdnavantwout03
description: This package provides access to and processes HIV-1 infection microarray data from the van't Wout et al. (2003) study. Use when user asks to load raw Cy3 and Cy5 absorption intensities from CD4+ T cell line experiments, transform encoded 16-bit TIFF values into intensity measurements, or analyze microarray data from HIV-1 infected cellular RNA transcripts.
homepage: https://bioconductor.org/packages/release/data/experiment/html/HIVcDNAvantWout03.html
---


# bioconductor-hivcdnavantwout03

name: bioconductor-hivcdnavantwout03
description: Access and process HIV-1 infection microarray data from the van't Wout et al. (2003) study. Use this skill to load raw Cy3 and Cy5 absorption intensities from CD4+ T cell line experiments and convert them into usable expression values.

## Overview
The `HIVcDNAvantWout03` package is a Bioconductor experiment data package. It provides a subset of data from a study assessing cellular RNA transcript expression (approx. 4600 transcripts) in CD4+ T cell lines following infection with HIV-1 BRU. 

The data represents a single block (12x32 spots) from a larger microarray experiment. It includes two primary datasets:
- `hiv1raw`: Cy3 (green) absorption intensities for channel 1.
- `hiv2raw`: Cy5 (red) absorption intensities for channel 2.

These datasets are stored as 16-bit TIFF encoded vectors that require specific mathematical transformation to retrieve actual intensity values.

## Loading the Data
To use the datasets, load the package and use the `data()` function:

```r
library(HIVcDNAvantWout03)

# Load the Cy3 and Cy5 raw data
data(hiv1raw)
data(hiv2raw)
```

## Data Structure and Transformation
The raw data is stored as a vector of length 450,000, which represents a 450x1000 matrix (ordered by column).

### Converting Raw Values to Intensities
The values are encoded for compact storage. To obtain the actual intensities, apply the following transformation formula:
`Intensity = (65535 - x)^2 * 0.0000471542407`

Example R implementation:
```r
# Define the transformation function
transform_hiv_data <- function(x) {
  scale_factor <- 4.71542407E-05
  intensity <- (65535 - x)^2 * scale_factor
  return(intensity)
}

# Apply transformation
hiv1_intensities <- transform_hiv_data(hiv1raw)
hiv2_intensities <- transform_hiv_data(hiv2raw)

# Reshape into the original 450x1000 matrix if needed
hiv1_matrix <- matrix(hiv1_intensities, nrow = 450, ncol = 1000)
```

## Typical Workflow
1. **Load Data**: Import `hiv1raw` and `hiv2raw`.
2. **Transform**: Convert the encoded 16-bit integers into real intensity values using the square-transformation formula.
3. **Analysis**: Use the resulting intensities for downstream microarray analysis (e.g., normalization, fold-change calculation between Cy3 and Cy5, or visualization of the 12x32 spot block).

## Reference documentation
- [HIVcDNAvantWout03 Reference Manual](./references/reference_manual.md)