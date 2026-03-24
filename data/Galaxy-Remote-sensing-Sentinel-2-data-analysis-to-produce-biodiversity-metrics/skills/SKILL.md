---
name: remote-sensing-sentinel-2-data-analysis-to-produce-biodivers
description: "This workflow processes Sentinel 2 satellite imagery to calculate spectral and biodiversity indices and generate diversity maps using specialized remote sensing preprocessing and analysis tools. Use this skill when you need to quantify ecosystem diversity and monitor environmental health by deriving spatial biodiversity metrics from multi-spectral satellite data."
homepage: https://workflowhub.eu/workflows/657
---

# Remote sensing Sentinel 2 data analysis to produce biodiversity metrics

## Overview

This Galaxy workflow automates the processing of Sentinel-2 satellite imagery to generate essential biodiversity metrics and spectral indices. It is designed to handle raw Sentinel-2 L2A data (ZIP format), performing initial preprocessing to extract reflectance and cloud mask information. By streamlining these complex remote sensing tasks, the workflow enables researchers to monitor ecosystem health and vegetation patterns across different geographic tiles.

The analysis pipeline utilizes a suite of specialized tools, including [srs_preprocess_s2](https://toolshed.g2.bx.psu.edu/repos/ecology/srs_preprocess_s2) for data preparation and [srs_spectral_indices](https://toolshed.g2.bx.psu.edu/repos/ecology/srs_spectral_indices) for calculating vegetation-related metrics. It further computes global biodiversity indices and generates diversity maps using [srs_diversity_maps](https://toolshed.g2.bx.psu.edu/repos/ecology/srs_diversity_maps), which help in visualizing beta diversity and other spatial ecological indicators.

The final outputs provide a comprehensive set of data products, including processed reflectance rasters, cloud masks, and various biodiversity index files. Additionally, the workflow generates visual plots (PNG format) for both spectral and biodiversity indices, facilitating immediate interpretation of the remote sensing results for ecological assessment.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | SENTINEL2A_20230214-105638-781_L2A_T31UET_D.zip | data_input |  |
| 1 | SENTINEL2A_20230210-111817-461_L2A_T30TWS_D.zip | data_input |  |


Ensure your input data are Sentinel-2 Level-2A (L2A) products in `.zip` format, as the preprocessing tools are specifically designed to handle these compressed archives. While individual datasets can be uploaded, organizing multiple tiles into a dataset collection can significantly streamline the execution of the preprocessing and index computation steps. Refer to the `README.md` file for comprehensive details on parameter settings and specific spectral band requirements for each biodiversity metric. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and easier management of multiple input tiles.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Preprocess sentinel 2 data | toolshed.g2.bx.psu.edu/repos/ecology/srs_preprocess_s2/srs_preprocess_s2/0.0.1 |  |
| 3 | Preprocess sentinel 2 data | toolshed.g2.bx.psu.edu/repos/ecology/srs_preprocess_s2/srs_preprocess_s2/0.0.1 |  |
| 4 | Compute biodiversity indices | toolshed.g2.bx.psu.edu/repos/ecology/srs_global_indices/srs_global_indices/0.0.1 |  |
| 5 | Compute spectral indices | toolshed.g2.bx.psu.edu/repos/ecology/srs_spectral_indices/srs_spectral_indices/0.0.1 |  |
| 6 | Map diversity | toolshed.g2.bx.psu.edu/repos/ecology/srs_diversity_maps/srs_diversity_maps/0.0.1 |  |
| 7 | Map diversity | toolshed.g2.bx.psu.edu/repos/ecology/srs_diversity_maps/srs_diversity_maps/0.0.1 |  |
| 8 | Compute biodiversity indices | toolshed.g2.bx.psu.edu/repos/ecology/srs_global_indices/srs_global_indices/0.0.1 |  |
| 9 | Compute spectral indices | toolshed.g2.bx.psu.edu/repos/ecology/srs_spectral_indices/srs_spectral_indices/0.0.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | output | output |
| 2 | output_refl | output_refl |
| 2 | output_cloud | output_cloud |
| 3 | output_refl | output_refl |
| 3 | output | output |
| 3 | output_cloud | output_cloud |
| 4 | plots_png | plots_png |
| 4 | output_indices | output_indices |
| 5 | plots | plots |
| 5 | output_indices | output_indices |
| 6 | plots | plots |
| 6 | output_beta | output_beta |
| 7 | output_beta | output_beta |
| 7 | plots | plots |
| 8 | plots_png | plots_png |
| 8 | output_indices | output_indices |
| 9 | plots | plots |
| 9 | output_indices | output_indices |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Remote_sensing_Sentinel_2_data_analysis_to_produce_biodiversity_metrics.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Remote_sensing_Sentinel_2_data_analysis_to_produce_biodiversity_metrics.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Remote_sensing_Sentinel_2_data_analysis_to_produce_biodiversity_metrics.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Remote_sensing_Sentinel_2_data_analysis_to_produce_biodiversity_metrics.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Remote_sensing_Sentinel_2_data_analysis_to_produce_biodiversity_metrics.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Remote_sensing_Sentinel_2_data_analysis_to_produce_biodiversity_metrics.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
