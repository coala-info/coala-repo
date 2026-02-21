---
name: mhcnuggets
description: MHCnuggets is a deep learning-based tool designed to predict the binding affinity of peptides to Major Histocompatibility Complex (MHC) molecules.
homepage: http://karchinlab.org/apps/mhcnuggets.html
---

# mhcnuggets

## Overview
MHCnuggets is a deep learning-based tool designed to predict the binding affinity of peptides to Major Histocompatibility Complex (MHC) molecules. It supports a wide array of MHC Class I and Class II alleles. This skill facilitates the execution of predictions via the command line, handling both single-peptide queries and batch processing of peptide lists.

## Installation and Setup
Ensure the environment is configured with the necessary deep learning backend:
- **Install**: `pip install mhcnuggets` or `conda install -c bioconda mhcnuggets`
- **Dependencies**: Requires `tensorflow`, `keras`, `numpy`, `scipy`, and `scikit-learn`.
- **Backend Check**: Verify that Keras is configured to use the TensorFlow backend in `~/.keras/keras.json`.

## Common CLI Patterns

### Class I Predictions
To predict binding for MHC Class I alleles (e.g., HLA-A*02:01):
```bash
python mnuggets_predict.py -a HLA-A*02:01 -p <peptide_sequence>
```

### Class II Predictions
To predict binding for MHC Class II alleles (e.g., HLA-DRB1*01:01):
```bash
python mnuggets_predict.py -a HLA-DRB1*01:01 -p <peptide_sequence> -c classII
```

### Batch Processing
For large datasets, pass a text file containing one peptide per line:
```bash
python mnuggets_predict.py -a HLA-A*02:01 -f <path_to_peptide_file> -o <output_csv_path>
```

## Expert Tips
- **Allele Naming**: Use standard nomenclature (e.g., `HLA-A*02:01`). If an allele is not found, check the supported allele list provided in the package metadata.
- **IC50 Thresholds**: MHCnuggets typically outputs predicted IC50 values in nM. A common threshold for "strong binders" is < 50nM, while < 500nM is often considered a "weak binder."
- **Performance**: For large-scale genomic pipelines, use the batch file input (`-f`) rather than calling the script repeatedly for individual peptides to minimize model loading overhead.

## Reference documentation
- [MHCnuggets Overview](./references/anaconda_org_channels_bioconda_packages_mhcnuggets_overview.md)