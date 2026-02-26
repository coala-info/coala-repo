---
name: prottest
description: ProtTest automates the selection of the best-fit amino acid substitution models for protein phylogenetic analysis. Use when user asks to select an evolutionary model, evaluate protein data against rate matrices, or determine optimal parameters for site-specific rate variation.
homepage: https://github.com/ddarriba/prottest3
---


# prottest

## Overview

ProtTest is a bioinformatic tool designed to automate the selection of amino acid replacement models. By leveraging PhyML for maximum likelihood estimations, it evaluates protein data against a candidate list of 120 models (comprising 15 rate matrices combined with various rate variation parameters). This process is essential for protein phylogenetics, as it provides model-averaged estimates and identifies the optimal parameters for site-specific rate variation and observed amino acid frequencies.

## Command Line Usage

The primary way to interact with the tool in modern versions (3.4.2+) is through the `prottest3` wrapper script, which handles both the graphical and console interfaces.

### Basic Execution
To run a standard model selection on a protein alignment:
```bash
prottest3 -i <input_alignment> [selection_criteria]
```

### Model Selection Criteria
ProtTest 3 allows sorting and selection based on multiple information criteria. You can specify one or more of the following:
- `-AIC`: Akaike Information Criterion
- `-AICC`: Corrected Akaike Information Criterion
- `-BIC`: Bayesian Information Criterion
- `-DT`: Decision Theory Criterion

### Performance and Resource Management
- **Memory**: Large alignments or complex model sets can be memory-intensive. If you encounter "low memory" errors, ensure the environment has at least 2GB of RAM available.
- **Threading**: Use the `-threads` option to enable parallel processing of likelihood calculations, which significantly reduces execution time for large datasets.
- **PhyML Logging**: Use the `-log` parameter to enable or disable real-time logging from the underlying PhyML process. This is useful for debugging stalled analyses.

### Expert Tips
- **Model Matrices**: By default, ProtTest computes all available matrices. If you have prior knowledge of the data (e.g., viral vs. nuclear), you can specify a subset of matrices to speed up the search.
- **PhyML Binaries**: Version 3.4+ allows the use of system-wide installed PhyML binaries. Ensure `phyml` is in your PATH or configured in the properties file to avoid using the bundled legacy versions if you require specific PhyML features.
- **Output Interpretation**: Focus on the "Model Selection" summary table at the end of the output. The model with the lowest score for your chosen criterion (e.g., BIC) is generally considered the best fit.

## Reference documentation
- [ProtTest 3 README](./references/github_com_ddarriba_prottest3.md)
- [Version 3.2 Release Notes](./references/github_com_ddarriba_prottest3_tags.md)
- [Known Issues and Memory Constraints](./references/github_com_ddarriba_prottest3_issues.md)