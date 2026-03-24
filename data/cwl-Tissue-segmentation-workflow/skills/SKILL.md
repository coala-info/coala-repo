---
name: tissue-segmentation-workflow
description: "This Common Workflow Language pipeline utilizes AI-based extraction tools to perform automated tissue segmentation on H&E-stained whole slide images. Use this skill when you need to isolate relevant biological regions from background artifacts in digital pathology slides to facilitate accurate downstream diagnostic or spatial analysis."
homepage: https://workflowhub.eu/workflows/1328
---
# Tissue segmentation workflow

## Overview

This [Tissue segmentation workflow](https://workflowhub.eu/workflows/1328) is a Common Workflow Language (CWL) implementation designed to automate the identification of tissue regions within H&E-stained whole slide images. By leveraging AI-driven analysis, the workflow distinguishes biological material from the slide background, providing a foundational step for downstream digital pathology and spatial analysis.

The core execution involves the `#main/extract-tissue` step, which processes high-resolution image data to generate precise segmentation masks. This workflow is open-source under the [MIT License](https://opensource.org/licenses/MIT) and can be integrated into larger computational pathology pipelines via [WorkflowHub](https://workflowhub.eu/workflows/1328).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| #main/batch-size |  | null, int |  |
| #main/chunk-size |  | null, int |  |
| #main/gpu |  | null, int |  |
| #main/level |  | int |  |
| #main/slide |  | File |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| #main/extract-tissue | #main/extract-tissue |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| #main/tissue |  | File |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1328
- `extract_tissue.cwl` — workflow definition (CWL)
- `tissue_segmentation_workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
