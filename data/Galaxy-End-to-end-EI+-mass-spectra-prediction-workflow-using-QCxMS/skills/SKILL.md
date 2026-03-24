---
name: end-to-end-ei-mass-spectra-prediction-workflow-using-qcxms
description: "This Galaxy workflow predicts in-silico EI+ mass spectra from SMILES strings using OpenBabel for conformer generation, xtb for molecular optimization, and the QCxMS suite for semi-empirical quantum chemical simulations. Use this skill when you need to generate reference mass spectra for identifying unknown compounds in GC-MS metabolomics or exposomics studies where experimental standards are unavailable."
homepage: https://workflowhub.eu/workflows/1597
---

# End-to-end EI+ mass spectra prediction workflow using QCxMS

## Overview

This workflow provides an automated pipeline for predicting Electron Ionization (EI+) mass spectra from chemical structures. It utilizes semi-empirical quantum physics methods, specifically [QCxMS](https://github.com/qcxms/QCxMS), to generate in-silico spectra. This is particularly valuable in fields like exposomics and metabolomics for identifying compounds when experimental reference standards are unavailable.

The process begins by taking a list of SMILES strings and names as input. It performs conformer generation and handles compound conversion using OpenBabel, followed by rigorous molecular geometry optimization via [xtb](https://github.com/grimme-lab/xtb). These optimized structures serve as the foundation for the QCxMS simulation, which includes both neutral and production runs to simulate molecular fragmentation.

The final output is a standardized MSP file containing the predicted mass spectra, suitable for use in library searching and metabolite identification. The workflow also provides intermediate datasets, including optimized XYZ coordinates and conformer outputs. This tool is tagged for use in [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) contexts and is released under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Molecules with SMILES and NAME without a header. | data_input | First column should containe the name of the molecule, the second should contain the SMILES code. |
| 1 | Number of conformers to generate | parameter_input | By default one conformer |
| 2 | Optimization Levels | parameter_input | Level of accuracy for the optimization |
| 3 | QC Method | parameter_input | Available: GFN1-xTB and GFN2-xTB |


Ensure your input file is a headerless tab-separated or text file containing SMILES strings and compound names to allow proper parsing and splitting into collections for parallel processing. Use the `.smi` or `.txt` format for the initial molecule list, as the workflow will automatically handle the conversion to `.sdf` and `.xyz` formats required for quantum chemical calculations. For large-scale batches, verify that your Galaxy instance supports collection operations to manage the high volume of intermediate conformer and optimization files efficiently. Refer to the `README.md` for comprehensive details on parameter selection for different QC methods and optimization levels. You can automate the execution setup by using `planemo workflow_job_init` to generate a `job.yml` template for your input data.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.3+galaxy1 |  |
| 5 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.3+galaxy1 |  |
| 6 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.2 |  |
| 7 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.2 |  |
| 8 | Parse parameter value | param_value_from_file |  |
| 9 | Compound conversion | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/3.1.1+galaxy0 |  |
| 10 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/9.3+galaxy1 |  |
| 11 | Generate conformers | toolshed.g2.bx.psu.edu/repos/bgruening/ctb_im_conformers/ctb_im_conformers/1.1.4+galaxy0 | Generate 3D conformers from SDF input for each molecule. It requires the number of conformers as an input parameter. Default parameters value is 1. |
| 12 | Compound conversion | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/3.1.1+galaxy0 | Convert the conformer to cartesian coordinate (XYZ) format |
| 13 | xtb molecular optimization | toolshed.g2.bx.psu.edu/repos/recetox/xtb_molecular_optimization/xtb_molecular_optimization/6.6.1+galaxy3 | Semi-empirical optimization |
| 14 | QCxMS neutral run | toolshed.g2.bx.psu.edu/repos/recetox/qcxms_neutral_run/qcxms_neutral_run/5.2.1+galaxy4 | Produce preparation input files for production runs |
| 15 | QCxMS production run | toolshed.g2.bx.psu.edu/repos/recetox/qcxms_production_run/qcxms_production_run/5.2.1+galaxy3 | Calculate the mass spectra for a given molecule using QCxMS. It generates .res files, which are collected and converted into MSP format in the last step |
| 16 | Filter failed datasets | __FILTER_FAILED_DATASETS__ | Remove failed runs |
| 17 | QCxMS get results | toolshed.g2.bx.psu.edu/repos/recetox/qcxms_getres/qcxms_getres/5.2.1+galaxy2 | Produce simulated mass spectra into MSP file format. |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 11 | conformer_output | outfile |
| 12 | XYZ output | file_outputs |
| 13 | optimized output | output |
| 14 | [.in] output | coords1 |
| 14 | [.xyz] output | coords3 |
| 14 | [.start] output | coords2 |
| 15 | res output | res_files |
| 17 | MSP output | msp_output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run end-to-end-ei--mass-spectra-prediction-workflow-using-qcxms.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run end-to-end-ei--mass-spectra-prediction-workflow-using-qcxms.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run end-to-end-ei--mass-spectra-prediction-workflow-using-qcxms.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init end-to-end-ei--mass-spectra-prediction-workflow-using-qcxms.ga -o job.yml`
- Lint: `planemo workflow_lint end-to-end-ei--mass-spectra-prediction-workflow-using-qcxms.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `end-to-end-ei--mass-spectra-prediction-workflow-using-qcxms.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
