---
name: ms2pip
description: MS²PIP predicts the relative intensities of fragment ions in tandem mass spectrometry spectra using machine learning. Use when user asks to predict peptide fragmentation patterns, generate predicted spectral libraries from FASTA files, or correlate predicted intensities with experimental mass spectrometry data.
homepage: http://compomics.github.io/projects/ms2pip_c
---

# ms2pip

## Overview

MS²PIP (MS2 Peak Intensity Prediction) is a high-performance tool that utilizes the XGBoost machine learning algorithm to predict the relative intensities of fragment ions in tandem mass spectrometry (MS2) spectra. By providing accurate predictions that closely resemble observed spectra, it enables researchers to validate peptide identifications and build comprehensive spectral libraries without requiring extensive experimental data for every peptide. It supports a wide range of fragmentation methods, including HCD and CID, as well as specialized models for labeling techniques like TMT and iTRAQ.

## CLI Usage Patterns

### Single Peptide Prediction
Predict and optionally visualize the fragmentation spectrum for a specific peptide sequence.
```bash
ms2pip predict-single -s <peptide_sequence> -c <charge> -m <model_name>
```
*Example:* `ms2pip predict-single -s ACDEGHIK -c 2 -m HCD`

### Batch Prediction
Process a list of peptides provided in a PEPREC (peptide record) file.
```bash
ms2pip predict-batch <peprec_file> -m <model_name> -w <output_file>
```

### Spectral Library Generation
Generate a predicted spectral library directly from a protein FASTA file.
```bash
ms2pip predict-library <fasta_file> -m <model_name>
```

### Correlation Analysis
Compare predicted intensities against observed experimental data (MGF format) to calculate correlation coefficients.
```bash
ms2pip correlate <peprec_file> <mgf_file> -m <model_name>
```

## Model Selection Guide

Choosing the correct model is critical for prediction accuracy. Available models include:

| Model Name | Fragmentation / Instrument / Label |
| :--- | :--- |
| `HCD` | Standard Higher-energy Collisional Dissociation |
| `CID` | Standard Collision-Induced Dissociation |
| `TripleTOF5600` | Sciex TripleTOF 5600+ specific fragmentation |
| `TMT` | TMT-labeled peptides |
| `iTRAQ` | iTRAQ-labeled peptides |
| `iTRAQ_phospho` | iTRAQ-labeled phosphopeptides |

## Expert Tips and Best Practices

*   **Input Formatting:** Ensure PEPREC files are tab-separated and contain the required columns: `spec_id`, `modifications`, `peptide`, and `charge`.
*   **Modification Syntax:** Use the MS²PIP-specific modification nomenclature (e.g., `Oxidation` or `Carbamidomethyl`) as defined in the tool's configuration to ensure they are recognized by the XGBoost models.
*   **Performance:** For large-scale proteome predictions, use `predict-library` with multi-threading (if supported by the environment) to significantly reduce processing time compared to individual batch runs.
*   **Validation:** Use the `correlate` command to benchmark MS²PIP performance on a subset of your experimental data before running large-scale library predictions.



## Subcommands

| Command | Description |
|---------|-------------|
| ms2pip annotate-spectra | Annotate observed spectra. |
| ms2pip correlate | Compare predicted and observed intensities and optionally compute correlations. |
| ms2pip get-training-data | Extract feature vectors and target intensities from observed spectra for training. |
| ms2pip predict-batch | Predict fragmentation spectra for a batch of peptides. |
| ms2pip predict-library | Predict spectral library from protein FASTA file. |

## Reference documentation
- [MS2PIP GitHub Repository](./references/github_com_CompOmics_ms2pip.md)
- [MS2PIP Usage Guide](./references/ms2pip_readthedocs_io_en_v4.2.0-alpha.0_usage.md)
- [MS2PIP Prediction Models](./references/ms2pip_readthedocs_io_en_v4.2.0-alpha.0_prediction-models.md)