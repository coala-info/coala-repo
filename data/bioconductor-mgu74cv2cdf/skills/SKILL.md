---
name: bioconductor-mgu74cv2cdf
description: This package provides the Chip Definition File environment and coordinate mapping for the Affymetrix MG_U74Cv2 mouse genome microarray. Use when user asks to map probe-level data to probesets, convert between probe indices and (x,y) coordinates, or process MG_U74Cv2 CEL files using the affy package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgu74cv2cdf.html
---

# bioconductor-mgu74cv2cdf

name: bioconductor-mgu74cv2cdf
description: Provides mapping and metadata for the Affymetrix MG_U74Cv2 (Murine Genome U74v2) chip. Use this skill when working with Mouse Genome U74v2 microarray data in R, specifically for converting between (x,y) probe coordinates and index values, or when requiring the CDF environment for AffyBatch objects.

# bioconductor-mgu74cv2cdf

## Overview
The `mgu74cv2cdf` package is a Bioconductor annotation data package containing the Chip Definition File (CDF) environment for the Affymetrix MG_U74Cv2 mouse genome array. It is primarily used by other Bioconductor packages like `affy` to map probe-level data to their respective probesets and physical locations on the microarray.

## Key Components
- `mgu74cv2cdf`: The main environment object containing the mapping between probesets and probe indices.
- `mgu74cv2dim`: An environment object describing the dimensions of the MG_U74Cv2 chip (640 x 640 pixels).
- `i2xy`: Function to convert a single-number index to (x,y) coordinates.
- `xy2i`: Function to convert (x,y) coordinates to a single-number index.

## Usage Examples

### Loading the Package
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mgu74cv2cdf")

library(mgu74cv2cdf)
```

### Coordinate Conversion
The chip uses a 1-based coordinate system ranging from 1 to 640 for both x and y.

```r
# Convert (x, y) coordinates to a single index
index <- xy2i(x = 5, y = 5)

# Convert a single index back to (x, y) coordinates
coords <- i2xy(index)
# Returns a matrix with columns "x" and "y"
```

### Accessing Chip Dimensions
```r
# View dimension information
get("mgu74cv2dim", envir = mgu74cv2cdf)
```

### Integration with AffyBatch
This package is typically used automatically when loading CEL files from the MG_U74Cv2 platform:
```r
library(affy)
# If CEL files are from MG_U74Cv2, affy will look for this CDF package
data <- ReadAffy() 
# The cdfName will be set to "mgu74cv2"
```

## Workflow Tips
- **Index Range**: The single-number indices range from 1 to 409,600 (640 * 640).
- **Environment Access**: To see the contents of the CDF environment, use `ls(mgu74cv2cdf)`. To look up a specific probeset, use `get("probeset_id", envir = mgu74cv2cdf)`.
- **Automated Handling**: In most high-level analyses (like RMA or MAS5 normalization), you do not need to call these functions manually; the `affy` package handles the mapping internally using this package.

## Reference documentation
- [mgu74cv2cdf Reference Manual](./references/reference_manual.md)