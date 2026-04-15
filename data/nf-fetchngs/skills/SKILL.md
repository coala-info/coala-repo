---
name: fetchngs
description: This pipeline retrieves metadata and raw FastQ files from public databases including SRA, ENA, DDBJ, and GEO using a simple list of accession identifiers. Use when you need to programmatically download sequencing data and generate ready-to-use samplesheets for downstream nf-core workflows like rnaseq or atacseq.
homepage: https://github.com/nf-core/fetchngs
---

# fetchngs

## Overview
The pipeline simplifies the process of obtaining public sequencing data by resolving database identifiers to their experiment-level metadata and raw data links. It automates the retrieval of FastQ files and collates all associated metadata into a single, structured samplesheet, eliminating the need for manual data gathering from multiple web interfaces.

In practice, users provide a list of accessions, and the pipeline handles the complexities of API communication and parallelized downloads. The resulting output is designed to be immediately compatible with other bioinformatics pipelines, particularly those within the nf-core ecosystem, ensuring metadata consistency across projects.

## Data preparation
The primary input is a simple text-based file (CSV, TSV, or TXT) containing one database identifier per line. Supported identifiers include SRA, ENA, DDBJ, or GEO accessions such as Run (SRR/ERR/DRR), Sample (SAMN/SAME/SAMD), Project (PRJNA/PRJEB/PRJDB), or GEO (GSE/GSM) IDs.

Example `ids.csv`:
```csv
SRR9984183
SRR13191702
ERR1160846
ERR1109373
```

The pipeline validates these IDs against a specific regex pattern to ensure they are valid public database accessions before attempting to fetch metadata.

## How to run
Run the pipeline by providing the input file and an output directory. It is recommended to specify a pipeline version with `-r` and use `-profile` for your compute environment (e.g., `docker`, `singularity`, or `conda`).

```bash
nextflow run nf-core/fetchngs \
   -r 1.11.0 \
   -profile <docker/singularity/institute> \
   --input ids.csv \
   --outdir ./results
```

Key parameters include:
- `--download_method`: Choose between `ftp` (default), `aspera`, or `sratools`.
- `--nf_core_pipeline`: Automatically format the output samplesheet for a specific pipeline (e.g., `rnaseq`, `atacseq`, `viralrecon`, or `taxprofiler`).
- `--skip_fastq_download`: Fetch only the metadata without downloading the large FastQ files.
- `-resume`: Use this Nextflow flag to restart a run from the last successful step if it was interrupted.

## Outputs
Results are saved in the directory specified by `--outdir`. The most important files include:
- `samplesheet/samplesheet.csv`: A comprehensive CSV containing paths to the downloaded FastQ files and their associated metadata.
- `multiqc/`: A MultiQC report summarizing the download statistics and metadata.
- `fastq/`: The raw sequencing files (unless `--skip_fastq_download` was used).

If `--nf_core_pipeline` was specified, an additional samplesheet tailored to that pipeline's specific column requirements will be generated. For detailed information on output structure, refer to the [official output documentation](https://nf-co.re/fetchngs/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)