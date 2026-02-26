---
name: w4mclstrpeakpics
description: w4mclstrpeakpics visualizes metabolomics feature clusters to assess data quality and validate peak alignment. Use when user asks to assess the quality of metabolomics feature clusters, identify outliers, validate peak alignment, or visualize feature consistency across samples.
homepage: https://github.com/HegemanLab/w4mclstrpeakpics
---


# w4mclstrpeakpics

## Overview
`w4mclstrpeakpics` is a specialized R package designed for the visual inspection of metabolomics data. It bridges the gap between raw XCMS preprocessing and downstream statistical analysis by providing a way to assess the quality of feature clusters. By visualizing the intensities and likelihoods of features among members of a sample cluster, researchers can identify outliers, validate alignment, and ensure that the features being analyzed are consistent across the experimental group.

## Installation
The package is available via Bioconda. It is recommended to install it within a dedicated Conda environment to manage R dependencies:

```bash
conda install bioconda::w4mclstrpeakpics
```

## Core Workflow and Usage
The tool is primarily used within an R environment. It expects input data to follow the Workflow4Metabolomics (W4M) standard, which typically consists of a data matrix and corresponding sample metadata.

### R Usage Pattern
To use the tool in an R script or session:

1.  **Load the library**:
    ```R
    library(w4mclstrpeakpics)
    ```

2.  **Execute Assessment**:
    The primary functional entry point is the `peak_pool_assessment` function. This function processes the data and generates the visualization.
    ```R
    # Example conceptual usage
    # peak_pool_assessment(data_matrix_path, metadata_path, output_image_path)
    ```

### Input Requirements
*   **Data Matrix**: A tabular file containing feature intensities across samples, preprocessed using XCMS.
*   **Metadata**: A file defining sample classes or groups, allowing the tool to cluster and compare peaks by experimental condition.

## Best Practices and Tips
*   **Pre-Analysis Validation**: Use this tool immediately after peak alignment and grouping in XCMS. It serves as a critical quality control step to ensure that "clustered" peaks actually represent the same chemical entity across different samples.
*   **Galaxy Integration**: While this is an R package, it is "Galaxy-oriented." If working within a Galaxy environment, look for the `w4mclstrpeakpics` tool wrapper to perform these visualizations without writing R code.
*   **Data Formatting**: Ensure your data matrix and metadata files are strictly W4M-compliant (tab-separated values with specific header requirements) to avoid parsing errors in the R functions.

## Reference documentation
- [w4mclstrpeakpics Overview](./references/anaconda_org_channels_bioconda_packages_w4mclstrpeakpics_overview.md)
- [HegemanLab w4mclstrpeakpics GitHub Repository](./references/github_com_HegemanLab_w4mclstrpeakpics.md)