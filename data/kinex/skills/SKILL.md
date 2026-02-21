---
name: kinex
description: Kinex (Kinome Exploration Tool) is a Python-based bioinformatics package designed to infer causal kinases from phosphoproteomics datasets.
homepage: https://github.com/bedapub/kinex
---

# kinex

## Overview

Kinex (Kinome Exploration Tool) is a Python-based bioinformatics package designed to infer causal kinases from phosphoproteomics datasets. It bridges the gap between observed phosphorylation changes and the upstream enzymatic activity responsible for them. Use this skill to automate the process of scoring peptide sequences, performing kinase enrichment analysis, and comparing results against drug collections to understand signaling pathways.

## Installation and Setup

Kinex requires Python 3.11. It is best managed via Conda to handle bioinformatics dependencies.

```bash
# Recommended installation via Bioconda
conda install -c bioconda kinex
```

## Core Python API Usage

The primary interface for Kinex is the `Kinex` class.

### 1. Initialization
You can initialize Kinex with built-in specificity matrices or provide custom ones for specific research needs.

```python
from kinex import Kinex
import pandas as pd

# Initialize with predefined Ser/Thr and Tyr matrices
kinex = Kinex()

# Initialize with custom matrices
kinex = Kinex(
    scoring_matrix_ser_thr=pd.read_csv('ser_thr_matrix.csv'),
    scoring_matrix_tyr=pd.read_csv('tyr_matrix.csv')
)
```

### 2. Substrate Sequence Scoring
To score a specific peptide sequence, use the `get_score` method. Ensure the phosphorylated residue is marked with an asterisk (`*`).

```python
sequence = "FVKQKAY*QSPQKQ"
score_results = kinex.get_score(sequence)
```

### 3. Kinase Enrichment Analysis
This is the core workflow for inferring causal kinases from a list of experimental sites.

```python
enrich = kinex.get_enrichment(
    input_sites, 
    fc_threshold=1.5,       # Fold-change threshold for significance
    phospho_priming=False,  # Set to True if considering prior phosphorylation events
    favorability=True,      # Weight by kinase favorability
    method="max"            # Scoring method (e.g., "max" or "mean")
)

# Access results for different residue types
ser_thr_results = enrich.ser_thr
tyr_results = enrich.tyr
```

## Best Practices and Tips

- **Sequence Formatting**: When scoring sequences, the window size should typically be centered around the phosphorylation site. The tool expects the site of interest to be indicated by `*`.
- **Data Thresholds**: When running `get_enrichment`, the `fc_threshold` (fold-change) significantly impacts the sensitivity of the inference. Start with a standard 1.5 or 2.0 threshold and adjust based on the noise level of your phosphoproteomics data.
- **Visualization**: The enrichment object returned by `get_enrichment` has built-in plotting capabilities. Use `enrich.ser_thr.plot()` for quick visual inspection of kinase activity shifts.
- **Matrix Selection**: Kinex supports both Serine/Threonine and Tyrosine kinases. Ensure your input data is correctly partitioned or that you are checking the appropriate attribute (`.ser_thr` vs `.tyr`) in the results.

## Reference documentation
- [Kinex GitHub Repository](./references/github_com_bedapub_kinex.md)
- [Kinex Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kinex_overview.md)