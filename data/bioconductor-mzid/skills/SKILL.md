---
name: bioconductor-mzid
description: The bioconductor-mzid package parses mzIdentML files into consistent R objects for downstream statistical analysis. Use when user asks to parse mzIdentML files, read identification data from search engines, or flatten mzIdentML results into a data frame.
homepage: https://bioconductor.org/packages/release/bioc/html/mzID.html
---


# bioconductor-mzid

## Overview

The `mzID` package is a dedicated parser for the mzIdentML file format. It is designed to handle the high variability of the mzIdentML XML specification, providing a consistent R object structure regardless of the search engine (e.g., Mascot, SEQUEST) used to generate the data. It is primarily used to bridge raw identification files with downstream statistical analysis in R.

## Core Workflow

### 1. Loading mzIdentML Files
The primary function is `mzID()`, which reads a `.mzid` file and returns an object of class `mzID`.

```r
library(mzID)

# Path to your mzIdentML file
file_path <- "path/to/identifications.mzid"

# Parse the file
mz_results <- mzID(file_path)

# View summary information
mz_results
```

### 2. Data Structure
An `mzID` object is organized into slots reflecting the XML hierarchy:
- `@parameters`: Search settings and software metadata.
- `@psm`: Peptide-Spectrum Matches (the core identification data).
- `@peptides`: Peptide sequences and modifications.
- `@database`: Protein database information.
- `@evidence`: Links between peptides and protein accessions.

### 3. Flattening Results
Most users prefer a tabular format for analysis. Use the `flatten()` function to convert the complex `mzID` object into a standard R `data.frame`.

```r
# Convert to a flat data frame
flat_df <- flatten(mz_results)

# Each row represents a PSM
head(flat_df)

# Check available columns (scores, accessions, sequences, etc.)
colnames(flat_df)
```

## Key Functions and Usage Tips

### Function Reference
- `mzID(file)`: Constructor that parses the XML file.
- `flatten(object)`: Transforms the S4 object into a long-format `data.frame`.
- `length(object)`: Returns the number of PSMs in the object.

### Important Considerations
- **Column Ambiguity**: When using `flatten()`, columns like `length` may refer to the protein/nucleotide sequence length rather than the peptide length. Always verify the context of numeric columns.
- **Memory**: For very large mzIdentML files, the parsing process can be memory-intensive due to the underlying XML DOM parsing.
- **Identification Scores**: Score column names (e.g., `mascot:score`, `X!Tandem:expect`) vary depending on the software that generated the file. Use `colnames(flatten(obj))` to identify the specific score metrics available.

## Reference documentation

- [Parsing mzIdentML files using mzID](./references/HOWTO_mzID.md)