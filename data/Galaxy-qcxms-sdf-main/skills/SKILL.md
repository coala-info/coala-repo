---
name: qcxms-spectra-prediction-from-sdf
description: This Galaxy workflow predicts electron ionization mass spectra from 3D molecular structures in SDF format using Open Babel and the QCxMS simulation suite. Use this skill when you need to generate theoretical fragmentation patterns for chemical compounds to assist in structure elucidation or to supplement experimental mass spectrometry libraries.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# qcxms-spectra-prediction-from-sdf

## Overview

This Galaxy workflow automates the prediction of electron ionization (EI) mass spectra using the [QCxMS](https://github.com/recetox/qcxms) method. It is designed to process molecular structures provided in SDF format, which must include 3D coordinates typically sourced from databases like PubChem.

The pipeline begins by converting the input SDF file into XYZ format using [Open Babel](http://openbabel.org/). It then proceeds through a multi-stage QCxMS simulation, starting with a neutral run to prepare the molecular structure, followed by a production run that simulates the fragmentation process.

The final stage of the workflow extracts and processes the simulation data to generate predicted mass spectra. The primary output is an MSP file containing the predicted EI mass spectra, which can be used for compound identification and chemical analysis. This workflow is distributed under the MIT License.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input SDF File | data_input | An input file containing one or multiple structures with already generated conformers, for example from PubChem. |


Ensure your input SDF file contains accurate 3D coordinates for all atoms, as these are essential for the initial Open Babel conversion to XYZ format. While this workflow typically processes a single dataset, you can utilize Galaxy collections to run the pipeline on multiple molecules simultaneously. For automated execution and testing, consider using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on parameter configuration and specific tool requirements. Predicted spectra are ultimately provided in MSP format for downstream analysis.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Compound conversion | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/3.1.1+galaxy2 |  |
| 2 | QCxMS neutral run | toolshed.g2.bx.psu.edu/repos/recetox/qcxms_neutral_run/qcxms_neutral_run/5.2.1+galaxy7 |  |
| 3 | QCxMS production run | toolshed.g2.bx.psu.edu/repos/recetox/qcxms_production_run/qcxms_production_run/5.2.1+galaxy5 |  |
| 4 | QCxMS get results | toolshed.g2.bx.psu.edu/repos/recetox/qcxms_getres/qcxms_getres/5.2.1+galaxy4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | fragments | res_files |
| 4 | Predicted Spectra | msp_output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run QCxMS-Spectra-Prediction-from-SDF.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run QCxMS-Spectra-Prediction-from-SDF.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run QCxMS-Spectra-Prediction-from-SDF.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init QCxMS-Spectra-Prediction-from-SDF.ga -o job.yml`
- Lint: `planemo workflow_lint QCxMS-Spectra-Prediction-from-SDF.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `QCxMS-Spectra-Prediction-from-SDF.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)