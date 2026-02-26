---
name: chromhmm
description: ChromHMM is a computational framework that uses a multivariate Hidden Markov Model to integrate multiple chromatin datasets and segment the genome into functional chromatin states. Use when user asks to binarize epigenetic signal data, learn chromatin state models, segment the genome into functional categories, or perform enrichment analysis on genomic annotations.
homepage: https://github.com/jernst98/ChromHMM
---


# chromhmm

## Overview
ChromHMM is a computational framework for learning and characterizing chromatin states. It integrates multiple chromatin datasets—such as ChIP-seq data for various histone modifications—to discover the major re-occurring combinatorial and spatial patterns of marks across the genome. By modeling the presence or absence of marks using a multivariate Hidden Markov Model, it segments the genome into functional categories (e.g., enhancers, promoters, repressed regions) without requiring prior annotation.

## Core CLI Workflow

ChromHMM is a Java-based tool. Most commands follow the pattern: `java -mx[memory]M -jar ChromHMM.jar [Command] [Options]`.

### 1. Data Binarization
Before learning a model, input signal data (BED or BAM) must be converted into a binary format (presence/absence of a mark in a genomic bin).

```bash
# Binarize BED files for a specific assembly
java -mx4000M -jar ChromHMM.jar BinarizeBed CHROMSIZES/hg19.txt SAMPLEDATA_HG19 cellmarkfiletable.txt OUTPUT_DIRECTORY
```
*   **cellmarkfiletable.txt**: A tab-delimited file with columns: `Cell_Type`, `Mark`, and `BED_File_Name`.
*   **CHROMSIZES**: Use the provided files in the `CHROMSIZES` directory for the relevant assembly.

### 2. Learning the Model
This is the primary step where the HMM is trained and the genome is segmented.

```bash
# Learn a model with a specific number of states (e.g., 15)
java -mx4000M -jar ChromHMM.jar LearnModel BINARIZED_DATA_DIR OUTPUT_DIR 15 hg19
```
*   **States**: The number of states is a user-defined parameter. Common choices range from 10 to 25.
*   **Output**: Generates emission and transition parameters, and the final segmentation (BED/browser files).

### 3. Enrichment Analysis
After segmentation, characterize states by calculating their overlap with known genomic features.

```bash
# Calculate overlap enrichment with annotations
java -mx4000M -jar ChromHMM.jar OverlapEnrichment SEGMENTATION_FILE ANNOTATION_DIR OUTPUT_PREFIX
```

## Expert Tips and Best Practices

*   **Memory Allocation**: ChromHMM is memory-intensive. Always use the `-mx` flag (e.g., `-mx4000M` for 4GB) to ensure the JVM has enough heap space for large genomes.
*   **State Reordering**: Use the `Reorder` command to make state numbering consistent across different models or to match biological intuition (e.g., putting promoter states first).
    *   Pattern: `java -jar ChromHMM.jar Reorder -reordercolsmodelfile [mapping_file] input_model output_model`
*   **Labeling**: Use the `-labels` option in `OverlapEnrichment` and `NeighborhoodEnrichment` to provide human-readable names for states in the resulting heatmaps.
*   **Binarization Thresholds**: If the default Poisson threshold is too strict or lenient, consider using `BinarizeBam` with custom signal thresholds to better capture weak but consistent marks.
*   **Anchor Files**: When using `NeighborhoodEnrichment`, utilize the `ANCHORFILES` directory to center analysis on specific features like Transcription Start Sites (TSS).

## Reference documentation
- [ChromHMM Overview](./references/anaconda_org_channels_bioconda_packages_chromhmm_overview.md)
- [ChromHMM Repository Structure](./references/github_com_jernst98_ChromHMM.md)
- [Version 1.19 Updates](./references/github_com_jernst98_ChromHMM_tags.md)