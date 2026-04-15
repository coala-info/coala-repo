---
name: workflow-constructed-from-history-unnamed-history
description: This multi-wavelength light curve analysis workflow processes astronomical data to detect Gamma-Ray Bursts and analyze their temporal evolution using HESS and specialized lightcurve analysis tools. Use this skill when you need to characterize the high-energy emission profiles of transient astrophysical events and compare light curves across different energy bands.
homepage: https://eurosciencegateway.eu/
metadata:
  docker_image: "N/A"
---

# workflow-constructed-from-history-unnamed-history

## Overview

This workflow automates a multi-wavelength light curve analysis for astronomical data, specifically targeting Gamma-Ray Bursts (GRBs). The process begins with a dedicated [GRB detection](https://usegalaxy.org/) step, followed by data processing using the [HESS](https://toolshed.g2.bx.psu.edu/repos/astroteam/hess_astro_tool/hess_astro_tool/0.0.1+galaxy0) tool to handle high-energy stereoscopic system observations.

The core of the pipeline utilizes three distinct instances of the [lightcurve-analysis](https://github.com/galaxyproject/tools-iuc) tool. These steps are configured to model and analyze light curve data across different energy bands or parameters, allowing for a comprehensive temporal study of the detected astronomical events.

Originally constructed from a Galaxy history, this workflow provides a reproducible framework for moving from initial detection to refined multi-wavelength analysis. It streamlines the integration of specialized astronomical tools, making complex astrophysical modeling more accessible within the Galaxy ecosystem.

## Inputs and data preparation

_None listed._


Ensure your input data are in standard astronomical formats such as FITS or CSV, specifically formatted for GRB event lists and HESS instrument responses. Use dataset collections to manage multi-wavelength observations efficiently, as the lightcurve-analysis tools are designed to process multiple spectral bands in parallel. Refer to the `README.md` file for comprehensive details on parameter settings and specific data structure requirements. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | GRB detection | grb-detection_astro_tool |  |
| 1 | HESS | toolshed.g2.bx.psu.edu/repos/astroteam/hess_astro_tool/hess_astro_tool/0.0.1+galaxy0 |  |
| 2 | lightcurve-analysis | lightcurve_analysis_astro_tool_pr91 |  |
| 3 | lightcurve-analysis | lightcurve_analysis_astro_tool_pr91 |  |
| 4 | lightcurve-analysis | lightcurve_analysis_astro_tool_pr91 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run multi-lc.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run multi-lc.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run multi-lc.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init multi-lc.ga -o job.yml`
- Lint: `planemo workflow_lint multi-lc.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `multi-lc.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)