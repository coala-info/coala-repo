---
name: biokit
description: Biokit provides a toolkit for computational biology focusing on data visualization, statistical analysis, and R-based bioinformatics integration within Python. Use when user asks to visualize correlation matrices, perform mixture model analysis, manipulate biological identifiers, or execute R packages from Python.
homepage: http://pypi.python.org/pypi/biokit
---


# biokit

## Overview
The `biokit` skill provides a specialized toolkit for computational biology, focusing on data visualization and statistical analysis. It serves as a bridge for developers who need to manipulate biological sequences, perform mixture model analysis, or utilize R-based bioinformatics tools within a Python environment. This skill is ideal for tasks involving complex data plotting (like correlation matrices) and managing biological identifiers.

## Core Modules and Usage

### Visualization (viz)
The `viz` module is the most prominent feature of biokit, used for high-quality biological data plots.
- **Corrplot**: Use for visualizing correlation matrices.
- **Heatmap**: Use for representing data intensity across two dimensions.
- **Mixture Models**: Use `biokit.stats` for statistical modeling of sub-populations within a dataset.

### Biological Identifiers and Sequences
- **Taxonomy**: Access and manipulate Taxon identifiers.
- **Gene Ontology**: Retrieve and work with GO identifiers.
- **Sequence Manipulation**: Perform basic operations on biological sequences.

### R Integration
Biokit provides a wrapper to facilitate the installation and execution of R packages directly from Python. Use this when a specific bioinformatics method is only available in R but the primary workflow is in Python.

## Best Practices
- **Transition Awareness**: Note that many features (specifically mixture models and certain visualization tools) are migrating to the `sequana` project. If advanced features are missing or deprecated, check for `sequana` equivalents.
- **BioServices Integration**: Biokit is designed to work alongside `BioServices`. Use them together when you need to fetch remote biological data for local analysis.
- **Environment**: Ensure Python 3.7+ is used, as older versions are not supported in the latest releases.

## Reference documentation
- [biokit PyPI Project Overview](./references/pypi_org_project_biokit.md)
- [biokit Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_biokit_overview.md)