---
name: metatdenovo
description: nf-core/metatdenovo performs de novo assembly and annotation of metatranscriptomic and metagenomic data from prokaryotes, eukaryotes, or viruses using FASTQ inputs and optional user-provided assemblies or open reading frames. Use when characterizing complex microbial communities without a reference genome to generate gene counts, functional assignments via eggNOG or KofamScan, and taxonomic classifications.
homepage: https://github.com/nf-core/metatdenovo
---

## Overview
The nf-core/metatdenovo pipeline provides a best-practice workflow for the assembly and annotation of environmental sequencing data. It addresses the challenge of identifying and quantifying genes in samples where reference genomes are missing by utilizing de novo assembly strategies for various organism types, including prokaryotes, eukaryotes, and viruses.

In practice, users provide raw sequencing reads and receive a comprehensive suite of results including assembled contigs, predicted protein-coding sequences, and standardized summary tables. The pipeline integrates quality control, read trimming, optional normalization, and multiple choices for assembly and ORF calling to suit different biological contexts.

## Data preparation
Input is defined via a CSV samplesheet containing sample identifiers and paths to FASTQ files. Files must use `.fq` or `.fastq` extensions, with optional `.gz` compression.

*   **sample**: Unique sample identifier; rows with the same name are concatenated and treated as a single sample.
*   **fastq_1**: Path to the first-read FASTQ file (required).
*   **fastq_2**: Path to the second-read FASTQ file (optional for paired-end data).

Example `samplesheet.csv`:
```csv
sample,fastq_1,fastq_2
sample1,./data/S1_R1_001.fastq.gz,./data/S1_R2_001.fastq.gz
sample2,./data/S2_fw.fastq.gz,
```

Users can optionally provide a finished assembly using `--user_assembly` to skip the assembly stage, or specific ORF files with `--user_orfs_faa` and `--user_orfs_gff`. Functional and taxonomic annotation may require local database paths such as `--eggnog_dbpath`, `--kofam_dir`, or a CSV mapping for `--diamond_dbs`.

## How to run
Run the pipeline using the `nextflow run` command, specifying a profile for software management (e.g., Docker, Singularity, or Conda).

```bash
nextflow run nf-core/metatdenovo \
    -profile <docker/singularity/institute> \
    --input samplesheet.csv \
    --outdir ./results \
    --assembler megahit \
    --orf_caller prokka
```

Key parameters include:
*   `--assembler`: Choose between `megahit` or `spades`.
*   `--orf_caller`: Choose between `prokka`, `prodigal`, or `transdecoder`.
*   `--spades_flavor`: Specify assembly type (e.g., `rna`, `metaviral`, `rnaviral`).
*   `-resume`: Restart a run from the last successful step.
*   `-r`: Pin a specific pipeline release version.

## Outputs
Results are saved to the directory specified by `--outdir`. The primary summary of the run is the MultiQC report, which aggregates quality control and tool-specific statistics.

Standardized results for downstream analysis in R or Python are located in the `summary_tables` directory. These include gene counts from FeatureCounts and functional/taxonomic annotations. Detailed documentation on output structure and interpretation is available at `https://nf-co.re/metatdenovo/output`.

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
