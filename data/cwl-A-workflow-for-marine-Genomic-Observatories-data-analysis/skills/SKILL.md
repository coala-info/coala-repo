---
name: a-workflow-for-marine-genomic-observatories-data-analysis
description: This CWL workflow processes marine metagenomic sequencing data using the MGnify pipeline v5.1 to perform taxonomic classification and functional annotation through tools like InterProScan, EggNOG, and Diamond. Use this skill when you need to characterize the biodiversity and metabolic potential of marine microbial communities by identifying gene functions and taxonomic compositions within environmental samples.
homepage: https://www.embrc.eu/emo-bon
metadata:
  docker_image: "N/A"
---

# a-workflow-for-marine-genomic-observatories-data-analysis

## Overview

[metaGOflow](https://workflowhub.eu/workflows/384) is a Common Workflow Language (CWL) pipeline designed for the analysis of marine Genomic Observatories data. Developed as part of an EOSC-Life project, the workflow is based on the [MGnify pipeline v5.1](https://github.com/hariszaf/pipeline-v5/tree/pipeline_5.1) and is optimized for biodiversity assessment and metagenomic functional annotation.

The workflow processes metagenomic data through a series of modular steps, including quality control, taxonomic classification, and functional profiling. It is designed to be portable and reproducible, supporting execution via `cwltool` using either Docker or Singularity/Apptainer containers on standalone systems or high-performance computing (HPC) clusters.

To facilitate comprehensive analysis, the pipeline integrates several reference databases such as SILVA, eggNOG, and InterProScan. Users can customize the execution by toggling specific subworkflows and parameters within a configuration file, allowing for flexible processing of paired-end sequencing reads.

## Inputs

_None listed._


## Steps

_Step list is not in the RO-Crate metadata; open the main workflow CWL below or see WorkflowHub for the diagram._


## Outputs

_None listed._


## Files

- WorkflowHub: https://workflowhub.eu/workflows/384
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata