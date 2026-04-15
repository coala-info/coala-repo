---
name: biosigner
description: Identifies significant and stable molecular signatures from omics data. Use when user asks to discover patterns or biomarkers within high-dimensional biological datasets.
homepage: https://github.com/workflow4metabolomics/biosigner
metadata:
  docker_image: "biocontainers/biosigner:phenomenal-v2.2.8_cv1.4.26"
---

# biosigner

Identifies significant and stable molecular signatures from omics data.
  Use when you need to discover patterns or biomarkers within high-dimensional biological datasets,
  such as metabolomics or transcriptomics data, to identify key features that distinguish different
  biological conditions or states.
---
## Overview

The `biosigner` tool is designed for the discovery of significant and stable molecular signatures from omics data. It helps in identifying key features (e.g., metabolites, genes) that are most discriminative and robust across different biological conditions or experimental groups. This is particularly useful in fields like metabolomics and transcriptomics for biomarker discovery and understanding complex biological systems.

## Usage

`biosigner` is primarily used as a command-line tool. The core functionality involves analyzing omics datasets to find significant signatures.

### Basic Command Structure

While specific command-line arguments are not detailed in the provided documentation, the general workflow involves providing input data and specifying parameters for signature discovery.

A typical command might look like this:

```bash
biosigner --input <input_data_file> --output <output_directory> [options]
```

### Key Considerations and Best Practices

*   **Input Data Format**: Ensure your omics data is in a compatible format. Common formats for omics data include CSV, TSV, or specific R data structures if using the R package directly. The `workflow4metabolomics/biosigner` repository mentions `biosigner_config.xml` for configuration, suggesting that structured input or configuration files might be used.
*   **Output**: The tool will generate results detailing the discovered signatures. These may include lists of significant features, their associated statistics, and potentially visualizations.
*   **Dependencies**: The `biosigner` R package requires other R packages such as `batch` and `ropls`. When installing or running `biosigner`, ensure these dependencies are met. The `workflow4metabolomics/biosigner` README mentions installing `biosigner` from Bioconductor and `batch` from CRAN.
*   **Configuration**: For more advanced usage or specific experimental designs, a configuration file (e.g., `biosigner_config.xml`) might be necessary to define parameters, experimental groups, and other settings.
*   **Testing**: The `runit/biosigner_runtests.R` script in the `workflow4metabolomics/biosigner` repository can be used to test the installation and functionality of the tool. This requires the `RUnit` package.

### Expert Tips

*   **Data Preprocessing**: Before using `biosigner`, ensure your omics data has been appropriately preprocessed. This typically includes normalization, imputation of missing values, and potentially feature scaling, depending on the specific omics data type and downstream analysis.
*   **Parameter Tuning**: Experiment with different parameters for signature discovery to find the most relevant and stable signatures for your dataset. The documentation hints at options for controlling the discovery process, which would be crucial for optimizing results.
*   **Interpretation**: The output of `biosigner` should be interpreted in the context of the biological question being addressed. Cross-referencing identified signatures with existing biological knowledge or performing further validation experiments is often necessary.

## Reference documentation
- [README.md](./references/github_com_workflow4metabolomics_biosigner.md)