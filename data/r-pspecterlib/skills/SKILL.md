---
name: r-pspecterlib
description: This R package provides tools for proteomics data analysis, including peptide fragment matching, sequence mapping, and mass spectrometry visualization. Use when user asks to calculate fragmentation patterns, match peptides to experimental spectra, map peptides to protein sequences, generate extracted ion chromatograms, or visualize MSPathFinderT output.
homepage: https://cran.r-project.org/web/packages/pspecterlib/index.html
---


# r-pspecterlib

name: r-pspecterlib
description: Specialized R package for proteomics data analysis, focusing on peptide fragment matching, visualization, and sequence mapping for both top-down and bottom-up proteomics. Use this skill when you need to calculate fragmentation patterns, generate extracted ion chromatograms (XICs), map peptides to protein sequences, or visualize MSPathFinderT output.

## Overview

The `pspecterlib` package provides the backend functionality for the PSpecteR proteomics visualization application. It is designed to handle both digested (bottom-up) and intact (top-down) proteomics data. Key capabilities include matching peptide fragments to experimental spectra, testing alternative peptides or mass modifications, and visualizing results from mass spectrometry files (mzML or Thermo raw).

## Installation

To install the package from GitHub:

```R
# install.packages("devtools")
devtools::install_github("EMSL-Computing/pspecterlib")
```

## Core Workflows

### 1. Data Loading
The package supports multiple input formats for comprehensive analysis:
- **MS Files**: mzML or ThermoFisher raw files.
- **ID Files**: Optional mzid files for identification data.
- **FASTA Files**: Optional protein sequence databases.

### 2. Peptide Fragmentation and Matching
Calculate and visualize how peptides fragment within the mass spectrometer:
- Generate theoretical fragmentation patterns for specific peptide sequences.
- Match these theoretical fragments against experimental spectra.
- Support for various fragmentation types (e.g., b/y ions for bottom-up, a/b/c/x/y/z for top-down).

### 3. Sequence Mapping
Map identified peptides back to their parent protein sequences to visualize coverage and location. This is essential for understanding protein processing and modification sites.

### 4. Extracted Ion Chromatograms (XIC)
Generate XICs to visualize the intensity of specific ions over retention time, helping to validate peptide identifications and quantify peaks.

### 5. MSPathFinderT Integration
Visualize and process output specifically from the MSPathFinderT search engine, facilitating the analysis of top-down proteomics data.

## Usage Tips
- **Top-Down vs. Bottom-Up**: Ensure you specify the correct ion types when calculating fragments, as intact proteins (top-down) often produce a wider variety of ion series than digested peptides.
- **Mass Modifications**: Use the package to test how specific mass shifts (PTMs) affect the fragment matching score to validate potential modifications.
- **Visualization**: Many functions are designed to produce plots compatible with the PSpecteR Shiny application but can be used independently in R sessions.

## Reference documentation

- [README](./references/README.md)
- [Articles](./references/articles.md)
- [Home Page](./references/home_page.md)
- [Wiki](./references/wiki.md)