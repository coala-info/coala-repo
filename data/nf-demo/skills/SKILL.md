---
name: demo
description: This pipeline processes single or paired-end FASTQ files through quality control and adapter trimming using FastQC and seqtk to produce MultiQC reports and cleaned sequence data. Use when running bioinformatics workshops or demonstrations that require a simplified, fast-executing workflow to illustrate core pipeline concepts and quality assessment.
homepage: https://github.com/nf-core/demo
---

# demo

## Overview
nf-core/demo is a streamlined bioinformatics pipeline built for workshops and demonstrations. It addresses the need for a fast-running example workflow that mimics standard production pipelines while remaining accessible for educational purposes.

The pipeline takes raw sequencing data and performs essential preprocessing tasks, including quality assessment and read trimming. It outputs standardized reports and processed files, making it a practical tool for teaching Nextflow and nf-core best practices.

## Data preparation
The pipeline requires a samplesheet in CSV, TSV, JSON, or YAML format. This file must contain sample identifiers and paths to FASTQ files.

`samplesheet.csv` structure:
- `sample`: Unique sample name without spaces.
- `fastq_1`: Path to the first read file (must be compressed `.fastq.gz` or `.fq.gz`).
- `fastq_2`: Path to the second read file for paired-end data (optional).

Example `samplesheet.csv`:
```csv
sample,fastq_1,fastq_2
SAMPLE1_PE,sample1_R1.fastq.gz,sample1_R2.fastq.gz
SAMPLE2_SE,sample2_R1.fastq.gz,
```

Reference genome files can be provided via `--fasta` or by specifying an iGenomes ID with `--genome`. If using `--fasta`, the pipeline can automatically generate a BWA index.

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to test the installation first using the `test` profile.

```bash
# Test the pipeline
nextflow run nf-core/demo -profile test,docker --outdir ./results

# Run with custom data
nextflow run nf-core/demo \
    -profile <docker/singularity/conda> \
    --input samplesheet.csv \
    --outdir ./results
```

Key parameters:
- `-profile`: Execution environment (e.g., `docker`, `singularity`, `conda`).
- `--input`: Path to the samplesheet.
- `--outdir`: Path to the results directory.
- `--skip_trim`: Skip the trimming step using seqtk.
- `-resume`: Restart the pipeline from the last cached step.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary deliverable is the MultiQC report, which aggregates quality metrics from all samples.

- `multiqc/`: Contains the `multiqc_report.html` for an overview of read quality and trimming statistics.
- `fastqc/`: Raw and trimmed read quality control plots.
- `seqtk/`: Trimmed FASTQ files (if trimming is not skipped).

For a detailed description of all output files, refer to the [official output documentation](https://nf-co.re/demo/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/CONTRIBUTING.md`](references/docs/CONTRIBUTING.md)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)