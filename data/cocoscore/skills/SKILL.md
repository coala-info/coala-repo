---
name: cocoscore
description: CoCoScore (Context-aware Co-occurrence Score) is a tool designed to enhance biomedical text mining by moving beyond simple co-occurrence counts.
homepage: https://github.com/JungeAlexander/cocoscore
---

# cocoscore

## Overview
CoCoScore (Context-aware Co-occurrence Score) is a tool designed to enhance biomedical text mining by moving beyond simple co-occurrence counts. While traditional methods often produce noise by counting any two entities mentioned in the same sentence, CoCoScore uses a machine learning approach (utilizing fastText) to assess the textual context. It determines the likelihood that a sentence actually describes a meaningful relationship. This skill should be used to improve the precision of association scores in datasets involving disease-gene, tissue-gene, or protein-protein interactions.

## Installation and Setup
CoCoScore requires Python and the fastText library.

*   **Recommended (Conda):**
    ```bash
    conda install -c bioconda cocoscore
    ```
    *Note: The bioconda installation automatically handles the fastText dependency.*

*   **Alternative (Pip):**
    ```bash
    pip install cocoscore
    ```
    *Note: If installing via pip, you must manually install fastText v0.1.0 and ensure the `fasttext` binary is in your $PATH.*

## Core Workflow
To use CoCoScore effectively, you typically follow a distant supervision workflow:

1.  **Model Acquisition:** CoCoScore relies on a pre-trained fastText model to evaluate sentence context.
    ```bash
    wget http://download.jensenlab.org/BLAH4/demo.ftz
    ```
2.  **Data Preparation:** Prepare a dataset of sentences where entity pairs are co-mentioned.
3.  **Scoring:** Apply the context-aware scoring model to your sentence list to generate a probability score for each association.
4.  **Aggregation:** Aggregate individual sentence scores into a final association score for entity pairs.

## Best Practices
*   **Version Matching:** Ensure you are using fastText version 0.1.0. Newer versions of fastText may have compatibility issues with the pre-trained models or the scoring logic expected by CoCoScore.
*   **Contextual Filtering:** Use the `score_cutoff` parameter during the scoring phase to filter out low-confidence sentence associations before aggregating final entity-pair scores.
*   **Distant Supervision:** When training or fine-tuning, use distant supervision to automatically label large datasets of sentences, but be aware that this creates a "noisy" training set that requires validation against gold-standard datasets (like protein-protein interaction databases).
*   **Environment Testing:** Use `tox` to verify the installation and ensure all dependencies (scikit-learn, fastText, etc.) are correctly configured in your environment.

## Reference documentation
- [CoCoScore GitHub Repository](./references/github_com_JungeAlexander_cocoscore.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_cocoscore_overview.md)