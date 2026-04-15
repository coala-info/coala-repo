---
name: taxonomy-profiling-and-visualization-with-krona
description: This microbiome workflow performs taxonomic profiling on a collection of preprocessed samples using Kraken2 and generates interactive visualizations with Krona. Use this skill when you need to identify the taxonomic composition of metagenomic samples and create hierarchical pie charts to explore the relative abundance of different organisms.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# taxonomy-profiling-and-visualization-with-krona

## Overview

This workflow provides an automated pipeline for taxonomic profiling and hierarchical visualization of microbiome sequencing data. It accepts a collection of preprocessed sequencing samples and a specified [Kraken2](https://toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.1+galaxy1) database as primary inputs to classify reads across various taxonomic ranks.

The process begins by using Kraken2 to assign taxonomic labels to the input reads, generating both classification files and summary reports. These reports are then processed by [Krakentools](https://toolshed.g2.bx.psu.edu/repos/iuc/krakentools_kreport2krona/krakentools_kreport2krona/1.2+galaxy1), which converts the data into a format specifically optimized for multi-layered visualization.

In the final stage, the workflow utilizes [Krona pie charts](https://toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0) to create interactive, browser-based visualizations. These charts allow users to explore the relative abundance and taxonomic distribution of their samples through an intuitive, zoomable interface.

Distributed under the MIT license, this workflow is integrated with the [Intergalactic Workflow Commission (IWC)](https://github.com/galaxyproject/iwc) and follows [GTN](https://training.galaxyproject.org/) best practices. It is particularly suited for microbiome and pathogen research within the microgalaxy and pathogfair ecosystems.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | collection_of_preprocessed_samples | data_collection_input | Output collection from the Nanopore Preprocessing workflow |
| 1 | kraken_database | parameter_input | kraken_database_for_user_to_choose |


To run this workflow, provide a collection of preprocessed sequencing reads in FASTQ format and specify a compatible Kraken2 taxonomic database. Utilizing a data collection is necessary for efficient batch processing and ensures that the subsequent Krakentools and Krona steps correctly handle multi-sample outputs. For detailed guidance on database versions and specific input requirements, consult the README.md file. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Kraken2 | toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.1+galaxy1 |  |
| 3 | Krakentools: Convert kraken report file | toolshed.g2.bx.psu.edu/repos/iuc/krakentools_kreport2krona/krakentools_kreport2krona/1.2+galaxy1 |  |
| 4 | Krona pie chart | toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | kraken2_with_pluspf_database_output | output |
| 2 | kraken2_with_pluspf_database_output_report | report_output |
| 3 | converted_kraken_report | output |
| 4 | krona_pie_chart | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run taxonomy-profiling-and-visualisation-with-krona.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run taxonomy-profiling-and-visualisation-with-krona.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run taxonomy-profiling-and-visualisation-with-krona.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init taxonomy-profiling-and-visualisation-with-krona.ga -o job.yml`
- Lint: `planemo workflow_lint taxonomy-profiling-and-visualisation-with-krona.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `taxonomy-profiling-and-visualisation-with-krona.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)