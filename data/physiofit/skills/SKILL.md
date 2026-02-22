---
name: physiofit
description: PhysioFit is a scientific computing tool designed for fluxomics and systems biology.
homepage: https://github.com/MetaSys-LISBP/PhysioFit
---

# physiofit

## Overview
PhysioFit is a scientific computing tool designed for fluxomics and systems biology. It transforms raw time-course measurements of cell concentrations and extracellular substrates into kinetic parameters and flux estimates. This skill should be used to guide the process of metabolic flux analysis, from data preparation in TSV/TXT formats to the statistical validation of estimated growth rates and exchange fluxes.

## Installation and Setup
PhysioFit requires Python 3.9 or higher. It can be installed via pip or conda:

```bash
# Using pip
pip install physiofit

# Using conda
conda install bioconda::physiofit
```

## Core Workflow
PhysioFit can be operated via a Graphical User Interface (GUI) for visual inspection or via the Command Line Interface (CLI) for automated processing.

### 1. Data Preparation
*   **Format**: Input files must be in `.tsv` (tab-separated) or `.txt` format.
*   **Content**: The data must contain time-course measurements. Typically, this includes a time column, a biomass/cell concentration column, and columns for various metabolites (substrates and products).
*   **Quality Check**: Ensure that the data path points directly to the measurement file and that the file is properly formatted before running the estimation.

### 2. Running the Tool
*   **GUI Mode**: To launch the biologist-friendly interface for visual fitting and manual model adjustment:
    ```bash
    physiofit
    ```
*   **CLI/Library Mode**: Use the command line for batch processing or integrate it into Python scripts for high-throughput metabolic modeling.

### 3. Model Selection and Fitting
*   **Standard Models**: PhysioFit includes built-in steady-state and dynamic growth models.
*   **Custom Models**: Users can implement tailor-made models for specific experimental setups or non-standard growth kinetics.
*   **Optimization**: The tool fits the mathematical models to the data to minimize the difference between observed and predicted concentrations.

### 4. Statistical Validation
*   **Sensitivity Analysis**: Always perform the Monte-Carlo sensitivity analysis to estimate the precision and confidence intervals of the calculated fluxes.
*   **Model Comparison**: Use the calculated Akaike Information Criterion (AIC) to objectively identify which growth model best represents the experimental data without over-fitting.
*   **Visual Inspection**: Review the fitted curves against the raw data points to identify outliers or systematic deviations.

## Expert Tips
*   **Model Parsimony**: If multiple models provide similar fits, prefer the one with the lower AIC value.
*   **Data Localization**: When initializing the `io_handler` in custom scripts, ensure the data paths are absolute or correctly relative to the execution directory to avoid initialization bugs.
*   **Flux Direction**: Remember that PhysioFit distinguishes between uptake (negative flux) and production (positive flux) based on the concentration trends over time.

## Reference documentation
- [PhysioFit GitHub Repository](./references/github_com_MetaSys-LISBP_PhysioFit.md)
- [Bioconda PhysioFit Package](./references/anaconda_org_channels_bioconda_packages_physiofit_overview.md)