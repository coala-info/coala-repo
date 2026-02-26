---
name: chamois
description: CHAMOIS predicts hierarchical chemical classifications for biosynthetic gene clusters using machine learning to link genomic data with chemical structures. Use when user asks to predict chemical features from GenBank files, search metabolite catalogs for similar compounds, or explain which genes influenced a specific chemical classification.
homepage: https://chamois.readthedocs.io/
---


# chamois

## Overview

CHAMOIS (Chemical Hierarchy Approximation for secondary Metabolism clusters Obtained In Silico) is a specialized bioinformatics tool designed to bridge the gap between genomic data and chemical structures. It takes BGC sequences—typically those predicted by antiSMASH or GECCO—and uses machine learning to predict the hierarchical chemical classification (ChemOnt) of the resulting natural product. This allows for high-throughput prioritization of biosynthetic clusters based on their likely chemical output before any physical isolation or mass spectrometry is performed.

## Core CLI Workflows

### Inference and Prediction
The primary use case for CHAMOIS is predicting chemical features from one or more GenBank files.

*   **Basic Prediction**: Generate ChemOnt class predictions from a BGC file.
    `chamois predict input_cluster.gbk --output predictions.hdf5`
*   **Visualizing Results**: Render the hierarchical predictions as a tree structure directly in the terminal.
    `chamois render predictions.hdf5`

### Compound and Catalog Searching
Once predictions are generated, you can use them to identify potential known compounds or search databases.

*   **Catalog Search**: Compare predictions against a metabolite catalog (like NPAtlas) to find the most similar known compounds.
    `chamois search predictions.hdf5 --catalog npatlas`
*   **Direct Comparison**: Determine which BGC in a dataset is most likely to produce a specific query metabolite.
    `chamois compare predictions.hdf5 --query metabolite_smiles.txt`

### Model Interpretation
To understand why the model made a specific chemical class prediction:

*   **Explain Predictions**: Generate a gene contribution table to see which specific Open Reading Frames (ORFs) or domains influenced the classification.
    `chamois explain predictions.hdf5`

### Training and Evaluation
For advanced users looking to retrain the model on custom datasets:

*   **Annotation**: Extract features from GenBank files to create a training-ready dataset.
    `chamois annotate dataset.gbk --output features.hdf5`
*   **Training**: Train the logistic regression classifiers (requires `scikit-learn`).
    `chamois train features.hdf5 --output custom_model.pkl`
*   **Validation**: Evaluate model performance using cross-validation.
    `chamois cv features.hdf5`

## Expert Tips

*   **Installation Extras**: If you intend to use the training or validation sub-commands, ensure you install the training dependencies using `pip install "chamois-tool[train]"`.
*   **Module Invocation**: If the `chamois` executable is not in your system PATH, you can invoke the CLI as a Python module: `python -m chamois.cli <command>`.
*   **Input Compatibility**: CHAMOIS is optimized for BGCs predicted in silico. For best results, use standardized GenBank outputs from antiSMASH or GECCO as your starting point.
*   **HDF5 Management**: CHAMOIS uses HDF5 for storing intermediate features and predictions. These files can be large; use `chamois render` to inspect them without needing external HDF5 viewers.

## Reference documentation
- [CHAMOIS Overview](./references/chamois_readthedocs_io_en_latest.md)
- [CLI Reference](./references/chamois_readthedocs_io_en_latest_cli_index.html.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_chamois_overview.md)