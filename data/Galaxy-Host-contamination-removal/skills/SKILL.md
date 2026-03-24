---
name: host-contamination-removal
description: "This Galaxy workflow removes host DNA contamination from paired-end FASTQ sequencing data by aligning reads to a reference genome using Bowtie2 and generating quality reports with MultiQC. Use this skill when you need to filter out non-target host sequences from metagenomic or clinical samples to ensure downstream analysis focuses exclusively on the microbial or pathogen DNA of interest."
homepage: https://workflowhub.eu/workflows/2042
---

# Host contamination removal

## Overview

This workflow is designed to streamline the removal of host-derived sequences from paired-end sequencing data, a critical step in metagenomics and clinical pathogen detection. It accepts a collection of paired FASTQ files and a reference genome build as primary inputs to identify and filter out reads originating from the host organism.

The core processing is performed by [Bowtie2](https://bowtie-bio.sourceforge.net/bowtie2/index.shtml), which aligns the input reads against the specified host reference. By identifying sequences that map to the host, the workflow allows researchers to isolate unmapped reads for downstream analysis, effectively reducing noise and computational overhead.

To ensure data quality and process transparency, the workflow integrates [MultiQC](https://multiqc.info/) to generate a comprehensive summary report of the alignment statistics. The final outputs are organized using collection zipping tools for easier data management. This tool is associated with the [GTN](https://training.galaxyproject.org/) and [fairymags](https://github.com/fairymags) projects and is available under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input paired fastq | data_collection_input |  |
| 1 | Reference Genome Build In | parameter_input |  |


Ensure your input is a paired-end fastq collection in fastqsanger or fastqsanger.gz format to allow the workflow to process multiple samples simultaneously. You must select a compatible built-in reference genome index for Bowtie2 to accurately identify and filter out host-derived sequences. For comprehensive details on specific parameter configurations and environment setup, refer to the accompanying README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated testing and local execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.3+galaxy1 |  |
| 3 | Zip collections | __ZIP_COLLECTION__ |  |
| 4 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
