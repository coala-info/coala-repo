---
name: deeplc
description: DeepLC predicts liquid chromatography retention times for peptides using a deep learning architecture that supports various chemical modifications. Use when user asks to predict peptide retention times, calibrate predictions to specific experimental gradients, or format peptide modification data for chromatography modeling.
homepage: http://compomics.github.io/projects/DeepLC
---


# deeplc

## Overview
DeepLC is a specialized tool for liquid chromatography retention time (RT) prediction. Unlike traditional predictors, it uses a deep learning architecture that generalizes well to modified peptides, even those not present in the training data. This skill enables you to prepare input data, execute predictions via the CLI or Python API, and perform calibration to align predictions with specific experimental setups.

## Input Data Format
DeepLC requires a CSV file with specific columns. Ensure your data follows this schema:

- **seq**: Unmodified peptide sequence (e.g., `AAINQKLIETGER`).
- **modifications**: MS2PIP-style format: `location|name`.
    - `location`: 1-based index for amino acids; `0` for N-terminal; `-1` for C-terminal.
    - `name`: Unimod (PSI-MS) name (e.g., `6|Acetyl`).
    - Multiple mods: Separate with pipes (e.g., `12|Oxidation|18|Acetyl`).
- **tr**: Observed retention time (Required only for calibration files).

## Command Line Interface (CLI)
The most efficient way to run predictions is via the terminal.

### Basic Prediction
```bash
deeplc --file_pred peptide_list.csv
```

### Prediction with Calibration (Recommended)
To map predictions to your specific gradient, provide a file containing peptides with known retention times:
```bash
deeplc --file_pred to_predict.csv --file_cal calibration_data.csv
```

### Key CLI Arguments
- `--file_pred`: Path to the CSV file for RT prediction.
- `--file_cal`: Path to the CSV file for calibration.
- `--help`: View all available parameters including batch size and model selection.

## Python Module Usage
For integration into data pipelines, use the `DeepLC` class:

```python
import pandas as pd
from deeplc import DeepLC

# Load data
pep_df = pd.read_csv("to_predict.csv").fillna("")
cal_df = pd.read_csv("calibration.csv").fillna("")

# Initialize and run
dlc = DeepLC()
dlc.calibrate_preds(seq_df=cal_df)
preds = dlc.make_preds(seq_df=pep_df)
```

## Expert Tips & Best Practices
- **Mandatory Modifications**: You must include fixed modifications (like `Carbamidomethyl`) in the input file; DeepLC does not assume them.
- **Unimod Names**: Always use official Unimod PSI-MS names. If a modification is missing, it must be added to `unimod_to_formula.csv` in the DeepLC installation directory.
- **Memory Management**: If you encounter Out-of-Memory (OOM) errors, reduce the `batch_size` parameter.
- **Normalization**: If predictions return values between [0, 10] instead of your expected time units, it means no calibration was performed. Always use a calibration set for real-world time units.
- **Model Selection**: By default, DeepLC selects the best model based on calibration. For specific chromatography (e.g., HILIC), you can manually specify models if the default selection is suboptimal.

## Reference documentation
- [DeepLC Project Documentation](./references/compomics_github_io_projects_DeepLC.md)
- [Bioconda DeepLC Overview](./references/anaconda_org_channels_bioconda_packages_deeplc_overview.md)