---
name: atacseq
description: This pipeline performs ATAC-seq analysis starting from raw FASTQ files, supporting multiple aligners like BWA, Bowtie2, and STAR, and requires a reference genome or iGenomes ID to produce filtered BAM files, MACS2 peak calls, and DESeq2 differential accessibility reports. Use when analyzing chromatin accessibility data from single-end or paired-end reads to identify open chromatin regions, generate consensus peaksets, and visualize results via MultiQC or IGV sessions.
homepage: https://github.com/nf-core/atacseq
---

## Overview
nf-core/atacseq provides a comprehensive workflow for analyzing ATAC-seq data, addressing the need for reproducible identification of open chromatin regions across biological replicates. It handles the transition from raw sequencing reads to high-level analysis, including library complexity estimation, peak calling, and statistical testing for differential accessibility between conditions.

The pipeline accepts FASTQ files and produces a variety of outputs including aligned and filtered BAM files, normalized bigWig tracks for visualization, and annotated peak sets. It integrates quality control at every stage, culminating in a MultiQC report and an ATAC-seq specific ataqv report to assess the success of the transposition and sequencing.

## Data preparation
Users must provide a comma-separated samplesheet via the `--input` parameter. The file requires a header and specific columns for sample names, FASTQ paths, and replicate numbers.

- `sample`: Unique name for the sample.
- `fastq_1`: Path to the first-read FASTQ file (must end in `.fastq.gz` or `.fq.gz`).
- `fastq_2`: Path to the second-read FASTQ file for paired-end data (optional).
- `replicate`: Integer starting from 1 representing the biological replicate.
- `control`: Optional sample name to be used as a control.

Example `samplesheet.csv`:
```csv
sample,fastq_1,fastq_2,replicate
CONTROL,AEG588A1_R1.fastq.gz,AEG588A1_R2.fastq.gz,1
CONTROL,AEG588A2_R1.fastq.gz,AEG588A2_R2.fastq.gz,2
TREATMENT,AEG588B1_R1.fastq.gz,AEG588B1_R2.fastq.gz,1
```

Reference requirements include a genome FASTA and GTF/GFF annotation. These can be provided automatically using `--genome` (e.g., `GRCh38`) or manually via `--fasta` and `--gtf`. If using MACS2 for peak calling, an effective genome size must be provided via `--macs_gsize` or inferred from the `--read_length` and `--genome` parameters.

## How to run
Execute the pipeline using the `nextflow run` command. It is recommended to specify a container profile like `-profile docker` or `-profile singularity`.

```bash
nextflow run nf-core/atacseq \
    --input samplesheet.csv \
    --outdir ./results \
    --genome GRCh38 \
    --read_length 100 \
    -profile docker
```

Key parameters include:
- `--aligner`: Choose between `bwa` (default), `bowtie2`, `chromap`, or `star`.
- `--narrow_peak`: Use this flag to run MACS2 in narrowPeak mode; otherwise, it defaults to broad peaks.
- `--read_length`: Required to calculate or retrieve the correct MACS2 genome size if not using `--macs_gsize`.
- `-resume`: Use this Nextflow flag to restart a run from the last successful step.
- `-r`: Pin a specific version of the pipeline (e.g., `-r 2.1.2`).

## Outputs
All results are saved to the directory specified by `--outdir`. The primary summary of the run is the `multiqc/multiqc_report.html` file, which aggregates QC metrics from all tools.

Key output directories include:
- `bwa/library/`: Filtered and processed BAM files.
- `bwa/merged_library/macs2/`: Peak calls in BED and XLS formats.
- `bwa/merged_library/deseq2/`: Differential accessibility results, including PCA plots and heatmaps.
- `ataqv/`: ATAC-seq specific quality control reports.
- `igv/`: An IGV session file for integrated visualization of tracks and peaks.

For a complete description of all output files, refer to the official [output documentation](https://nf-co.re/atacseq/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
