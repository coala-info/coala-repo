---
name: bioconductor-msbackendmgf
description: This package provides a backend for the Spectra Bioconductor package to import, export, and manage MS/MS data in Mascot Generic Format (MGF). Use when user asks to read MGF files into a Spectra object, export mass spectrometry data to MGF format, or handle annotated MGF files with per-peak metadata.
homepage: https://bioconductor.org/packages/release/bioc/html/MsBackendMgf.html
---


# bioconductor-msbackendmgf

## Overview

The `MsBackendMgf` package provides a backend for the `Spectra` Bioconductor package, enabling the handling of MS/MS data stored in Mascot Generic Format (MGF). It supports two primary backends:
1. `MsBackendMgf`: For standard MGF files.
2. `MsBackendAnnotatedMgf`: For MGF files containing per-peak annotations (e.g., in-silico generated spectra).

## Core Workflows

### Importing MGF Files

To read MGF data, use the `Spectra` constructor and specify `MsBackendMgf()` as the source.

```r
library(Spectra)
library(MsBackendMgf)

# Define file paths
fls <- c("path/to/file1.mgf", "path/to/file2.mgf")

# Create Spectra object
sps <- Spectra(fls, source = MsBackendMgf())

# Access data
spectraVariables(sps)
sps$rtime
sps$precursorMz
mz(sps)
intensity(sps)
```

### Custom Variable Mapping

MGF "dialects" often use different field names for metadata. You can map these to standard `Spectra` variables using a named character vector.

```r
# Check default mapping
spectraVariableMapping(MsBackendMgf())

# Add or overwrite mappings (e.g., mapping TITLE to spectrumName)
custom_map <- c(spectrumName = "TITLE", spectraVariableMapping(MsBackendMgf()))

# Import with custom mapping
sps <- Spectra(fls, source = MsBackendMgf(), mapping = custom_map)
sps$spectrumName
```

### Exporting to MGF

Use the `export()` function. By default, all spectra variables are exported as MGF fields.

```r
# Basic export
export(sps, backend = MsBackendMgf(), file = "output.mgf")

# Export with custom mapping (to ensure specific fields like TITLE are set)
export(sps, backend = MsBackendMgf(), file = "output.mgf", mapping = custom_map)

# Export without the TITLE field
export(sps, backend = MsBackendMgf(), file = "output.mgf", exportTitle = FALSE)
```

### Handling Annotated MGF Files

For files where each m/z and intensity pair has additional metadata (like fragment annotations), use `MsBackendAnnotatedMgf`.

```r
# Import annotated data
sps_ann <- Spectra(ann_file, source = MsBackendAnnotatedMgf())

# List available peak variables
peaksVariables(sps_ann)

# Extract peak data including annotations (usually named V1, V2, etc.)
pd <- peaksData(sps_ann, columns = c("mz", "intensity", "V1"))
head(pd[[1]])
```

## Performance Tips

- **Parallel Processing**: For large files (>100,000 spectra) or many files, use `BiocParallel`.
  ```r
  library(BiocParallel)
  # Use MulticoreParam for Linux/Mac or SnowParam for Windows
  sps <- Spectra(fls, source = MsBackendMgf(), BPPARAM = MulticoreParam())
  ```
- **Variable Selection**: Before exporting, use `selectSpectraVariables()` to remove unnecessary metadata that might not be supported by downstream external tools.

## Reference documentation

- [Description and usage of MsBackendMgf](./references/MsBackendMgf.Rmd)
- [Description and usage of MsBackendMgf](./references/MsBackendMgf.md)