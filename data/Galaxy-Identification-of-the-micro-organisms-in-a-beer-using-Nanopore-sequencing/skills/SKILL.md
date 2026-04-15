---
name: identification-of-the-micro-organisms-in-a-beer-using-nanopo
description: This workflow processes raw Nanopore sequencing reads through quality control and adapter trimming using FastQC, Porechop, and fastp before performing taxonomic classification with Kraken2 and visualizing results with Krona. Use this skill when you need to identify the microbial composition of a fermented beverage or environmental sample to detect specific bacteria and yeast species.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# identification-of-the-micro-organisms-in-a-beer-using-nanopo

## Overview

This Galaxy workflow is designed to identify microbial communities in beer samples using long-read Nanopore sequencing data. It provides a streamlined pipeline for microbiome analysis, moving from raw sequence reads to taxonomic classification to characterize the specific bacteria and yeast present in a sample.

The process begins with rigorous quality control and preprocessing. It utilizes [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0) for initial data assessment, followed by [Porechop](https://toolshed.g2.bx.psu.edu/repos/iuc/porechop/porechop/0.2.4+galaxy0) for adapter removal and [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.2+galaxy0) for read filtering. These steps ensure that the downstream analysis is performed on high-quality, clean genomic data.

For taxonomic identification, the workflow employs [Kraken2](https://toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.1+galaxy1), which assigns taxonomic labels to the sequences. The resulting data is refined through filtering and converted via [Krakentools](https://toolshed.g2.bx.psu.edu/repos/iuc/krakentools_kreport2krona/krakentools_kreport2krona/1.2+galaxy0) to generate interactive [Krona pie charts](https://toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0). This visualization allows for an intuitive exploration of the beer's microbial composition.

Developed based on [GTN](https://training.galaxyproject.org/) training materials and released under the MIT license, this workflow is a practical tool for food science and quality control. It is tagged for Microbiome research and provides essential outputs for identifying spoilage organisms or monitoring fermentation profiles.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | input | data_input |  |


The primary input for this workflow should be raw Nanopore sequencing data in FASTQ format, which can be uploaded as individual datasets or organized into a dataset collection for more efficient batch processing. Utilizing collections is particularly beneficial when comparing microbial profiles across multiple beer samples to ensure consistent tool execution across the entire cohort. For exhaustive details on data preparation and specific database requirements for Kraken2, consult the README.md file. You may also use `planemo workflow_job_init` to create a `job.yml` for automated job configuration.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |
| 2 | Porechop | toolshed.g2.bx.psu.edu/repos/iuc/porechop/porechop/0.2.4+galaxy0 |  |
| 3 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.2+galaxy0 |  |
| 4 | Kraken2 | toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.1+galaxy1 |  |
| 5 | Filter | Filter1 |  |
| 6 | Filter | Filter1 |  |
| 7 | Krakentools: Convert kraken report file | toolshed.g2.bx.psu.edu/repos/iuc/krakentools_kreport2krona/krakentools_kreport2krona/1.2+galaxy0 |  |
| 8 | Krona pie chart | toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | kraken_report | report_output |
| 7 | krakentool_report | output |


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