---
name: bioconductor-macsquantifyr
description: MACSQuantifyR automates the processing, statistical analysis, and visualization of flow cytometry data exported from Miltenyi MACSQuantify software. Use when user asks to import MACSQuantify Excel files, perform interactive replicate selection on plate templates, calculate drug synergy using the Chou-Talalay method, or generate automated Word reports.
homepage: https://bioconductor.org/packages/release/bioc/html/MACSQuantifyR.html
---

# bioconductor-macsquantifyr

name: bioconductor-macsquantifyr
description: Automated processing and analysis of flow cytometry data from Miltenyi MACSQuantify software. Use this skill to import Excel exports, interactively sort replicates based on plate templates, perform statistical analysis (mean/SD), compute drug combination indices (Chou-Talalay method), and generate comprehensive Word reports.

## Overview
MACSQuantifyR streamlines the post-acquisition analysis of flow cytometry data. It specifically addresses the challenge of complex plate templates (e.g., drug screenings) where replicates are not necessarily contiguous. The package provides both a fully automated pipeline and a flexible step-by-step workflow for custom 2D/3D data visualization and synergy analysis.

## Core Workflows

### 1. Automated Pipeline
Use the `pipeline()` function for a quick, end-to-end analysis including data loading, interactive replicate selection, and report generation.

```r
library(MACSQuantifyR)

# Path to the Excel file exported from MACSQuantify
file_path <- "path/to/your/data.xlsx"

# Runs interactive selection and generates 'outputMQ' folder with results
MACSQuant <- pipeline(
  filepath = file_path,
  number_of_replicates = 3,
  number_of_conditions = 8,
  control = TRUE
)
```

### 2. Step-by-Step Analysis
For greater control over plot aesthetics, condition naming, and drug combination modeling.

**Initialization and Loading:**
```r
# 1. Create object
MQ_obj <- new_class_MQ(path = "output_directory")
slot(MQ_obj, "experiment_name") <- "My_Experiment_001"

# 2. Load data (requires specific columns: Full path, WID, %-#, Count/mL)
MQ_obj <- load_MACSQuant(file_path, sheet_name = "Sheet1", MACSQuant.obj = MQ_obj)
```

**Replicate Selection:**
Define condition names and doses before running the interactive selector.
```r
slot(MQ_obj, "param.experiment")$c_names <- c("DrugA_Low", "DrugA_High", "DrugB", "Combo")
slot(MQ_obj, "param.experiment")$doses <- c(1, 10, 5, 15)

# This opens a plot window for manual well selection
MQ_obj <- on_plate_selection(
  MQ_obj,
  number_of_replicates = 3,
  number_of_conditions = 4,
  control = TRUE,
  save.files = TRUE
)
```

**Visualization and Synergy:**
```r
# Generate barplots (flavour: "counts" or "percent")
p <- barplot_data(MQ_obj, plt.flavour = "percent", plt.combo = TRUE)

# Compute Combination Index (CI) for drug synergy
MQ_obj <- combination_index(MQ_obj)

# Finalize report
generate_report(MQ_obj)
```

## Key Functions
- `new_class_MQ()`: Initializes the S4 object to store data and parameters.
- `load_MACSQuant()`: Imports Excel data. Ensure the file contains "Full path", "WID", "%-#", and "Count/mL".
- `on_plate_selection()`: Triggers the interactive UI. You must click the wells in the order of your conditions.
- `combination_index()`: Calculates synergy/antagonism based on the Chou-Talalay method.
- `generate_report()`: Compiles all saved plots and statistics into a `results.docx` file.

## Tips for Success
- **Interactive Selection**: When `on_plate_selection` or `pipeline` is called, R will wait for you to click on the plot device. Follow the console prompts to select replicates for each condition sequentially.
- **Output Folder**: The package creates an `outputMQ` folder. Be careful as subsequent runs might overwrite existing files in that directory.
- **Data Format**: The input Excel must be the standard export from Miltenyi MACSQuantify. If columns are missing or renamed, `load_MACSQuant` will fail.

## Reference documentation
- [MACSQuantifyR - Introduction](./references/MACSQuantifyR.md)
- [MACSQuantifyR - Step-by-step analysis](./references/MACSQuantifyR_combo.md)
- [MACSQuantifyR - Automatic pipeline](./references/MACSQuantifyR_pipeline.md)