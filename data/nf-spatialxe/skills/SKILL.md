---
name: spatialxe
description: nf-core/spatialxe processes and performs quality control on Xenium spatialomics data using a samplesheet of FASTQ files and a reference genome. Use when analyzing Xenium datasets to generate standardized results and MultiQC reports, though note the pipeline is currently under active development.
homepage: https://github.com/nf-core/spatialxe
---

## Overview
nf-core/spatialxe is a bioinformatics pipeline designed for the processing and quality control of Xenium spatialomics data. It provides a standardized workflow to handle raw sequencing reads and reference information to produce analysis-ready results.

The pipeline addresses the need for reproducible spatial transcriptomics analysis by integrating tools for data validation and QC. It is built using Nextflow and supports containerized execution via Docker or Singularity for high portability across different compute infrastructures.

## Data preparation
The pipeline requires a comma-separated samplesheet provided via the `--input` parameter. This CSV file must contain a header and define the sample names and paths to the corresponding FASTQ files.

**Samplesheet columns:**
- `sample`: Unique identifier for the sample (cannot contain spaces).
- `fastq_1`: Path to the first read FASTQ file (must end in `.fastq.gz` or `.fq.gz`).
- `fastq_2`: Path to the second read FASTQ file (optional).

Example `samplesheet.csv`:
```csv
sample,fastq_1,fastq_2
sample1,path/to/reads_1.fastq.gz,path/to/reads_2.fastq.gz
```

A reference genome is also required. This can be specified using a pre-configured iGenomes ID via `--genome` (e.g., `--genome GRCh38`) or by providing a path to a FASTA file using `--fasta`. If `--genome` is not used, the `--fasta` parameter is mandatory.

## How to run
Execute the pipeline using the `nextflow run` command. It is recommended to specify a release version with `-r` and a container profile such as `docker` or `singularity` to ensure reproducibility.

```bash
nextflow run nf-core/spatialxe \
    -r 1.0.0 \
    -profile docker \
    --input samplesheet.csv \
    --outdir ./results \
    --genome GRCh38
```

To test the pipeline with a minimal dataset, use the built-in test profile:
```bash
nextflow run nf-core/spatialxe -profile test,docker --outdir ./test_results
```

Common Nextflow flags include `-resume` to restart a run from the last cached step and `-profile` to select software management tools (e.g., `conda`, `podman`).

## Outputs
Results are saved in the directory specified by the `--outdir` parameter. The primary deliverable for quality assessment is the MultiQC report, which aggregates statistics from various pipeline stages into a single interactive HTML file.

Key output locations:
- `multiqc/`: Contains the MultiQC report and associated data.
- `pipeline_info/`: Contains Nextflow execution reports, including trace files and resource logs.

Detailed descriptions of all output files and how to interpret them are available in the official [output documentation](https://nf-co.re/spatialxe/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
