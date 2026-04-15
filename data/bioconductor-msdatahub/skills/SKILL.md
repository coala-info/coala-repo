---
name: bioconductor-msdatahub
description: MsDataHub provides access to example mass spectrometry datasets from ExperimentHub for proteomics and metabolomics experiments. Use when user asks to access sample mass spectrometry data, load raw MS spectra, retrieve peptide spectrum matches, or obtain quantitative proteomics tables for testing and demonstration.
homepage: https://bioconductor.org/packages/release/bioc/html/MsDataHub.html
---

# bioconductor-msdatahub

name: bioconductor-msdatahub
description: Access example mass spectrometry data from ExperimentHub for proteomics and metabolomics experiments. Use when needing sample datasets for testing or demonstrating workflows involving the Spectra, PSMatch, or QFeatures packages. This skill provides access to raw MS data (mzML, CDF), peptide spectrum matches (mzid), and quantitative proteomics tables (MaxQuant, DIA-NN).

# bioconductor-msdatahub

## Overview

The `MsDataHub` package serves as a centralized repository for mass spectrometry (MS) example datasets within the Bioconductor ecosystem. It utilizes the `ExperimentHub` infrastructure to download and cache data locally, ensuring efficient access. The package includes diverse data types: raw MS1/MS2 spectra, identification results (PSMs), and processed quantitative data from both DDA and DIA experiments.

## Installation

Install the package using `BiocManager`:

```r
if (!require("BiocManager")) install.packages("BiocManager")
BiocManager::install("MsDataHub")
```

## Typical Workflows

### Discovering Available Data

To view a summary table of all currently available datasets, their types, and descriptions:

```r
library(MsDataHub)
MsDataHub()
```

### Loading Raw MS Data (Spectra)

Raw data files (mzML, netCDF) are accessed via specific functions that return the path to the cached file. These are typically processed using the `Spectra` package.

```r
library(Spectra)

# TripleTOF DDA data
f_dda <- PestMix1_DDA.mzML()
s_dda <- Spectra(f_dda)

# FAAH KO netCDF data
f_ko <- ko15.CDF()
s_ko <- Spectra(f_ko)
```

### Loading Peptide Spectrum Matches (PSM)

Identification data in `.mzid` format can be loaded and analyzed using the `PSMatch` package.

```r
library(PSMatch)

# Load PXD000001 identification data
f_mzid <- TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01.20141210.mzid()
psms <- PSM(f_mzid)
```

### Loading Quantitative Proteomics Data (QFeatures)

The package provides various quantitative tables, including MaxQuant and DIA-NN outputs.

**MaxQuant (CPTAC):**
```r
library(QFeatures)
f_cptac <- cptac_peptides.txt()
# Identify intensity columns (e.g., starting with 'Intensity.')
ecols <- grep("Intensity\\.", names(read.delim(f_cptac)))
readSummarizedExperiment(f_cptac, ecols, sep = "\t")
```

**DIA-NN Outputs:**
```r
# Label-free DIA
lfdia_path <- MsDataHub::benchmarkingDIA.tsv()
lfdia_data <- read.delim(lfdia_path)
readQFeaturesFromDIANN(lfdia_data)

# Multiplexed (mTRAQ) plexDIA
plexdia_path <- MsDataHub::Report.Derks2022.plexDIA.tsv()
plexdia_data <- read.delim(plexdia_path)
readQFeaturesFromDIANN(plexdia_data, multiplexing = "mTRAQ")
```

### Accessing Contaminant Databases

Access FASTA files for common contaminants (cRAP) for proteomics search engine configuration:

```r
# Access MaxQuant contaminant database
crap_path <- crap_maxquant.fasta.gz()
```

## Tips for Usage

- **Caching**: The first time a data accessor function (e.g., `ko15.CDF()`) is called, the file is downloaded. Subsequent calls retrieve the file from the local `ExperimentHub` cache.
- **Function Naming**: Accessor functions generally match the filename. If a filename starts with a digit, R prepends an `X` (e.g., `X20171016_POOL_POS_1_105.134.mzML()`).
- **Documentation**: Use `?TripleTOF`, `?cptac`, or `?cRAP` to see detailed metadata and provenance for specific datasets.

## Reference documentation

- [Mass Spectrometry Data on ExperimentHub](./references/MsDataHub.Rmd)
- [Mass Spectrometry Data on ExperimentHub (Markdown)](./references/MsDataHub.md)