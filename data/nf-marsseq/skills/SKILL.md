---
name: nf-core-marsseq
description: This pipeline preprocesses single-cell MARS-seq v2.0 data using FASTQ inputs, specific Excel metadata files, and reference genomes to produce count matrices and QC reports. Use when analyzing plate-based single-cell RNA sequencing data or when an RNA velocity workflow is required via conversion to 10X v2 format for StarSolo.
homepage: https://github.com/nf-core/marsseq
---

## Overview
nf-core/marsseq is a bioinformatics pipeline designed for the preprocessing of single-cell RNA sequencing data generated using the MARS-seq v2.0 protocol. It handles the complexities of plate-based techniques, often combined with FACS, to study rare cell populations.

The pipeline transforms raw FASTQ reads into gene expression matrices while providing an optional RNA velocity workflow. By converting MARS-seq reads into a 10X v2 compatible format, it enables the use of StarSolo for studying cellular dynamics.

## Data preparation
Users must provide a CSV samplesheet and three specific Excel metadata files for each batch. The samplesheet requires the following columns: `batch`, `fastq_1`, `fastq_2`, `amp_batches`, `seq_batches`, and `well_cells`.

Required metadata files:
*   `amp_batches.xlsx`: Amplification batch information.
*   `seq_batches.xlsx`: Sequencing batch information.
*   `well_cells.xlsx`: Mapping of wells to cells.

Reference genomes (mm9, mm10, or GRCh38_v43) are downloaded from the GENCODE database. If references including ERCC spike-ins are not already available, they must be generated using the `--build_references` parameter. Custom FASTA and GTF files can be provided via `--fasta` and `--gtf` if a standard genome is not specified.

## How to run
To build references before the first analysis run:
```bash
nextflow run nf-core/marsseq \
  -profile docker \
  --genome mm10 \
  --build_references \
  --input samplesheet.csv \
  --outdir ./results
```

To run the standard analysis:
```bash
nextflow run nf-core/marsseq \
  -profile <docker/singularity/institute> \
  --genome mm10 \
  --input samplesheet.csv \
  --outdir ./results
```

To enable RNA velocity analysis, include the `--velocity` flag. Use `-r` to specify a pipeline version and `-resume` to restart a run from the last cached step. Pipeline parameters should be provided via the CLI or a `-params-file`.

## Outputs
Results are saved in the directory specified by `--outdir`. Primary outputs include gene expression matrices, StarSolo results (if velocity is enabled), and a MultiQC report summarizing sequencing quality and alignment metrics.

Detailed descriptions of all output files and reports are available in the official documentation at `https://nf-co.re/marsseq/output`.

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
