---
name: riassigner
description: The riassigner tool is a Python-based utility designed to standardize Gas Chromatography-Mass Spectrometry (GC-MS) data by converting experimental retention times into retention indices.
homepage: https://github.com/RECETOX/RIAssigner
---

# riassigner

## Overview
The riassigner tool is a Python-based utility designed to standardize Gas Chromatography-Mass Spectrometry (GC-MS) data by converting experimental retention times into retention indices. This process makes retention data comparable across different instruments and experiments. The tool functions by taking a "query" dataset of unknown compounds and a "reference" dataset of known compounds (typically an inert alkane series where RI = carbon number × 100) to perform mathematical interpolation.

## Installation
The tool can be installed via conda or pip:
- **Conda**: `conda install -c bioconda riassigner`
- **Pip**: `pip install riassigner`

## Core Python Workflow
The primary way to interact with riassigner is through its Python API. The workflow involves loading data, choosing a computation method, and writing the results.

### 1. Loading Data
Use `MatchMSData` for spectral formats and `PandasData` for tabular formats.
```python
from RIAssigner.data import MatchMSData, PandasData

# Load query data (e.g., experimental peaks)
# Supported units: "seconds", "min"
query = PandasData("peaks.csv", "csv", rt_unit="seconds")

# Load reference data (e.g., Alkanes)
reference = MatchMSData("alkanes.msp", "msp", rt_unit="min")
```

### 2. Computing Retention Indices
Choose between `Kovats` (piecewise linear) or `CubicSpline` methods.
```python
from RIAssigner.compute import Kovats, CubicSpline

# Using Kovats method (Van den Dool and Kratz)
method = Kovats()
query.retention_indices = method.compute(query, reference)
```

### 3. Exporting Results
```python
query.write("results_with_ri.csv")
```

## Supported Formats
- **Input (Read)**: `.msp`, `.mgf` (via matchms integration); `.csv`, `.tsv`, `.parquet` (via pandas integration).
- **Output (Write)**: `.csv`, `.tsv`, `.parquet`.

## Best Practices and Expert Tips
- **Unit Consistency**: Always specify the `rt_unit` ("seconds" or "min") during data loading. RIAssigner handles the conversion internally, but incorrect initial labeling will lead to invalid RI values.
- **Reference Preparation**: Ensure your reference file (e.g., alkanes) contains both retention times and their corresponding fixed RI values. For alkanes, the RI is typically the carbon number multiplied by 100.
- **Method Selection**: 
    - Use **Kovats** for standard linear interpolation between reference points.
    - Use **CubicSpline** when you require a smoother interpolation curve, which can be more accurate if the retention time/index relationship is non-linear.
- **Tabular Data**: When using `.csv` or `.tsv` files, ensure the column headers for retention time are clearly defined or follow standard naming conventions that pandas can parse.

## Common CLI Usage
While primarily used as a library, the tool supports command-line operations for quick processing:
- Use the `--query` and `--reference` flags to specify input files.
- Specify the computation method using the `--method` flag (e.g., `kovats`).
- Use the `--output` flag to define the destination file.

## Reference documentation
- [RIAssigner GitHub Repository](./references/github_com_RECETOX_RIAssigner.md)
- [Bioconda RIAssigner Overview](./references/anaconda_org_channels_bioconda_packages_riassigner_overview.md)