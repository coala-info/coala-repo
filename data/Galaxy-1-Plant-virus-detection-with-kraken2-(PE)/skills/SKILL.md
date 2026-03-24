---
name: 1-plant-virus-detection-with-kraken2
description: "This Galaxy workflow performs taxonomic classification of paired-end FASTQ sequencing data to detect plant viruses using Kraken2, Kraken2Tax, and Krona visualization. Use this skill when you need to identify viral pathogens in plant samples and analyze the taxonomic composition of metagenomic datasets."
homepage: https://workflowhub.eu/workflows/101
---

# 1: Plant virus detection with kraken2

## Overview

This workflow is designed for the rapid taxonomic classification of plant viruses using paired-end sequencing data. It leverages [Kraken2](https://toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.1+galaxy0) to provide fast and efficient predictions of the taxonomic composition within a dataset, making it particularly suitable for virology research and diagnostics.

The pipeline processes raw FASTQ inputs through Kraken2 to generate initial classification reports and taxonomy tables. These results are subsequently refined using the [Convert Kraken](https://toolshed.g2.bx.psu.edu/repos/devteam/kraken2tax/Kraken2Tax/1.2) tool, which standardizes the taxonomy data for improved readability and downstream compatibility.

To facilitate data interpretation, the workflow concludes by generating an interactive [Krona pie chart](https://toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0). This provides a visual hierarchical representation of the detected taxa. Key outputs include the primary Kraken report, modified taxonomy tables, and a comprehensive taxonomic prediction report.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Data_R1.fastq | data_input |  |
| 1 | Data_R2.fastq | data_input |  |


For this workflow, ensure your input files are in FASTQ format, ideally organized as a paired dataset collection to streamline the processing of R1 and R2 reads. While individual datasets are supported, using collections is recommended for scaling the analysis across multiple plant samples efficiently. Refer to the README.md for comprehensive details on selecting the appropriate Kraken2 database and configuring taxonomic filters for viral detection. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and parameter management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Kraken2 | toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.1+galaxy0 | provide different taxonomic prediction with several false positive. WARNING: consider changing the database |
| 3 | Convert Kraken | toolshed.g2.bx.psu.edu/repos/devteam/kraken2tax/Kraken2Tax/1.2 | just re-arrange the column of the tabular file so it can be ready for krona representation |
| 4 | Krona pie chart | toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0 | Improve kraken2 taxonomic result representation in a HTLM report |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | Kraken_report | report_output |
| 2 | Kraken_taxonomy_table | output |
| 3 | Kraken_taxonomy_table_modified | out_file |
| 4 | Taxonomic_prediction_report | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-1__Plant_virus_detection_with_kraken2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-1__Plant_virus_detection_with_kraken2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-1__Plant_virus_detection_with_kraken2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-1__Plant_virus_detection_with_kraken2.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-1__Plant_virus_detection_with_kraken2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-1__Plant_virus_detection_with_kraken2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
