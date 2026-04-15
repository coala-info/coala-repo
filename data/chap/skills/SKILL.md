---
name: chap
description: CHAP is a tool for the functional annotation of ion channel structures. Use when user asks to analyze ion channel structures for functional annotation.
homepage: https://github.com/channotation/chap
metadata:
  docker_image: "quay.io/biocontainers/chap:0.9.1--h2df963e_2"
---

# chap

chap/SKILL.md
```yaml
name: chap
description: Tool for the functional annotation of ion channel structures. Use when Claude needs to analyze ion channel structures for functional annotation, particularly when working with molecular dynamics simulation data.
```
## Overview
CHAP (Channel Annotation Package) is a C++ tool designed for the functional annotation of ion channel structures. It leverages molecular dynamics simulation data to provide insights into the structure and function of ion channels. This skill is useful when you need to perform detailed analysis on ion channel pores and their properties.

## Usage Instructions

CHAP is a command-line tool. The primary command is `chap`.

### Installation

CHAP can be installed via conda:
```bash
conda install bioconda::chap
```
Alternatively, it can be compiled from source. Refer to the GitHub repository for detailed compilation instructions, which involve prerequisites like CMake, a C++ compiler, Boost, CBLAS/LAPACKE, and libgromacs.

### Basic Usage

The general syntax for using CHAP is:
```bash
chap [options] <input_file>
```

### Key Functionality and Options

While the provided documentation does not detail specific command-line arguments or options for the `chap` executable, it indicates that running `chap -h` should provide an online help for its usage.

Based on the tool's purpose, common operations would likely involve:
*   **Inputting simulation data**: Providing molecular dynamics trajectory files (e.g., from GROMACS).
*   **Specifying structural information**: Potentially defining ion channel pore coordinates or parameters.
*   **Performing annotations**: Generating functional annotations based on the input data.

**Expert Tip:** Always consult the tool's help message (`chap -h`) for the most accurate and up-to-date command-line options and their descriptions. If specific command-line arguments are not immediately clear, refer to the project's website (www.channotation.org) or the GitHub issue tracker for examples and further documentation.

## Reference documentation
- [CHAP - The Channel Annotation Package](./references/github_com_channotation_chap.md)