---
name: end-to-end-ei-mass-spectra-prediction-workflow-using-qcxms
description: This workflow predicts in-silico electron ionization mass spectra from SMILES strings using OpenBabel for conformer generation, xtb for molecular optimization, and QCxMS for semi-empirical quantum chemical simulations. Use this skill when you need to generate reference mass spectra for identifying unknown compounds in metabolomics or exposomics studies where experimental standards are unavailable.
homepage: https://www.recetox.muni.cz/en/services/data-services-2/spectrometric-data-processing-and-analysis
metadata:
  docker_image: "N/A"
---

# end-to-end-ei-mass-spectra-prediction-workflow-using-qcxms

## Overview

This workflow provides an automated pipeline for predicting in-silico EI+ mass spectra using semi-empirical quantum physics methods. It is designed for applications in exposomics and metabolomics, enabling the generation of reference spectra for compounds where experimental data may be unavailable. The process begins with SMILES input, which undergoes 3D structure generation and conformer ensemble sampling using [Open Babel](https://toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/3.1.1+galaxy1).

The core of the simulation involves high-level molecular optimization via [xtb](https://toolshed.g2.bx.psu.edu/repos/recetox/xtb_molecular_optimization/xtb_molecular_optimization/6.6.1+galaxy3), followed by the [QCxMS](https://toolshed.g2.bx.psu.edu/repos/recetox/qcxms_production_run/qcxms_production_run/5.2.1+galaxy4) (Quantum Chemistry Electron Ionization Mass Spectrometry) program suite. The workflow executes both neutral and production runs to simulate molecular fragmentation patterns based on the specified quantum chemical methods and optimization levels.

The final output is a standardized MSP file containing the predicted mass spectra, suitable for library searching and compound identification. Intermediate outputs, including optimized XYZ coordinates and conformer ensembles, are also preserved for validation. This workflow is licensed under the [MIT License](https://opensource.org/licenses/MIT) and integrates tools from the RECETOX repository to streamline complex computational chemistry tasks within Galaxy.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Molecules with SMILES | data_input |  |
| 1 | Number of conformers to generate | parameter_input | By default one conformer |
| 2 | QC Method | parameter_input | Available: GFN1-xTB and GFN2-xTB |
| 3 | Optimization Levels | parameter_input | Level of accuracy for the optimization |


Ensure your input molecules are provided in a tabular or SMILES format, as these will be converted into 3D coordinates and optimized through semi-empirical methods. Using data collections is highly recommended to manage the multiple conformers and intermediate files generated during the xtb and QCxMS runs efficiently. For automated execution and testing, you can initialize a job configuration using `planemo workflow_job_init` to create a `job.yml` file. Refer to the `README.md` for comprehensive details on parameter selection for optimization levels and quantum chemical methods. All final predicted spectra are consolidated into a single MSP file for downstream library matching.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Compound conversion | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/3.1.1+galaxy1 |  |
| 5 | Generate conformers | toolshed.g2.bx.psu.edu/repos/bgruening/ctb_im_conformers/ctb_im_conformers/1.1.4+galaxy0 | Generate 3D conformers from SDF input for each molecule. It requires the number of conformers as an input parameter. Default parameters value is 1. |
| 6 | Compound conversion | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/3.1.1+galaxy1 | Convert the conformer to cartesian coordinate (XYZ) format |
| 7 | xtb molecular optimization | toolshed.g2.bx.psu.edu/repos/recetox/xtb_molecular_optimization/xtb_molecular_optimization/6.6.1+galaxy3 | Semi-empirical optimization |
| 8 | QCxMS neutral run | toolshed.g2.bx.psu.edu/repos/recetox/qcxms_neutral_run/qcxms_neutral_run/5.2.1+galaxy6 | Produce preparation input files for production runs |
| 9 | QCxMS production run | toolshed.g2.bx.psu.edu/repos/recetox/qcxms_production_run/qcxms_production_run/5.2.1+galaxy4 | Calculate the mass spectra for a given molecule using QCxMS. It generates .res files, which are collected and converted into MSP format in the last step |
| 10 | Filter failed datasets | __FILTER_FAILED_DATASETS__ | Remove failed runs |
| 11 | QCxMS get results | toolshed.g2.bx.psu.edu/repos/recetox/qcxms_getres/qcxms_getres/5.2.1+galaxy3 | Produce simulated mass spectra into MSP file format. |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | conformer_output | outfile |
| 6 | XYZ output | file_outputs |
| 7 | optimized output | output |
| 8 | [.in] output | coords1 |
| 8 | [.xyz] output | coords3 |
| 8 | [.start] output | coords2 |
| 9 | res output | res_files |
| 11 | MSP output | msp_output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-End-to-end_EI__mass_spectra_prediction_workflow_using_QCxMS.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-End-to-end_EI__mass_spectra_prediction_workflow_using_QCxMS.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-End-to-end_EI__mass_spectra_prediction_workflow_using_QCxMS.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-End-to-end_EI__mass_spectra_prediction_workflow_using_QCxMS.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-End-to-end_EI__mass_spectra_prediction_workflow_using_QCxMS.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-End-to-end_EI__mass_spectra_prediction_workflow_using_QCxMS.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)