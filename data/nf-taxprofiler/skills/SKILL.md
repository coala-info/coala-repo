---
name: taxprofiler
description: The pipeline performs taxonomic classification and abundance estimation of shotgun short- and long-read metagenomic data using a samplesheet of FASTQ/FASTA files and a database CSV to run multiple profilers like Kraken2, MetaPhlAn, or MALT in parallel. Use when analyzing metagenomic communities across different sequencing platforms to compare results from various classification tools and databases against a single dataset.
homepage: https://github.com/nf-core/taxprofiler
---

## Overview
nf-core/taxprofiler is designed for the taxonomic identification of reads or taxonomic abundance estimation from metagenomic datasets. It addresses the challenge of tool-specific output formats by providing standardized taxonomic tables, allowing researchers to compare results across different algorithms and reference databases within a single execution.

The pipeline processes raw sequencing data through various quality control and preprocessing stages, including adapter clipping, complexity filtering, and host-read removal. It then dispatches the cleaned reads to one or more user-selected taxonomic profilers, ultimately aggregating the findings into comparative reports and interactive visualizations.

## Data preparation
The pipeline requires two primary input files: a samplesheet and a database sheet. The samplesheet defines the raw sequencing data, while the database sheet specifies which taxonomic profiling tools to run and where their respective reference indices are located.

**Samplesheet requirements:**
A CSV file with the following columns: `sample`, `run_accession`, `instrument_platform`, `fastq_1`, `fastq_2`, and `fasta`.
- `instrument_platform` must be one of the supported types (e.g., ILLUMINA, OXFORD_NANOPORE).
- Reads must be gzipped (`.fastq.gz` or `.fq.gz`).

```csv
sample,run_accession,instrument_platform,fastq_1,fastq_2,fasta
2612,run1,ILLUMINA,2612_run1_R1.fq.gz,,
2612,run3,ILLUMINA,2612_run3_R1.fq.gz,2612_run3_R2.fq.gz,
```

**Database sheet requirements:**
A CSV file with the following columns: `tool`, `db_name`, `db_params`, and `db_path`.
- `db_path` can point to a directory or a `.tar.gz` archive.
- Profilers only run if a corresponding database is provided in this sheet.

```csv
tool,db_name,db_params,db_path
kraken2,db2,--quick,/<path>/<to>/kraken2/testdb-kraken2.tar.gz
metaphlan,db1,,/<path>/<to>/metaphlan/metaphlan_database/
```

## How to run
Run the pipeline by specifying the input sheets and the desired profiling tools. Use `-profile` to define the software container engine (e.g., docker, singularity) and `-r` to pin a specific version.

```bash
nextflow run nf-core/taxprofiler \
   -r 1.1.0 \
   -profile docker \
   --input samplesheet.csv \
   --databases databases.csv \
   --outdir ./results \
   --run_kraken2 \
   --run_metaphlan
```

Key parameters include:
- `--perform_shortread_hostremoval`: Enables host-read filtering (requires `--hostremoval_reference`).
- `--run_profile_standardisation`: Generates standardized tables via Taxpasta.
- `-resume`: Restarts the pipeline from the last successful step if interrupted.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary deliverables include:

- `multiqc/`: High-level quality control reports for raw reads and preprocessing steps.
- `taxpasta/`: Standardized taxonomic abundance tables that facilitate direct comparison between different profiling tools.
- `krona/`: Interactive HTML pie charts for Kraken2, Centrifuge, Kaiju, and MALT results.
- `analysis_ready_reads/`: If `--save_analysis_ready_fastqs` is used, contains the final cleaned reads used for profiling.
- Tool-specific folders (e.g., `kraken2/`, `metaphlan/`): Contain the raw output files and reports from each individual profiler.

For detailed information on specific file structures, refer to the [official output documentation](https://nf-co.re/taxprofiler/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
- [`references/docs/usage/faq-troubleshooting.md`](references/docs/usage/faq-troubleshooting.md)
- [`references/docs/usage/tutorials.md`](references/docs/usage/tutorials.md)
