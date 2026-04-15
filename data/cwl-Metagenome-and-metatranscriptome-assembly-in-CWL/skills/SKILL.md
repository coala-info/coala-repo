---
name: metagenome-and-metatranscriptome-assembly-in-cwl
description: This CWL workflow performs quality control, host decontamination, and assembly of metagenomic or metatranscriptomic short-read data using metaSPAdes or MEGAHIT. Use this skill when you need to reconstruct genomes or transcripts from environmental samples to characterize microbial community composition and functional potential.
homepage: https://www.ebi.ac.uk/metagenomics
metadata:
  docker_image: "N/A"
---

# metagenome-and-metatranscriptome-assembly-in-cwl

## Overview

This workflow provides a standardized pipeline for the assembly of metagenomic and metatranscriptomic short-read data. It is designed to handle both single-end and paired-end reads, utilizing [metaSPAdes](https://github.com/ablab/spades) as the default for paired-end data and [MEGAHIT](https://github.com/voutcn/megahit) for single-end data or co-assemblies. Users can find the source code and implementation details on [WorkflowHub](https://workflowhub.eu/workflows/474).

The process is divided into three primary stages:
*   **Quality Control:** Performs adapter trimming, removal of low-quality regions, and host decontamination.
*   **Assembly:** Executes the assembly using the selected engine (metaSPAdes or MEGAHIT) based on the input data type or user configuration.
*   **Post-assembly:** Conducts secondary decontamination (Host and PhiX), filters contigs by length (minimum 500bp), and generates comprehensive assembly statistics.

To run the pipeline, users must provide BWA and BLAST indices for host decontamination. The workflow outputs include cleaned FASTQ files, archived assembly FASTA files, coverage tables, and human-readable JSON statistics. Detailed execution requires [CWLtool](https://github.com/common-workflow-language/cwltool) and can be run using the provided metagenome or metatranscriptome executables.

## Inputs

_None listed._


## Steps

_Step list is not in the RO-Crate metadata; open the main workflow CWL below or see WorkflowHub for the diagram._


## Outputs

_None listed._


## Files

- WorkflowHub: https://workflowhub.eu/workflows/474
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata