---
name: extended-source
description: "This workflow simulates extended gamma-ray source halos using CRbeam and astrophysical parameters such as redshift, IGMF, and EBL to produce spectral plots and source images. Use this skill when you need to analyze the impact of the intergalactic magnetic field on the observable spatial and energy distributions of secondary gamma-ray emission from distant point sources."
homepage: https://workflowhub.eu/workflows/1369
---

# Extended Source

## Overview

This workflow calculates the extended gamma-ray source halo produced by cosmic ray interactions using the [crbeam](https://toolshed.g2.bx.psu.edu/repos/astroteam/crbeam_astro_tool/crbeam_astro_tool/0.0.2+galaxy0) simulation engine. It models the propagation of particles from a source by incorporating astrophysical parameters such as redshift, Intergalactic Magnetic Field (IGMF) properties, and Extragalactic Background Light (EBL) models.

The pipeline processes raw simulation results through a series of data transformation steps. It utilizes [astropy fits2csv](https://toolshed.g2.bx.psu.edu/repos/astroteam/astropy_fits2csv/astropy_fits2csv/0.1.0+galaxy0) for format conversion and [AWK-based text processing](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1) to reformat and augment the Monte Carlo data. These steps prepare the datasets for detailed spectral analysis and spatial imaging.

The final stage generates comprehensive astrophysical products, including primary and secondary gamma-ray spectra and spatial source images. Using [Plot Tools](https://toolshed.g2.bx.psu.edu/repos/astroteam/plot_tools_astro_tool/plot_tools_astro_tool/0.0.1+galaxy0), the workflow produces both visual plots and FITS images suitable for analyzing the morphology and energy distribution of the extended source.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Dec | parameter_input | Source Dec |
| 1 | RA | parameter_input | Source RA |
| 2 | ThetaMax | parameter_input | Maximal angular distance from center in degrees |
| 3 | ThetaMin | parameter_input | Minimal angular distance from center in degrees |
| 4 | redshift | parameter_input | source redshift |
| 5 | N | parameter_input | number of particles to simulate |
| 6 | initial particle | parameter_input |  |
| 7 | EmaxSource | parameter_input | maximal initial energy  [TeV] |
| 8 | Emin | parameter_input | minimal energy of secondary photons  [TeV] |
| 9 | EminSource | parameter_input | minimal source energy [TeV] |
| 10 | gamma | parameter_input | intrinsic spectrum slope |
| 11 | IGMF | parameter_input | intergalactic magnetic field amplitude  [fG] |
| 12 | IGMF Lmax | parameter_input | Maximal turbulent IGMF scale [Mpc] |
| 13 | EBL | parameter_input |  |


This workflow relies on numerical parameter inputs to drive the CRbeam simulation, so ensure all physical values like coordinates and energy thresholds are correctly defined before execution. While no initial datasets are required, the resulting outputs will be generated as FITS images and CSV tabular data for further analysis. For a detailed explanation of each parameter's units and specific constraints, refer to the README.md file. You can streamline the entry of these numerous parameters by using `planemo workflow_job_init` to create a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 14 | CRbeam | toolshed.g2.bx.psu.edu/repos/astroteam/crbeam_astro_tool/crbeam_astro_tool/0.0.2+galaxy0 |  |
| 15 | astropy fits2csv | toolshed.g2.bx.psu.edu/repos/astroteam/astropy_fits2csv/astropy_fits2csv/0.1.0+galaxy0 |  |
| 16 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 |  |
| 17 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 |  |
| 18 | Add column | addValue |  |
| 19 | Plot Tools | toolshed.g2.bx.psu.edu/repos/astroteam/plot_tools_astro_tool/plot_tools_astro_tool/0.0.1+galaxy0 |  |
| 20 | Add column | addValue |  |
| 21 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 |  |
| 22 | Add column | addValue |  |
| 23 | Plot Tools | toolshed.g2.bx.psu.edu/repos/astroteam/plot_tools_astro_tool/plot_tools_astro_tool/0.0.1+galaxy0 |  |
| 24 | Add column | addValue |  |
| 25 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 | Calculate RA and Dec for every event |
| 26 | Plot Tools | toolshed.g2.bx.psu.edu/repos/astroteam/plot_tools_astro_tool/plot_tools_astro_tool/0.0.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 15 | mc_data | output |
| 19 | prim_spectrum_data | out_spectrum_histogram_data |
| 19 | prim_spectrum_plot | out_spectrum_histogram_picture |
| 23 | sec_spectrum_data | out_spectrum_histogram_data |
| 23 | sec_spectrum_plot | out_spectrum_histogram_picture |
| 26 | source_fits_image | out_sky_plot_fits_image |
| 26 | source_image | out_sky_plot_plot |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Extended_Source.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Extended_Source.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Extended_Source.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Extended_Source.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Extended_Source.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Extended_Source.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
