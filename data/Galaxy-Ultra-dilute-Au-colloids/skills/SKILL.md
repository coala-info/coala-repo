---
name: workflow-constructed-from-history-extracting-structural-info
description: "This Galaxy workflow processes compiled X-ray Absorption Spectroscopy data of gold colloids and TiO2-supported nanoparticles using Larch Athena and Larch Plot tools. Use this skill when you need to characterize the structural evolution and identify nanoparticle growth in ultra-dilute gold colloids during their immobilization onto solid supports."
homepage: https://workflowhub.eu/workflows/1800
---

# Workflow constructed from history ''Extracting structural information of Au colloids at ultra-dilute concentrations: identification of growth during nanoparticle immobilization (paper-3''

## Overview

This workflow is designed to analyze X-ray Absorption Spectroscopy (XAS) data to investigate the structural characteristics of gold (Au) colloids at ultra-dilute concentrations. It specifically supports research into nanoparticle growth during the immobilization process onto TiO2 supports, facilitating the extraction of detailed structural information from challenging, low-concentration samples.

The pipeline utilizes the [Larch](https://xraypy.github.io/xraylarch/) software suite integrated into Galaxy. It begins with a compiled XAS data project file (`.prj`) and proceeds through multiple iterations of the `larch_athena` tool. These steps are used to perform essential data processing tasks such as normalization, background subtraction, and Fourier transforms to convert raw absorption spectra into interpretable structural data.

The final stages of the workflow employ `larch_plot` to generate visual representations of the processed spectra. This allows for the comparative analysis of the Au colloids and TiO2-supported nanoparticles, helping researchers identify changes in particle size or coordination environment that occur during the immobilization phase.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Compiled_XAS_data_Colloid_and_TiO2_supported_Au.prj | data_input |  |


Ensure the primary input is uploaded as a `.prj` Athena project file to maintain compatibility with the Larch tool suite. While this workflow processes a single dataset, users handling multiple samples should consider organizing them into a dataset collection for more efficient batch processing. Refer to the `README.md` for comprehensive details on parameter settings and specific data preparation requirements. For automated execution, you can initialize the environment using `planemo workflow_job_init` to generate a `job.yml` template.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 2 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 3 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 4 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 5 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 6 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 7 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 8 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 9 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 |  |
| 10 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run 1a5c6ad02e8082a6.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run 1a5c6ad02e8082a6.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run 1a5c6ad02e8082a6.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init 1a5c6ad02e8082a6.ga -o job.yml`
- Lint: `planemo workflow_lint 1a5c6ad02e8082a6.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `1a5c6ad02e8082a6.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
