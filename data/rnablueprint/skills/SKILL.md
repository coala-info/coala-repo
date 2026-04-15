---
name: rnablueprint
description: RNAblueprint generates RNA sequences that match specific structural targets through uniform sampling of the valid sequence space. Use when user asks to design RNA sequences for multiple structural targets, generate unbiased samples of compatible sequences, or apply IUPAC sequence constraints to RNA design.
homepage: https://github.com/ViennaRNA/RNAblueprint
metadata:
  docker_image: "quay.io/biocontainers/rnablueprint:1.3.3--py311pl5321h6accb3f_0"
---

# rnablueprint

## Overview
The `rnablueprint` library and command-line tool provide a solution for the "inverse folding" problem—generating sequences that match desired structural targets. Unlike many other design tools, `rnablueprint` guarantees uniform sampling of the valid sequence space, ensuring that the generated sequences are statistically representative of all possible solutions. It supports multiple simultaneous structural constraints (multi-target design) and sequence-level constraints using IUPAC notation.

## Installation
The most efficient way to install the tool is via Bioconda:
```bash
conda install bioconda::rnablueprint
```

## Command Line Usage
The primary interface is the `RNAblueprint` executable. Because the tool is highly flexible, always consult the built-in help for the specific version installed:
```bash
RNAblueprint --help
```

### Core Workflow
1.  **Define Structural Constraints**: Prepare your target secondary structures in dot-bracket notation. The tool ensures that all base pairs specified in the input are strictly satisfied.
2.  **Define Sequence Constraints**: Use IUPAC ambiguity codes (e.g., `N` for any base, `R` for purine, `Y` for pyrimidine) to restrict specific positions in the sequence.
3.  **Sampling**: Run the tool to generate a set of sequences. Since sampling is uniform, you can generate multiple sequences to get a non-biased view of the compatible sequence space.

### Key Capabilities
-   **Multi-Target Design**: You can provide multiple structural constraints. The tool will find sequences compatible with the intersection of all provided structures.
-   **Uniformity**: Use this tool when you need to perform statistical analysis on the sequence space, as it avoids the "GC-content bias" or "energy-minimization bias" found in heuristic-based designers.
-   **Scripting Interfaces**: For complex workflows, `rnablueprint` provides Python and Perl interfaces (via SWIG), allowing you to integrate uniform sampling directly into custom bioinformatics pipelines.

## Expert Tips
-   **Library Integration**: If the CLI does not support a specific complex logic, use the Python interface to access the underlying C++ library functions.
-   **Constraint Compatibility**: Ensure that your structural constraints and IUPAC sequence constraints are not mutually exclusive (e.g., requiring a G-C pair at a position where the sequence constraint forbids G or C).
-   **Big Numbers**: If working with extremely large sequence spaces, ensure the library was compiled with `libGMP` support (`--enable-libGMP`) to handle multiprecision integers for counting the solution space.

## Reference documentation
- [RNAblueprint Overview](./references/anaconda_org_channels_bioconda_packages_rnablueprint_overview.md)
- [RNAblueprint GitHub README](./references/github_com_ViennaRNA_RNAblueprint.md)