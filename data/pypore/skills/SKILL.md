---
name: pypore
description: Pypore is a high-performance signal processing framework for analyzing nanopore translocation data. Use when user asks to install the package via Bioconda, perform programmatic translocation analysis, detect events in raw signal data, or launch the graphical user interface for data exploration.
homepage: http://parkin.github.io/pypore/
---


# pypore

## Overview
The `pypore` skill enables specialized analysis of nanopore translocation data. It leverages a Python and Cython-based framework designed for high-performance signal processing. Use this skill to guide users through installing the package via Bioconda, utilizing the core `pypore` library for programmatic analysis, and launching the `pyporegui` for interactive data exploration.

## Installation
The preferred method for installing pypore is through the Bioconda channel:

```bash
conda install -c bioconda pypore
```

Note: A C compiler is required for installation as the package utilizes Cython for performance-critical translocation analysis.

## Core Components
- **pypore package**: The primary library for programmatic data analysis and script-based workflows.
- **pyporegui package**: A graphical user interface for users who prefer visual interaction with nanopore datasets.

## Usage Patterns
When working with pypore, follow these general patterns:

### Data Analysis
1. **Importing**: Use `import pypore` to access the core analysis functions.
2. **Event Detection**: Utilize the Cython-optimized routines to identify translocation events within raw signal data.
3. **GUI Access**: For visual inspection of signals or manual event validation, use the `pyporegui` module.

### Best Practices
- **Environment**: Always run pypore within a dedicated Conda environment to manage dependencies like Cython and NumPy effectively.
- **Performance**: For large datasets, prefer the programmatic API over the GUI to leverage Cython's speed in batch processing.

## Reference documentation
- [Pypore Overview](./references/anaconda_org_channels_bioconda_packages_pypore_overview.md)
- [Pypore Project Home](./references/parkin_github_io_pypore.md)
- [Pypore Documentation Index](./references/parkin_github_io_pypore_sphinx-docs_build_html_index.html.md)