---
name: cwl4incorporatetssintogxf-paired-end-file
description: "This Common Workflow Language pipeline utilizes the TSSr R package to identify transcription start sites from paired-end CAGE-seq data and integrate them into existing genome annotation files. Use this skill when you need to refine gene models by accurately mapping transcription start sites and extending 5'UTR regions to better characterize the regulatory landscape of a genome."
homepage: https://workflowhub.eu/workflows/1343
---
# CWL4IncorporateTSSintoGXF (paired-end file)

## Overview

This workflow automates the identification of Transcription Start Sites (TSS) from CAGE-seq data and integrates this information, along with recalculated 5'UTR data, into existing gene annotation files (GFF/GTF). It leverages the [TSSr](https://github.com/Linlab-slu/TSSr) R package for precise TSS determination, providing a streamlined approach for enhancing functional genomics annotations.

The pipeline processes paired-end CAGE-seq reads and a reference genome to generate an updated annotation file. Key operations include:
*   Mapping CAGE-seq reads to the reference genome.
*   Identifying and quantifying TSS positions using the TSSr framework.
*   Updating the input GXF file to incorporate refined TSS and 5'UTR coordinates.

The source code and implementation details are available in the [CWL4IncorporateTSSintoGXF](https://github.com/RyoNozu/CWL4IncorporateTSSintoGXF) repository and on [WorkflowHub](https://workflowhub.eu/workflows/1343). The workflow is designed to run in containerized environments using `cwltool` and Docker to ensure reproducibility across different computing platforms.

## Inputs

_None listed._


## Steps

_Step list is not in the RO-Crate metadata; open the main workflow CWL below or see WorkflowHub for the diagram._


## Outputs

_None listed._


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1343
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
