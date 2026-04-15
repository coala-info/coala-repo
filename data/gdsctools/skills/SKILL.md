---
name: gdsctools
description: gdsctools automates the identification of genomic markers of drug sensitivity by correlating drug response data with genomic features. Use when user asks to perform ANOVA analysis on GDSC data, identify genomic markers of drug response, or run regression models on IC50 matrices.
homepage: http://pypi.python.org/pypi/gdsctools
metadata:
  docker_image: "quay.io/biocontainers/gdsctools:1.0.1--py_0"
---

# gdsctools

## Overview
gdsctools is a specialized suite for bio-informatics analysis of GDSC data (cancerrxgene.org). It enables researchers to automate the identification of genomic markers of drug sensitivity by correlating drug response matrices with genomic feature matrices. The tool provides both a standalone command-line application for rapid analysis and a Python API for custom scripting and integration into larger data science workflows.

## Command-Line Usage
The primary entry point for standalone analysis is the `gdsctools_anova` application.

### Basic ANOVA Analysis
To run a standard ANOVA analysis, you must provide two tab-separated or comma-separated files:
1. **IC50 Matrix**: Rows are COSMIC identifiers, columns are drug names.
2. **Genomic Feature Matrix**: Rows are COSMIC identifiers, columns are features (e.g., mutations, CNVs).

```bash
gdsctools_anova --input-ic50 ic50.txt --input-features features.txt
```

### Advanced Tools
Beyond basic ANOVA, gdsctools includes specialized tools for different statistical approaches:
- **Regression**: Support for Ridge and Lasso regression models.
- **OmniBEM**: A tool for specific BEM (Binary Entity Matrix) analysis.

## Python API Integration
For more control or iterative analysis, use the Python interface.

### Running a Full ANOVA
```python
from gdsctools import ANOVA, ic50_test

# Initialize with IC50 data and features file
# ic50_test is a built-in example dataset
an = ANOVA(ic50_test, 'features.txt')

# Execute the full ANOVA pipeline
an.anova_all()
```

## Best Practices and Expert Tips
- **Identifier Consistency**: Ensure that both the IC50 and genomic feature matrices use consistent COSMIC identifiers as row labels. The tool relies on these IDs to join the datasets.
- **Data Format**: While the tool handles various text formats, using standard tab-separated (.txt) or comma-separated (.csv) files is recommended for compatibility.
- **Environment Selection**: While the library supports Python 2.7 and 3.x, use Python 3.x if you intend to run the standalone pipelines on a cluster, as they require Snakemake.
- **Built-in Testing**: Use `from gdsctools import ic50_test` to load sample data and verify your installation or script logic before running on large experimental datasets.

## Reference documentation
- [gdsctools · PyPI](./references/pypi_org_project_gdsctools.md)