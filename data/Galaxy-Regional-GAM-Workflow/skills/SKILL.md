---
name: regional-gam-workflow
description: This ecology workflow processes regional monitoring data from a CSV file using Generalized Additive Models to calculate flight curves, abundance indices, and temporal trends. Use this skill when you need to analyze species population dynamics over time to identify significant ecological trends and account for seasonal phenology in monitoring datasets.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# regional-gam-workflow

## Overview

This workflow provides a standardized pipeline for analyzing ecological monitoring data to estimate population trends using Generalized Additive Models (GAM). Based on [GTN training materials](https://training.galaxyproject.org/), it is specifically designed to process opportunistic or structured count data, such as butterfly monitoring schemes, to generate robust abundance indices.

The process begins by reformatting and counting the input `regionalGAM.csv` data. It then utilizes specialized tools to compute a flight curve, which describes the seasonal distribution of the species, and calculates the abundance index. These steps are critical for normalizing data across different sites and sampling events.

Statistical modeling is performed using GLMM-PQL to determine expected temporal trends and GLS for modeling those trends over time. The workflow includes an autocorrelation test (ACF) to validate the model's assumptions regarding temporal dependency. Final outputs include statistical summaries and visualizations generated via ggplot2 and dedicated plotting tools to illustrate population dynamics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | regionalGAM.csv | data_input |  |


Ensure the input `regionalGAM.csv` is uploaded as a tabular or CSV file, verifying that column headers match the expected ecology format for flight curve analysis. While this workflow typically processes a single dataset, you can utilize dataset collections if analyzing multiple regions or species simultaneously to streamline batch execution. Refer to the `README.md` for specific column requirements and detailed parameter settings for the GAM and GLMMPQL steps. For automated testing or command-line execution, use `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.1 |  |
| 2 | Count | Count1 |  |
| 3 | Flight curve | toolshed.g2.bx.psu.edu/repos/ecology/regionalgam_flight_curve/regionalgam_flight_curve/1.5 |  |
| 4 | Abundance index | toolshed.g2.bx.psu.edu/repos/ecology/regionalgam_ab_index/regionalgam_ab_index/1.5 |  |
| 5 | Scatterplot w ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy1 |  |
| 6 | Expected temporal trend | toolshed.g2.bx.psu.edu/repos/ecology/regionalgam_glmmpql/regionalgam_glmmpql/1.5 |  |
| 7 | Model temporal trend | toolshed.g2.bx.psu.edu/repos/ecology/regionalgam_gls/regionalgam_gls/1.5 |  |
| 8 | Autocorrelation test | toolshed.g2.bx.psu.edu/repos/ecology/regionalgam_autocor_acf/regionalgam_autocor_acf/1.5 |  |
| 9 | Plot abundance | toolshed.g2.bx.psu.edu/repos/ecology/regionalgam_plot_trend/regionalgam_plot_trend/1.5 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | output | output |
| 4 | output | output |
| 6 | output2 | output2 |
| 6 | output | output |
| 7 | output2 | output2 |
| 7 | output | output |
| 8 | output_res_values | output_res_values |
| 8 | output | output |
| 9 | output | output |
| 9 | output_tsv | output_tsv |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-tutorial-training-regionalgam-complete-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-tutorial-training-regionalgam-complete-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-tutorial-training-regionalgam-complete-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-tutorial-training-regionalgam-complete-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-tutorial-training-regionalgam-complete-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-tutorial-training-regionalgam-complete-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)