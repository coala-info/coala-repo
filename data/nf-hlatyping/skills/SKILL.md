---
name: hlatyping
description: This pipeline performs 4-digit HLA genotyping from DNA or RNA sequencing data using OptiType for class I alleles and optionally HLA-HD for class I and II loci. Use when analyzing whole exome, genome, or transcriptome data to identify major and minor HLA-I loci through integer linear programming or when class II typing is required via a local HLA-HD installation.
homepage: https://github.com/nf-core/hlatyping
---

## Overview
nf-core/hlatyping is designed to solve the problem of Human Leukocyte Antigen (HLA) typing using next-generation sequencing data. It maps reads against a reference of known MHC class I alleles and uses integer linear programming to find allele combinations that maximize the number of explained reads.

The pipeline accepts FASTQ or BAM files from various sequencing modalities and produces high-resolution HLA genotyping predictions. While OptiType is the default for class I typing, the pipeline can also integrate HLA-HD for broader class I and II coverage if the user provides the necessary licensed software distribution.

## Data preparation
The pipeline requires a comma-separated samplesheet provided via the `--input` parameter. This file must contain columns for sample IDs, sequencing type, and paths to FASTQ or BAM files.

**Samplesheet columns:**
- `sample`: Unique sample identifier (no spaces).
- `fastq_1`: Path to first-read FASTQ file (`.fastq.gz` or `.fq.gz`).
- `fastq_2`: Path to second-read FASTQ file for paired-end data.
- `seq_type`: Sequencing type, either `dna` or `rna`.
- `bam`: Optional path to a BAM file.

Example `samplesheet.csv`:
```csv
sample,fastq_1,fastq_2,seq_type
CONTROL_REP1,AEG588A1_S1_L002_R1_001.fastq.gz,AEG588A1_S1_L002_R2_001.fastq.gz,dna
```

If using HLA-HD, you must provide the path to the software tarball using `--hlahd_path`. Reference genomes can be specified using the `--genome` parameter (e.g., `--genome GRCh38`) to utilize iGenomes.

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to use `-profile` for software management (e.g., `docker`, `singularity`, or `conda`) and `-r` to pin a specific version.

```bash
nextflow run nf-core/hlatyping \
    -profile docker \
    --input samplesheet.csv \
    --outdir ./results \
    -r 2.1.0
```

**Key Parameters:**
- `--tools`: Specifies the tool(s) to use; defaults to `optitype`, but can include `hlahd`.
- `--solver`: Choose the integer programming solver for OptiType, either `glpk` (default) or `cbc`.
- `--enumerations`: Number of suboptimal solutions OptiType should output (default: 1).
- `-resume`: Use this Nextflow flag to restart a pipeline from the last cached step.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary deliverables include:

- **HLA Typing Results:** 4-digit HLA genotyping predictions from OptiType or HLA-HD.
- **MultiQC Report:** A summary report (`multiqc_report.html`) aggregating quality control metrics from FastQC and tool-specific logs.
- **Intermediate Files:** Optional merged FASTQ files if `--save_merged_fastq` is enabled.

For a detailed description of all output files, refer to the [official output documentation](https://nf-co.re/hlatyping/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
