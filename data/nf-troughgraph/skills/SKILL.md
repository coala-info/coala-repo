---
name: troughgraph
description: The pipeline ingests single or paired-end FASTQ files via a CSV samplesheet and utilizes reference genomes to provide a quantitative assessment of permafrost landscapes and thaw levels. Use when monitoring permafrost regions to evaluate the extent of environmental degradation or thaw using high-throughput sequencing data.
homepage: https://github.com/nf-core/troughgraph
---

## Overview
nf-core/troughgraph is designed for the quantitative assessment of underlying permafrost landscapes and the extent of permafrost thaw in a region. It bridges genomic data with environmental monitoring by processing sequencing reads against reference genomes to characterize landscape-level changes.

The pipeline accepts raw sequencing data in FASTQ format and generates quality control reports alongside specific assessments of permafrost conditions. Users receive standardized outputs that facilitate the comparison of thaw levels across different geographical sites or time points.

## Data preparation
Users must provide a CSV samplesheet via the `--input` parameter. The file requires a header and three columns: `sample`, `fastq_1`, and `fastq_2` (optional for single-end). FastQ files must be Gzipped and use the `.fq.gz` or `.fastq.gz` extension.

Example `samplesheet.csv`:
```csv
sample,fastq_1,fastq_2
CONTROL_REP1,AEG588A1_S1_L002_R1_001.fastq.gz,AEG588A1_S1_L002_R2_001.fastq.gz
```

Reference genome files are required for the workflow. Specify a reference using `--genome` to use iGenomes, or provide a path to a FASTA file with `--fasta`. If a BWA index is not provided when using a custom FASTA, the pipeline will generate one automatically.

## How to run
Execute the pipeline using the `nextflow run` command. It is recommended to use `-profile` for software management (e.g., `docker`, `singularity`, or `conda`) and `-r` to pin a specific pipeline release.

```bash
nextflow run nf-core/troughgraph \
  -profile docker \
  -r 1.0.0 \
  --input samplesheet.csv \
  --outdir ./results
```

Use `-resume` to restart a run from the last successful step if it was interrupted. Pipeline parameters should be provided via the command line or a `-params-file`; do not use the `-c` option for parameters.

## Outputs
Results are saved in the directory specified by the `--outdir` parameter. Primary deliverables include quality control reports from FastQC and a consolidated MultiQC report that summarizes the run statistics.

The pipeline also produces quantitative assessments of permafrost landscapes. For a detailed description of all output files and how to interpret the results, refer to the [official output documentation](https://nf-co.re/troughgraph/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
