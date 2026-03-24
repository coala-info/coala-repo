---
name: capturing-mitoflashes
description: "This workflow processes time-lapse microscopy images to automatically detect and measure mitoflashes using spot detection, nearest neighbor linking, and curve fitting tools. Use this skill when you need to quantify transient mitochondrial activity or track the dynamics of small, spot-like organelles across a temporal image sequence."
homepage: https://workflowhub.eu/workflows/1499
---

# Capturing mitoflashes

## Overview

This Galaxy workflow is designed for the automated detection and measurement of mitoflashes within time-lapse microscopy images. While specifically optimized for mitochondrial activity, the pipeline is versatile enough to be used for the detection and tracking of other spot-like organelles characterized by small motion.

The analysis follows a three-step technical process. It begins with 2D spot detection to identify potential mitoflashes, followed by temporal linking using a nearest-neighbors approach to track these spots across successive frames. Finally, the workflow performs curve fitting to provide precise measurements and quantification of the detected events.

Developed as part of the [GTN](https://training.galaxyproject.org/) ecosystem and licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/), this tool provides a standardized method for mitochondrial research. If this workflow facilitates your data analysis, please cite the following research: [https://doi.org/10.1097/j.pain.0000000000002642](https://doi.org/10.1097/j.pain.0000000000002642).

## Inputs and data preparation

_None listed._


Ensure your input time-lapse microscopy images are in a compatible format such as TIFF and organized as a dataset collection to facilitate efficient batch processing across the temporal sequence. Using a list collection is particularly effective for managing the frames required by the linking and curve-fitting tools. Refer to the README.md for comprehensive details on parameter settings and data preparation specific to your imaging hardware. You can also use `planemo workflow_job_init` to create a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Spot Detection | toolshed.g2.bx.psu.edu/repos/imgteam/spot_detection_2d/ip_spot_detection_2d/0.0.1 | Localization and intensity measurement of mitochondria in all frames.  (*Note: 1. The input image sequence should be a single TIFF stack; 2. parameter 'Sigma' needs to be adapted for the input image.) |
| 1 | Perform linking in time series (nearest neighbors) | toolshed.g2.bx.psu.edu/repos/imgteam/points_association_nn/ip_points_association_nn/0.0.3-2 | Association of all detected mitochondria.   (*Note: Parameter 'Neighborhood size' needs to be adapted for the size and moving speed of mitochondria in images.) |
| 2 | Perform curve fitting | toolshed.g2.bx.psu.edu/repos/imgteam/curve_fitting/ip_curve_fitting/0.0.3-2 | For each mitochondrion, a curve is fitted to its intensities over time.  If the significance level is set to a value greater than zero, an additional curve is generated to assist in distinguishing mitoflash events (significant intensity deviation from the fitted curve). |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | Spot Detection of Mitoflashes | fn_out |
| 1 | Spot Detection Across Frames | fn_out |
| 2 | Curve Fitting for Mitoflash Detection | fn_out |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run capturing-mitoflashes.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run capturing-mitoflashes.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run capturing-mitoflashes.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init capturing-mitoflashes.ga -o job.yml`
- Lint: `planemo workflow_lint capturing-mitoflashes.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `capturing-mitoflashes.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
