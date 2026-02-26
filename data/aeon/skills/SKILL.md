---
name: aeon
description: AEON is a framework for the symbolic analysis and parameter synthesis of Boolean networks using Binary Decision Diagrams. Use when user asks to analyze large state spaces, detect attractors or fixed points, perform reachability analysis, or synthesize parameters for partially specified biological models.
homepage: https://github.com/sybila/biodivine-aeon-py
---


# aeon

## Overview

AEON (specifically the `biodivine-aeon-py` library) is a powerful framework for the symbolic analysis of Boolean networks. Unlike tools that rely on explicit state-space exploration, AEON utilizes Binary Decision Diagrams (BDDs) to manage massive state spaces, making it capable of analyzing complex biological systems. A standout feature is its support for "partially specified" networks, where update functions can contain unknown parameters. This allows for parameter synthesis—finding the exact logic that satisfies a specific biological property.

## Installation and Setup

The library is available via PyPI and Conda. It requires Python 3.9 or higher.

- **Pip**: `pip install biodivine_aeon`
- **Conda**: `conda install bioconda::aeon`

## Core Functionality

### Supported File Formats
AEON provides bidirectional conversion and validation for several standard formats:
- `.aeon`: Native format supporting parameters and regulatory constraints.
- `.sbml`: Systems Biology Markup Language.
- `.bnet`: Standard Boolean network format.
- `.booleannet`: BooleanNet format.
- `.bma`: JSON/XML formats used by BioModelAnalyzer.

### Network Manipulation
Before analysis, use these methods to simplify the model:
- **Variable Inlining**: Reduces the number of variables by substituting functions.
- **Pruning**: Removes unused parameters or redundant regulations.
- **Reduction**: Eliminates constants and input variables to focus on core dynamics.

### Symbolic Analysis Algorithms
AEON provides optimized symbolic implementations for:
- **Attractor Enumeration**: Detecting long-term behaviors in asynchronous networks.
- **Fixed-Point Detection**: Finding steady states using both naive and optimized symbolic methods.
- **Trap Spaces**: Identifying minimal, maximal, and essential trap spaces.
- **Reachability**: Computing forward and backward reachable sets from specific states or subspaces.
- **Classification**: Categorizing networks based on attractor bifurcation or phenotype oscillation types.

## Working with the BBM API

The Biodivine Boolean Models (BBM) API allows direct access to a curated database of models.

- **Retrieval**: Fetch models using numeric IDs or unique identifiers.
- **Metadata**: Access variable names, regulations, keywords, and associated publications.
- **Conversion**: Directly convert database entries into `BooleanNetwork` objects.
- **Filtering**: Search for models based on size, number of inputs, or specific network properties.

## Expert Tips and Best Practices

- **Symbolic Sets**: Always prefer using `ColorSet` and `VertexSet` for operations. These represent sets of states and parameters symbolically; performing operations on them (intersection, union, difference) is significantly faster than iterating over individual elements.
- **Parameter Synthesis**: When update functions are unknown, use (H)CTL formulas to synthesize parameters. AEON can determine the set of "colors" (parameter configurations) for which a property holds.
- **Memory Management**: BDD operations can be memory-intensive. When working with very large networks (>100 variables), perform network reduction and variable inlining early in the workflow to keep the BDD size manageable.
- **Regulatory Graphs**: Use the graph analysis module to compute Feedback Vertex Sets (FVS) or detect cycles before running full symbolic analysis, as these structural properties often dictate the complexity of the dynamic analysis.

## Reference documentation

- [Biodivine AEON.py GitHub Repository](./references/github_com_sybila_biodivine-aeon-py.md)
- [AEON Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_aeon_overview.md)