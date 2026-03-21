---
name: pacsomatic
description: This pipeline performs somatic analysis on PacBio HiFi read data by ingesting a samplesheet of FASTQ files and a reference genome to produce somatic variant calls, methylation profiles, and tumor clonality reports. Use when conducting comparative studies of tumor/normal pairs to identify SNVs, indels, structural variants, copy number variations, and differential methylation regions.
homepage: https://github.com/nf-core/pacsomatic
---

## Overview
nf-core/pacsomatic is a bioinformatics pipeline designed for the somatic analysis of cancer genomes using PacBio HiFi long-read data. It automates the pairing of tumor and normal alignments to facilitate comparative studies that provide insights into cancer biology.

The pipeline processes raw reads to generate a wide range of outputs, including somatic variant calls (SNV, INDEL, SV, CNV), tumor purity and clonality estimates, and methylation analysis. It also supports Homologous Recombination Deficiency (HRD) analysis via CHORD and Differential Methylation Region (DMR) detection and annotation.

## Data preparation
Users must provide a comma-separated samplesheet via the `--input` parameter. This file requires a header and contains columns for the sample identifier and paths to the FASTQ files.

`samplesheet.csv` example:
```csv
sample,fastq_1,fastq_2
TUMOR_REP1,tumor_hifi_1.fastq.gz,
NORMAL_REP1,normal_hifi_1.fastq.gz,
```

Input FASTQ files must be Gzipped and use the `.fq.gz` or `.fastq.gz` extension. While `fastq_1` is required, `fastq_2` can be used for paired-end data if applicable. A reference genome is mandatory, supplied either via a FASTA file with `--fasta` or an iGenomes identifier with `--genome`.

## How to run
Execute the pipeline using the `nextflow run` command. It is recommended to test the configuration with the `test` profile before running on production data.

```bash
nextflow run nf-core/pacsomatic \
  -profile docker \
  --input samplesheet.csv \
  --outdir ./results
```

Key parameters include:
- `-profile`: Specifies the software container engine (e.g., `docker`, `singularity`, or `conda`).
- `--outdir`: The directory where results will be saved.
- `-resume`: Restarts a run from the last completed step if it was interrupted.
- `-r`: Pins a specific version of the pipeline (e.g., `-r 1.0.0`).

## Outputs
Results are saved to the directory specified by the `--outdir` parameter. The primary summary of the run, including quality control metrics for the raw reads, is provided in the MultiQC report.

Detailed deliverables include somatic variant VCFs (SNV, SV, CNV), methylation calls, and tumor clonality reports. For a comprehensive description of all output files and how to interpret them, refer to the [official output documentation](https://nf-co.re/pacsomatic/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
