---
name: stochastic-gravitational-wave-backgorund-sgwb-tool
description: This Galaxy workflow utilizes the sgwb_astro_tool to model and analyze the stochastic gravitational wave background within the field of astrophysics. Use this skill when you need to characterize the cumulative signal from unresolved gravitational wave sources or investigate the cosmological implications of background noise in interferometric data.
homepage: https://eurosciencegateway.eu/
metadata:
  docker_image: "N/A"
---

# stochastic-gravitational-wave-backgorund-sgwb-tool

## Overview

This Galaxy workflow is designed to facilitate the study and modeling of the Stochastic Gravitational Wave Background (SGWB). It provides a structured environment for researchers to analyze the collective signal from unresolved gravitational wave sources, such as distant binary black hole mergers or primordial cosmic events.

The workflow utilizes the [sgwb_astro_tool](https://toolshed.g2.bx.psu.edu/repos/astroteam/sgwb_astro_tool/sgwb_astro_tool/0.0.1+galaxy0) to perform its core astrophysical calculations. By integrating this tool into a Galaxy pipeline, the process ensures reproducibility and allows for the efficient handling of complex gravitational wave datasets.

The current implementation consists of two sequential steps using the SGWB tool. This configuration enables users to compare different astrophysical models or process multiple parameter sets simultaneously, providing a comprehensive view of the potential gravitational wave background signals.

## Inputs and data preparation

_None listed._


Ensure input data is provided in tabular format containing the required astrophysical parameters for gravitational wave background modeling. Utilizing dataset collections is highly effective for managing multiple parameter realizations or batch processing across the SGWB tool steps. Please consult the README.md for exhaustive details on specific column requirements and configuration settings. For streamlined testing and execution, consider using `planemo workflow_job_init` to create your `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | SGWB | toolshed.g2.bx.psu.edu/repos/astroteam/sgwb_astro_tool/sgwb_astro_tool/0.0.1+galaxy0 |  |
| 1 | SGWB | toolshed.g2.bx.psu.edu/repos/astroteam/sgwb_astro_tool/sgwb_astro_tool/0.0.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Stochastic_Gravitational_Wave_Backgorund_(SGWB)_tool.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Stochastic_Gravitational_Wave_Backgorund_(SGWB)_tool.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Stochastic_Gravitational_Wave_Backgorund_(SGWB)_tool.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Stochastic_Gravitational_Wave_Backgorund_(SGWB)_tool.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Stochastic_Gravitational_Wave_Backgorund_(SGWB)_tool.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Stochastic_Gravitational_Wave_Backgorund_(SGWB)_tool.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)