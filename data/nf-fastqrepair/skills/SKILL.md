---
name: fastqrepair
description: This pipeline recovers corrupted FASTQ.gz files and fixes uncompliant or disordered reads using a samplesheet of single-end or paired-end data to produce cleaned FASTQ files and MultiQC reports. Use when sequencing data is truncated, contains invalid characters, or has lost read pairing, though it requires consistent file extensions within each samplesheet row.
homepage: https://github.com/nf-core/fastqrepair
---

## Overview
nf-core/fastqrepair solves the problem of corrupted or malformed sequencing data by attempting to recover reads from damaged compressed files and enforcing structural compliance. It addresses issues such as non-ACGTN characters, truncated files, and desynchronized paired-end reads that often cause downstream analysis tools to fail.

The pipeline transforms raw, potentially broken FASTQ files into a "repaired" state where reads are well-formed, properly paired, and validated for quality. Users receive cleaned sequence data alongside detailed reports documenting the specific cleaning actions taken for each sample.

## Data preparation
The pipeline requires a comma-separated samplesheet (CSV) containing paths to the FASTQ files. Sample names must not contain spaces, and files must use standard extensions such as `.fq.gz`, `.fastq.gz`, `.fq`, or `.fastq`.

**Constraints:**
- For paired-end data, both files in a single row must have the same extension (e.g., you cannot mix `.fastq.gz` and `.fastq`).
- The `fastq_2` column is optional for single-end data.

**Example samplesheet.csv:**
```csv
sample,fastq_1,fastq_2
mysampleA,sample_R1.fastq.gz,sample_R2.fastq.gz
mysampleB,sample_R3.fq,sample_R4.fq
mysampleC,sample_R5.fq.gz
```

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to use `-profile` for environment management (e.g., docker, singularity) and `-r` to specify a pipeline version.

```bash
nextflow run nf-core/fastqrepair \
   -profile <docker/singularity/institute> \
   --input samplesheet.csv \
   --outdir <OUTDIR>
```

**Key Parameters:**
- `--num_splits`: Number of chunks for parallel processing (default: 2).
- `--qin`: ASCII offset for BBMap, either 33 (Sanger) or 64 (old Solexa).
- `--alphabet`: Allowed characters in the sequence line (default: "ACGTN").
- `--skip_bbmap_repair`: Disables the re-pairing step if only format cleaning is needed.
- `--publish_all_tools`: Saves intermediate results from each tool in the output directory.
- `-resume`: Use this Nextflow flag to restart a run from the last successful step.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary deliverables include:

- **Cleaned FASTQ files**: Well-formed and repaired sequence data ready for downstream analysis.
- **Cleaning Reports**: Short textual summaries of the specific actions taken to fix or drop reads.
- **QC Reports**: FastQC results for the recovered reads and an aggregated MultiQC report.

For a detailed description of the folder structure and report interpretation, refer to the [official output documentation](https://nf-co.re/fastqrepair/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
