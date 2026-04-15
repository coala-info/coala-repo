---
name: bioconductor-alabaster
description: The alabaster package serves as an umbrella for the alabaster framework to ensure all associated sub-packages are installed for dynamic serialization and unserialization of Bioconductor objects. Use when user asks to install the complete alabaster ecosystem, manage dependencies for Bioconductor data storage, or resolve missing method errors during object saving and loading.
homepage: https://bioconductor.org/packages/release/bioc/html/alabaster.html
---

# bioconductor-alabaster

## Overview

The `alabaster` package serves as an umbrella for the broader **alabaster** framework. Its primary purpose is to act as a single installation target that ensures all associated `alabaster.*` packages (such as `alabaster.base`, `alabaster.matrix`, `alabaster.se`, etc.) are present on the system. This is critical because the framework uses dynamic package identification to determine how to serialize or unserialize specific Bioconductor resources; if a specific sub-package is missing, the look-up and subsequent data processing will fail.

## Usage and Workflows

### Installation and Setup

The most common use case for this package is ensuring environment readiness. Instead of installing individual components, use the umbrella package:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("alabaster")
```

### Core Framework Logic

While `alabaster` itself is a meta-package, it enables the functionality found in `alabaster.base`. The framework follows a "save and load" paradigm for Bioconductor objects:

1.  **Serialization**: Objects (like `SummarizedExperiment` or `SingleCellExperiment`) are saved to a directory structure (an "artifact") that includes metadata and raw data files.
2.  **Dynamic Dispatch**: When saving or loading, the framework checks the object type and dynamically calls the appropriate `alabaster.<type>` package.
3.  **Portability**: The resulting directory is designed to be language-agnostic and easily synchronized with remote databases (like ArtifactDB).

### Typical Workflow

1.  **Load the umbrella**: Loading `library(alabaster)` ensures the environment is configured, though you will typically call functions from `alabaster.base`.
2.  **Save an object**:
    ```r
    # Example using alabaster.base logic enabled by the umbrella
    library(alabaster.base)
    saveObject(my_bioc_object, path = "path/to/destination")
    ```
3.  **Read an object**:
    ```r
    # The framework automatically detects the type and uses the correct sub-package
    new_obj <- readObject("path/to/destination")
    ```

## Tips for AI Agents

- **Installation Failures**: If a user reports that `readObject` or `saveObject` cannot find a method for a specific class, recommend installing or re-loading the `alabaster` umbrella package to ensure all dispatchers are registered.
- **Developer Usage**: For developers building lightweight applications, you may suggest installing only specific sub-packages (e.g., `alabaster.schemas` or `alabaster.base`) to reduce the dependency footprint, provided the resource types are known and limited.
- **Namespace**: Note that `alabaster` does not export many functions itself; it primarily manages the dependency graph for the `alabaster.*` ecosystem.

## Reference documentation

- [Umbrella for the alabaster framework](./references/userguide.md)