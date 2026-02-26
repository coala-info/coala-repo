---
name: bioconductor-flowqbdata
description: This package provides flow cytometry data files and metadata for testing and examples within the flowQB framework. Use when user asks to load sample datasets for flow cytometry quality benchmarks, access FCS files for instrument characterization, or run examples from the flowQB package.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/flowQBData.html
---


# bioconductor-flowqbdata

name: bioconductor-flowqbdata
description: Access and use the flowQBData package, which provides essential flow cytometry data files for testing and examples within the flowQB framework. Use this skill when you need to load sample datasets for flow cytometry quality benchmarks, instrument characterization, or to run examples from the flowQB package.

# bioconductor-flowqbdata

## Overview
The `flowQBData` package is a dedicated Bioconductor ExperimentData package. It serves as a data repository for the `flowQB` package, containing specific flow cytometry data files (FCS files) and associated metadata required for automated instrument characterization and benchmarking. It is primarily used to demonstrate workflows for calculating detector efficiency, background noise, and other quality control metrics in flow cytometry.

## Loading the Data
Since `flowQBData` is a data package, it does not contain complex functions but rather provides the file paths to raw data.

```r
# Load the library
library(flowQBData)

# List files contained in the package
dir(system.file("extdata", package="flowQBData"))
```

## Typical Workflow
The data in this package is intended to be passed into `flowQB` functions. A common workflow involves identifying the path to the sample FCS files and then using them for analysis.

1. **Locate Sample Files**: Use `system.file` to find the directory where the experiment data is stored.
2. **Identify Specific Datasets**: The package typically includes bead data or multi-intensity particles used for Q and B (Quantum efficiency and Background) calculations.
3. **Integration with flowQB**: Pass these paths to `flowQB` functions like `read.FCS` or specific benchmarking wrappers.

```r
# Example: Accessing a specific folder of data
data_path <- system.file("extdata", "Beads", package="flowQBData")
# List files in that specific sub-directory
list.files(data_path)
```

## Tips
- **Dependency**: This package is almost always used in conjunction with the `flowQB` software package. Ensure `flowQB` is installed to perform actual analysis on these data files.
- **Data Format**: The files are stored in standard FCS (Flow Cytometry Standard) format.
- **Purpose**: Use these datasets to validate your installation of the flow cytometry analysis pipeline before applying it to your own experimental data.

## Reference documentation
- [flowQBData Reference Manual](./references/reference_manual.md)