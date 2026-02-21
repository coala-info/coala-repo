---
name: ananse
description: ANANSE (ANalysis Algorithm for Networks Specified by Enhancers) is a computational framework designed to map the regulatory landscape of cell fate changes.
homepage: https://github.com/vanheeringen-lab/ANANSE
---

# ananse

## Overview
ANANSE (ANalysis Algorithm for Networks Specified by Enhancers) is a computational framework designed to map the regulatory landscape of cell fate changes. It moves beyond simple differential expression by integrating enhancer activity (often from ATAC-seq or H3K27ac ChIP-seq) with gene expression data to build state-specific gene regulatory networks. Use this skill to identify the "master regulators" responsible for driving a cell from a source state to a target state.

## Core Workflow and CLI Usage

The standard ANANSE pipeline consists of three primary steps: predicting binding, building the network, and calculating influence.

### 1. Predict TF Binding
Use `ananse binding` to predict the binding probability of transcription factors based on enhancer activity and motif analysis.
```bash
ananse binding -g <genome_fasta> -a <peaks.bed> -e <expression.tpm> -o <binding_output.h5>
```
*   **Input**: Requires a genome (via genomepy), ATAC-seq/ChIP-seq peaks, and a gene expression table.
*   **Output**: An HDF5 file containing binding probabilities for all TFs across all regions.

### 2. Infer Gene Regulatory Networks
Use `ananse network` to combine binding probabilities with gene expression to create a GRN.
```bash
ananse network -b <binding_output.h5> -e <expression.tpm> -o <network_output.h5>
```
*   **Tip**: You can provide a specific list of TFs or regions to focus the network construction.
*   **Annotation**: If using a custom genome, ensure the gene annotation matches the expression table identifiers.

### 3. Calculate TF Influence
Use `ananse influence` to compare two GRNs (e.g., Source vs. Target) and identify the TFs most likely to drive the transition.
```bash
ananse influence -s <source_network.h5> -t <target_network.h5> -d <diff_expression.txt> -o <influence_results.txt>
```
*   **Differential Expression**: The `-d` file should contain log-fold changes and p-values.
*   **Output**: A ranked list of TFs based on their "influence score," which combines network topology changes with differential expression.

## Inspection and Utilities

### Viewing HDF5 Results
ANANSE stores its large-scale data in HDF5 format. Use the `view` command to inspect these files without loading them into a custom script.
*   **List TFs in a binding file**: `ananse view <binding.h5> --list-tfs`
*   **List regions**: `ananse view <binding.h5> --list-regions`
*   **Extract specific network edges**: `ananse view <network.h5> -n 100` (shows the top 100 edges)

## Expert Tips
*   **Genome Consistency**: Always use the same genome version (e.g., hg38) across all steps. ANANSE integrates with `genomepy` to manage these references.
*   **Memory Management**: `ananse network` can be memory-intensive for large datasets. If running on a cluster, ensure you allocate sufficient RAM for the HDF5 processing.
*   **Single-Cell Integration**: For single-cell data (Scanpy/Seurat), use the `scANANSE` wrapper or the `anansnake` pipeline to automate the transition from cluster-level data to ANANSE networks.
*   **Input Normalization**: Ensure expression data (TPM) is consistently normalized across the samples being compared to avoid artifacts in the influence calculation.

## Reference documentation
- [ANANSE GitHub Repository](./references/github_com_vanheeringen-lab_ANANSE.md)
- [ANANSE Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ananse_overview.md)