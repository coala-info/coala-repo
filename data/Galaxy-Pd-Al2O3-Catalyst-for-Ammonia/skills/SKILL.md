---
name: paper_6-pdal2o3_100c_175c_300c
description: "This workflow processes X-ray absorption spectroscopy project files for Pd/Al2O3 catalysts at multiple reaction temperatures using Larch Athena and Larch Plot. Use this skill when you need to characterize the structural changes and chemical states of palladium catalysts during ammonia-related reactions across a temperature gradient from 100°C to 300°C."
homepage: https://workflowhub.eu/workflows/1803
---

# Paper_6-PdAl2O3_100C_175C_300C

## Overview

This Galaxy workflow processes X-ray Absorption Spectroscopy (XAS) data for a Pd/Al2O3 catalyst system across various temperature profiles. It utilizes four primary project inputs: a reference state in Helium after reduction and three reaction states at 100°C, 175°C, and 300°C.

The core of the analysis is performed using the [larch_athena](https://toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena) tool, which executes a series of data processing steps including normalization, background subtraction, and energy alignment. These steps are repeated across multiple iterations to handle the different temperature datasets, ensuring consistent preparation for structural and electronic analysis.

Finally, the workflow employs [larch_plot](https://toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot) to generate visual representations of the processed spectra. These plots facilitate the comparative study of the catalyst's behavior and phase changes as a function of temperature, providing insights into the Pd/Al2O3 system's performance during the reaction.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | He_after_reduction.prj | data_input |  |
| 1 | reaction-100C.prj | data_input |  |
| 2 | 175C.prj | data_input |  |
| 3 | 300C.prj | data_input |  |


To run this workflow, ensure all input files are uploaded in the Athena project format (`.prj`), as these contain the necessary X-ray absorption spectroscopy data groups for processing. Each dataset should be uploaded individually to match the specific temperature-based input ports (100C, 175C, 300C, and post-reduction). For comprehensive details on parameter settings and data origin, please refer to the `README.md` file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 5 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 6 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 7 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 8 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 9 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 10 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 11 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 12 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 13 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 14 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 15 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 16 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 17 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 18 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 19 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 20 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 21 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 22 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 23 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 24 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 25 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 26 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 27 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 28 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 29 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 30 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 31 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 |  |
| 32 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 |  |
| 33 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 |  |
| 34 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 |  |
| 35 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 |  |
| 36 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run eac4157620e0fcac.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run eac4157620e0fcac.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run eac4157620e0fcac.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init eac4157620e0fcac.ga -o job.yml`
- Lint: `planemo workflow_lint eac4157620e0fcac.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `eac4157620e0fcac.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
