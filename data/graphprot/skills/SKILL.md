---
name: graphprot
description: GraphProt models RNA-binding protein preferences by incorporating sequence and secondary structure information through a graph-based approach. Use when user asks to optimize model parameters, train classification or regression models, predict binding sites or nucleotide-wise profiles, and generate sequence or structure motifs.
homepage: https://github.com/dmaticzka/graphprot
metadata:
  docker_image: "quay.io/biocontainers/graphprot:1.1.7--py36_0"
---

# graphprot

## Overview
GraphProt is a computational tool designed to model the binding preferences of RNA-binding proteins. Unlike simple sequence-based models, GraphProt uses a graph-based approach to incorporate both sequence and secondary structure information. It supports two primary modes: classification (distinguishing bound sites from unbound sites) and regression (predicting continuous binding affinities).

## Core Workflows

### 1. Parameter Optimization (ls)
Before training a final model, use the `ls` action to find the best parameters for your specific dataset.
```bash
GraphProt.pl --action ls -fasta train_positives.fa -negfasta train_negatives.fa
```
*   **Output**: Optimized parameters are saved to `GraphProt.param`.

### 2. Model Training (train)
Train a model using positive (bound) and negative (unbound) sequences.
```bash
GraphProt.pl --action train -fasta train_positives.fa -negfasta train_negatives.fa
```
*   **Regression Mode**: Add `-mode regression -affinities scores.txt` where the affinity file contains one value per line corresponding to the fasta entries.
*   **Custom Prefix**: Use `-prefix my_model` to avoid overwriting default filenames.

### 3. Binding Prediction (predict)
Apply a trained model to new sequences to predict binding sites or nucleotide-wise profiles.
*   **Whole Site Prediction**:
    ```bash
    GraphProt.pl --action predict -fasta test.fa -model GraphProt.model
    ```
*   **Nucleotide-wise Profile**:
    ```bash
    GraphProt.pl --action predict_profile -fasta test.fa -model GraphProt.model
    ```
*   **High-Affinity Sites (HAS)**:
    ```bash
    GraphProt.pl --action predict_has -fasta test.fa -model GraphProt.model -percentile 99
    ```

### 4. Motif Generation (motif)
Generate visual representations of the sequence and structure preferences captured by the model.
```bash
GraphProt.pl --action motif --model GraphProt.model --fasta train_positives.fa
```
*   **Output**: Creates `GraphProt.sequence_motif.png` and `GraphProt.structure_motif.png`.

## Expert Tips and Best Practices

*   **The Viewpoint Mechanism**: GraphProt uses case sensitivity in FASTA files to define the "viewpoint." Use **uppercase** letters for the actual binding site nucleotides and **lowercase** letters for the surrounding context. Lowercase nucleotides are used for RNA structure prediction but are not treated as potential binding centers.
*   **Secondary Structure**: GraphProt relies on `RNAshapes` for structure predictions. Ensure your input sequences include enough context (lowercase) for accurate folding.
*   **Performance Evaluation**: Use `--action cv` to run a 10-fold cross-validation. Check `GraphProt.cv_results` for performance metrics like AUC.
*   **Advanced Graph Creation**: For custom graph processing, use the underlying `fasta2shrep_gspan.pl` tool. This allows for manual control over abstraction levels and window shifts.

## Reference documentation
- [GraphProt GitHub Repository](./references/github_com_dmaticzka_GraphProt.md)
- [Bioconda GraphProt Overview](./references/anaconda_org_channels_bioconda_packages_graphprot_overview.md)