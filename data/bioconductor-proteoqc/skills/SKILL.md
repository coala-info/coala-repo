---
name: bioconductor-proteoqc
description: This tool provides an automated quality control pipeline for mass spectrometry-based proteomics data to generate interactive HTML reports. Use when user asks to generate proteomics QC reports, perform MS/MS searches using X!Tandem, calculate iTRAQ or TMT labeling efficiency, or analyze precursor charge distributions.
homepage: https://bioconductor.org/packages/3.8/bioc/html/proteoQC.html
---


# bioconductor-proteoqc

name: bioconductor-proteoqc
description: Automated quality control (QC) pipeline for mass spectrometry-based proteomics data. Use this skill to generate interactive HTML QC reports from peak list files (MGF, mzML, mzXML), perform MS/MS searches using X!Tandem, calculate labeling efficiency for iTRAQ/TMT, and analyze precursor charge distributions.

## Overview

The `proteoQC` package provides an integrated R-based pipeline for proteomics quality control. It automates the process of searching peak lists against protein databases and generates comprehensive, interactive HTML reports. Key features include protein inference, contamination analysis (cRAP), and reproducibility summaries across biological and technical replicates.

## Core Workflow

### 1. Experimental Design
The pipeline requires a design file (space-separated text) with the following columns:
- `file`: Path to peak list files (MGF, mzML, or mzXML).
- `sample`: Sample identifiers (e.g., treatment groups).
- `bioRep`: Biological replicate number.
- `techRep`: Technical replicate number.
- `fraction`: Fraction number (for fractionated samples).

```r
# Example of reading a design file
design_path <- "experimental_design.txt"
read.table(design_path, header = TRUE)
```

### 2. Running the QC Pipeline
Use `msQCpipe` to perform the MS/MS search and process the data. This function wraps `rTANDEM`.

```r
library(proteoQC)

qcres <- msQCpipe(
  spectralist = "experimental_design.txt",
  fasta = "database.fasta",
  outdir = "./qc_results",
  miss = 0,             # Number of missed cleavages
  enzyme = 1,           # Trypsin
  varmod = 2,           # Variable modifications (see showMods())
  fixmod = 1,           # Fixed modifications
  tol = 10,             # Precursor tolerance (ppm)
  itol = 0.6,           # Fragment tolerance (Daltons)
  cpu = 2,              # Number of cores
  mode = "identification"
)
```

### 3. Generating the Report
Once the pipeline is complete, generate the interactive HTML report.

```r
# Generate report from the result object or the output directory
html_file <- reportHTML(qcres)
# Or: reportHTML("./qc_results")

# Open the report in a browser
browseURL(html_file)
```

## Utility Functions

### Modification and Enzyme Lookups
Before running the pipeline, check the supported indices for modifications and enzymes.
- `showMods()`: Displays available modifications (e.g., Carbamidomethyl, Oxidation, iTRAQ, TMT).
- `showEnzyme()`: Displays available proteolytic enzymes.

### Labeling Efficiency
For isobaric tagging (iTRAQ/TMT), calculate the labeling efficiency of the reagents.
```r
# reporter = 1 for iTRAQ4plex, 2 for iTRAQ8plex, 3 for TMT6plex
ratio <- labelRatio("sample.mgf", reporter = 2)
```

### Precursor Charge Distribution
Analyze the distribution of precursor charges in a peak list file.
```r
charge_data <- chargeStat("sample.mgf")
# Returns a data frame with Charge and Number columns
```

### Protein Inference
Group peptides into proteins to handle the protein inference problem.
```r
proteinGroup(file = "peptide_identifications.txt", outfile = "protein_groups.txt")
```

## Tips for Success
- **mzML/mzXML Support**: Ensure `rTANDEM` version > 1.5.1 is installed if using these formats instead of MGF.
- **Performance**: The `msQCpipe` function is computationally intensive. Use the `cpu` parameter to parallelize the search.
- **Loading Previous Results**: If you have already run the pipeline, you can reload the results using `loadmsQCres("./qc_results")` without re-running the search.

## Reference documentation
- [proteoQC: an R package for proteomics data quality assessment](./references/proteoQC.Rmd)
- [proteoQC: an R package for proteomics data quality assessment](./references/proteoQC.md)