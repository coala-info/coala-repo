---
name: multiaffinity
description: "This CWL workflow utilizes RNA-seq data and community detection tools to model how gene dysregulation propagates across multilayer biological networks. Use this skill when you need to identify key driver genes and characterize the functional consequences of molecular alterations in pediatric cancer or other complex diseases."
homepage: https://workflowhub.eu/workflows/250
---
# multiAffinity

## Overview

[multiAffinity](https://workflowhub.eu/workflows/250) is a Common Workflow Language (CWL) pipeline designed to analyze how gene dysregulation propagates across multilayer networks. By integrating transcriptomic data—such as RNA-seq—with network-based approaches, the workflow identifies key genes and modules associated with specific diseases, with particular applications in pediatric cancer research.

The workflow utilizes community-detection algorithms to uncover structural patterns within complex biological networks. It maps dysregulation signals onto these layers to pinpoint central drivers of disease phenotypes and characterize the connectivity between affected genes. Detailed technical guidance and implementation instructions are available in the [official documentation](https://marbatlle.github.io/multiAffinity/).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| counts |  | File[] | Count Matrices of the RNA-Seq studies - List of input CSV files, separated by commas |
| metadata |  | File[] | Metadata of the RNA-Seq studies - List of input CSV files, separated by commas |
| layers |  | File[]? | Layers of the multilayer networks - List of input CSV files, separated by commas |
| approach |  | string? | Computes correlation on each community or respect all genes, local or global approach (default is local) |
| output_dir |  | string? | Defines name for output folder |
| padj |  | string? | Sets significance value for DESeq2, RRA, and Spearman's Corr (default is 0.05) |
| LFC |  | string? | Defines whether self loops are removed or not, takes values 0 or 1 (default is 1) |
| control_id |  | string? | Defines metadata label for the control samples (default is Normal) |
| multiXrank_r |  | string? | Global restart probability for multiXrank, given by float between 0 and 1 (default is 0.15) |
| multiXrank_selfloops |  | int? | Defines whether self loops are removed or not, takes values 0 or 1 (default is 1) |
| Molti_modularity |  | int? | Sets Newman modularity resolution parameter on molTI-DREAM (default is 1) |
| Molti_Louvain |  | int? | Switches to randomized Louvain on molTI-DREAM and sets num. of randomizations (default is 5) |
| min_nodes |  | int? | Defines minimum number of nodes required to describe a community (default is 7) |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| tool | tool |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| output |  | Directory | Contains degs, communities and affinity information |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/250
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
