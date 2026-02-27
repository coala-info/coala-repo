---
name: bioconductor-proteomicsannotationhubdata
description: This tool integrates proteomics and mass spectrometry data into the Bioconductor AnnotationHub for standardized access. Use when user asks to discover proteomics datasets, retrieve raw mass spectrometry data from PRIDE, or convert mass spectrometry files into Bioconductor objects.
homepage: https://bioconductor.org/packages/3.6/bioc/html/ProteomicsAnnotationHubData.html
---


# bioconductor-proteomicsannotationhubdata

name: bioconductor-proteomicsannotationhubdata
description: Access and manage proteomics and mass spectrometry data through the Bioconductor AnnotationHub. Use this skill to discover, retrieve, and process standardized proteomics datasets (raw MS data, identification results, and quantitation data) from repositories like PRIDE.

# bioconductor-proteomicsannotationhubdata

## Overview

The `ProteomicsAnnotationHubData` package facilitates the integration of proteomics and mass spectrometry data into the Bioconductor `AnnotationHub` infrastructure. It provides the metadata and "recipes" necessary to convert raw files from repositories like PRIDE into standardized R/Bioconductor objects (e.g., `mzR`, `MSnbase`, `Biostrings`). This allows for direct, reproducible access to proteomics data without manual file handling or format conversion.

## Accessing Proteomics Data

### Initialize AnnotationHub

To begin, initialize the `AnnotationHub` client:

```r
library(AnnotationHub)
ah <- AnnotationHub()
```

### Discover Datasets

Search for proteomics data using keywords, PRIDE identifiers, or the package-specific variable:

```r
# Query by provider or project ID
query(ah, "PRIDE")
query(ah, "PXD000001")

# List all datasets managed by ProteomicsAnnotationHubData
library(ProteomicsAnnotationHubData)
availableProteomicsAnnotationHubData
```

### Retrieve Metadata and Data

Access specific entries using their AnnotationHub identifiers (e.g., "AH49008"):

```r
# View metadata
ah["AH49008"]

# Download and load the data object
# This returns a standardized object (e.g., mzRpwiz, MSnSet, or AAStringSet)
data_obj <- ah[["AH49008"]]
```

## Working with Data Types

The package serves data in specific Bioconductor classes based on the source:

| Source Type | R Data Class | Description |
|-------------|--------------|-------------|
| mzML | `mzRpwiz` | Raw mass spectrometry data |
| mzTab / mzIdentML | `MSnSet` | Peptide/Protein quantitation data |
| mzid | `mzRident` | Identification results |
| FASTA | `AAStringSet` | Protein sequences |

### Example: Processing Raw MS Data

```r
library(mzR)
raw_ms <- ah[["AH49008"]] # Returns an mzRpwiz object
# Plot the first spectrum
plot(peaks(raw_ms, 1), type = "h", xlab = "M/Z", ylab = "Intensity")
```

## Contributing New Datasets

To add new proteomics data to AnnotationHub, you must prepare metadata in Debian Control File (DCF) format.

### Generate a Template

Use the template generator to create a starting point for your metadata:

```r
writePahdTemplate()
```

### Required Metadata Fields

When filling out the DCF file, ensure the following fields are correctly specified:
- **Title**: Prefixed with the experiment ID (e.g., PXD000001).
- **SourceType**: The original format (e.g., mzML, FASTA).
- **DispatchClass**: The internal AnnotationHub class (e.g., mzRpwiz, AAStringSet).
- **Location_Prefix**: Use `PRIDE` for FTP-hosted data or `S3` for Amazon storage.
- **Recipe**: The function used to process the data (use `NA` if no pre-processing is required).

## Reference documentation

- [Proteomics Data in Annotation Hub](./references/ProteomicsAnnotationHubData.Rmd)