---
name: chamois
description: CHAMOIS predicts chemical classes and features of metabolites produced by Biosynthetic Gene Clusters from genomic data. Use when user asks to predict chemical ontology terms for BGC sequences, interpret model predictions for specific chemical features, search for BGCs producing specific compound types, or train custom biosynthetic predictors.
homepage: https://chamois.readthedocs.io/
---


# chamois

## Overview

CHAMOIS (Chemical Hierarchy Approximation for secondary Metabolite clusters Obtained In Silico) is a specialized bioinformatics tool designed to bridge the gap between genomic data and chemical structures. It predicts the chemical classes and features of metabolites produced by Biosynthetic Gene Clusters (BGCs) without requiring experimental metabolomics data. It is particularly effective when used in conjunction with BGC discovery tools like GECCO or antiSMASH, allowing researchers to rapidly characterize the biosynthetic potential of microbial genomes.

## CLI Usage and Best Practices

The `chamois` command-line interface is organized into several subcommands for different stages of the biosynthetic analysis pipeline.

### 1. Inference (Predicting Chemical Features)
Use the `predict` subcommand to assign chemical ontology terms to BGC sequences.

*   **Basic Prediction**: Provide a GenBank or FASTA file containing BGC sequences.
    ```bash
    chamois predict --input bgcs.gbk --output predictions.tsv
    ```
*   **Input Compatibility**: CHAMOIS is designed to work directly with outputs from `GECCO` or `antiSMASH`.
*   **Output Format**: The results are typically provided as a TSV file mapping BGC identifiers to predicted ChemOnt (Chemical Ontology) terms and their associated probabilities.

### 2. Model Interpretation
To understand *why* a specific chemical feature was predicted, use the interpretation tools. This helps identify the specific protein domains or genomic signatures driving the prediction.

```bash
chamois explain --input bgcs.gbk --term "Polyketides"
```

### 3. Compound Search
Search for BGCs that are likely to produce specific types of compounds based on chemical ontology.

```bash
chamois search --query "Macrolides" --database my_bgc_collection.db
```

### 4. Training Custom Models
If you have a specialized dataset of BGCs with known chemical products, you can train a custom predictor.

```bash
chamois train --features features.npz --labels labels.csv --output custom_model.pkl
```

## Expert Tips

*   **Domain Annotation**: CHAMOIS relies on accurate protein domain annotation. Ensure your input files have high-quality ORF (Open Reading Frame) calls.
*   **ClassyFire Integration**: CHAMOIS uses the ClassyFire taxonomy. When querying or interpreting results, refer to the ChemOnt hierarchy for valid term names.
*   **Performance**: CHAMOIS is optimized for speed. It can process thousands of BGCs significantly faster than traditional structure-based docking or complex simulation methods.
*   **Memory Management**: For very large genomic datasets, consider processing files in batches to maintain a low memory footprint.



## Subcommands

| Command | Description |
|---------|-------------|
| chamois cvi | Trains a predictor based on features and classes, with options for preprocessing, training, cross-validation, and output. |
| chamois_annotate | Annotate BGC sequences with protein domains and gene features. |
| chamois_compare | Compare chemical classes predicted by CHAMOIS for BGCs against a set of queries. |
| chamois_cv | Train a predictor and evaluate it using cross-validation. |
| chamois_explain | Explain which domains contribute to a class prediction. |
| chamois_predict | Predicts BGC classes and associated domains. |
| chamois_render | Render probabilities from a predictor. |
| chamois_search | Searches a compound class catalog for predicted chemical classes. |
| chamois_train | Train a predictor model using feature and class tables. |
| chamois_validate | Validate a chamois model |

## Reference documentation

- [CHAMOIS Overview](./references/chamois_readthedocs_io_en_latest.md)
- [CLI Reference](./references/chamois_readthedocs_io_en_latest_cli_index.html.md)
- [API Reference](./references/chamois_readthedocs_io_en_latest_api_index.html.md)
- [GitHub Repository](./references/github_com_zellerlab_CHAMOIS.md)