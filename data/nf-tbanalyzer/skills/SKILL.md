---
name: tbanalyzer
description: nf-core/tbanalyzer provides a toolkit for the genomic characterization of Mycobacterium tuberculosis (Mtb) pathogens at the species and strain levels using FASTQ inputs, a CSV samplesheet, and reference genomes. Use when performing TB-GVAS analysis to generate quality control reports and strain-level characterizations from single-end or paired-end sequencing data.
homepage: https://github.com/nf-core/tbanalyzer
---

## Overview
nf-core/tbanalyzer is designed for the genomic characterization of *Mycobacterium tuberculosis* (Mtb) pathogens. It provides a comprehensive toolkit for identifying species and strain levels from raw sequencing data, facilitating the democratization of Mtb genomic analysis.

The pipeline processes raw FASTQ files to produce quality control metrics and genomic characterization results. It helps researchers and clinicians understand the genomic makeup of Mtb samples through a standardized workflow that integrates read quality assessment and comparative genomics.

## Data preparation
The pipeline requires a comma-separated (CSV) samplesheet and reference genome information. The samplesheet must contain columns for sample names, library preparation protocols, and paths to FASTQ files.

**Samplesheet requirements:**
- `sample`: Unique sample identifier (no spaces).
- `library`: Library preparation protocol name (no spaces).
- `fastq_1`: Path to the first FASTQ file (must end in `.fq.gz` or `.fastq.gz`).
- `fastq_2`: Path to the second FASTQ file for paired-end data (optional).

Example `samplesheet.csv`:
```csv
sample,library,fastq_1,fastq_2
SAMPLE1,lib1,SAMPLE1_R1.fastq.gz,SAMPLE1_R2.fastq.gz
SAMPLE2,lib1,SAMPLE2_R1.fastq.gz,
```

**Reference Genome:**
- Use `--genome <ID>` to specify an iGenomes reference.
- Alternatively, provide a custom FASTA file using `--fasta <path/to/genome.fasta>`. This is mandatory if `--genome` is not specified.

## How to run
The pipeline is executed using Nextflow with the `run` command. It is recommended to use a specific profile for software management (e.g., Docker, Singularity, or Conda) and to pin the pipeline version for reproducibility.

```bash
nextflow run nf-core/tbanalyzer \
    -r 1.0.0 \
    -profile <docker/singularity/conda> \
    --input samplesheet.csv \
    --outdir <RESULTS_DIR>
```

Use `-resume` to restart a run from the last successful step if it was interrupted. To test the pipeline with a minimal dataset, use `-profile test`.

## Outputs
Results are saved in the directory specified by the `--outdir` parameter. The primary deliverables include:

- **MultiQC Report**: A summary report aggregating quality control metrics from FastQC and other tools, typically found in the top level of the output directory.
- **QC Results**: Individual FastQC reports for raw sequencing reads.
- **Analysis Results**: Genomic characterization data at the species and strain levels.

For a detailed description of all output files and how to interpret them, refer to the [official output documentation](https://nf-co.re/tbanalyzer/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
