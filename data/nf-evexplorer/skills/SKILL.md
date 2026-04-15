---
name: evexplorer
description: The pipeline processes single-end or paired-end FASTQ reads using a CSV samplesheet and requires either a FASTA reference or an iGenomes identifier to perform quality control and sequence analysis. Use when analyzing experimental data with defined batches and conditions, such as normal versus disease states, to produce consolidated MultiQC reports and analysis deliverables.
homepage: https://github.com/nf-core/evexplorer
---

# evexplorer

## Overview
The evexplorer pipeline provides a standardized framework for the bioinformatics analysis of sequencing data, focusing on quality control and initial processing. It streamlines the transition from raw FASTQ files to interpreted results by integrating reference genome alignment and quality assessment tools.

Users provide experimental metadata including sample identifiers and conditions, which the pipeline uses to organize the analysis. The primary goal is to ensure data integrity through comprehensive reporting before proceeding to downstream biological interpretation.

## Data preparation
The pipeline requires a CSV samplesheet specified with the `--input` parameter. This file must contain a header and define the relationships between samples, their raw data, and experimental groupings.

`samplesheet.csv` structure:
- `sample`: Unique sample identifier (no spaces).
- `fastq_1`: Path to the first read file (`.fastq.gz` or `.fq.gz`).
- `fastq_2`: Path to the second read file for paired-end data (optional).
- `batch`: Integer indicating the sequencing batch (must be 1 or 2).
- `condition`: Experimental state, either `normal` or `disease`.

Example `samplesheet.csv`:
```csv
sample,fastq_1,fastq_2,batch,condition
CONTROL_REP1,AEG588A1_R1.fastq.gz,AEG588A1_R2.fastq.gz,1,normal
TREATED_REP1,AEG588A2_R1.fastq.gz,AEG588A2_R2.fastq.gz,2,disease
```

A reference genome is required, provided either via an iGenomes ID using `--genome` (e.g., `GRCh38`) or a path to a FASTA file using `--fasta`. If using `--fasta`, the pipeline can automatically generate required indices.

## How to run
Execute the pipeline using the `nextflow run` command. It is recommended to test the installation with the provided test profile before running on actual data.

```bash
nextflow run nf-core/evexplorer \
  -profile docker \
  --input samplesheet.csv \
  --outdir ./results \
  --genome GRCh38
```

Key parameters:
- `-profile`: Execution environment (e.g., `docker`, `singularity`, `conda`).
- `--outdir`: Path to save results.
- `-resume`: Re-run the pipeline from the last successful step if interrupted.
- `-r`: Specify a specific version or release of the pipeline (e.g., `-r 1.0.0`).

## Outputs
Results are saved in the directory specified by `--outdir`. The most critical file for initial review is the MultiQC report, which aggregates quality control metrics from FastQC and other processing steps.

Key output locations:
- `multiqc/`: Contains the `multiqc_report.html` for a summary of the entire run.
- `fastqc/`: Individual quality control reports for each input FASTQ file.

For a complete description of all generated files, refer to the [official output documentation](https://nf-co.re/evexplorer/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)