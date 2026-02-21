---
name: rs3
description: The `rs3` tool is a specialized Python package developed by the Genetic Perturbation Platform (GPP) to predict the efficiency of CRISPR single guide RNAs (sgRNAs).
homepage: https://github.com/gpp-rnd/rs3/tree/master/
---

# rs3

## Overview
The `rs3` tool is a specialized Python package developed by the Genetic Perturbation Platform (GPP) to predict the efficiency of CRISPR single guide RNAs (sgRNAs). It implements the Rule Set 3 algorithm, which improves upon previous iterations by offering two distinct prediction paths: a fast sequence-only model and a high-accuracy target-based model. Use this skill when you need to rank sgRNAs for experimental design or analyze the predicted potency of existing CRISPR libraries.

## Installation and Setup
The package can be installed via `pip` or `conda`. 

*   **Standard Install**: `pip install rs3`
*   **Bioconda**: `conda install bioconda::rs3`
*   **Mac Users**: You may need to install a compiled version of `lightgbm` (e.g., `conda install -c conda-forge lightgbm==3.3.5`) before installing `rs3` via pip.

## Sequence-Based Prediction
This is the most common use case for rapid scoring of sgRNA candidates based solely on their nucleotide context.

### Basic Usage
```python
from rs3.seq import predict_seq

# Sequences must be 30mer context sequences
context_seqs = ['GACGAAAGCGACAACGCGTTCATCCGGGCA', 'AGAAAACACTAGCATCCCCACCCGCGGACT']

# tracrRNA selection: 'Hsu2013' or 'Chen2013'
scores = predict_seq(context_seqs, sequence_tracr='Hsu2013')
```

### Expert Tip: tracrRNA Selection
The choice of `sequence_tracr` significantly impacts prediction accuracy.
*   **Hsu2013**: Use for standard tracrRNA designs.
*   **Chen2013**: Use for tracrRNA designs that do **not** have a Thymine (T) in the fifth position. This generally yields better predictions for modified scaffolds.

## Target-Based Prediction
Target-based models provide higher accuracy by considering the biological context of the cut site. This requires a more complex workflow involving feature matrices.

### Required Columns
To merge feature matrices correctly, your input DataFrame must contain these unique identifiers:
*   `sgRNA Context Sequence`
*   `Target Cut Length`
*   `Target Transcript`
*   `Orientation`

### Workflow Pattern
1.  **Initialize Design**: Load your sgRNA design table into a Pandas DataFrame.
2.  **Add Target Metadata**: Use `add_target_columns` to generate the `Transcript Base` (Ensembl ID without version) and `AA Index`.
3.  **Load Features**: Load amino acid sequences, conservation scores, and protein domains (often stored as Parquet files).
4.  **Predict**: Execute `predict_target`.

```python
import pandas as pd
from rs3.predicttarg import predict_target
from rs3.targetfeat import add_target_columns

# 1. Prepare design
design_df = pd.read_table('sgrna-designs.txt')

# 2. Add necessary index columns
design_targ_df = add_target_columns(design_df)

# 3. Predict (assuming feature matrices are prepared)
# scores = predict_target(design_targ_df, aa_feature_matrix, conservation_matrix, domain_matrix)
```

## Best Practices
*   **Input Length**: Ensure all sequences provided to the sequence model are exactly 30 nucleotides long. The model is trained on this specific context window.
*   **Data Handling**: Use `pyarrow` for reading transcript and feature data, as `rs3` workflows are optimized for Parquet format when handling large-scale genomic features.
*   **Transcript IDs**: When matching with internal `rs3` data, always strip version numbers from Ensembl IDs (e.g., use `ENST00000259457` instead of `ENST00000259457.8`).

## Reference documentation
- [Rule Set 3 GitHub Repository](./references/github_com_gpp-rnd_rs3.md)
- [Bioconda rs3 Overview](./references/anaconda_org_channels_bioconda_packages_rs3_overview.md)