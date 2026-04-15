---
name: nanopore-assembly-workflow-deprecated
description: This Common Workflow Language pipeline performs de novo assembly and taxonomic classification of Nanopore sequencing data using tools like Flye, Medaka, and Kraken2, with optional hybrid polishing via Pilon when Illumina reads are available. Use this skill when you need to reconstruct high-quality microbial genomes from complex environmental samples, determine taxonomic composition, or evaluate the completeness and contamination of metagenomic assemblies.
homepage: https://m-unlock.com
metadata:
  docker_image: "N/A"
---

# nanopore-assembly-workflow-deprecated

## Overview

This [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/254) workflow is designed for processing Oxford Nanopore Technologies (ONT) data, covering the pipeline from basecalled reads to (meta)assembly and binning. Note that this version is **deprecated**; users are encouraged to use the [updated hybrid assembly workflow](https://workflowhub.eu/workflows/367) for current projects.

The core pipeline performs quality control and filtering on Nanopore reads, followed by taxonomic classification using Kraken2. De-novo assembly is conducted via Flye, with subsequent polishing using Medaka and quality evaluation through metaQUAST.

When Illumina reads are provided, the workflow incorporates additional [quality filtering](https://workflowhub.eu/workflows/336?version=1) and assembly polishing using Pilon. It also supports a [binning sub-workflow](https://workflowhub.eu/workflows/64?version=11) utilizing tools such as MetaBAT2, CheckM, BUSCO, and GTDB-Tk. Source files for all tools and workflows are available in the [UNLOCK GitLab repository](https://git.wur.nl/unlock/cwl).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| identifier | Identifier used | string | Identifier for this dataset used in this workflow |
| threads | Number of threads | int? | Number of threads to use for computational processes |
| memory | Maximum memory in MB | int? | Maximum memory usage in megabytes |
| nanopore_fastq_files | Nanopore reads | string[]? | List of file paths with Nanopore raw reads in fastq format |
| illumina_forward_reads | illumina forward reads | string[]? | illumina sequenced forward read file |
| illumina_reverse_reads | illumina reverse reads | string[]? | illumina sequenced reverse file |
| use_reference_mapped_reads | Use mapped reads | boolean | Continue with reads mapped to the given reference |
| deduplicate | Deduplicate reads | boolean? | Remove exact duplicate reads (Illumina) with fastp |
| kraken_database | Kraken2 database | string | Absolute path with database location of kraken2 |
| basecall_model | Basecalling model | string | Basecalling model used with Guppy |
| metagenome | When working with metagenomes | boolean? | Metagenome option for the flye assembly |
| filter_references | Contamination reference file(s) | string[] | Reference fasta file(s) for contamination filtering |
| pilon_fixlist | Pilon fix list | string | A comma-separated list of categories of issues to try to fix |
| binning | Run binning workflow | boolean? | Run with contig binning workflow |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| workflow_quality_nanopore | Nanopore quality and filtering workflow | Quality and filtering workflow for nanopore reads |
| workflow_quality_illumina | Illumina quality and filtering workflow | Quality and filtering workflow for illumina reads |
| nanopore_kraken2 | Kraken2 Nanopore | Taxonomic classification of Nanopore reads |
| illumina_kraken2 | Kraken2 Illumina | Taxonomic classification of FASTQ reads |
| kraken2_compress | Compress kraken2 | Compress large kraken2 report file |
| kraken2_krona | Krona Kraken2 | Visualization of kraken2 with Krona |
| flye | Nanopore Flye assembly | De novo assembly of single-molecule reads with Flye |
| medaka | Medaka polishing of assembly | Medaka for polishing of assembled genome |
| metaquast_medaka | assembly evaluation | evaluation of polished assembly with metaQUAST |
| workflow_pilon | Pilon worklow | Illumina reads assembly polishing with Pilon |
| metaquast_nanopore_pilon | Illumina assembly evaluation | Illumina evaluation of pilon polished assembly with metaQUAST |
| illumina_pilon_readmapping | Read mapping | Illumina read mapping on pilon assembly for binning |
| illumina_pilon_sam_to_sorted_bam | sam conversion to sorted bam | Sam file conversion to a sorted bam file |
| workflow_binning | Binning workflow | Binning workflow to create bins |
| kraken2_files_to_folder | Kraken2 output folder | Preparation of Kraken2 output files to a specific output folder |
| flye_files_to_folder | Flye output folder | Preparation of Flye output files to a specific output folder |
| metaquast_medaka_files_to_folder | Nanopore metaQUAST output folder | Preparation of metaQUAST output files to a specific output folder |
| medaka_files_to_folder | Medaka output folder | Preparation of Medaka output files to a specific output folder |
| metaquast_pilon_files_to_folder | Illumina metaQUAST output folder | Preparation of QUAST output files to a specific output folder |
| pilon_files_to_folder | Pilon output folder | Preparation of pilon output files to a specific output folder |
| assembly_files_to_folder | Flye output folder | Preparation of Flye output files to a specific output folder |
| binning_files_to_folder | Binning output folder | Preparation of quast output files to a specific output folder |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| nanopore_quality_output | Read quality and filtering reports | Directory | Quality reports |
| illumina_quality_stats | Filtered statistics | Directory | Statistics on quality and preprocessing of the reads |
| kraken2_output | Kraken2 reports | Directory | Kraken2 taxonomic classification reports |
| assembly_output | Assembly output | Directory | Output from different assembly steps |
| binning_output | Binning output | Directory | Binning outputfolders |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/254
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata