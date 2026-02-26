---
name: metabolabpy
description: MetabolabPy is a Python package designed to process and analyze 1D and 2D NMR spectra for metabolomics and tracer-based metabolism studies. Use when user asks to process raw NMR data, perform automatic phase and baseline correction, identify peaks, or quantify metabolites from HSQC analysis.
homepage: https://github.com/ludwigc/metabolabpy
---


# metabolabpy

## Overview
MetabolabPy is a specialized Python package designed to streamline the processing of Nuclear Magnetic Resonance (NMR) spectra. It is particularly effective for researchers performing metabolomics and tracer-based metabolism analysis who need to transform raw 1D and 2D NMR data into quantifiable metabolite information. The tool automates critical spectral adjustment steps—such as referencing, phasing, and baseline correction—that are traditionally labor-intensive.

## Installation and Setup
Install the package via Conda using the Bioconda channel:
```bash
conda install bioconda::metabolabpy
```

## Core Workflow and CLI Usage
The primary interface is the `metabolabpy` command. Use the help flag to explore available subcommands and arguments:
```bash
metabolabpy --help
```

### Data Pre-processing
* **Referencing**: The tool supports automatic referencing using TMSP (Trimethylsilylpropanoic acid) or TSP. It includes logic to handle spectra where these internal standards might be missing or poorly defined.
* **Phase Correction**: MetabolabPy utilizes Continuous Wavelet Transform (CWT) for automatic phase correction to ensure spectral peaks are correctly oriented.
* **Baseline Correction**: Use the `autobaseline` features to remove spectral curvature. For precise quantification, the tool supports optional local baseline correction during peak integration to account for regional noise or overlaps.

### Peak Analysis and Quantification
* **Peak Picking**: Automate the identification of spectral features. Note that `add_peak` operations now include `n_protons` for better quantification accuracy.
* **Linewidth Calculation**: Use built-in functions to calculate peak linewidths, which is essential for assessing spectral quality and fitting TMSP standards.
* **Integration**: Perform peak integration with local baseline adjustments to derive metabolite concentrations or relative abundances.

### Metabolite Identification
* **HSQC Analysis**: The tool includes specialized scripts for 2D Heteronuclear Single Quantum Coherence (HSQC) analysis.
* **Metabolite Library**: Recent updates have expanded support for specific metabolites, including cytosine and uracil.
* **Loading Data**: Use `set_loadings_from_csv` to import external loading data for multivariate analysis or batch processing.

## Expert Tips and Best Practices
* **File Integrity**: Always run the `mlpy` file check if available to ensure the input data formats are compatible with the processing pipeline.
* **TMSP Fitting**: If your internal standard peak is distorted, use the `fit_tmsp` functionality to improve referencing accuracy before proceeding to peak picking.
* **Handling Missing Standards**: When processing large cohorts where some samples may lack TMSP, ensure the "automatic referencing update" logic is active to allow the tool to cope with these exceptions without crashing the batch.
* **Baseline Reset**: If automatic baseline correction produces artifacts, use the reset pre-processing function to return to the raw state before attempting manual or adjusted parameters.

## Reference documentation
- [MetabolabPy Overview](./references/anaconda_org_channels_bioconda_packages_metabolabpy_overview.md)
- [GitHub Repository and CLI Basics](./references/github_com_ludwigc_metabolabpy.md)
- [Functional Updates and Feature History](./references/github_com_ludwigc_metabolabpy_commits_master.md)