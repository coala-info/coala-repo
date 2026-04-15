---
name: erga-dataqc-hifi-v2601-wf0
description: This ERGA workflow performs quality control and preprocessing on PacBio HiFi raw reads using FastQC, Cutadapt, and SeqKit to generate trimmed sequences and summary statistics. Use this skill when you need to assess the quality of long-read sequencing data and remove adapter sequences to ensure high-quality inputs for downstream de novo genome assembly.
homepage: https://www.erga-biodiversity.eu/
metadata:
  docker_image: "N/A"
---

# erga-dataqc-hifi-v2601-wf0

## Overview

This workflow is designed for the initial quality control and preprocessing of PacBio HiFi raw reads, specifically tailored for the [ERGA](https://www.erga-biodiversity.eu/) (European Reference Genome Atlas) project. It accepts a collection of raw HiFi reads as input to assess sequence quality and prepare data for downstream assembly or comparative genomics.

The pipeline utilizes [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) to generate detailed quality metrics and [Cutadapt](https://cutadapt.readthedocs.io/) for trimming and adapter removal. It also calculates comprehensive sequence statistics using [SeqKit](https://bioinf.shenwei.me/seqkit/), providing a clear overview of read lengths, N50 values, and total base counts.

Results are aggregated into an interactive report via [MultiQC](https://multiqc.info/), allowing for easy inspection of the entire dataset. Key outputs include a collection of trimmed HiFi reads and a collapsed table of SeqKit statistics, ensuring the data meets the rigorous standards required for high-quality reference genome projects.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | HiFi raw reads collection | data_collection_input |  |


Ensure raw PacBio HiFi reads are provided in fastq.gz format and organized within a Galaxy collection to enable parallel processing and proper data aggregation. Using collections instead of individual datasets is required for the workflow to correctly generate the final summary tables and MultiQC reports. For comprehensive details on adapter trimming parameters and metadata requirements, please consult the README.md file. You may also use `planemo workflow_job_init` to streamline the creation of a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 2 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/5.2+galaxy0 |  |
| 3 | SeqKit statistics | toolshed.g2.bx.psu.edu/repos/iuc/seqkit_stats/seqkit_stats/2.12.0+galaxy0 |  |
| 4 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy4 |  |
| 5 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | HiFi trimmed collection | out1 |
| 5 | SeqKit HiFi raw table | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ERGA_DataQC_HiFi_v2601_(WF0).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ERGA_DataQC_HiFi_v2601_(WF0).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ERGA_DataQC_HiFi_v2601_(WF0).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ERGA_DataQC_HiFi_v2601_(WF0).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ERGA_DataQC_HiFi_v2601_(WF0).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ERGA_DataQC_HiFi_v2601_(WF0).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)