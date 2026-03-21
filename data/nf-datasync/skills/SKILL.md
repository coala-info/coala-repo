---
name: datasync
description: This system operations pipeline performs data synchronization, checksum generation using various backends, integrity validation, and automated archival or deletion based on user-defined rules and samplesheet inputs. Use when managing large data processing facilities that require automated file transfers, verification of data integrity across storage tiers, or rule-based cleanup of aged datasets.
homepage: https://github.com/nf-core/datasync
---

## Overview
nf-core/datasync is a system operations pipeline designed to automate routine data management tasks in large-scale processing environments. It addresses the need for reliable data transfers by providing workflows for synchronizing files, generating cryptographic checksums, and validating data integrity against previously recorded hashes.

The pipeline also facilitates data lifecycle management through configurable archival and deletion routines. Users can define rules based on file age or integrity status to move data to long-term storage or remove it entirely, producing comprehensive MultiQC reports that document every action taken during the run.

## Data preparation
The pipeline requires a comma-separated samplesheet provided via the `--input` parameter. This CSV file must contain a header row and define the files to be processed. According to the input schema, the file should include columns for sample identifiers and paths to the data files.

- **sample**: Unique identifier for the entry (no spaces allowed).
- **fastq_1**: Path to the first read file or primary data file (must end in `.fq.gz` or `.fastq.gz`).
- **fastq_2**: Path to the second read file for paired-end data (optional).

Example `samplesheet.csv`:
```csv
sample,fastq_1,fastq_2
CONTROL_R1,data/control_1.fastq.gz,data/control_2.fastq.gz
TEST_R1,data/test_1.fastq.gz,
```

Users can further refine synchronization behavior by providing YAML files to include or exclude specific files or sub-folders based on the presence of checkpoint files (e.g., `DEMUX_DONE`).

## How to run
The pipeline is executed using Nextflow with the required input and output parameters. It is highly recommended to use a container profile (e.g., `-profile docker`) to ensure reproducibility.

```bash
nextflow run nf-core/datasync \
   -r 1.0.0 \
   -profile docker \
   --input samplesheet.csv \
   --outdir ./results \
   --sync \
   --sync_backend 'sha256' \
   --sync_done true
```

Key parameters include:
- `--sync`: Enables the synchronization subworkflow.
- `--sync_backend`: Specifies the checksum algorithm (e.g., `sha256`, `md5`).
- `--sync_done`: If set to `true`, creates a `SYNC_DONE` file in each folder upon successful completion.
- `-resume`: Use this Nextflow flag to restart a run from the last successful step.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary deliverable is a MultiQC report which aggregates the logs and provides a summary of the synchronization, validation, or archival tasks performed.

- **MultiQC Report**: Located at `multiqc/multiqc_report.html`, this is the first file to inspect for a summary of the run.
- **Checksums**: Files containing generated hashes for data integrity tracking.
- **Archival Reports**: Documentation of files moved to archival storage or marked for deletion.
- **Sync Logs**: Detailed records of file transfers and synchronization status.

For a complete list of output files and their formats, refer to the [output documentation](https://nf-co.re/datasync/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
