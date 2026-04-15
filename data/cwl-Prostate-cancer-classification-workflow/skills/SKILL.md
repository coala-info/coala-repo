---
name: prostate-cancer-classification-workflow
description: This CWL workflow processes H&E whole slide images using AI-based tools to perform multi-resolution tissue segmentation and prostate cancer classification. Use this skill when you need to automate the detection of malignant tissue and characterize the spatial distribution of tumors within prostate histopathology specimens.
homepage: https://workflowhub.eu/workflows/1329
metadata:
  docker_image: "N/A"
---

# prostate-cancer-classification-workflow

## Overview

This [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/1329) workflow automates the segmentation and classification of prostate cancer from H&E whole slide images using artificial intelligence. It is designed to optimize computational efficiency by filtering regions of interest before performing high-resolution analysis.

The process follows a three-step execution logic:
*   **Initial Segmentation:** Performs low-resolution tissue segmentation to identify relevant areas for processing.
*   **Border Refinement:** Uses the low-resolution masks to perform high-resolution tissue segmentation, ensuring precise border detection.
*   **Cancer Classification:** Analyzes the identified tissue regions at high resolution to classify areas as either normal or cancerous.

Licensed under the MIT license, this workflow provides a standardized pipeline for digital pathology research and diagnostic tool development.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| #main/gpu |  | null, int |  |
| #main/slide |  | File |  |
| #main/tissue-high-batch-size |  | null, int |  |
| #main/tissue-high-chunk-size |  | null, int |  |
| #main/tissue-high-filter |  | string |  |
| #main/tissue-high-label |  | string |  |
| #main/tissue-high-level |  | int |  |
| #main/tissue-low-batch-size |  | null, int |  |
| #main/tissue-low-chunk-size |  | null, int |  |
| #main/tissue-low-label |  | string |  |
| #main/tissue-low-level |  | int |  |
| #main/tumor-batch-size |  | null, int |  |
| #main/tumor-chunk-size |  | null, int |  |
| #main/tumor-filter |  | string |  |
| #main/tumor-label |  | string |  |
| #main/tumor-level |  | int |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| #main/classify-tumor | #main/classify-tumor |  |
| #main/extract-tissue-high | #main/extract-tissue-high |  |
| #main/extract-tissue-low | #main/extract-tissue-low |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| #main/tissue |  | File |  |
| #main/tumor |  | File |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1329
- `classify_tumor.cwl` — workflow definition (CWL)
- `extract_tissue.cwl` — workflow definition (CWL)
- `pca_classification_workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata