---
name: paper-9-n2o-lamno3-figs1
description: "This Galaxy workflow processes XANES time series project files to analyze N2O decomposition on LaMnO3 catalysts using Larch Athena and Larch Plot tools. Use this skill when you need to characterize the oxidation state and local coordination environment of manganese catalysts during time-resolved catalytic reaction experiments."
homepage: https://workflowhub.eu/workflows/1806
---

# Paper 9 N2O-LaMnO3 Figs1

## Overview

This Galaxy workflow is designed to process and visualize X-ray Absorption Near Edge Structure (XANES) data related to the decomposition of $N_2O$ on a $LaMnO_3$ catalyst. The analysis begins with an Athena project file (`Figure_1_XANES_time_series.prj`) containing time-series spectral data as the primary input.

The workflow utilizes the [Larch Athena](https://toolshed.g2.bx.psu.edu/view/muon-spectroscopy-computational-project/larch_athena/) tool across several steps to perform data manipulation and preparation. These steps are essential for handling the spectroscopic project files, likely involving normalization or background subtraction of the XANES spectra to ensure consistency across the time series.

Following the data processing, the workflow employs the [Larch Plot](https://toolshed.g2.bx.psu.edu/view/muon-spectroscopy-computational-project/larch_plot/) tool to generate multiple graphical outputs. These visualizations correspond to the figures presented in the associated research paper, providing a clear representation of the electronic and structural changes in the catalyst during the reaction.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Figure_1_XANES_time_series.prj | data_input |  |


This workflow requires a single Athena project file (`.prj`) containing the XANES time series data as the primary input dataset. Ensure that the data groups within the project file are correctly formatted and labeled to allow the Larch Athena tools to extract the relevant spectra for plotting. For comprehensive details on the specific normalization and energy range parameters used in this analysis, refer to the `README.md` file. You can also use `planemo workflow_job_init` to create a `job.yml` file for streamlined execution and consistent parameter configuration across different environments.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.75+galaxy2 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.75+galaxy2 |  |
| 2 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.75+galaxy2 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.75+galaxy2 |  |
| 3 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.75+galaxy2 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.75+galaxy2 |  |
| 4 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.75+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.75+galaxy0 |  |
| 5 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.75+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.75+galaxy0 |  |
| 6 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.75+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.75+galaxy0 |  |
| 7 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.75+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.75+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run 5bfd0ef990bc80c4.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run 5bfd0ef990bc80c4.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run 5bfd0ef990bc80c4.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init 5bfd0ef990bc80c4.ga -o job.yml`
- Lint: `planemo workflow_lint 5bfd0ef990bc80c4.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `5bfd0ef990bc80c4.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
