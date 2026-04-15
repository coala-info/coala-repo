---
name: bioconductor-msbackendmsp
description: This tool provides support for the NIST MSP file format within Mass Spectrometry data workflows using the Spectra package infrastructure. Use when user asks to import MSP files, export spectra to MSP format, or convert between different MSP flavors like MoNA and MS-DIAL.
homepage: https://bioconductor.org/packages/release/bioc/html/MsBackendMsp.html
---

# bioconductor-msbackendmsp

name: bioconductor-msbackendmsp
description: Support for NIST MSP file format in Mass Spectrometry (MS) data workflows. Use this skill to import, export, and convert MS/MS spectra data between different MSP "flavors" (NIST, MoNA, MS-DIAL) using the Spectra package infrastructure.

## Overview

The `MsBackendMsp` package extends the `Spectra` framework to handle NIST MSP files, which are commonly used for sharing spectral libraries. It allows users to treat MSP files as backends for `Spectra` objects, enabling seamless integration with metabolomics annotation workflows. A key feature is its ability to handle different MSP "dialects" through customizable metadata mapping.

## Core Workflows

### Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MsBackendMsp")
```

### Importing MSP Data

To read an MSP file, use the `Spectra` constructor with `MsBackendMsp()` as the source.

```r
library(MsBackendMsp)
library(Spectra)

# Import using default NIST/MS-DIAL mapping
msp_file <- "path/to/data.msp"
sp <- Spectra(msp_file, source = MsBackendMsp())

# Access data
spectraVariables(sp)
sp$name
sp$precursorMz
```

### Handling Different MSP Flavors (e.g., MoNA)

MSP files often use different keys for metadata (e.g., "Name" vs "NAME"). Use `spectraVariableMapping()` to handle these variations.

```r
# View default mapping
spectraVariableMapping(MsBackendMsp())

# Import MoNA flavored files
mona_mapping <- spectraVariableMapping(MsBackendMsp(), "mona")
sp_mona <- Spectra(mona_file, 
                   source = MsBackendMsp(), 
                   mapping = mona_mapping)
```

### Exporting and Converting Data

You can export `Spectra` objects back to MSP format. By changing the mapping during export, you can effectively convert between MSP dialects.

```r
# Export to standard NIST format
export(sp_mona, 
       backend = MsBackendMsp(), 
       file = "output_nist.msp",
       mapping = spectraVariableMapping(MsBackendMsp()))

# Export to MoNA format
export(sp, 
       backend = MsBackendMsp(), 
       file = "output_mona.msp",
       mapping = spectraVariableMapping(MsBackendMsp(), "mona"))
```

## Custom Mappings

If a file uses non-standard fields, provide a named character vector to the `mapping` argument where:
- **Names** are the internal `Spectra` variable names (e.g., `precursorMz`).
- **Values** are the field names in the MSP file (e.g., `MY_PRECURSOR_FIELD`).

```r
custom_map <- c(precursorMz = "PRECURSORMZ", name = "COMPOUND_NAME")
sp_custom <- Spectra(file, source = MsBackendMsp(), mapping = custom_map)
```

## Key Functions

- `MsBackendMsp()`: Constructor for the MSP backend.
- `spectraVariableMapping(object, flavor)`: Retrieves pre-defined mappings (default is "nist", options include "mona").
- `export(object, backend, file, mapping)`: Writes spectra data to an MSP file.

## Reference documentation

- [MsBackendMsp Vignette (Rmd)](./references/MsBackendMsp.Rmd)
- [MsBackendMsp Vignette (Markdown)](./references/MsBackendMsp.md)