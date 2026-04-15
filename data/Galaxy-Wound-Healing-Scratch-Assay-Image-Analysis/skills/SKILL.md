---
name: wound-healing-scrath-assay-analysis
description: This Galaxy workflow processes image dataset collections to perform wound healing scratch assay analysis using the woundhealing_scratch_assay tool to generate TIF visualizations and CSV data. Use this skill when you need to quantify cell migration, wound closure rates, or tissue repair dynamics from microscopy images in regenerative medicine or oncology research.
homepage: https://www.embl.org/about/info/data-science-centre/bioimage-analysis-services/
metadata:
  docker_image: "N/A"
---

# wound-healing-scrath-assay-analysis

## Overview

This workflow automates the analysis of wound healing scratch assays, a standard method used to study cell migration and tissue regeneration. It is designed to process an input dataset collection, typically consisting of time-lapse microscopy images of a cell monolayer where a "wound" or scratch has been introduced.

The core processing is handled by the [woundhealing_scratch_assay](https://toolshed.g2.bx.psu.edu/repos/bgruening/woundhealing_scratch_assay/woundhealing_scratch_assay/1.6.1+galaxy0) tool. This tool identifies the denuded area in each frame, allowing for the quantification of the wound closure rate and other kinetic parameters of cell motility.

The workflow generates two primary outputs: a collection of processed TIF images that visualize the detected wound boundaries and a CSV file containing the quantitative measurements. These results facilitate the comparison of migration speeds and healing efficiency across different experimental conditions. For detailed setup and configuration instructions, please refer to the README.md in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset collection | data_collection_input |  |


Organize your scratch assay images, such as TIFF or PNG files, into a dataset collection to facilitate efficient batch processing of multiple time points. Ensure all images share consistent dimensions and orientations to maintain accuracy across the automated gap detection steps. Consult the `README.md` for exhaustive details on specific tool parameters and preprocessing requirements. For automated testing, you may use `planemo workflow_job_init` to generate a corresponding `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Wound healing scratch assay | toolshed.g2.bx.psu.edu/repos/bgruening/woundhealing_scratch_assay/woundhealing_scratch_assay/1.6.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | tif_output | tif_output |
| 1 | csv_output | csv_output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Wound_Healing_Scrath_Assay_Analysis.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Wound_Healing_Scrath_Assay_Analysis.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Wound_Healing_Scrath_Assay_Analysis.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Wound_Healing_Scrath_Assay_Analysis.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Wound_Healing_Scrath_Assay_Analysis.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Wound_Healing_Scrath_Assay_Analysis.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)