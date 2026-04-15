---
name: bioconductor-tartare
description: The tartare package provides a collection of complex mass spectrometry raw files from various Thermo Fisher Scientific instruments for testing and developing robust data processing code. Use when user asks to access example mass spectrometry data, test code against different Thermo .raw binary formats, or download slim real-world datasets via ExperimentHub.
homepage: https://bioconductor.org/packages/release/data/experiment/html/tartare.html
---

# bioconductor-tartare

## Overview
The `tartare` package is a Bioconductor Experiment Data package. It provides a collection of "slim" but complex real-world mass spectrometry raw files recorded on various Thermo Fisher Scientific instruments (Q Exactive HF-X, Fusion Lumos). These files are specifically designed for unit testing and developing robust code that can handle different "dialects" of the Thermo .raw binary format. It is primarily used in conjunction with `rawrr`, `Spectra`, and `MsBackendRawFileReader`.

## Loading Data via ExperimentHub
The recommended way to access `tartare` data is through `ExperimentHub`.

```r
library(ExperimentHub)

# Initialize Hub and query for tartare records
eh <- ExperimentHub()
tartare_records <- query(eh, "tartare")

# View available records
# EH3219 | Q Exactive HF-X mzXML
# EH3220 | Q Exactive HF-X raw
# EH3221 | Fusion Lumos mzXML
# EH3222 | Fusion Lumos raw
# EH4547 | Q Exactive HF Orbitrap raw

# Download/Load a specific file (e.g., Q Exactive HF-X raw)
raw_file_path <- eh[["EH3220"]]
```

## Accessing Metadata
You can access the package metadata to see details about the instruments and sample types (Pierce HeLa protein digest).

```r
# Locate the metadata file within the package
metadata_file <- system.file("extdata", "metadata.csv", package = "tartare")

# Read metadata
metadata <- read.csv(metadata_file, stringsAsFactors = FALSE)
head(metadata)
```

## Typical Workflow: Integration with Spectra
`tartare` provides the raw data that is then processed by other Bioconductor tools.

```r
library(Spectra)
library(MsBackendRawFileReader)

# Get path to a raw file from tartare via ExperimentHub
eh <- ExperimentHub()
local_raw_path <- eh[["EH3222"]] # Fusion Lumos raw

# Initialize Spectra object using the tartare file
be <- MsBackendRawFileReader::MsBackendRawFileReader()
s <- Spectra(local_raw_path, source = be)

# Explore the spectra
print(s)
table(msLevel(s))
```

## Instrument Dialects Provided
The package is useful for testing code against specific instrument configurations:
- **Q Exactive HF-X**: Includes Full MS, dd-MS2 (TopN), PRM, Targeted-SIM, and DIA experiments.
- **Fusion Lumos**: Includes Orbitrap HCD, ETD Decision Tree, Glycopeptide-enriched (EThcD), and TMT MS3 SPS experiments.

## Reference documentation
- [make and use tartare data](./references/tartare.Rmd)
- [tartare package vignette](./references/tartare.md)