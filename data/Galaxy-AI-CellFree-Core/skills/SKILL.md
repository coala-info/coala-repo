---
name: ai-cellfree-core
description: This workflow processes fluorescence and luminescence data using the iCFree suite to extract, calibrate, and learn from cell-free system experiments while generating plate designs and instructions for subsequent iterations. Use this skill when you need to automate the analysis of cell-free expression data and generate optimized experimental designs for active learning in synthetic biology.
homepage: https://www.micalis.fr/equipe/cell-free/
metadata:
  docker_image: "N/A"
---

# ai-cellfree-core

## Overview

The AI-CellFree - Core workflow is designed to streamline the processing, calibration, and analysis of experimental data from cell-free systems. It accepts three primary inputs: raw fluorescence or luminescence values, a sampling file, and a reference file used for calibration. By integrating the iCFree tool suite, the workflow automates the transition from raw experimental readings to actionable laboratory instructions.

The pipeline begins by extracting data and performing calibration using the [iCFree extractor](https://toolshed.g2.bx.psu.edu/repos/tduigou/icfree_extractor/icfree_extractor/2.9.0+galaxy9) and [iCFree calibrator](https://toolshed.g2.bx.psu.edu/repos/tduigou/icfree_calibrator/icfree_calibrator/2.9.0+galaxy9). This process normalizes the input values against reference standards, producing calibrated datasets, control points, and diagnostic graphs to ensure data quality and consistency.

Following calibration, the [iCFree learner](https://toolshed.g2.bx.psu.edu/repos/tduigou/icfree_learner/icfree_learner/2.9.0+galaxy9) analyzes the processed data to generate statistical insights and visualizations. The workflow concludes with experimental design and execution support through the [iCFree plate designer](https://toolshed.g2.bx.psu.edu/repos/tduigou/icfree_plate_designer/icfree_plate_designer/2.9.0+galaxy0) and [iCFree instructor](https://toolshed.g2.bx.psu.edu/repos/tduigou/icfree_instructor/icfree_instructor/2.9.0+galaxy0), which output specific instructions for setting up subsequent plates and laboratory protocols.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Fluo/Lumi values | data_input |  |
| 1 | Sampling file | data_input |  |
| 2 | Reference file for calibration | data_input |  |


Ensure your fluorescence/luminescence values, sampling, and reference files are formatted as CSV or TSV files to maintain compatibility with the iCFree tool suite. While individual datasets are standard for single runs, you can utilize data collections to manage multiple experimental replicates or plate layouts efficiently. Refer to the included README.md for specific column headers and metadata requirements necessary for successful extraction and calibration. You can also automate the execution of this workflow by generating a `job.yml` file using `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | iCFree extractor | toolshed.g2.bx.psu.edu/repos/tduigou/icfree_extractor/icfree_extractor/2.9.0+galaxy9 |  |
| 4 | iCFree calibrator | toolshed.g2.bx.psu.edu/repos/tduigou/icfree_calibrator/icfree_calibrator/2.9.0+galaxy9 |  |
| 5 | iCFree learner | toolshed.g2.bx.psu.edu/repos/tduigou/icfree_learner/icfree_learner/2.9.0+galaxy9 |  |
| 6 | iCFree plate designer | toolshed.g2.bx.psu.edu/repos/tduigou/icfree_plate_designer/icfree_plate_designer/2.9.0+galaxy0 |  |
| 7 | iCFree instructor | toolshed.g2.bx.psu.edu/repos/tduigou/icfree_instructor/icfree_instructor/2.9.0+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | output | output |
| 4 | output_control_points | output_control_points |
| 4 | output_graph | output_graph |
| 4 | output_calibrated | output_calibrated |
| 5 | output_csv | output_csv |
| 5 | output_png | output_png |
| 7 | iCFree instructor - Instructions | output_instructor |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-AI-CellFree_-_Core.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-AI-CellFree_-_Core.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-AI-CellFree_-_Core.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-AI-CellFree_-_Core.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-AI-CellFree_-_Core.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-AI-CellFree_-_Core.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)