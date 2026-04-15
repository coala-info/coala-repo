---
name: bioconductor-systempipeshiny
description: This tool provides a graphical user interface for managing systemPipeR workflows and performing interactive data visualization. Use when user asks to initialize SPS projects, launch the Shiny interface, perform RNA-Seq analysis, or create interactive plots using the Canvas workbench.
homepage: https://bioconductor.org/packages/release/bioc/html/systemPipeShiny.html
---

# bioconductor-systempipeshiny

name: bioconductor-systempipeshiny
description: A framework for interactive workflow management and data visualization using systemPipeShiny (SPS). Use this skill to initialize SPS projects, launch the Shiny interface, manage systemPipeR workflows, perform RNA-Seq analysis (normalization and DEG), and create interactive plots using the Canvas workbench.

# bioconductor-systempipeshiny

## Overview
`systemPipeShiny` (SPS) provides a Graphical User Interface (GUI) for the `systemPipeR` (SPR) workflow environment. It allows users to interactively design experimental metadata, visualize workflow topologies, and perform downstream analysis (like RNA-Seq) without extensive R coding. It features a modular design, a "Canvas" for plot management, and integration with other Bioconductor packages.

## Core Workflow

### 1. Project Initialization
Before launching the app, you must create a project directory structure.

```r
library(systemPipeShiny)

# Initialize in a specific directory
sps_dir <- file.path(tempdir(), "SPSProject")
spsInit(app_path = sps_dir, project_name = "SPSProject", change_wd = TRUE)
```

### 2. Launching the Application
SPS is a Shiny app. Once the project is initialized and the working directory is set to the project folder:

```r
# Launch the app
shiny::runApp()
```

### 3. RNA-Seq Analysis Workflow
SPS provides a dedicated module for RNA-Seq that handles data from raw counts to visualization.

*   **Data Input:** Requires a raw count table (first column gene IDs, others numeric counts) and a targets metadata file.
*   **Normalization:** Supports "raw", "rlog", or "VST" transformations via `DESeq2`.
*   **DEG Analysis:** Performs Differential Gene Expression based on comparison groups defined in the targets file header.
*   **Visualization:** Generates Volcano plots, MA plots, Heatmaps, and Upset plots.

### 4. Accessing Results Programmatically
If the Shiny session is stopped, results are often stored in the global environment for further R analysis:
*   `spsRNA_trans`: Contains the transformed count data (DESeq2 object).
*   `spsDEG`: A `SummarizedExperiment` object containing DEG results and comparison tables.

### 5. Quick Visualization
The `Quick {ggplot}` module integrates `esquisse` for drag-and-drop plot creation. Data can be uploaded as tabular files and converted into ggplot2 objects interactively.

## Key Functions
*   `spsInit()`: Creates the necessary folder structure and database for an SPS project.
*   `shiny::runApp()`: Starts the interactive GUI.
*   `spsComps`: A supporting package (automatically loaded) providing additional UI components like loaders and buttons.

## Tips for Success
*   **Project Structure:** Do not manually delete the `config/sps.db` or `config/sps_options.yaml` files, as these track app state and user permissions.
*   **Targets Files:** Ensure the targets file follows the `systemPipeR` format, specifically using `#` in the header to define comparison groups for DEG analysis.
*   **Canvas:** Use the "To Canvas" button within the GUI to send plots to the workbench for side-by-side comparison and basic editing.

## Reference documentation
- [systemPipeShiny](./references/systemPipeShiny.md)