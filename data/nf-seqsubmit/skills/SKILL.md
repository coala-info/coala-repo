---
name: nf-core-seqsubmit
description: This pipeline automates the submission of Metagenome Assembled Genomes (MAGs), bins, and metagenomic assemblies to the European Nucleotide Archive (ENA) using FASTA files, metadata samplesheets, and Webin credentials. Use when preparing large-scale genomic or metagenomic data for public archival, specifically requiring a pre-registered ENA study accession and valid Webin account secrets.
homepage: https://github.com/nf-core/seqsubmit
---

## Overview
nf-core/seqsubmit facilitates the complex process of uploading sequence data and associated metadata to the European Nucleotide Archive (ENA). It acts as a wrapper for the ENA Webin CLI, ensuring that genomic assemblies and metagenomic data meet the structural and metadata requirements of the International Nucleotide Sequence Database Collaboration (INSDC).

The pipeline handles three primary data modalities: Metagenome Assembled Genomes (MAGs), genomic bins, and general metagenomic assemblies. It validates input files, generates required manifest files, and performs either test or live submissions to ENA servers, providing a MultiQC report and Webin CLI logs as final verification of the submission status.

## Data preparation
The pipeline requires a CSV samplesheet, the structure of which depends on the chosen `--mode`. All FASTA files must be compressed and end with `.fa.gz` or `.fasta.gz`.

### MAGs and Bins modes
Used for `mags` or `bins` submissions. Required columns include:
- `sample`, `fasta`, `accession` (of raw reads)
- `assembly_software`, `binning_software`, `binning_parameters`
- `stats_generation_software`, `metagenome`
- `environmental_medium`, `broad_environment`, `local_environment`, `co-assembly`

### Metagenomic Assemblies mode
Used for `metagenomic_assemblies` submissions. Required columns include:
- `sample`, `fasta`, `run_accession`, `assembler`, `assembler_version`
- Either `coverage` OR `fastq_1` (and optional `fastq_2`) to calculate coverage automatically.

**Example Assembly Samplesheet:**
```csv
sample,fasta,fastq_1,fastq_2,coverage,run_accession,assembler,assembler_version
assembly_1,data/contigs_1.fasta.gz,data/reads_1.fastq.gz,data/reads_2.fastq.gz,,ERR011322,SPAdes,3.15.5
```

## How to run
Before running, you must set your ENA Webin credentials as Nextflow secrets:
```bash
nextflow secrets set WEBIN_ACCOUNT "Webin-XXX"
nextflow secrets set WEBIN_PASSWORD "XXX"
```

Run the pipeline by specifying the mode and required ENA metadata:
```bash
nextflow run nf-core/seqsubmit \
   -profile <docker/singularity/conda> \
   --mode <mags|bins|metagenomic_assemblies> \
   --input samplesheet.csv \
   --centre_name "Your Organisation" \
   --submission_study PRJEBXXXXX \
   --outdir ./results
```

Key flags:
- `--test_upload`: Set to `true` (default) to use the ENA TEST server; set to `false` for LIVE submission.
- `--webincli_submit`: Set to `false` to validate inputs without performing an actual upload.
- `-resume`: Use to restart the pipeline from the last successful step.

## Outputs
Results are organized in the directory specified by `--outdir`:
- `upload/manifests/`: Contains the generated manifest files required for ENA submission.
- `upload/webin_cli/`: Contains the ENA Webin CLI execution reports and submission logs.
- `multiqc/`: A summary report of the pipeline run and software versions.
- `pipeline_info/`: Execution metrics, including the trace file and hardware usage.

For detailed interpretation of submission reports, refer to the [official output documentation](https://nf-co.re/seqsubmit/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/methods.md`](references/docs/methods.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
