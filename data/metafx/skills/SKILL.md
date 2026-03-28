---
name: metafx
description: MetaFX transforms raw metagenomic reads into numerical features using de Bruijn graph components for sample differentiation and analysis. Use when user asks to extract metagenomic features, identify sequences that distinguish sample groups, perform PCA for sample clustering, or train machine learning models for classification and prediction.
homepage: https://github.com/ctlab/metafx
---

# metafx

## Overview
MetaFX (METAgenomic Feature eXtraction) is a specialized toolbox designed to transform raw metagenomic reads into meaningful numerical features. Unlike standard taxonomic profiling, MetaFX uses de Bruijn graph components to identify sequences that differentiate groups of samples (e.g., healthy vs. diseased). These features can be used to train machine learning models, perform PCA for sample clustering, or be exported as FASTA sequences for functional annotation.

## Core Workflows

### 1. Unsupervised Feature Extraction
Use these modules when you do not have predefined categories or want to explore natural clusters in the data.

*   **metafast**: Best for general distance estimation and heatmap generation.
    ```bash
    metafx metafast -k 31 -t <threads> -m <memory> -w <work_dir> -i <reads_pattern>
    ```
*   **metaspades**: Uses the SPAdes assembler logic for feature extraction (requires SPAdes installed).
    ```bash
    metafx metaspades -k 21 -w <work_dir> -i <paired_end_reads>
    ```

### 2. Supervised Feature Extraction
Use these modules when you have metadata (e.g., diagnosis) and want to find features that distinguish specific groups.

*   **unique**: Extracts k-mers present in one category but absent in others.
    ```bash
    metafx unique -k 31 -i <sample_list.txt> -w <work_dir>
    ```
    *Note: `sample_list.txt` should be a tab-separated file: `<path_to_file>\t<category>`.*
*   **chisq / stats**: Uses statistical tests to identify features with significant frequency differences between groups.

### 3. Analysis and Machine Learning
Once a feature table is generated (usually `feature_table.tsv`), use these modules for downstream analysis:

*   **PCA Visualization**:
    ```bash
    metafx pca -f <feature_table.tsv> -i <samples_categories.tsv> -w <out_dir> --show
    ```
*   **Cross-Validation**: Train and evaluate a model (Random Forest by default) using the extracted features.
    ```bash
    metafx cv -f <feature_table.tsv> -i <samples_categories.tsv> -n <folds> --grid
    ```
*   **Prediction**: Apply a trained model to new samples.
    ```bash
    metafx predict -f <new_feature_table.tsv> -m <model_file> -w <out_dir>
    ```

## Expert Tips and Best Practices

*   **K-mer Selection**: Use `-k 31` for most metagenomic applications to ensure high specificity. Lower k-mer sizes may increase sensitivity but lead to more ambiguous graph components.
*   **Memory Management**: MetaFX memory requirements grow linearly with dataset size. Use the `-m` flag (e.g., `-m 16G`) to prevent Java heap space errors. If not specified, it defaults to 90% of free RAM.
*   **Paired-End Detection**: Ensure paired-end files follow the naming convention `_R1`/`_R2` or `_r1`/`_r2` immediately before the extension for automatic detection.
*   **Performance Optimization**: If running multiple pipelines on the same data, use `metafx extract_kmers` first and then point subsequent commands to the resulting directory using `--kmers-dir`. This avoids redundant k-mer counting.
*   **Interpreting Results**: The `component.seq.fasta` files in the output directories contain the actual sequences representing your features. These should be submitted to BLAST or DIAMOND for biological annotation.



## Subcommands

| Command | Description |
|---------|-------------|
| metafx bandage | MetaFX bandage module – Machine Learning methods to train classifier and prepare for visualisation in Bandage (https://github.com/ctlab/BandageNG) |
| metafx calc_features | MetaFX calc_features module – to count values for new samples based on previously extracted features |
| metafx chisq | supervised feature extraction using top significant k-mers by chi-squared test |
| metafx colored | supervised feature extraction using group-colored de Bruijn graph |
| metafx cv | Machine Learning methods to train classification model based on extracted features and check accuracy via cross-validation |
| metafx extract_kmers | Counting k-mers presence for samples |
| metafx feature_analysis | MetaFX feature_analysis module – pipeline to build de Bruijn graphs for samples with selected feature and visualize them in BandageNG (https://github.com/ctlab/BandageNG) |
| metafx fit | Machine Learning methods to train classification model based on extracted features |
| metafx fit_predict | Machine Learning methods to train classification model based on extracted features and immediately apply it to classify new samples |
| metafx metafast | MetaFX metafast module – unsupervised feature extraction and distance estimation via MetaFast (https://github.com/ctlab/metafast/) |
| metafx metaspades | MetaFX metaspades module – unsupervised feature extraction and distance estimation via metaSpades (https://cab.spbu.ru/software/meta-spades/) |
| metafx pca | PCA dimensionality reduction and visualisation of samples based on extracted features |
| metafx predict | MetaFX predict module – Machine Learning methods to classify new samples based on pre-trained model |
| metafx stats | supervised feature extraction using statistically significant k-mers |
| metafx unique | supervised feature extraction using group-specific k-mers |

## Reference documentation
- [MetaFX GitHub Wiki](./references/github_com_ctlab_metafx_wiki.md)
- [MetaFX Tutorial](./references/github_com_ctlab_metafx_wiki_MetaFX-tutorial.md)
- [Main README](./references/github_com_ctlab_metafx.md)