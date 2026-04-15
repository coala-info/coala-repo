---
name: rpy2
description: rpy2 provides a bridge between Python and R to execute R code and use R packages within a Python environment. Use when user asks to run R code in Python, install rpy2, troubleshoot R shared library linking issues, or integrate R with Jupyter notebooks.
homepage: https://github.com/rpy2/rpy2
metadata:
  docker_image: "quay.io/biocontainers/rpy2:2.9.4--2"
---

# rpy2

## Overview
The rpy2 library serves as a bridge between Python and R, allowing for the execution of R code and the use of R packages directly within a Python environment. This skill provides the necessary patterns for robust installation, environment diagnostics, and resolving common linking issues that occur when Python cannot locate the R installation or its associated C libraries.

## Installation and Dependencies
To ensure full functionality, including support for NumPy, Pandas, and Jupyter/IPython integration, use the "all" dependency group.

- **Standard installation**: `pip install rpy2`
- **Full installation (recommended for data science)**: `pip install 'rpy2[all]'`
- **Developer/Source installation**: If installing from a source tree, install the constituent namespace packages:
  `pip install ./rpy2-rinterface/ ./rpy2-robjects/ .`

## Environment Configuration
A common failure point for rpy2 is the inability to locate the R shared library (especially when R is not in a standard system location).

### Resolving Shared Library Issues
If R is in your `PATH` but rpy2 fails to load, use the built-in diagnostic tool to update your library path before starting Python:

```bash
export LD_LIBRARY_PATH="$(python -m rpy2.situation LD_LIBRARY_PATH)":${LD_LIBRARY_PATH}
```

### Diagnostic Tooling
Use the `rpy2.situation` module to inspect the current environment and identify where rpy2 is looking for R:

```bash
python -m rpy2.situation
```

## Jupyter and IPython Integration
To use R code blocks within a Jupyter notebook or IPython session, load the rpy2 extension:

```python
%load_ext rpy2.ipython
```

## Testing the Installation
To verify that the R interface and object mapping are working correctly, run the test suite using `pytest`:

```bash
pytest rpy2-rinterface/ rpy2-robjects/
```

## Reference documentation
- [rpy2 GitHub Repository](./references/github_com_rpy2_rpy2.md)
- [rpy2 Issues and Troubleshooting](./references/github_com_rpy2_rpy2_issues.md)