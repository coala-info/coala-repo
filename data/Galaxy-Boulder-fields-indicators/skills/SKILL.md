---
name: boulder-fields-indicators
description: "This ecology workflow processes boulder field data from champbloc_ivr.csv, champbloc_qecb.csv, and ficheterrain.csv using IVR, QECB-Dissimilarity, and Diversity tools to calculate ecological indicators. Use this skill when you need to evaluate the ecological status, species diversity, and community dissimilarity of intertidal boulder field habitats."
homepage: https://workflowhub.eu/workflows/661
---

# Boulder fields indicators

## Overview

This Galaxy workflow is designed to assess the ecological health and physical vulnerability of boulder field ecosystems. By processing standardized field observation data, the pipeline generates key indicators used to monitor biodiversity and the impact of environmental pressures on these specific coastal habitats.

The workflow requires three primary CSV input files: `champbloc_ivr.csv`, `champbloc_qecb.csv`, and `ficheterrain.csv`. These inputs provide the raw field data necessary for calculating indices related to species distribution and the physical stability of the boulders.

The analysis is performed through three specialized tools from the [ecology toolshed](https://toolshed.g2.bx.psu.edu/repos/ecology/). The [IVR](https://toolshed.g2.bx.psu.edu/repos/ecology/cb_ivr/cb_ivr/0.0.0) tool calculates the Overturning Vulnerability Index, while the [QECB-Dissimilarity](https://toolshed.g2.bx.psu.edu/repos/ecology/cb_dissim/cb_dissim/0.0.0) and [Diversity](https://toolshed.g2.bx.psu.edu/repos/ecology/cb_div/cb_div/0.0.0) tools evaluate ecological quality and biological variety across the sampled sites.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | champbloc_ivr.csv | data_input |  |
| 1 | champbloc_qecb.csv | data_input |  |
| 2 | ficheterrain.csv | data_input |  |


Ensure all input files are uploaded in CSV format, specifically matching the expected schemas for IVR, QECB, and field data. While these inputs are typically handled as individual datasets, you can use collections if processing multiple sites simultaneously. Refer to the README.md for specific column requirements and data formatting standards necessary for the ecological indicator tools. You can automate the configuration of these inputs by generating a job.yml file using planemo workflow_job_init.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | IVR | toolshed.g2.bx.psu.edu/repos/ecology/cb_ivr/cb_ivr/0.0.0 |  |
| 4 | QECB-Dissimilarity | toolshed.g2.bx.psu.edu/repos/ecology/cb_dissim/cb_dissim/0.0.0 |  |
| 5 | Diversity | toolshed.g2.bx.psu.edu/repos/ecology/cb_div/cb_div/0.0.0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Boulder_fields_indicators.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Boulder_fields_indicators.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Boulder_fields_indicators.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Boulder_fields_indicators.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Boulder_fields_indicators.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Boulder_fields_indicators.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
