---
name: stec-pipeline
description: "This Galaxy workflow processes FASTQ sequencing data to characterize Shiga toxin-producing Escherichia coli (STEC) using the STEC pipeline 1.0 and BLAST-based analysis. Use this skill when you need to identify virulence genes, determine serotypes, or perform molecular characterization of STEC isolates from genomic sequencing data."
homepage: https://workflowhub.eu/workflows/644
---

# STEC pipeline

## Overview

This Galaxy workflow is designed for the automated characterization of Shiga toxin-producing *Escherichia coli* (STEC) from raw sequencing data. It utilizes the **STEC pipeline 1.0** tool to process fastq files, facilitating the rapid identification and virulence profiling of STEC strains in a standardized environment.

The core analysis involves a BLAST-based approach to detect specific genetic markers and virulence factors associated with STEC. By automating the sequence alignment and search process, the workflow ensures consistent detection of Shiga toxin genes ($stx1$, $stx2$) and other essential genomic features required for public health surveillance.

Upon completion, the workflow generates two primary outputs: a detailed STEC pipeline report and a concise summary. these documents provide a clear overview of the BLAST results, allowing researchers to quickly interpret the pathogenic potential and genomic composition of the analyzed samples.

## Inputs and data preparation

_None listed._


Ensure your input data consists of paired-end FASTQ files, ideally organized as a dataset collection to streamline batch processing through the STEC pipeline. Using collections is recommended for large-scale screening to maintain sample associations throughout the BLAST-based analysis and reporting steps. Refer to the README.md file for comprehensive details on parameter configurations and specific genomic markers used by the tool. You can automate the execution setup by generating a job.yml file using planemo workflow_job_init.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | STEC pipeline 1.0 | pipeline_stec_1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | Report - STEC pipeline (blast) on input dataset(s) | output_html |
| 0 | Summary - STEC pipeline (blast) on input dataset(s) | output_summary |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run WF2_Sciensano_fastq.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run WF2_Sciensano_fastq.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run WF2_Sciensano_fastq.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init WF2_Sciensano_fastq.ga -o job.yml`
- Lint: `planemo workflow_lint WF2_Sciensano_fastq.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `WF2_Sciensano_fastq.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
