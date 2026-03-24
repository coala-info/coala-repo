---
name: paper-1-xanes-lcf-exafs
description: "This Galaxy workflow performs XANES, LCF, and EXAFS analysis on Pt and Sn edge X-ray absorption spectra using Larch tools and crystallographic information files. Use this skill when you need to characterize the oxidation states and local atomic structures of bimetallic nanoparticle electrocatalysts under different reactive gas environments."
homepage: https://workflowhub.eu/workflows/1798
---

# Paper 1: XANES, LCF, EXAFS

## Overview

This workflow provides a comprehensive pipeline for analyzing X-ray Absorption Spectroscopy (XAS) data, specifically tailored for Pt3Sn nanoparticle electrocatalysts. It processes experimental data from both the Sn K-edge and Pt L3-edge collected under various environmental conditions, including H2, Ar, and Air. The analysis covers the full spectrum of XAS techniques, including X-ray Absorption Near Edge Structure (XANES) and Extended X-ray Absorption Fine Structure (EXAFS).

The initial stages utilize [larch_athena](https://toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena) for data normalization and energy calibration using Sn foil and SnO2 standards. Following preparation, the workflow employs [larch_lcf](https://toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_lcf) to perform Linear Combination Fitting. This allows for the quantification of species and oxidation states by fitting sample spectra against known reference materials.

For structural refinement, the workflow integrates [larch_feff](https://toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_feff) to calculate theoretical scattering paths from CIF crystallographic files of Pt3Sn, SnO2, and PtO2. These models are then used within [larch_artemis](https://toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_artemis) to perform EXAFS fitting, enabling the determination of local atomic coordination, bond lengths, and disorder parameters.

The entire process is supported by [larch_plot](https://toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot) for visualizing fits and spectral transformations. This automated approach ensures reproducible characterization of the catalysts' local environment and electronic structure across different chemical states.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Sn Foil | data_input |  |
| 1 | Sn foil Calibration | parameter_input |  |
| 2 | SnO2 | data_input |  |
| 3 | SnO2 Calibration | parameter_input |  |
| 4 | Sn K edge H2 under H2 | data_collection_input |  |
| 5 | Sn K edge under H2 Calibration | parameter_input |  |
| 6 | Sn K edge H2 | data_collection_input |  |
| 7 | Sn K edge Ar | data_collection_input |  |
| 8 | Sn K edge Air | data_collection_input |  |
| 9 | Sn3Pt Sn Calibration | parameter_input |  |
| 10 | Pt L3 edge H2 under H2 | data_collection_input |  |
| 11 | Pt L3 edge under H2 Calibration | parameter_input |  |
| 12 | Pt L3 edge H2 | data_collection_input |  |
| 13 | Pt L3 edge Ar | data_collection_input |  |
| 14 | Pt L3 edge Air | data_collection_input |  |
| 15 | Sn3Pt Pt Calibration | parameter_input |  |
| 16 | Pt3Sn Cif | data_input |  |
| 17 | SnO2 Cif | data_input |  |
| 18 | PtO2 Cif | data_input |  |


Ensure all spectral data are uploaded as text or tabular files, while structural models for Feff calculations must be provided in .cif format. Group experimental spectra into data collections to manage the various gas environments efficiently, but keep reference foils and calibration parameters as individual datasets. Refer to the README.md for the specific energy calibration values and metadata required to populate the parameter input fields. You can use `planemo workflow_job_init` to generate a `job.yml` file for faster configuration of these numerous inputs.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 19 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 |  |
| 20 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 |  |
| 21 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 |  |
| 22 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 |  |
| 23 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 |  |
| 24 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 |  |
| 25 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 |  |
| 26 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 |  |
| 27 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 |  |
| 28 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy0 |  |
| 29 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_feff/larch_feff/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_feff/larch_feff/0.9.80+galaxy0 |  |
| 30 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_feff/larch_feff/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_feff/larch_feff/0.9.80+galaxy0 |  |
| 31 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_feff/larch_feff/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_feff/larch_feff/0.9.80+galaxy0 |  |
| 32 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_feff/larch_feff/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_feff/larch_feff/0.9.80+galaxy0 |  |
| 33 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_lcf/larch_lcf/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_lcf/larch_lcf/0.9.80+galaxy0 |  |
| 34 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_lcf/larch_lcf/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_lcf/larch_lcf/0.9.80+galaxy0 |  |
| 35 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_lcf/larch_lcf/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_lcf/larch_lcf/0.9.80+galaxy0 |  |
| 36 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_lcf/larch_lcf/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_lcf/larch_lcf/0.9.80+galaxy0 |  |
| 37 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy0 |  |
| 38 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_lcf/larch_lcf/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_lcf/larch_lcf/0.9.80+galaxy0 |  |
| 39 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_lcf/larch_lcf/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_lcf/larch_lcf/0.9.80+galaxy0 |  |
| 40 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy0 |  |
| 41 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_select_paths/larch_select_paths/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_select_paths/larch_select_paths/0.9.80+galaxy0 |  |
| 42 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_artemis/larch_artemis/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_artemis/larch_artemis/0.9.80+galaxy1 |  |
| 43 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_artemis/larch_artemis/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_artemis/larch_artemis/0.9.80+galaxy1 |  |
| 44 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_artemis/larch_artemis/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_artemis/larch_artemis/0.9.80+galaxy1 |  |
| 45 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_artemis/larch_artemis/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_artemis/larch_artemis/0.9.80+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run bf972370cf6dfa23.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run bf972370cf6dfa23.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run bf972370cf6dfa23.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init bf972370cf6dfa23.ga -o job.yml`
- Lint: `planemo workflow_lint bf972370cf6dfa23.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `bf972370cf6dfa23.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
