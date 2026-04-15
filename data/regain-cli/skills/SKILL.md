---
name: regain-cli
description: regain-cli performs Bayesian network analysis to infer probabilistic dependencies and co-occurrence patterns between resistance and virulence genes in bacterial populations. Use when user asks to identify resistance genes, generate presence/absence matrices, infer gene network structures, or calculate conditional probability and relative risk metrics for multidrug resistance.
homepage: https://github.com/ERBringHorvath/regain_CLI
metadata:
  docker_image: "quay.io/biocontainers/regain-cli:1.7.1--pyhdfd78af_0"
---

# regain-cli

## Overview

ReGAIN (Resistance Gene Association and Inference Network) is a specialized command-line toolset for analyzing how resistance and virulence genes move and co-occur within bacterial populations. Unlike simple correlation tools, ReGAIN utilizes Bayesian network structure learning (via the `bnlearn` and `gRain` R packages) to infer probabilistic dependencies. This allows researchers to move beyond presence/absence counts to calculate interpretable metrics like conditional probability, relative risk, and bidirectional probability scores, highlighting gene constellations linked to multidrug resistance.

## Core Workflow and Modules

The ReGAIN pipeline is modular. Use `regain --module-health` to verify that all components (Python, R, and NCBI AMRFinderPlus) are correctly configured before starting an analysis.

### 1. Data Preparation
*   **Gene Identification**: Use the `AMR.run` module to identify resistance and virulence genes in your genomic assemblies.
*   **Matrix Generation**: Use `matrix.run` to convert gene identification results into a presence/absence matrix suitable for Bayesian analysis.
*   **Curation**: Use `curate.run` and `combine.run` to filter datasets or merge multiple runs into a single analysis-ready file.

### 2. Bayesian Network Analysis
*   **Structure Learning (`bnS`)**: Use this module to infer the network architecture. It identifies which genes are conditionally dependent on one another.
*   **Logic and Inference (`bnL`)**: Use this module to perform conditional probability queries (CPQuery) on the learned network to calculate specific risk metrics.

### 3. Visualization and Multivariate Analysis
*   **Network Visualization**: Use the `network` module to generate graphical representations of the gene associations.
*   **Multivariate Analysis (`MVA`)**: Use this for higher-level statistical summaries of the gene relationships across the population.

## Interpreting Probability Metrics

When analyzing output from the `bnL` module, use the following guidelines to interpret the relationships between Variable A (Outcome) and Variable B (Condition):

*   **Conditional Probability P(A|B)**: The likelihood of seeing Gene A when Gene B is present (0 to 1 scale).
*   **Relative Risk (RR)**: 
    *   **RR > 1**: Positive relationship (co-occurrence).
    *   **RR < 1**: Negative relationship (mutual exclusivity).
    *   **RR = 1**: Independence.
*   **Absolute Risk Difference**: The difference in probability of A being present vs. absent based on B. Negative values indicate a strong negative probabilistic relationship.
*   **Bidirectional Probability Score (BDPS)**: Used to determine directional asymmetry. If BDPS > 1, the influence of B on A is stronger than A on B.

## CLI Best Practices

*   **Database Updates**: Always run `amrfinder -u` before a new project to ensure you are using the latest NCBI resistance gene definitions.
*   **Environment Management**: ReGAIN relies on a specific stack of Python and R. It is recommended to run it within a dedicated Conda environment (e.g., `regain-conda`).
*   **Permission Issues**: If you encounter "permission denied" when running `regain`, ensure the shell scripts in the source directory have execution bits set (`chmod +x`).
*   **Baseline Risk**: Always check the "Baseline Risk" value in `bnS` outputs; this represents the raw percentage occurrence of a gene in your dataset and provides context for the conditional metrics.

## Reference documentation
- [ReGAIN GitHub Repository](./references/github_com_ERBringHorvath_regain_CLI.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_regain-cli_overview.md)