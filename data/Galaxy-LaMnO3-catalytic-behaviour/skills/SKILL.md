---
name: lamno3-catalytic-behaviour
description: This Galaxy workflow analyzes the catalytic behavior of LaMnO3 by processing Mn K-edge and La L3-edge X-ray absorption time-series data using Larch Athena, Feff, and Artemis tools. Use this skill when you need to investigate dynamic changes in the local atomic structure and oxidation states of perovskite catalysts during chemical reactions.
homepage: https://eurosciencegateway.eu/
metadata:
  docker_image: "N/A"
---

# lamno3-catalytic-behaviour

## Overview

This workflow investigates the catalytic behavior of Lanthanum Manganite (LaMnO3) through the analysis of X-ray Absorption Spectroscopy (XAS) data. It processes experimental time-series datasets from the Mn K-edge and La L3-edge, utilizing crystallographic information files (CIF) for Mn2O3 and LaMnO3 to provide the necessary structural frameworks for theoretical modeling.

The analysis pipeline begins with [larch_athena](https://toolshed.g2.bx.psu.edu/view/muon-spectroscopy-computational-project/larch_athena), which performs data normalization and background subtraction on the absorption spectra. Following initial processing, [larch_feff](https://toolshed.g2.bx.psu.edu/view/muon-spectroscopy-computational-project/larch_feff) is employed to calculate theoretical Extended X-ray Absorption Fine Structure (EXAFS) scattering paths based on the input crystal structures.

In the final stages, specific scattering paths are isolated and fitted to the experimental data using [larch_artemis](https://toolshed.g2.bx.psu.edu/view/muon-spectroscopy-computational-project/larch_artemis). The workflow generates various visualizations via [larch_plot](https://toolshed.g2.bx.psu.edu/view/muon-spectroscopy-computational-project/larch_plot) to characterize the local atomic environment and electronic transitions of the catalyst during the reaction series.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Upload: Figure 2-5_ Mn_K_edge_LMOA_time_series.prj | data_input |  |
| 1 | Upload: Figure 2-5_ La_L3_edge_LMOA_time_series.prj | data_input |  |
| 2 | mp-565203_Mn2O3.cif | data_input |  |
| 3 | 1667441.cif | data_input |  |


To run this workflow, ensure you have uploaded the required Athena project files (.prj) for the Mn K-edge and La L3-edge time series alongside the corresponding structural CIF files (.cif) for Mn2O3 and LaMnO3. These inputs should be handled as individual datasets to be correctly mapped to the Larch Athena and FEFF tool steps. For automated execution and parameter mapping, you can use `planemo workflow_job_init` to generate a `job.yml` file. Detailed configuration settings for the XAS analysis and path selections are documented in the README.md. Always verify that the atom sites in your CIF files match the expected coordination shells for accurate FEFF calculations.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 5 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 6 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 7 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_feff/larch_feff/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_feff/larch_feff/0.9.80+galaxy0 |  |
| 8 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_feff/larch_feff/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_feff/larch_feff/0.9.80+galaxy0 |  |
| 9 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 |  |
| 10 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 |  |
| 11 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 |  |
| 12 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 |  |
| 13 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_select_paths/larch_select_paths/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_select_paths/larch_select_paths/0.9.80+galaxy0 |  |
| 14 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_select_paths/larch_select_paths/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_select_paths/larch_select_paths/0.9.80+galaxy0 |  |
| 15 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_artemis/larch_artemis/0.9.80+galaxy2 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_artemis/larch_artemis/0.9.80+galaxy2 |  |
| 16 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_artemis/larch_artemis/0.9.80+galaxy2 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_artemis/larch_artemis/0.9.80+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run f06ca0d3d213b10e.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run f06ca0d3d213b10e.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run f06ca0d3d213b10e.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init f06ca0d3d213b10e.ga -o job.yml`
- Lint: `planemo workflow_lint f06ca0d3d213b10e.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `f06ca0d3d213b10e.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)