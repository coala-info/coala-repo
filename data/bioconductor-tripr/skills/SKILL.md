---
name: bioconductor-tripr
description: The tripr package provides a framework for analyzing B cell and T cell receptor gene sequence data from IMGT/HighV-Quest output. Use when user asks to clean and filter receptor sequences, identify clonotypes, profile repertoires, or perform somatic hypermutation analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/tripr.html
---


# bioconductor-tripr

## Overview
The `tripr` package provides a comprehensive framework for analyzing B cell and T cell receptor gene sequence data. It is designed to process output files from the IMGT/HighV-Quest tool. The package supports both an interactive Shiny interface and a programmatic R command-line workflow via the `run_TRIP` function. Key capabilities include data cleaning (preselection), filtering (selection), clonotype identification, repertoire profiling, and somatic hypermutation (SHM) analysis.

## Core Workflow

### 1. Data Preparation
`tripr` requires IMGT/HighV-Quest output files (typically `.txt`).
- **Structure**: Every sample must have its own individual folder. All sample folders must reside within a single root directory.
- **Files**: Common files used include `1_Summary.txt`, `2_IMGT-gapped-nt-sequences.txt`, `4_IMGT-gapped-AA-sequences.txt`, and `6_Junction.txt`.

### 2. Programmatic Analysis with run_TRIP
The primary function for command-line analysis is `run_TRIP()`.

```r
library(tripr)

# Define paths
datapath <- "/path/to/root_folder"
output_path <- "/path/to/output_results"

# Execute analysis
run_TRIP(
    datapath = datapath,
    output_path = output_path,
    cell = "Bcell", # or "Tcell"
    throughput = "High Throughput", # or "Low Throughput"
    filelist = c("1_Summary.txt", "2_IMGT-gapped-nt-sequences.txt", "4_IMGT-gapped-AA-sequences.txt", "6_Junction.txt"),
    preselection = "1,2,3,4C:W", # Criteria indices
    selection = "5",             # Filter indices
    pipeline = "1,2,3",          # Pipeline step indices
    select_clonotype = "V Gene + CDR3 Amino Acids"
)
```

### 3. Preprocessing Options
- **Preselection (Cleaning)**:
    1. Functional V-Gene only.
    2. CDR3 with no special characters.
    3. Productive sequences only.
    4. Valid CDR3 start/end landmarks (e.g., "F|D").
- **Selection (Filtering)**:
    5. V-REGION identity % range.
    6. Specific V Gene.
    7. Specific J Gene.
    8. Specific D Gene.
    9. CDR3 length range.
    10. Specific CDR3 amino-acid motif.

### 4. Pipeline Steps
Pipeline indices for the `pipeline` argument:
- `1`: Clonotype computation (frequencies of unique clonotypes).
- `2`: Highly similar clonotypes (allows mismatches).
- `3`: Repertoires extraction (V, D, J gene usage).
- `4`: Highly similar repertoires.
- `5`: Multiple value comparison (cross-tabulation).
- `10`: Alignment (VDJ/VJ regions).
- `11`: Somatic hypermutations (requires Alignment step).

### 5. Step Dependencies
- **Clonotypes**: Must run before Highly Similar Clonotypes or Repertoires Extraction.
- **Alignment**: Must run before Mutations analysis.
- **Identity Groups**: Must be defined before Somatic Hypermutation Status.

## Results Interpretation
The `run_TRIP` function saves results to the `output_path`:
- **/output**: Contains `.txt` tables for summaries, clean data, clonotypes, and repertoires.
- **/Analysis**: Contains generated plots and visualizations.

## Launching the Interactive App
To use the graphical interface instead of the command line:
```r
tripr::run_app()
```

## Reference documentation
- [tripr User Guide](./references/tripr_guide.md)
- [tripr RMarkdown Source](./references/tripr_guide.Rmd)