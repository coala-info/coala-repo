---
name: saqc
description: SaQC is a specialized framework designed to automate the quality control, annotation, and processing of time series data. Use when user asks to flag outliers, handle missing values, align data streams, or implement reproducible quality control workflows for sensor-based information.
homepage: https://github.com/Helmholtz-UFZ/saqc
---


# saqc

## Overview

SaQC (System for automated Quality Control) is a specialized framework designed to ensure the integrity of time series data. It provides a robust set of algorithms to analyze, annotate, and process data streams, making it a primary choice for data scientists and engineers working with environmental or sensor-based information. The tool allows for reproducible quality control workflows through two main interfaces: a Python API for programmatic integration and a Command Line Interface (CLI) that utilizes a simple, text-based configuration system.

## CLI Usage Patterns

The SaQC CLI is driven by a semicolon-separated configuration file. This is the preferred method for repeatable, production-level quality control pipelines.

### Basic Command Structure
```bash
saqc --config path/to/config.csv --data path/to/data.csv --outfile path/to/output.csv
```

### Configuration File Format
The configuration file (typically a `.csv` or `.txt`) follows a `varname ; test` structure. You can use specific variable names or regular expressions.

| varname | test |
| :--- | :--- |
| `temp` | `flagRange(min=0, max=40)` |
| `SM(1\|2)+` | `flagNaN()` |
| `SM2` | `flagZScore(window="30d", thresh=3.5, method='modified')` |
| `Dummy` | `flagGeneric(field=["SM1", "SM2"], func=(isflagged(x) | isflagged(y)))` |

**Expert Tip**: Use the `flagGeneric` function to implement custom logic that combines multiple variables or complex boolean conditions.

## Python API Integration

For interactive data exploration (e.g., in Jupyter Notebooks) or integration into larger Python applications, use the `SaQC` object.

### Core Workflow
1. **Initialize**: Load your data into a pandas DataFrame and pass it to the `SaQC` constructor.
2. **Chain**: Apply quality control functions using method chaining.
3. **Execute**: The operations are recorded and can be inspected or exported.

```python
import pandas as pd
from saqc import SaQC

# Load data
data = pd.read_csv("data.csv", index_col=0, parse_dates=True)

# Initialize and chain QC tests
qc = SaQC(data=data)
qc = (
    qc.align("SM2", freq="15Min")
    .flagNaN("SM(1|2)+", regex=True)
    .flagRange("SM1", min=10, max=60)
    .flagZScore("SM2", window="30d", thresh=3.5)
)

# Access the flagged data or the flags themselves
final_data = qc.data
flags = qc.flags
```

## Best Practices and Tips

- **Variable Selection**: Use `regex=True` in Python methods or standard regex in the CLI config to apply the same test to multiple sensors (e.g., `temp_.*` to flag all temperature sensors).
- **Function Naming**: Note that in recent versions, `flagMissing` has been renamed to `flagNaN` to better reflect its operation on "Not a Number" values in datasets.
- **Data Alignment**: Use the `.align()` method early in your chain if your sensors have different sampling frequencies or offsets to ensure subsequent multi-variable tests (like `flagGeneric`) work on synchronized timestamps.
- **Window Strings**: When using window-based tests (like Z-Score or Rolling means), use pandas-style offset strings (e.g., `"12h"`, `"7d"`, `"30min"`) for the `window` parameter.

## Reference documentation
- [SaQC GitHub Repository](./references/github_com_Helmholtz-UFZ_saqc.md)
- [SaQC Commits and Version History](./references/github_com_Helmholtz-UFZ_saqc_commits_develop.md)