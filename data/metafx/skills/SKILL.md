---
name: metafx
description: MetaFX extracts biological features from metagenomic short-read data by identifying specific components in a de Bruijn graph. Use when user asks to extract features from raw reads, visualize sample proximity via PCA, perform statistical analysis, or train and apply machine learning models for sample classification.
homepage: https://github.com/ctlab/metafx
---


# metafx

## Overview
MetaFX (METAgenomic Feature eXtraction) is a specialized toolkit designed to bridge the gap between raw metagenomic short-read data and biological interpretation. It transforms large-scale sequencing datasets into a feature table by identifying specific components in a de Bruijn graph that are either unique to certain sample groups or common across a dataset. This skill enables the execution of unsupervised and supervised pipelines for feature extraction, sample visualization via PCA, and the training of classification models.

## Installation and Environment
MetaFX requires a Java Runtime Environment (JRE 1.8+) and Python 3.9+.

*   **Conda (Recommended):** `conda install -c bioconda metafx`
*   **Manual:** Clone the repository and add the `bin/` directory and its subdirectories (`metafx-modules`, `metafx-scripts`) to your `PATH`.
*   **Dependencies:** Ensure `coreutils` is installed on macOS (`brew install coreutils`).

## Core CLI Usage
The general syntax for all operations is:
`metafx <pipeline> [launch_options] [input_parameters]`

### 1. Feature Extraction
Feature extraction is the primary step to convert raw reads into a numeric feature table.

*   **Supervised Extraction (Group-relevant):**
    Use the `unique` pipeline when you have labeled data and want to find features that distinguish specific categories.
    ```bash
    metafx unique -t 8 -m 4G -k 31 -w output_dir -i sample_list.txt
    ```
    *   `-i`: A tab-separated file containing `<path_to_reads>\t<category>`.
    *   `-k`: K-mer size (maximum 31).

*   **Unsupervised Extraction (MetaFast):**
    Use when you have no prior knowledge of sample relations.
    ```bash
    metafx metafast -t 8 -m 8G -k 21 -w wd_metafast -i test_data/*.fastq.gz
    ```

### 2. Visualization and Analysis
Once a `feature_table.tsv` is generated, use these modules to understand sample proximity.

*   **PCA Visualization:**
    ```bash
    metafx pca -w wd_pca -f wd_unique/feature_table.tsv -i wd_unique/samples_categories.tsv --show
    ```
*   **Statistical Significance:**
    Use `metafx chisq` to perform basic statistical analysis on the extracted features.

### 3. Machine Learning Workflow
MetaFX supports training models to predict categories for new metagenomic samples.

*   **Cross-Validation:**
    Evaluate model performance on your current feature table.
    ```bash
    metafx cv -t 4 -w wd_cv -f feature_table.tsv -i samples_categories.tsv --grid
    ```
*   **Training (Fit):**
    Save a model for future use.
    ```bash
    metafx fit -f feature_table.tsv -i samples_categories.tsv -w model_dir
    ```
*   **Inference (Predict):**
    Apply a trained model to new, unseen samples.
    ```bash
    metafx predict -w predict_dir -m model_dir/model.pkl -i new_samples.txt
    ```

## Expert Tips and Best Practices
*   **Read Naming:** For paired-end read detection, files must use `_R1`/`_R2` or `_r1`/`_r2` suffixes (e.g., `sample_R1.fastq.gz`).
*   **Memory Allocation:** Always specify memory with the `-m` flag (e.g., `-m 16G`). Required RAM scales linearly with the total size of the input dataset.
*   **K-mer Selection:** Use `-k 31` for high specificity in complex metagenomes; use lower values (e.g., 21) for faster processing or lower coverage samples.
*   **Interpreting Features:** The `contigs_<category>/` directory contains FASTA files of the features. These can be run through BLAST or other annotation tools to identify the specific organisms or genes driving the classification.
*   **Graph Visualization:** MetaFX produces `.gfa` files (e.g., `components-graph.gfa`). These can be loaded into **Bandage** to visualize the connectivity of the extracted features.

## Reference documentation
- [MetaFX Main Repository](./references/github_com_ctlab_metafx.md)
- [MetaFX Wiki and Detailed Module Guide](./references/github_com_ctlab_metafx_wiki.md)