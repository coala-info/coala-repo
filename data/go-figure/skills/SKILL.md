---
name: go-figure
description: "GO-Figure! transforms lists of Gene Ontology terms into publication-ready summary visualizations. Use when user asks to visualize functional enrichment results, generate GO term plots, or summarize genomic data interpretation."
homepage: https://gitlab.com/evogenlab/GO-Figure
---


# go-figure

## Overview
GO-Figure! is a specialized tool for bioinformaticians to transform lists of Gene Ontology terms into informative, publication-ready summary visualizations. It streamlines the process of interpreting functional enrichment results by providing a simple command-line interface to generate plots that would otherwise require custom plotting scripts. This skill helps in executing the tool correctly, managing its dependencies via Conda, and utilizing its core plotting features for genomic data interpretation.

## Installation and Environment
The most reliable way to use go-figure is through a dedicated Conda environment to ensure all scientific Python dependencies (like `matplotlib`, `seaborn`, and `scikit-learn`) are correctly versioned.

- **Install via Bioconda**: `conda install bioconda::go-figure`
- **Environment Setup**: If encountering library errors (e.g., with `adjusttext` or `PyQt`), create a fresh environment:
  ```bash
  conda create -n go-figure bioconda::go-figure
  conda activate go-figure
  ```

## Common CLI Patterns
The tool is typically invoked using the `gofigure.py` script.

- **Basic Plotting**:
  To generate a visualization from a list of GO terms:
  ```bash
  gofigure.py -i input_terms.tsv -o output_directory/
  ```

- **Limiting Results**:
  Use the `-a` flag to specify the number of terms to include or to set an abundance/significance threshold:
  ```bash
  gofigure.py -i input_terms.tsv -a 10 -o output_directory/
  ```

## Input Data Requirements
- **Format**: Input files should be Tab-Separated Values (.tsv).
- **Content**: The file should contain a list of GO terms. Ensure GO IDs (e.g., GO:0008150) are properly formatted.
- **Exploratory Analysis**: When comparing multiple datasets, run the command for each dataset and direct outputs to distinct subdirectories to facilitate side-by-side comparison of functional profiles.

## Troubleshooting and Best Practices
- **Binary vs. Script**: While binaries exist for Ubuntu and Mac, using the Python script within a Conda environment is the preferred method for stability and compatibility with modern Linux distributions.
- **Output Management**: Always specify an output directory with `-o`. The tool generates multiple files, and keeping them organized in specific folders prevents file overwriting during multi-dataset comparisons.
- **Dependency Conflicts**: If plotting fails with display errors, ensure `matplotlib` is configured for your environment (e.g., using a non-interactive backend if running on a headless server).

## Reference documentation
- [go-figure - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_go-figure_overview.md)
- [GO-Figure activity (GitLab Atom Feed)](./references/gitlab_com_evogenlab_GO-Figure.atom.md)
- [Waterhouse Lab / GO-Figure · GitLab](./references/gitlab_com_evogenlab_GO-Figure.md)