---
name: bioconductor-metaboannotation
description: This tool annotates MS-based metabolomics data by matching experimental features like m/z, retention time, and spectra against reference libraries. Use when user asks to perform metabolite annotation, match MS/MS spectra against libraries, compare chemical formulas, or identify compounds using m/z and retention time values.
homepage: https://bioconductor.org/packages/release/bioc/html/MetaboAnnotation.html
---

# bioconductor-metaboannotation

name: bioconductor-metaboannotation
description: Annotation of MS-based metabolomics data by matching query entities (m/z, retention time, spectra, formulas) against reference targets. Use this skill when you need to perform metabolite annotation, match experimental MS/MS spectra against libraries (MassBank, CompDb), or organize standard compounds into mixes.

# bioconductor-metaboannotation

## Overview

The `MetaboAnnotation` package provides a high-level framework for annotating metabolomics data. It centers around "matching" functions that compare query data (experimental features) against target data (reference libraries). The package handles one-to-many and one-to-none relationships through specialized `Matched` and `MatchedSpectra` objects, which preserve both the original data and the matching metadata (scores, adducts, etc.).

## Core Matching Functions

The package provides three primary functions, each using specific parameter objects to define the matching logic:

1.  `matchValues()`: Matches numerical values like m/z and retention time.
2.  `matchSpectra()`: Matches fragment (MS2) spectra using similarity scores.
3.  `matchFormula()`: Matches chemical formulas.

## Workflow: Matching m/z and Retention Time

To match experimental features against a reference data frame or database:

1.  **Define Parameters**: Use `Mass2MzParam` (for m/z only) or `Mass2MzRtParam` (for m/z and RT).
2.  **Execute Match**: Call `matchValues()`.
3.  **Extract Results**: Use `matchedData()` to get a combined table.

```r
library(MetaboAnnotation)

# 1. Setup parameters (matching query m/z to target exact mass via adducts)
parm <- Mass2MzRtParam(
    adducts = c("[M+H]+", "[M+Na]+"),
    tolerance = 0.005, 
    ppm = 10,
    toleranceRt = 10
)

# 2. Perform matching
# query can be data.frame, SummarizedExperiment, or QFeatures
# target is usually a data.frame or CompDb
matched_res <- matchValues(query_data, target_data, param = parm, rtColname = "rtime")

# 3. Explore results
matched_res                 # Summary of matches
whichQuery(matched_res)     # Indices of matched query features
matchedData(matched_res)    # Full DataFrame of matches (includes target_ prefix columns)
```

## Workflow: MS/MS Spectra Matching

To match experimental MS2 spectra against a reference library (e.g., MassBank):

1.  **Prepare Spectra**: Ensure query and target are `Spectra` objects.
2.  **Define Similarity**: Use `CompareSpectraParam` or `MatchForwardReverseParam`.
3.  **Execute Match**: Call `matchSpectra()`.

```r
library(Spectra)

# Define matching parameters
csp <- CompareSpectraParam(
    requirePrecursor = TRUE, # Only compare spectra with similar precursor m/z
    ppm = 10,
    tolerance = 0.01,
    matchedPeaksCount = TRUE
)

# Perform matching
mtches <- matchSpectra(query_spectra, target_spectra, param = csp)

# Access results
mtches$score                # Similarity scores
mtches$target_compound_name # Names from target library
plotSpectraMirror(mtches[2]) # Visualize a specific match
```

### Advanced Spectra Matching Tips
*   **Alternative Similarity**: To use spectral entropy, set `MAPFUN = joinPeaksNone` and `FUN = msentropy_similarity` within `CompareSpectraParam`.
*   **Performance**: For large datasets, convert `Spectra` backends to `MsBackendMemory()` using `setBackend()` to speed up calculations.
*   **Validation**: Use `validateMatchedSpectra(mtches)` to open an interactive Shiny app for manual curation of matches.

## Working with Bioconductor Objects

`MetaboAnnotation` integrates with standard Bioconductor containers:
*   **SummarizedExperiment**: Pass the object as `query`. Matching is performed on `rowData(se)`.
*   **QFeatures**: Pass the object and specify the assay with `queryAssay = "assay_name"`.
*   **CompoundDb**: Use a `CompDb` object as the `target` in `matchValues` or `matchSpectra`.

## Utility: Creating Standard Mixes

The `createStandardMixes()` function helps design experiments by grouping standards so that no two compounds in a mix have overlapping m/z values.

```r
# x must be a matrix with m/z values (rows = compounds, cols = adducts)
mixes <- createStandardMixes(
    standard_matrix, 
    min_diff = 2, 
    max_nstd = 15, 
    iterativeRandomization = TRUE
)
```

## Reference documentation
- [Annotation of MS-based Metabolomics Data](./references/MetaboAnnotation.Rmd)
- [Annotation of MS-based Metabolomics Data](./references/MetaboAnnotation.md)