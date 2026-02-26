---
name: bioconductor-geosubmission
description: The GEOsubmission package prepares microarray data and metadata for submission to the NCBI Gene Expression Omnibus by generating a SOFT format file. Use when user asks to deposit microarray data to GEO, convert metadata and expression data into SOFT format, or prepare Affymetrix CEL files for NCBI submission.
homepage: https://bioconductor.org/packages/release/bioc/html/GEOsubmission.html
---


# bioconductor-geosubmission

## Overview

The `GEOsubmission` package simplifies the process of depositing microarray data into the NCBI Gene Expression Omnibus (GEO). Its primary function, `microarray2soft`, aggregates user-provided metadata and expression data into a single SOFT format file. This file, when combined with raw data files (like .CEL files) in a ZIP archive, allows for "direct deposit" to GEO.

## Core Workflow

The package relies on two metadata text files and one source of expression data.

### 1. Prepare Metadata Files
You must create two tab-delimited text files:
*   **Sample Information (`sampleInfo.txt`)**: Contains columns for sample titles, organism, characteristics, and the names of the raw data files (e.g., `sample1.CEL`).
*   **Series Information (`seriesInfo.txt`)**: Contains the study title, summary, overall design, and contributor names.

### 2. Generate the SOFT File
The `microarray2soft` function is the workhorse of the package.

**Scenario A: Affymetrix CEL files (Automatic Normalization)**
If you provide a directory containing CEL files, the package can use the `affy` package to perform RMA normalization automatically.
```r
library(GEOsubmission)

sampleID <- c('1', '2') # IDs matching the metadata
seriesName <- 'MyStudy'

microarray2soft(
  sampleID = sampleID,
  sampleread = 'sampleInfo.txt',
  seriesname = seriesName,
  seriesread = 'seriesInfo.txt',
  softname = 'submission.soft',
  datadir = 'path/to/CEL/files'
)
```

**Scenario B: Pre-normalized Expression Matrix**
For non-Affymetrix platforms or if you have already normalized your data, provide a tab-delimited text file where rows are probes and columns are samples.
```r
microarray2soft(
  sampleID = sampleID,
  sampleread = 'sampleInfo.txt',
  seriesname = seriesName,
  seriesread = 'seriesInfo.txt',
  softname = 'submission.soft',
  expressionmatrix = 'normalized_values.txt'
)
```

## Function Parameters: microarray2soft

*   `sampleID`: Character vector of sample identifiers.
*   `sampleread`: Path to the sample metadata file.
*   `seriesname`: A descriptive name for the series.
*   `seriesread`: Path to the series metadata file.
*   `softname`: The name of the output SOFT file. If set to `''`, it prints to the console.
*   `datadir`: Directory where raw data files (CEL files) are located.
*   `writedir`: Directory where the SOFT file will be saved (defaults to current).
*   `expressionmatrix`: Path to a text file containing normalized expression data (optional).
*   `verbose`: Boolean to toggle status messages.

## Tips for Success

1.  **Consistency Checks**: `microarray2soft` automatically checks that the raw files listed in `sampleInfo.txt` actually exist in the `datadir`.
2.  **SOFT Format Validation**: Before uploading to GEO, you can inspect the generated `.soft` file using `readLines()` to ensure the headers (e.g., `^SAMPLE`, `!Sample_title`) and tables are correctly formatted.
3.  **Final Packaging**: After generating the SOFT file, compress it along with your raw data files (CEL, etc.) into a single `.zip` or `.tar` archive for the GEO "Direct Deposit" web form.

## Reference documentation

- [GEOsubmission](./references/GEOsubmission.md)