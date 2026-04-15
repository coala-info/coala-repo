---
name: readsimulator
description: This pipeline generates simulated sequencing reads for amplicon, target capture, metagenome, and whole-genome data using a samplesheet of names and seeds, reference FASTA files, or NCBI accessions. Use when creating synthetic Illumina or PacBio FASTQ datasets to benchmark bioinformatics tools or validate pipeline configurations across different genomic modalities.
homepage: https://github.com/nf-core/readsimulator
---

# readsimulator

## Overview
nf-core/readsimulator is a comprehensive workflow designed to produce synthetic sequencing data for a variety of biological applications. It integrates specialized simulation engines such as ART for amplicons, Japsa capsim for target capture, InsilicoSeq for metagenomes, and wgsim for whole-genome sequencing into a unified framework.

The pipeline automates the retrieval of reference sequences—either from local files, iGenomes, or direct NCBI downloads—and applies user-defined error models and abundance profiles. In addition to generating raw FASTQ files, it provides quality control reports and a ready-to-use samplesheet for downstream analysis pipelines.

## Data preparation
The primary input is a comma-separated samplesheet specified with the `--input` parameter. This file defines the sample identifiers and the seeds used for random read generation to ensure reproducibility.

`samplesheet.csv` example:
```csv
sample,seed
sample_1,1
sample_2,4
```

Depending on the simulation mode, additional reference data is required:
- **General Reference:** A FASTA file (`--fasta`), an iGenomes ID (`--genome`), or a list of NCBI accessions (`--ncbidownload_accessions`).
- **Target Capture:** A bait/probe file in FASTA or BED format (`--probe_file`) or a pre-defined probe set name (`--probe_ref_name`).
- **Metagenomics:** Optional TSV files for abundance (`--metagenome_abundance_file`) or coverage (`--metagenome_coverage_file`) distributions.
- **Amplicons:** Forward and reverse primer sequences (defaults provided, or via `--amplicon_fw_primer` and `--amplicon_rv_primer`).

## How to run
The pipeline must be executed with one of the four simulation mode flags: `--amplicon`, `--target_capture`, `--metagenome`, or `--wholegenome`. Use `-profile` to specify the software container engine (e.g., `docker`, `singularity`, or `conda`).

```bash
nextflow run nf-core/readsimulator \
    -profile <docker/singularity/conda> \
    -r 1.0.0 \
    --input samplesheet.csv \
    --wholegenome \
    --outdir ./results
```

To resume a previous run that was interrupted, add the `-resume` flag. Specific simulation parameters, such as read length (`--amplicon_read_length`) or error rates (`--wholegenome_error_rate`), can be adjusted via the command line or a parameters file.

## Outputs
Results are placed in the directory defined by `--outdir`. The most important files include:
- **Simulated Reads:** FASTQ files for each sample defined in the input.
- **Generated Samplesheet:** A CSV file (header: `sample,fastq_1,fastq_2`) mapping the simulated files for immediate use in other pipelines.
- **Reports:** A MultiQC HTML report summarizing the simulation statistics and FastQC results.

For a complete list of output files and their formats, refer to the official documentation at [https://nf-co.re/readsimulator/output](https://nf-co.re/readsimulator/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)