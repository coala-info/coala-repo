---
name: hsdecipher
description: HSDecipher is a bioinformatics pipeline for the downstream analysis, statistical quantification, and visualization of highly similar gene duplicates. Use when user asks to calculate HSD metrics, categorize gene copy distributions, merge datasets across similarity thresholds, or generate functional heatmaps for gene duplication patterns.
homepage: https://github.com/zx0223winner/HSDecipher
---


# hsdecipher

## Overview
HSDecipher is a specialized bioinformatics pipeline designed for the downstream analysis of gene duplicates that exhibit high sequence similarity. It bridges the gap between raw duplicate identification and evolutionary interpretation by providing tools to quantify HSD populations, filter redundant candidates across varying stringency levels, and visualize functional clusters through heatmaps. Use this skill when you need to process output from tools like HSDFinder to understand gene duplication patterns within or between species, particularly when evaluating how different similarity thresholds affect the identified gene set.

## Core Workflows and CLI Usage

### 1. Statistical Analysis
Use `HSD_statistics.py` to calculate HSD metrics across multiple files (e.g., different species or thresholds).

```bash
python3 HSD_statistics.py <path_to_HSD_folder> <format_ext> <output_name.tsv>
```
*   **Input**: A directory containing HSD files.
*   **Format**: Usually 'txt' or 'tsv'.
*   **Output**: A table containing candidate counts, non-redundant copies, capturing values, and performance scores.

### 2. Gene Copy Categorization
Use `HSD_categories.py` to evaluate the distribution of HSD groups based on the number of copies (2, 3, or 4+).

```bash
python3 HSD_categories.py <path_to_HSD_folder> <format_ext> <output_name.tsv>
```

### 3. Dataset Expansion (Add-on Mode)
Use `HSD_add_on.py` to merge HSD data from different thresholds. This is critical for enlarging candidate categories while removing redundancy.

```bash
python3 HSD_add_on.py -i <base_input_file> -a <additional_file> -o <merged_output_file>
```
*   **Logic**: If a more relaxed threshold (e.g., 90%_30aa) contains identical genes or the same copies as a stricter cutoff (e.g., 90%_10aa), the redundant candidates are removed during the merge.

### 4. Batch Processing
Use `HSD_batch_run.py` to execute a standard series of combination thresholds (E + (D + (C + (B + A)))) automatically.

```bash
python3 HSD_batch_run.py -i <input_folder>
```
*   **Filtering**: This script automatically removes candidates if the minimum gene copy length is less than half of the maximum length or if Pfam domains are inconsistent.

### 5. Heatmap Visualization
Use `HSD_heatmap.py` to visualize HSDs sharing the same pathway functions for intra- or inter-species comparison.

```bash
python3 HSD_heatmap.py -f <HSD_folder> -k <KO_file_folder> -r <width_pixels> -c <height_pixels>
```
*   **Requirement**: Requires a folder of KO (KEGG Orthology) files to map functional pathways.

## Data Specifications

### Input File Format
HSDecipher expects a 9-column tab-delimited file with the following structure:
1.  **HSD_identifier**: Usually the first gene model ID.
2.  **gene_copies**: Semicolon-separated list of duplicate genes.
3.  **AA_length**: Semicolon-separated amino acid lengths.
4.  **function_type**: e.g., Pfam, PRINTS, Gene3D.
5.  **function_identifier**: e.g., PF06454.
6.  **function_Description**: Text description of the function.
7.  **E-value**: Significance of the functional match.
8.  **InterPro_identifier**: IPR entry ID.
9.  **InterPro_description**: IPR entry description.

## Expert Tips and Best Practices
*   **Threshold Strategy**: To minimize redundancy while maximizing dataset size, always start with strict thresholds and progressively add more relaxed thresholds using the `HSD_add_on.py` logic.
*   **Domain Consistency**: When manually filtering HSDs, prioritize candidates where all gene copies share the same number and type of Pfam domains to ensure functional homology.
*   **Length Ratio**: A common quality control metric in HSD analysis is ensuring the shortest gene copy in a group is at least 50% the length of the longest copy.
*   **Installation**: If the environment is not set up, use `conda install bioconda::hsdecipher` for a quick deployment of all dependencies.

## Reference documentation
- [HSDecipher GitHub Repository](./references/github_com_zx0223winner_HSDecipher.md)
- [HSDecipher Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hsdecipher_overview.md)