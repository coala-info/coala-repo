---
name: sigprofilerplotting
description: The `sigprofilerplotting` skill provides a standardized framework for visualizing the diverse landscape of somatic mutations.
homepage: https://github.com/alexandrovlab/SigProfilerPlotting
---

# sigprofilerplotting

## Overview
The `sigprofilerplotting` skill provides a standardized framework for visualizing the diverse landscape of somatic mutations. It transforms raw mutational matrices into intuitive, color-coded bar charts and "sample portraits" that represent the specific contexts of DNA damage and repair processes. This tool is essential for interpreting the output of mutational signature extraction workflows and comparing mutational profiles across different cancer samples or projects.

## Quick Start & CLI Patterns
The tool can be used directly from the command line or within a Python environment.

### Command Line Interface (CLI)
The CLI follows a consistent pattern for the primary small-scale mutation types:
`SigProfilerPlotting <function> <matrix_path> <output_path> <project> <plot_type>`

**Common Commands:**
- **SBS Plots:** `SigProfilerPlotting plotSBS ./input/matrix.txt ./output/ ProjectName 96`
- **DBS Plots:** `SigProfilerPlotting plotDBS ./input/matrix.txt ./output/ ProjectName 78`
- **Indel Plots:** `SigProfilerPlotting plotID ./input/matrix.txt ./output/ ProjectName 83`

### Python API Usage
For more granular control, use the Python interface:
```python
import sigProfilerPlotting as sigPlt

# Plotting SBS with percentages instead of raw counts
sigPlt.plotSBS(matrix_path, output_path, project, plot_type="96", percentage=True)

# Plotting Copy Number Variations (CNV)
sigPlt.plotCNV(matrix_path, output_path, project, percentage=True, aggregate=False)

# Plotting Structural Variants (SV)
sigPlt.plotSV(matrix_path, output_path, project, percentage=False, aggregate=True)
```

## Parameter Guidance
- **matrix_path**: Path to the tab-delimited mutational matrix file.
- **output_path**: Directory where the resulting PDF/PNG files will be saved.
- **project**: A string identifier used for naming the output files.
- **plot_type**: The context of the matrix. Common values include:
    - **SBS**: 6, 24, 96, 192, 384, 1536
    - **DBS**: 78, 312
    - **ID**: 28, 83, 96
- **percentage**: Set to `True` to normalize the y-axis to 100% (useful for comparing signatures); set to `False` for raw mutation counts (useful for sample profiles).
- **aggregate**: (CNV/SV only) Set to `True` to generate a single PDF containing counts per sample for the entire project.

## Sample Portraits
To generate a comprehensive "Sample Portrait" (a multi-panel visualization showing all mutation types for a single sample), ensure you have matrices for all standard contexts (SBS-96, DBS-78, ID-83, etc.) in the same directory.

```python
from sigProfilerPlotting import sample_portrait as sP
sP.samplePortrait(sample_matrices_path, output_path, project, percentage=False)
```

## Best Practices
- **Input Consistency**: Ensure the `plot_type` parameter matches the dimensions of your input matrix (e.g., don't pass an SBS-1536 matrix to a function expecting SBS-96).
- **Output Management**: The tool creates subdirectories within your `output_path`. Use unique `project` names to avoid overwriting previous results.
- **Environment**: Ensure `SigProfilerMatrixGenerator` is installed if you are generating matrices from VCF files before plotting.

## Reference documentation
- [SigProfilerPlotting GitHub Repository](./references/github_com_SigProfilerSuite_SigProfilerPlotting.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_sigprofilerplotting_overview.md)