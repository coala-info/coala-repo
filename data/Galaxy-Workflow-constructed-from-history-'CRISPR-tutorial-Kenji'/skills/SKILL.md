---
name: workflow-constructed-from-history-crispr-tutorial-kenji
description: This CRISPR screen analysis workflow processes guide library references and sequencing data collections using FastQC, Cutadapt, and MAGeCK to quantify and test guide enrichment or depletion. Use this skill when you need to identify genes that regulate specific phenotypes by analyzing high-throughput CRISPR screening data for statistically significant changes in guide RNA abundance.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# workflow-constructed-from-history-crispr-tutorial-kenji

## Overview

This Galaxy workflow is designed for CRISPR screen analysis, providing a standardized pipeline to process raw sequencing data and identify significant gene hits. Based on [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) materials, it automates the transition from raw reads to statistical enrichment analysis.

The initial stages focus on quality control and sequence refinement. The workflow utilizes [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) and [MultiQC](https://multiqc.info/) to evaluate read quality, while [Cutadapt](https://cutadapt.readthedocs.io/) is employed to trim adapters and primers. These steps ensure that the library sequences are accurately prepared for mapping against the guide RNA references.

For the core functional genomics analysis, the pipeline integrates the MAGeCK (Model-based Analysis of Genome-wide CRISPR-Cas9 Knockout) suite. [MAGeCK count](https://sourceforge.net/p/mageck/wiki/Home/) generates read count tables by matching sequencing data against the provided Brunello or Calabrese library references. Finally, [MAGeCK test](https://sourceforge.net/p/mageck/wiki/Home/) performs robust statistical testing to determine gene-level enrichment or depletion across experimental conditions.

The workflow requires three primary inputs: a library contents CSV, a guides reference file, and a dataset collection of sequencing reads. It is tagged for [Genome-annotation](https://galaxyproject.org/tags/genome-annotation/) and serves as a comprehensive tool for researchers performing large-scale CRISPR screens.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | broadgpp-brunello-library-contents.csv | data_input |  |
| 1 | Calabrese_SetA_Guides_Reference.csv | data_input |  |
| 2 | Input Dataset Collection | data_collection_input |  |


Ensure your CRISPR library and guide reference files are uploaded in CSV format, while raw sequencing reads should be organized into a dataset collection to facilitate batch processing through Cutadapt and MAGeCK. It is essential to verify that the library file columns align with MAGeCK’s expected schema for accurate guide counting and statistical testing. Refer to the README.md for comprehensive details on data formatting and specific parameter settings required for this CRISPR screen analysis. You may also use `planemo workflow_job_init` to create a `job.yml` file for streamlined job submission and reproducibility.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 4 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/3.4+galaxy1 |  |
| 5 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.9+galaxy1 |  |
| 6 | MAGeCK count | toolshed.g2.bx.psu.edu/repos/iuc/mageck_count/mageck_count/0.5.9.2.4 |  |
| 7 | MAGeCKs test | toolshed.g2.bx.psu.edu/repos/iuc/mageck_test/mageck_test/0.5.9.2.1 |  |


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