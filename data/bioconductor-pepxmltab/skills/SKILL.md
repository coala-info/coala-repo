---
name: bioconductor-pepxmltab
description: This tool parses and filters pepXML files from mass spectrometry search engines into tabular R data frames. Use when user asks to convert XML-based peptide-spectrum matches to tables, filter proteomics search results, or estimate false discovery rates.
homepage: https://bioconductor.org/packages/release/bioc/html/pepXMLTab.html
---

# bioconductor-pepxmltab

name: bioconductor-pepxmltab
description: Parsing and filtering pepXML files from various mass spectrometry search engines (MyriMatch, Mascot, SEQUEST, X!Tandem) into tabular R data frames. Use this skill when you need to convert XML-based peptide-spectrum matches (PSMs) into human-readable tables or perform FDR-based filtering on proteomics search results.

# bioconductor-pepxmltab

## Overview

The `pepXMLTab` package provides a streamlined workflow for handling pepXML files, which are a standard output format for many mass spectrometry search engines. It converts the complex, nested XML structure of `spectrum_query` sections into flat R data frames (tabular format) and provides robust filtering mechanisms to calculate and apply False Discovery Rate (FDR) thresholds at the peptide level.

## Core Workflow

### 1. Convert pepXML to Tabular Format

The primary function `pepXML2tab` parses the pepXML file. The resulting data frame columns vary depending on the search engine used (e.g., `mvh` for MyriMatch, `ionscore` for Mascot, `xcorr` for SEQUEST/MyriMatch, `hyperscore` for X!Tandem).

```r
library(pepXMLTab)

# Path to your pepXML file
pepxml_file <- "path/to/your/results.pepXML"

# Convert to data frame
psm_table <- pepXML2tab(pepxml_file)

# View the first few rows
head(psm_table)
```

### 2. Filter PSMs and Estimate FDR

The `PSMfilter` function filters the tabular data based on search engine scores, hit rank, and peptide length. It uses a decoy database approach (searching against reversed or shuffled sequences) to estimate FDR.

```r
# Filter PSMs with a 1% FDR threshold
# Note: 'scorecolumn' must match the specific score name from your search engine
passed_psms <- PSMfilter(
  psm_table, 
  pepFDR = 0.01, 
  scorecolumn = 'mvh',    # Use 'ionscore', 'xcorr', or 'hyperscore' as appropriate
  hitrank = 1,            # Usually keep only the top hit
  minpeplen = 6,          # Minimum peptide length
  decoyprefix = 'rev_'    # Prefix used for decoy proteins in your database
)
```

## Key Functions and Parameters

### pepXML2tab(file)
- **file**: Path to the input `.pepXML` file.
- **Returns**: A data frame where each row is a PSM. Common columns include `spectrum`, `peptide`, `protein`, `calc_neutral_pep_mass`, and engine-specific scores.

### PSMfilter(dat, pepFDR, scorecolumn, hitrank, minpeplen, decoyprefix)
- **dat**: The data frame produced by `pepXML2tab`.
- **pepFDR**: The False Discovery Rate threshold (e.g., 0.01 for 1%).
- **scorecolumn**: The string name of the column containing the primary score to filter on.
- **hitrank**: Integer; filters for hits at or better than this rank (usually 1).
- **minpeplen**: Integer; minimum amino acid length for peptides.
- **decoyprefix**: The string prefix identifying decoy entries in the `protein` column.

## Usage Tips

- **Score Selection**: Ensure you identify the correct score column for your search engine. 
    - MyriMatch: `mvh` or `xcorr`
    - Mascot: `ionscore`
    - SEQUEST: `xcorr`
    - X!Tandem: `hyperscore` or `expect`
- **FDR Calculation**: The package calculates FDR by separating peptides into classes based on tryptic status and charge state, applying the threshold to each class before pooling results.
- **Modification Parsing**: The `modification` column in the output table encodes variable modifications (e.g., `1;111.03...`) which can be used for downstream analysis of PTMs.

## Reference documentation

- [Introduction to pepXMLTab](./references/pepXMLTab.md)