---
name: kmermaid
description: This pipeline performs comparative analysis of omes using k-mer based methods, accepting FASTQ, BAM, FASTA, or SRA inputs to generate sketches, distance matrices, and MultiQC reports. Use when comparing sequencing datasets across different modalities or organisms, especially when requiring optional pre-processing steps like rRNA removal, protein translation, or 10X BAM extraction.
homepage: https://github.com/nf-core/kmermaid
---

# kmermaid

## Overview
nf-core/kmermaid is designed for the comparative analysis of biological sequences, such as genomes or transcriptomes, using k-mer similarity methods. It provides a flexible framework to process raw sequencing data or assembled sequences into sketches that can be compared to determine distances between samples.

The pipeline handles diverse input types and includes optional pre-processing modules for read trimming, ribosomal RNA removal, and the translation of nucleotide sequences to protein. Results are consolidated into statistical summaries and a visual MultiQC report for quality assessment.

## Data preparation
The primary input is a comma-separated samplesheet provided via `--input`. This file must contain a header and at least two columns: `sample` (a unique identifier without spaces) and `fastq_1` (path to the first read file). An optional `fastq_2` column is used for paired-end data.

Example `samples.csv`:
```csv
sample,fastq_1,fastq_2
CONTROL_R1,AEG588A1_S1_L002_R1_001.fastq.gz,AEG588A1_S1_L002_R2_001.fastq.gz
```

Alternatively, the pipeline accepts direct paths to data using specific flags:
*   `--read_pairs`: Glob patterns for FASTQ files (e.g., `'data/*{R1,R2}*.fastq.gz'`).
*   `--fastas`: Glob patterns for FASTA files.
*   `--bam`: Path to a BAM file, including support for 10X Genomics archives.
*   `--sra`: SRA experiment accessions.

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to specify a pipeline release with `-r` and a configuration profile with `-profile` (e.g., `docker`, `singularity`, or `conda`).

```bash
nextflow run nf-core/kmermaid \
  -r 1.0.0 \
  --input samples.csv \
  --outdir ./results \
  -profile docker
```

For specific data types or analysis modes, use the corresponding flags:
*   **SRA data:** `nextflow run nf-core/kmermaid --sra SRP016501 --outdir ./results -profile docker`
*   **FASTA files:** `nextflow run nf-core/kmermaid --fastas '*.fasta' --outdir ./results -profile docker`
*   **Split k-mer analysis:** `nextflow run nf-core/kmermaid --input samples.csv --split_kmer --subsample 1000 --outdir ./results -profile docker`

Use `-resume` to restart a run from the last cached step if it was interrupted.

## Outputs
All results are saved to the directory specified by the `--outdir` parameter. The primary deliverables include:

*   **Sketches:** Compressed representations of the input sequences used for comparison.
*   **Distances:** Calculated similarity or distance metrics between samples.
*   **MultiQC Report:** A summary HTML file providing an overview of read quality and pipeline statistics.
*   **Statistics:** Files containing detailed metrics from the k-mer analysis.

Detailed descriptions of all output files and their formats can be found in the [official output documentation](https://nf-co.re/kmermaid/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)