---
name: sentinel-2-example
description: This workflow processes Sentinel-2 satellite imagery to calculate spectral and biodiversity indices and generate diversity maps using specialized ecology tools. Use this skill when you need to analyze satellite-derived spectral data to monitor ecosystem health or map spatial patterns of biodiversity across a landscape.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# sentinel-2-example

## Overview

This workflow processes Sentinel-2 satellite imagery to analyze biodiversity and spectral characteristics. It begins by taking a raw Sentinel-2 L2A zip file as input and performing preprocessing to generate essential reflectance data and cloud masks.

Following preprocessing, the workflow calculates various spectral indices. These results are then used to compute global biodiversity indices, providing quantitative insights into the ecological characteristics of the captured geographic region.

The final stage involves mapping diversity and generating visual representations of the data. The workflow produces a comprehensive set of outputs, including beta diversity maps and various PNG plots, which facilitate the interpretation of spatial biodiversity patterns.

Developed for ecological remote sensing, this resource is tagged for [GTN](https://training.galaxyproject.org/) and [Galaxy](https://galaxyproject.org/) users. The workflow is shared under a [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | SENTINEL2A_20230214-105638-781_L2A_T31UET_D.zip | data_input |  |


Ensure the input Sentinel-2 L2A data is uploaded as a `.zip` file to maintain the internal directory structure required by the preprocessing tool. While this example uses a single dataset, you can scale the analysis by organizing multiple scenes into a dataset collection. Refer to the `README.md` for comprehensive details on data acquisition and specific parameter configurations. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Preprocess sentinel 2 data | toolshed.g2.bx.psu.edu/repos/ecology/srs_preprocess_s2/srs_preprocess_s2/0.0.1 |  |
| 2 | Compute spectral indices | toolshed.g2.bx.psu.edu/repos/ecology/srs_spectral_indices/srs_spectral_indices/0.0.1 |  |
| 3 | Compute biodiversity indices | toolshed.g2.bx.psu.edu/repos/ecology/srs_global_indices/srs_global_indices/0.0.1 |  |
| 4 | Map diversity | toolshed.g2.bx.psu.edu/repos/ecology/srs_diversity_maps/srs_diversity_maps/0.0.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | output | output |
| 1 | output_refl | output_refl |
| 1 | output_cloud | output_cloud |
| 2 | output_indices | output_indices |
| 2 | plots | plots |
| 3 | plots_png | plots_png |
| 3 | output_indices | output_indices |
| 4 | plots | plots |
| 4 | output_beta | output_beta |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run sentinel-2-example.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run sentinel-2-example.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run sentinel-2-example.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init sentinel-2-example.ga -o job.yml`
- Lint: `planemo workflow_lint sentinel-2-example.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `sentinel-2-example.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)