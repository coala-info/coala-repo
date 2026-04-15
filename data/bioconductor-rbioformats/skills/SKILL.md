---
name: bioconductor-rbioformats
description: This tool provides an R interface to the Bio-Formats library for reading and processing over 150 proprietary microscopy and life sciences image formats. Use when user asks to read multidimensional image data, extract OME-XML metadata, handle large microscopy datasets, or access format-specific metadata in R.
homepage: https://bioconductor.org/packages/release/bioc/html/RBioFormats.html
---

# bioconductor-rbioformats

name: bioconductor-rbioformats
description: Interface to the Bio-Formats Java library for reading over 150 life sciences and microscopy image formats (HCS, time-lapse, digital pathology). Use when Claude needs to read complex multidimensional image data, extract OME-XML metadata, or handle large image datasets in R using the AnnotatedImage class.

# bioconductor-rbioformats

## Overview

The `RBioFormats` package provides an R interface to the OME Bio-Formats library. It allows for the direct reading of proprietary microscopy formats into R without prior conversion. It extends the `EBImage` infrastructure by introducing the `AnnotatedImage` class, which bundles pixel data with comprehensive metadata.

## Core Workflows

### Reading Images

Use `read.image` to load image data. By default, pixel values are normalized to the [0, 1] range.

```r
library(RBioFormats)

# Read a file
img <- read.image("path/to/microscopy_file.czi")

# Inspect dimensions and order (e.g., "x y c z t")
dimorder(img)

# Print summary without data preview
print(img, short = TRUE)
```

### Accessing Metadata

Metadata is stored in the `metadata` slot of an `AnnotatedImage` object and is categorized into `coreMetadata`, `globalMetadata`, and `seriesMetadata`.

```r
# Extract all metadata
meta <- metadata(img)

# Access core metadata (guaranteed fields like sizeX, sizeY, sizeZ, sizeC, sizeT)
core <- coreMetadata(img)
print(core$sizeT) # Number of time points

# Access format-specific global metadata
global <- globalMetadata(img)
```

### Handling Large Datasets

To avoid memory issues with large stacks, read metadata first and then subset the image data during the read process.

```r
# Read metadata only
meta <- read.metadata("large_file.tif")

# Read a specific subset (e.g., the 5th time point)
img_subset <- read.image("large_file.tif", subset = list(T = 5))

# Read a specific series in a multi-series file
img_series <- read.image("large_file.tif", series = 2)
```

### OME-XML Metadata

For advanced metadata processing, you can extract the raw OME-XML representation.

```r
library(xml2)
omexml <- read.omexml("path/to/file")
xml_data <- read_xml(omexml)
```

## Tips and Best Practices

- **Normalization**: If you need the raw pixel values (e.g., 16-bit integers), set `normalize = FALSE` in `read.image`.
- **EBImage Compatibility**: `AnnotatedImage` objects are compatible with `EBImage` functions. Use `as.Image(annotated_img)` if a strict `Image` class object is required by a specific function.
- **Mock Files**: Use `mockFile()` to generate synthetic images for testing pipelines without needing external files.
- **Dimension Order**: Always check `dimorder(img)` as different microscopy formats may store dimensions in different sequences (e.g., XYCZT vs XYTCZ).

## Reference documentation

- [RBioFormats: an R interface to the Bio-Formats library](./references/RBioFormats.md)
- [RBioFormats Vignette Source](./references/RBioFormats.Rmd)