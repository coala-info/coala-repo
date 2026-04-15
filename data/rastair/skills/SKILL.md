---
name: rastair
description: Rastair is a command-line tool used for prokaryotic genome annotation via the RAST system and for analyzing DNA methylation data. Use when user asks to submit genomic assemblies for annotation, retrieve functional assignments, call methylated positions, or analyze methylation per-read.
homepage: https://bitbucket.org/bsblabludwig/rastair/src/v0.8.2/
metadata:
  docker_image: "quay.io/biocontainers/rastair:2.0.0--h03e3cfe_0"
---

# rastair

## Overview
Rastair is a command-line interface for the RAST annotation system, designed to streamline the process of prokaryotic genome labeling. It allows researchers to submit genomic assemblies (FASTA format) to the RAST server and retrieve comprehensive annotations including gene calls and functional assignments. This skill provides the necessary patterns for executing local-to-remote annotation workflows and managing the resulting data.

## Core Workflows

### Genome Annotation
The primary function is submitting a FASTA file for annotation.
- Ensure the input file contains valid DNA sequences in FASTA format.
- Use the `--email` flag to associate the job with your RAST account.
- Specify the `--domain` (Bacteria or Archaea) to ensure correct genetic code and model selection.

### Data Retrieval
Once a job is submitted, rastair can be used to poll status and download results.
- Results are typically available in multiple formats: GFF3 (for genome browsers), GenBank (for submission), and protein FASTA.
- Use the job ID provided during submission to track progress.

## CLI Best Practices
- **Batch Processing**: When annotating multiple genomes, use a loop structure to submit jobs sequentially, capturing the Job ID for each to a log file.
- **Taxonomy Specification**: Providing a specific NCBI Taxonomy ID (`--taxon`) significantly improves the accuracy of the initial gene calling and functional assignment.
- **Output Management**: Always specify an output directory to prevent file clutter, as RAST generates numerous auxiliary files (logs, intermediate features, and final annotations).



## Subcommands

| Command | Description |
|---------|-------------|
| rastair | A command-line tool for managing rastair configurations. |
| rastair | For more information, try '--help'. |
| rastair | A tool for analyzing and visualizing RNA sequencing data. |
| rastair call | Call methylated positions |
| rastair convert | Convert between different file formats |
| rastair mbias | Calculate conversion per base position in read |
| rastair per-read | Call methylation per-read This will produce a bed file that list the methylation status of all CpGs in every read that overlaps a CpG, plus some other metadata |
| rastair_view | View internal format as JSON lines |

## Reference documentation
- [Rastair Source and Usage](./references/bitbucket_org_bsblabludwig_rastair_src_v0.8.2.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_rastair_overview.md)