---
name: workflow-palladium-co-oxidation
description: This workflow processes X-ray absorption spectroscopy data from palladium-catalyzed CO oxidation experiments using Larch Athena and Larch Plot tools on project files containing various temperature and gas conditions. Use this skill when you need to analyze the electronic and local structural changes of palladium catalysts during CO oxidation under varying thermal and atmospheric environments.
homepage: https://eurosciencegateway.eu/
metadata:
  docker_image: "N/A"
---

# workflow-palladium-co-oxidation

## Overview

This workflow facilitates the analysis of palladium-catalyzed carbon monoxide (CO) oxidation using X-ray absorption spectroscopy (XAS) data. It processes experimental datasets collected under varying thermal and atmospheric conditions, specifically comparing catalyst behavior at 100°C in Helium against 280°C environments both with and without Hydrogen.

The pipeline relies heavily on the [Larch Athena](https://toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena) tool suite to perform data reduction and normalization. Multiple processing steps are employed to handle the input project files, likely performing essential XAS tasks such as background subtraction, edge-step normalization, and potentially Fourier transforms to examine the local atomic structure of the palladium catalyst.

In the final stages, the workflow utilizes [Larch Plot](https://toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot) to generate visual representations of the processed spectra. These outputs enable researchers to compare the oxidation states and coordination environments of the palladium species across the different experimental parameters provided in the input files.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | 100C_Helium.prj | data_input |  |
| 1 | 280C_without_H2.prj | data_input |  |
| 2 | 280C_with_H2.prj | data_input |  |


Ensure all input files are provided in the Athena project format (`.prj`) to maintain compatibility with the Larch Athena tool steps. This workflow is designed to process individual datasets for each temperature condition rather than data collections, so upload each file separately to your Galaxy history. Refer to the `README.md` for comprehensive details on the experimental parameters and specific data processing settings required for this analysis. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and parameter management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 4 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 5 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 6 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 7 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 8 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 9 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 10 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 11 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 12 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 |  |
| 13 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 |  |
| 14 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run 6f06eaf80b70511e.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run 6f06eaf80b70511e.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run 6f06eaf80b70511e.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init 6f06eaf80b70511e.ga -o job.yml`
- Lint: `planemo workflow_lint 6f06eaf80b70511e.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `6f06eaf80b70511e.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)