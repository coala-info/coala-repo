---
name: ms2pip
description: ms2pip predicts the relative intensities of fragment ions in tandem mass spectrometry spectra using machine learning models. Use when user asks to predict peptide fragment ion intensities, generate theoretical spectral libraries, or compare predicted spectra against experimental data.
homepage: http://compomics.github.io/projects/ms2pip_c
---


# ms2pip

## Overview
ms2pip (MS² Peak Intensity Prediction) is a high-performance tool designed to predict the relative intensities of fragment ions in tandem mass spectrometry (MS2) spectra. By leveraging machine learning models trained on vast proteomics datasets, it provides accurate theoretical spectra for given peptide sequences and their modifications. This skill facilitates the generation of predicted spectra for various fragmentation methods (e.g., HCD, CID, ETD) and instrument types, enabling more sensitive and accurate peptide-spectrum matching.

## Usage Guidelines

### Core Command Structure
The primary interface for ms2pip is the command line. The basic syntax requires a peptide input file (typically in `.peprec` format) and a configuration for the model.

```bash
ms2pip <input_peprec_file> -m <model_name> -c <config_file>
```

### Input Requirements
- **PEPREC Format**: A space-separated or tab-separated file containing columns: `spec_id`, `modifications`, `peptide`, and `charge`.
- **Modifications**: Represented as `Location|Modification_Name` (e.g., `0|Acetylation`).
- **Models**: Choose the model corresponding to your experimental setup (e.g., `HCD`, `CID`, `TMT`, `iTRAQ`).

### Common Patterns
- **Predicting Intensities**: To generate predictions for a list of peptides, ensure your config file specifies the correct fragmentation and instrument settings.
- **Spectral Library Generation**: Use ms2pip to create comprehensive theoretical libraries for DIA (Data-Independent Acquisition) analysis.
- **Evaluation**: Compare predicted intensities against experimental MGF files using the `-s` flag to calculate Pearson correlation coefficients.

### Expert Tips
- **Model Selection**: Always match the model to the specific fragmentation type and N-terminal/C-terminal labeling (like TMT) used in the experiment for maximum accuracy.
- **Batch Processing**: For large-scale proteomics projects, split PEPREC files to parallelize prediction tasks across multiple CPU cores.
- **Custom Models**: If working with non-standard fragmentation or unique organisms, consider using the underlying XGBoost framework to train a custom intensity model.

## Reference documentation
- [ms2pip Overview](./references/anaconda_org_channels_bioconda_packages_ms2pip_overview.md)