---
name: indices-builder-from-gbol-rdf-ttl
description: This CWL workflow converts annotated genomes in GBOL RDF format into FASTA and GTF files to generate alignment and quantification indices using STAR, bowtie2, and kallisto. Use this skill when preparing reference genomic and transcriptomic data for sequence alignment, read mapping, or gene expression quantification from semantically annotated sources.
homepage: https://m-unlock.com
metadata:
  docker_image: "N/A"
---

# indices-builder-from-gbol-rdf-ttl

## Overview

This [CWL workflow](https://workflowhub.eu/workflows/75) automates the generation of genomic and transcriptomic indices required for sequence alignment and quantification. It is designed to process annotated genomes provided in the GBOL RDF (TTL) format, ensuring compatibility between semantic data sources and standard bioinformatics pipelines.

The process begins by utilizing SAPP tools to extract reference sequences and annotations, converting the RDF input into GTF and FASTA formats. These intermediate files are then used to build indices for several widely used alignment and mapping tools.

The workflow produces the following components:
*   **Bowtie2 and Kallisto indices**: Standard outputs for DNA-seq alignment and RNA-seq pseudo-alignment.
*   **STAR index**: An optional component typically generated for genomes of eukaryotic origin to support splice-aware alignment.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| threads | number of threads | int? | number of threads to use for computational processes |
| memory | maximum memory usage in megabytes | int? | maximum memory usage in megabytes |
| inputFile | turtle file | File | Annotated genome in GBOL turtle file (.ttl) format |
| run_star | Run STAR | boolean | create STAR index for genome if true. (For genomes with exons) |
| genomeSAindexNbases | STAR parameter | int? | For small genomes, the parameter --genomeSAindexNbases must be scaled down. |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| rdf2gtf | RDF to GTF | Convert input RDF (turtle) file to GTF file |
| rdf2fasta | RDF to Fasta | Convert input RDF (turtle) file to Genome fasta file. |
| STAR | STAR index | Creates STAR index with genome fasta and GTF file |
| bowtie2 | bowtie2 index | Creates bowtie2 index with genome fasta |
| kallisto | kallisto index | Creates kallisto index with transcripts fasta file |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| STAR | STAR | Directory | STAR index folder |
| bowtie2 | bowtie2 | Directory | bowtie2 index folder |
| kallisto | kallisto | Directory | kallisto index folder |
| genomefasta | Genome fasta | File | Genome fasta file |
| gtf | GTF | File | Genes in GTF format |
| transcripts | Transcripts | File | Transcripts fasta file |
| proteins | Proteins | File | Proteins fasta file |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/75
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata