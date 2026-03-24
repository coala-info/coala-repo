---
name: calculating-diversity-from-microbiome-taxonomic-data
description: "This microbiome workflow processes Bracken taxonomic classification data using Krakentools to calculate multiple alpha diversity indices and Bray-Curtis beta diversity. Use this skill when you need to quantify species richness and evenness within samples or compare microbial community composition across different environmental or clinical conditions."
homepage: https://workflowhub.eu/workflows/1431
---

# Calculating diversity from microbiome taxonomic data

## Overview

This workflow is designed to analyze microbiome taxonomic data by calculating ecological diversity metrics from Bracken classification results. It processes an input dataset collection to provide a comprehensive overview of microbial community structure, facilitating both within-sample and between-sample comparisons.

The pipeline utilizes [Krakentools](https://github.com/jenniferlu717/KrakenTools) to compute several alpha diversity indices. These steps measure the richness and evenness of species within individual samples, allowing researchers to characterize the biological complexity of their specific environments.

For comparative analysis, the workflow calculates beta diversity using the Bray-Curtis dissimilarity metric. This enables the quantification of compositional differences across the entire dataset collection, identifying how microbial communities shift between different conditions or sites.

Developed as part of the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/), this workflow provides a standardized, reproducible approach to microbiome post-classification analysis under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Dataset Collection | data_collection_input |  |


Ensure your input is a dataset collection containing Bracken report files, as the Krakentools steps are optimized to process multiple samples simultaneously for comparative analysis. Using a collection is essential to maintain sample organization and streamline the calculation of alpha and beta diversity metrics across your entire cohort. Refer to the `README.md` for comprehensive details on parameter settings and specific formatting requirements for the taxonomic data. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Krakentools: Calculates alpha diversity | toolshed.g2.bx.psu.edu/repos/iuc/krakentools_alpha_diversity/krakentools_alpha_diversity/1.2+galaxy1 |  |
| 2 | Krakentools: Calculates alpha diversity | toolshed.g2.bx.psu.edu/repos/iuc/krakentools_alpha_diversity/krakentools_alpha_diversity/1.2+galaxy1 |  |
| 3 | Krakentools: Calculates alpha diversity | toolshed.g2.bx.psu.edu/repos/iuc/krakentools_alpha_diversity/krakentools_alpha_diversity/1.2+galaxy1 |  |
| 4 | Krakentools: Calculates alpha diversity | toolshed.g2.bx.psu.edu/repos/iuc/krakentools_alpha_diversity/krakentools_alpha_diversity/1.2+galaxy1 |  |
| 5 | Krakentools: Calculates alpha diversity | toolshed.g2.bx.psu.edu/repos/iuc/krakentools_alpha_diversity/krakentools_alpha_diversity/1.2+galaxy1 |  |
| 6 | Krakentools: calculates beta diversity (Bray-Curtis dissimilarity) | toolshed.g2.bx.psu.edu/repos/iuc/krakentools_beta_diversity/krakentools_beta_diversity/1.2+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow.ga -o job.yml`
- Lint: `planemo workflow_lint workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
