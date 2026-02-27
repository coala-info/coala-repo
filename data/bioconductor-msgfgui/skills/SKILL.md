---
name: bioconductor-msgfgui
description: MSGFgui provides a graphical user interface for performing peptide identification and visualizing proteomics data using the MS-GF+ search engine. Use when user asks to launch a GUI for mass spectrometry analysis, perform peptide identification from raw data, or visualize protein coverage and annotated spectra.
homepage: https://bioconductor.org/packages/3.8/bioc/html/MSGFgui.html
---


# bioconductor-msgfgui

## Overview
`MSGFgui` provides a Shiny-based graphical user interface for the MS-GF+ proteomics search engine. It allows users to perform peptide identification from raw mass spectrometry data (mzML, etc.) against FASTA databases without using the command line. It features advanced D3.js visualizations for protein coverage, peptide-spectrum matches (PSM), and annotated spectra.

## Core Functions

### Launching the Interface
The primary way to use this package is by launching the GUI.
```r
library(MSGFgui)

# Start the GUI in the default browser
MSGFgui()

# Start with specific shiny parameters
MSGFgui(port = '0.0.0.0')
```
*Note: To stop the GUI and return to the R console, press 'Esc' in the R terminal.*

### Accessing Data in R
You can retrieve the results currently loaded or recently processed in the GUI into your active R session.
```r
# Retrieve results as an mzIDCollection object
results <- currentData()

# Inspect the results
show(results)
```

## Typical Workflow

1.  **Data Preparation**: Ensure raw data is in an open format (preferably `.mzML`). Prepare a `.fasta` file containing target protein sequences.
2.  **Launch GUI**: Run `MSGFgui()`.
3.  **Configuration**:
    *   **Upload**: Select raw data files and the FASTA database.
    *   **Parameters**: Set precursor tolerance, isotope error range, fragmentation method, and modifications (hover over parameter names for tooltips).
4.  **Analysis**: Click "Analyse". Progress is tracked via a status bar.
5.  **Exploration**:
    *   **Samples Tab**: View overall ID statistics and FDR distributions.
    *   **Identifications Tab**: Drill down from Protein -> Peptide -> Scan (Spectrum).
    *   **Filter Tab**: Apply FDR cutoffs or filter by retention time, charge, or modifications.
6.  **Export**: Use the toolbar to export results as `.RDS`, `.xlsx`, or `.txt`.

## Critical Usage Tips
*   **RStudio Compatibility**: Running `MSGFgui()` inside RStudio may cause crashes when accessing raw MS/MS scans due to incompatibilities between `shiny` and `mzR`. It is recommended to run the GUI from a standard R terminal.
*   **System Requirements**: Proteomics analysis is resource-intensive. While the GUI is lightweight, the underlying MS-GF+ search benefits significantly from multiple cores and high RAM.
*   **Batch Processing**: You can select multiple raw files during the upload step to create batch jobs.
*   **Importing External Results**: You can import existing MS-GF+ results (generated via the `MSGFplus` package or command line) into the GUI for visualization, provided the original raw data files are in the same directory.

## Reference documentation
- [Using MSGFgui](./references/Using_MSGFgui.md)