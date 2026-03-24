---
name: a-workflow-demonstrating-the-run-interpolation-based-on-idw
description: "This geospatial workflow processes CSV and GeoJSON data using Inverse Distance Weighting interpolation and image comparison tools to analyze spatial distributions. Use this skill when you need to estimate environmental variables across a continuous surface from discrete point samples or validate the accuracy of spatial interpolation models."
homepage: https://workflowhub.eu/workflows/807
---

# A workflow demonstrating the 'Run interpolation based on IDW' tool

## Overview

This workflow demonstrates the functionality of the [Run interpolation based on IDW](https://toolshed.g2.bx.psu.edu/view/ecology/interpolation_run_idw_interpolation) tool within the Galaxy ecosystem. It is designed to process spatial datasets, specifically utilizing input files in CSV and GeoJSON formats to generate interpolated surfaces using the Inverse Distance Weighting (IDW) method.

The pipeline begins by filtering the input data and converting tabular formats to ensure compatibility across different processing stages. It then executes the IDW interpolation tool multiple times, allowing for the generation of spatial models based on the provided coordinates and values.

In the final stage, the workflow employs the [GraphicsMagick image comparison](https://toolshed.g2.bx.psu.edu/view/bgruening/graphicsmagick_image_compare) tool to evaluate the resulting outputs. This step is essential for validating the interpolation results and ensuring consistency across different runs or parameter settings.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | run_idw_interpolation_test_input1.csv | data_input |  |
| 1 | run_idw_interpolation_test_input2.geojson | data_input |  |


Ensure your input data is correctly formatted as CSV for tabular coordinates and GeoJSON for spatial boundaries to ensure compatibility with the IDW interpolation tool. While individual datasets are used in this demonstration, you can process multiple locations simultaneously by organizing your inputs into a dataset collection. Refer to the `README.md` file for comprehensive details on parameter settings and specific column requirements. You can automate the setup of these inputs using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Filter | Filter1 |  |
| 3 | Run interpolation | toolshed.g2.bx.psu.edu/repos/ecology/interpolation_run_idw_interpolation/interpolation_run_idw_interpolation/1.0 |  |
| 4 | Convert tabular to CSV | tabular_to_csv |  |
| 5 | Run interpolation | toolshed.g2.bx.psu.edu/repos/ecology/interpolation_run_idw_interpolation/interpolation_run_idw_interpolation/1.0 |  |
| 6 | Compare two images | toolshed.g2.bx.psu.edu/repos/bgruening/graphicsmagick_image_compare/graphicsmagick_image_compare/1.3.42+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy_workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy_workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy_workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy_workflow.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy_workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy_workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
