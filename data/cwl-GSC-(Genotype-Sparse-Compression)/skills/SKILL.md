---
name: gsc-genotype-sparse-compression
description: This CWL workflow utilizes the Genotype Sparse Compression (GSC) tool to perform high-ratio lossless or lossy compression and decompression of genomic variant data in VCF or BCF formats. Use this skill when managing massive population-scale sequencing datasets to minimize storage footprints while maintaining rapid query access for downstream genomic analysis.
homepage: https://github.com/luo-xiaolong/GSC.git
metadata:
  docker_image: "N/A"
---

# gsc-genotype-sparse-compression

## Overview

The [GSC (Genotype Sparse Compression)](https://github.com/luo-xiaolong/GSC.git) workflow provides a highly efficient solution for the lossless compression of VCF and BCF files. By utilizing advanced sparse compression techniques, it significantly reduces storage requirements—demonstrated by compressing 800GB of 1000 Genomes Project data down to approximately 1GB—while maintaining fast query and decompression capabilities.

This [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/885) implementation automates the compression and decompression processes. It supports both lossless (default) and lossy modes, allowing users to manage large-scale genomic datasets with customizable parameters for multi-threading, ploidy settings, and replication depth.

During decompression or querying, the workflow supports several optional components:
* **Range and Sample Filtering:** Extract specific genomic coordinates or subsets of samples.
* **Attribute Filtering:** Include or exclude sites based on Allele Count (AC), Allele Frequency (AF), or Quality (QUAL) scores.
* **Output Customization:** Generate BCF or VCF formats, with options to suppress headers or genotypes to streamline downstream analysis.

## Inputs

_None listed._


## Steps

_Step list is not in the RO-Crate metadata; open the main workflow CWL below or see WorkflowHub for the diagram._


## Outputs

_None listed._


## Files

- WorkflowHub: https://workflowhub.eu/workflows/885
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata