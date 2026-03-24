---
name: cosifer
description: "This CWL workflow utilizes the COSIFER framework to reconstruct molecular interaction networks from high-throughput data by integrating multiple inference methods into a consensus model. Use this skill when you need to identify robust gene regulatory relationships or protein-protein interactions to characterize the molecular landscape of complex diseases like pediatric cancer."
homepage: https://workflowhub.eu/workflows/118
---
# COSIFER

## Overview

[COSIFER](https://workflowhub.eu/workflows/118) (COnSensus Interaction Network InFErence Service) is a Common Workflow Language (CWL) implementation of a framework designed to reconstruct molecular interaction networks. It utilizes a consensus approach that integrates multiple inference methods and data sources to produce more robust and reliable network models than single-method alternatives.

The workflow is primarily used for analyzing high-throughput biological data, such as RNA-seq, and is tagged for applications in cancer and pediatric research. By combining different algorithmic predictions, it identifies consistent biological interactions across various datasets.

This implementation executes the core `cosifer` tool as a single integrated step. It is based on the Python package and methodology detailed in [Manica et al. (2020)](https://doi.org/10.1093/bioinformatics/btaa942) and is released under the Apache-2.0 license.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| data_matrix |  | File | Gene expression data matrix |
| gmt_filepath |  | File? | Optional GMT file to perform inference on multiple gene sets |
| index_col |  | int? | Column index in the data. Defaults to None, a.k.a., no index |
| outdir |  | string | Path to the output directory |
| separator |  | string? | Separator for the data. Defaults to . |
| samples_on_rows |  | boolean? | Flag that indicates that data contain the samples on rows. Defaults to False. |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| cosifer | cosifer |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| resdir |  | Directory |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/118
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
