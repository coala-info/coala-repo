---
name: genomeskim
description: nf-core/genomeskim performs quality control and filtering of genome skims followed by organelle assembly or genome analysis using FASTQ inputs, CSV samplesheets, and optional reference genomes to produce filtered reads and assembly results. Use when processing low-coverage genomic data for organelle assembly or genome analysis to ensure standardized and reproducible bioinformatics results.
homepage: https://github.com/nf-core/genomeskim
---

# genomeskim

## Overview
nf-core/genomeskim is a bioinformatics pipeline designed for the analysis of genome skims, which are typically low-coverage sequencing datasets. It solves the problem of inconsistent processing by providing a best-practice workflow for read filtering, quality assessment, and subsequent assembly of organelles or genomic components.

In practice, the pipeline transforms raw sequencing reads into filtered datasets and assembled sequences. Users receive comprehensive quality reports and processed genomic data ready for downstream evolutionary or comparative analysis.

## Data preparation
The pipeline requires a CSV samplesheet provided via the `--input` parameter. This file must include a header and define the sample names and paths to paired-end or single-end FASTQ files.

Example `samplesheet.csv`:
```csv
sample,fastq_1,fastq_2
SAMPLE1,reads_1.fastq.gz,reads_2.fastq.gz
```
- `sample`: Unique identifier for the sample (no spaces).
- `fastq_1`: Path to the first read file (required, `.fastq.gz` or `.fq.gz`).
- `fastq_2`: Path to the second read file (optional for single-end).

Reference genomes are specified using `--genome` for iGenomes identifiers or `--fasta` for a direct path to a FASTA file.

## How to run
Execute the pipeline with the `nextflow run` command, ensuring a compute profile is selected for dependency management.

```bash
nextflow run nf-core/genomeskim \
  --input samplesheet.csv \
  --outdir <OUTDIR> \
  --genome GRCh37 \
  -profile docker
```
- `-profile`: Choose from `docker`, `singularity`, `conda`, etc.
- `-resume`: Re-run the pipeline from the last completed process.
- `-r`: Pin a specific version of the pipeline (e.g., `-r 1.0.0`).

## Outputs
All results are stored in the directory defined by the `--outdir` parameter. The most important file for initial review is the MultiQC report, which provides a summary of the read quality and processing metrics.

Additional outputs include:
- FastQC reports for raw read quality.
- Pipeline execution reports in the `pipeline_info` directory.

For a full description of the directory structure and file contents, refer to the [official output documentation](https://nf-co.re/genomeskim/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)