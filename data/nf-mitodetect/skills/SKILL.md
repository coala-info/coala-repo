---
name: mitodetect
description: This pipeline performs A-Z analysis of mitochondrial NGS data using single or paired-end FASTQ inputs and reference genomes from FASTA files or iGenomes to produce processed data and MultiQC reports. Use when characterizing mitochondrial genomes or detecting variants in mitochondrial sequencing datasets where standardized quality control and reproducible processing are required.
homepage: https://github.com/nf-core/mitodetect
---

## Overview
nf-core/mitodetect is a bioinformatics pipeline designed for the comprehensive analysis of mitochondrial Next-Generation Sequencing (NGS) data. It streamlines the transition from raw sequencing reads to analyzed mitochondrial genomic information, ensuring consistency and reproducibility across different datasets.

The workflow processes raw FASTQ files against a specified mitochondrial reference genome. It generates detailed quality control metrics and processed outputs, allowing researchers to evaluate the integrity of their mitochondrial sequencing experiments and obtain results suitable for downstream analysis.

## Data preparation
Users must provide a comma-separated samplesheet via the `--input` parameter. This CSV file requires a header and specific columns for sample identification and file paths.

```csv
sample,fastq_1,fastq_2
CONTROL_REP1,AEG588A1_S1_L002_R1_001.fastq.gz,AEG588A1_S1_L002_R2_001.fastq.gz
```

- **Sample names**: Must be provided and cannot contain spaces.
- **FastQ files**: Must be compressed (`.fq.gz` or `.fastq.gz`) and cannot contain spaces in the file paths. `fastq_2` is optional for single-end data.
- **Reference Genome**: A FASTA file (`.fasta`, `.fa`, or `.fna`, optionally gzipped) must be provided via `--fasta` unless a pre-configured iGenomes ID is specified with `--genome`. If a BWA index is not provided, the pipeline will generate one automatically.

## How to run
Execute the pipeline using the `nextflow run` command. It is recommended to test the installation with the provided test profile before running on actual data.

```bash
nextflow run nf-core/mitodetect \
   -profile docker \
   --input samplesheet.csv \
   --outdir ./results
```

Key parameters include:
- `-profile`: Choose a configuration profile such as `docker`, `singularity`, `conda`, or an institutional profile.
- `--input`: Path to the samplesheet CSV file.
- `--outdir`: The output directory where results will be saved.
- `-resume`: Use this flag to restart a pipeline from the last cached step if a previous run was interrupted.
- `-r`: Specify a pipeline release version (e.g., `-r 1.0.0`) to ensure reproducibility.

## Outputs
Results are saved in the directory specified by the `--outdir` parameter. The primary summary of the run, including read quality and integrated pipeline metrics, is found in the MultiQC report.

Key deliverables include:
- **QC Reports**: Quality control metrics from FastQC and a consolidated MultiQC report.
- **Processed Data**: Results from the mitochondrial analysis stages.

For a detailed description of all output files and how to interpret them, refer to the [official output documentation](https://nf-co.re/mitodetect/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
