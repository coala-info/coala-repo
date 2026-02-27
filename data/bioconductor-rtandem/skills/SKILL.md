---
name: bioconductor-rtandem
description: This package identifies proteins from tandem mass spectrometry data by running the X!Tandem engine within the R environment. Use when user asks to perform protein identification searches, manage taxonomy and search parameters, or parse and analyze MS/MS results.
homepage: https://bioconductor.org/packages/3.8/bioc/html/rTANDEM.html
---


# bioconductor-rtandem

name: bioconductor-rtandem
description: Protein identification by tandem mass spectrometry using X!Tandem. Use this skill to run rTANDEM searches, manage taxonomy and parameter objects, and analyze MS/MS results within R.

# bioconductor-rtandem

## Overview

The `rTANDEM` package encapsulates the X!Tandem engine for protein identification from tandem mass spectrometry (MS/MS) data. It allows users to perform searches directly from R by managing XML-based parameters and taxonomy files as R objects. The package provides tools to parse results into `data.table` objects for downstream analysis, such as filtering proteins by expectation values or peptide counts.

## Typical Workflow

### 1. Initialize Taxonomy
The taxonomy object links a taxon name to specific database files (FASTA or binary `.pro` files).

```r
library(rTANDEM)

# Create a taxonomy object
taxonomy <- rTTaxo(
  taxon = "yeast",
  format = "peptide",
  URL = system.file("extdata/fasta/scd.fasta.pro", package="rTANDEM")
)
```

### 2. Configure Search Parameters
Parameters are managed via an `rTParam` object. You typically start with a default parameter set and update specific values like input spectra and output paths.

```r
param <- rTParam()

# Set fine-grained parameters from a default XML
param <- setParamValue(param, 'list path', 'default parameters', 
                       value=system.file("extdata/default_input.xml", package="rTANDEM"))

# Set search-specific parameters
param <- setParamValue(param, 'protein', 'taxon', value="yeast")
param <- setParamValue(param, 'list path', 'taxonomy information', value=taxonomy)
param <- setParamValue(param, 'spectrum', 'path', 
                       value=system.file("extdata/test_spectra.mgf", package="rTANDEM"))
param <- setParamValue(param, 'output', 'path', value=paste(getwd(), "output.xml", sep="/"))
```

### 3. Run the Analysis
The `tandem()` function executes the search and returns the path to the generated XML result file.

```r
result.path <- tandem(param)
```

### 4. Parse and Analyze Results
Convert the XML output into an R object for filtering and exploration.

```r
# Load results into R
result.R <- GetResultsFromXML(result.path)

# Extract identified proteins with filters
# log.expect: -1.3 corresponds to an expectation value of ~0.05
proteins <- GetProteins(result.R, log.expect=-1.3, min.peptides=2)

# Extract peptides for a specific protein
peptides <- GetPeptides(
  protein.uid = proteins$uid[1], 
  results = result.R, 
  expect = 0.05
)
```

## Key Functions

- `rTTaxo()`: Creates a taxonomy object to map taxa to database files.
- `rTParam()`: Initializes a parameter object.
- `setParamValue()`: Modifies specific settings within a parameter object.
- `tandem()`: Calls the X!Tandem engine to process spectra.
- `GetResultsFromXML()`: Parses the X!Tandem XML output into an R-friendly format.
- `GetProteins()`: Filters and retrieves protein-level data.
- `GetPeptides()`: Retrieves peptide-level data for specific proteins.
- `GetDegeneracy()`: Checks if a peptide sequence is shared across multiple proteins.

## Tips for Analysis

- **Data Format**: Supported spectra formats include 'DTA', 'PKL', and 'MGF'.
- **Expectation Values**: X!Tandem uses expectation values (E-values). In `GetProteins`, the `log.expect` parameter is the base-10 logarithm of the E-value (e.g., -2.0 for 0.01).
- **Degeneracy**: Always check peptide degeneracy using `GetDegeneracy()` before using a peptide for quantification, as many sequences are shared between proteins.
- **Integration**: Since results are returned as `data.table` objects, they integrate seamlessly with other Bioconductor packages like `biomaRt` for functional annotation.

## Reference documentation

- [rTANDEM: An R encapsulation of X!Tandem](./references/rTANDEM.md)