---
name: mokapot
description: mokapot uses semi-supervised machine learning to rescore peptide-spectrum matches and improve peptide identifications in proteomics workflows. Use when user asks to rescore PSMs, enhance peptide identification confidence, or apply the Percolator algorithm using custom machine learning classifiers.
homepage: https://github.com/wfondrie/mokapot
---


# mokapot

## Overview

mokapot is a highly flexible Python implementation of the Percolator algorithm, designed to enhance the identification of peptides in proteomics workflows. It uses semi-supervised machine learning to learn the characteristics of high-quality peptide-spectrum matches (PSMs) by comparing target matches against a decoy distribution. Unlike the original Percolator, mokapot is built to be extensible, allowing for the use of various machine learning classifiers (such as gradient boosting) and the ability to train joint models across multiple experiments while maintaining valid confidence estimates for each individual run.

## Installation

Install mokapot using either the Conda or Pip package managers:

```bash
# Using Conda (recommended for bioinformatics)
conda install -c bioconda mokapot

# Using Pip
pip install mokapot
```

## Command Line Interface (CLI)

The CLI is the fastest way to perform standard rescoring tasks.

### Basic Rescoring
To rescore PSMs from a Percolator tab-delimited (PIN) file:
```bash
mokapot psms.pin
```

### Working with PepXML
mokapot also supports the PepXML format directly:
```bash
mokapot psms.pep.xml
```

## Python API Usage

For advanced workflows, such as swapping classifiers or custom data handling, use the Python API.

### Standard Workflow
```python
import mokapot

# 1. Load the PSMs
psms = mokapot.read_pin("psms.pin")

# 2. Run the semi-supervised learning (brew)
results, models = mokapot.brew(psms)

# 3. Export results to text files
results.to_txt()
```

### Customizing the Classifier
One of mokapot's primary advantages is the ability to use non-linear classifiers from libraries like scikit-learn.

```python
import mokapot
from sklearn.ensemble import GradientBoostingClassifier

# Define a custom model wrapper
model = mokapot.Model(GradientBoostingClassifier())

# Use the custom model in the brew process
psms = mokapot.read_pin("psms.pin")
results, models = mokapot.brew(psms, model=model)
```

## Best Practices and Expert Tips

- **Input Format**: Ensure your search engine output is converted to the Percolator "PIN" format (tab-delimited with specific feature columns) or PepXML before running mokapot.
- **Decoy Strategy**: mokapot relies on a decoy database search. Ensure your input contains a balanced number of target and decoy matches for the semi-supervised learning to function correctly.
- **Joint Modeling**: If you have multiple small experiments, consider training a joint model across all of them to improve the classifier's performance, which mokapot handles while still providing per-experiment FDR estimates.
- **Memory Management**: For very large datasets, monitor memory usage as mokapot loads PSMs into memory. Using the Python API allows for more granular control over data loading if memory becomes a bottleneck.
- **Reproducibility**: When using the API, set a random seed in the `brew()` function to ensure consistent results across different runs.

## Reference documentation
- [github_com_wfondrie_mokapot.md](./references/github_com_wfondrie_mokapot.md)
- [anaconda_org_channels_bioconda_packages_mokapot_overview.md](./references/anaconda_org_channels_bioconda_packages_mokapot_overview.md)