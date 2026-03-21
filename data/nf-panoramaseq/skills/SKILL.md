---
name: panoramaseq
description: This pipeline processes sequencing-based spatial transcriptomics data from in-situ arrays using FASTQ samplesheets and reference genome sequences to produce quality control metrics and analysis deliverables. Use when performing spatial transcriptomics analysis requiring standardized read QC with FastQC and aggregated reporting via MultiQC.
homepage: https://github.com/nf-core/panoramaseq
---

## Overview
nf-core/panoramaseq is designed to handle the complexities of sequencing-based spatial transcriptomics data derived from in-situ arrays. It automates the processing of raw sequencing reads to provide researchers with data suitable for downstream spatial analysis.

The pipeline accepts raw FASTQ files and maps them against a provided reference genome. It integrates standard quality control tools to ensure data integrity and provides a consolidated view of the experiment's performance across all samples.

## Data preparation
Users must provide a comma-separated samplesheet containing the paths to sequencing data. The file must include a header and follow a specific column structure.

`samplesheet.csv` example:
```csv
sample,fastq_1,fastq_2
CONTROL_REP1,AEG588A1_S1_L002_R1_001.fastq.gz,AEG588A1_S1_L002_R2_001.fastq.gz
```

- **FASTQ files**: Must be compressed (`.fastq.gz` or `.fq.gz`). Both single-end and paired-end data are supported.
- **Reference Genome**: A FASTA file must be provided via `--fasta` unless a pre-configured iGenomes ID is specified using `--genome`.
- **Constraints**: Sample names must not contain spaces. The samplesheet must be a CSV file.

## How to run
The pipeline is executed using Nextflow with the `--input` and `--outdir` parameters. It is recommended to use a container profile (e.g., Docker or Singularity) for reproducibility.

```bash
nextflow run nf-core/panoramaseq \
   -profile docker \
   --input samplesheet.csv \
   --outdir ./results \
   --fasta reference.fasta
```

Use `-resume` to restart a run from the last successful step if it was interrupted. Specific pipeline versions can be pinned using the `-r` flag. Pipeline parameters should be provided via the CLI or a `-params-file`, while custom configuration files should be provided via `-c`.

## Outputs
Results are saved in the directory specified by the `--outdir` parameter. The primary summary of the run is the MultiQC report, which aggregates statistics from FastQC and other processing steps.

Key output locations:
- `multiqc/`: Contains the `multiqc_report.html` for a high-level overview of the data quality.
- `fastqc/`: Contains individual quality control reports for each input FASTQ file.

For a comprehensive list of output files and their formats, refer to the [official output documentation](https://nf-co.re/panoramaseq/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
