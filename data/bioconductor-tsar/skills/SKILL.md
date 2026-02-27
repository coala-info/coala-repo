---
name: bioconductor-tsar
description: This tool processes qPCR data to perform thermal shift analysis for identifying protein-ligand interactions. Use when user asks to process raw fluorescence readings, normalize data, estimate melting temperatures using GAM or Boltzmann models, and generate comparative visualizations like boxplots or derivative plots.
homepage: https://bioconductor.org/packages/release/bioc/html/TSAR.html
---


# bioconductor-tsar

name: bioconductor-tsar
description: Comprehensive thermal shift analysis (TSA) for qPCR data. Use when Claude needs to process raw fluorescence readings, perform normalization, estimate melting temperatures (Tm) using GAM or Boltzmann models, and generate comparative visualizations (boxplots, curve plots, derivative plots).

# bioconductor-tsar

## Overview
TSAR (Thermal Shift Analysis in R) is a Bioconductor package designed to process qPCR data to identify protein-ligand interactions through thermal stability changes. It manages data across three tiers: raw readings (`raw_data`), normalized/pre-processed data (`norm_data`), and analyzed data ready for visualization (`tsar_data`). It supports both command-line workflows and interactive Shiny applications for data weeding, analysis, and graphing.

## Data Preparation
Ensure input data is a data frame with the following required columns:
- Temperature (double)
- Fluorescence (double)
- Well.Position (character)

## Core Workflows

### 1. Data Pre-processing and Weeding
Clean raw data by removing blank wells or corrupted curves.
- Use `screen(raw_data)` to visualize all curves for potential errors.
- Use `remove_raw(raw_data, removerange = c("A", "B", "1", "8"))` to remove a range of wells.
- Use `remove_raw(raw_data, removelist = c("A01", "C05"))` to remove specific wells.
- Use `weed_raw(raw_data)` to launch an interactive Shiny app for curve selection and removal.

### 2. Normalization and Analysis
Convert fluorescence to a 0-1 scale and estimate Tm values.
- Use `normalize(df)` to scale fluorescence.
- Use `gam_analysis(raw_data, smoothed = TRUE)` for batch processing of 96-well plates. This function wraps normalization, GAM modeling, and Tm estimation.
- For individual wells, use `model_gam()` followed by `Tm_est()`.
- Use `view_model(analyzed_well_df)` to inspect the model fit and derivative calculation.

### 3. Metadata Integration
Map ligand and protein conditions to well positions.
- Use `join_well_info()` to merge analysis results with a condition table (Well, Protein, Ligand).
- Use `read_tsar(x, output_content = 2)` to extract the full dataset including analysis and normalized values.

### 4. Merging and Visualization
Combine biological replicates and generate publication-quality plots.
- Use `merge_norm(data = list(df1, df2), name = c("file1", "file2"), date = c("date1", "date2"))` to aggregate replicates.
- Use `TSA_boxplot(tsar_data, color_by = "Protein", label_by = "Ligand")` for Tm comparisons.
- Use `TSA_compare_plot(tsar_data, control_condition = "Control_ID")` to compare curves against a control.
- Use `view_deriv(tsar_data, frame_by = "condition_ID")` to compare first derivatives.
- Use `graph_tsar(tsar_data)` for an interactive visualization dashboard.

## Helper Functions
- `condition_IDs(tsar_data)`: List all unique condition identifiers.
- `well_IDs(tsar_data)`: List all unique well identifiers.
- `TSA_Tms(tsar_data)`: List Tm estimations by condition.
- `Tm_difference(tsar_data)`: Calculate delta Tm relative to a control.

## Tips and Troubleshooting
- **Smoothing**: TSAR uses `mgcv::gam` for smoothing. If data is already smoothed, set `smoothed = TRUE` in analysis functions to avoid redundant modeling.
- **Tm Estimation**: Tm is estimated using the maximum of the first derivative. Inspect noisy data using `view_model()` if Tm values seem incorrect.
- **Dependencies**: Load `ggplot2` and `plotly` to modify automated graphs; load `shiny` for interactive functions.
- **Data Export**: Use `write_tsar(df, name = "filename", file = "csv")` to save results locally.

## Reference documentation
- [Frequently Asked Questions](./references/FAQ_assistance.md)
- [TSAR Package Structure](./references/TSAR_Package_Structure.md)
- [TSAR Workflow by Command](./references/TSAR_Workflow_by_Command.md)
- [TSAR Workflow by Shiny](./references/TSAR_Workflow_by_Shiny.md)