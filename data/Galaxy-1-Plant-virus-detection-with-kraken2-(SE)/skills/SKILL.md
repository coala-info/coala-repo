---
name: 1-plant-virus-detection-with-kraken2-se
description: "This Galaxy workflow processes single-end sequencing data for plant virus detection using Kraken2, Kraken2Tax, and Krona pie charts. Use this skill when you need to identify viral pathogens in plant samples and visualize the taxonomic distribution of sequences to assess infection status."
homepage: https://workflowhub.eu/workflows/124
---

# 1: Plant virus detection with kraken2 (SE)

## Overview

This workflow provides a fast and efficient pipeline for the taxonomic classification of single-end (SE) sequencing data, specifically tailored for virology and plant virus detection. It leverages [Kraken2](https://toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.1+galaxy0) to perform k-mer based taxonomic assignment, allowing for rapid identification of viral sequences within a dataset.

The process begins by generating a detailed Kraken report and taxonomy table. These results are then refined using the [Convert Kraken](https://toolshed.g2.bx.psu.edu/repos/devteam/kraken2tax/Kraken2Tax/1.2) tool to modify the taxonomy table for downstream compatibility. This ensures that the classification data is properly formatted for final analysis and reporting.

To facilitate data interpretation, the workflow concludes by generating an interactive [Krona pie chart](https://toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0). This visualization provides an intuitive overview of the taxonomic composition, making it easier for researchers to identify specific plant viruses and assess the overall microbial diversity of their samples.

## Inputs and data preparation

_None listed._


Ensure your input sequences are in FASTQ format, which can be uploaded as individual datasets or organized into a dataset collection for efficient batch processing. It is essential to verify that the Kraken2 database selected during execution contains the relevant plant virus reference sequences for accurate taxonomic assignment. For comprehensive details on parameter settings and database requirements, please consult the README.md file. You may also use `planemo workflow_job_init` to create a `job.yml` file for streamlined job configuration and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Kraken2 | toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.1+galaxy0 | provide different taxonomic prediction with several false positive. WARNING: consider changing the database |
| 1 | Convert Kraken | toolshed.g2.bx.psu.edu/repos/devteam/kraken2tax/Kraken2Tax/1.2 | just re-arrange the column of the tabular file so it can be ready for krona representation |
| 2 | Krona pie chart | toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0 | Improve kraken2 taxonomic result representation in a HTLM report |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | Kraken_report | report_output |
| 0 | Kraken_taxonomy_table | output |
| 1 | Kraken_taxonomy_table_modified | out_file |
| 2 | Taxonomic_prediction_report | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-1__Plant_virus_detection_with_kraken2_(SE).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-1__Plant_virus_detection_with_kraken2_(SE).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-1__Plant_virus_detection_with_kraken2_(SE).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-1__Plant_virus_detection_with_kraken2_(SE).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-1__Plant_virus_detection_with_kraken2_(SE).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-1__Plant_virus_detection_with_kraken2_(SE).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
