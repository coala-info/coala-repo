---
name: cwl-gmx-automatic-ligand-parameterization-tutorial
description: This CWL workflow automates small molecule ligand parameterization for molecular dynamics by using OpenBabel for energy minimization and ACPype to generate GROMACS topologies. Use this skill when you need to generate accurate force field parameters and topologies for small molecules to enable their inclusion in GROMACS molecular dynamics simulations.
homepage: https://mmb.irbbarcelona.org/biobb/
metadata:
  docker_image: "N/A"
---

# cwl-gmx-automatic-ligand-parameterization-tutorial

## Overview

This CWL workflow automates the ligand parameterization process for small molecules using the [BioExcel Building Blocks (biobb)](https://mmb.irbbarcelona.org/biobb/) library. It is designed to prepare chemical structures for molecular dynamics simulations, specifically generating the necessary files for the GROMACS engine. The implementation is available on [WorkflowHub](https://workflowhub.eu/workflows/255).

The pipeline executes a sequence of structural refinements and parameter calculations:
* **Structural Preparation:** Uses OpenBabel to add hydrogen atoms to the ligand and perform an initial energetic minimization.
* **Parameter Generation:** Utilizes ACPype to calculate charges and generate topology files.
* **Force Field Assignment:** Applies the Generalized Amber Force Field (GAFF) and AM1-BCC charging methods to ensure compatibility with standard simulation environments.

The final outputs provide the processed structure and topology files required to integrate the ligand into larger biological systems for simulation. This workflow is licensed under [Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0) and was developed by the MMB group at the Barcelona Supercomputing Center and the Institute for Research in Biomedicine.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step2_babel_minimize_config |  | string |  |
| step2_babel_minimize_input_path |  | File |  |
| step2_babel_minimize_output_path |  | string |  |
| step3_acpype_params_gmx_config |  | string |  |
| step3_acpype_params_gmx_output_path_gro |  | string |  |
| step3_acpype_params_gmx_output_path_itp |  | string |  |
| step3_acpype_params_gmx_output_path_top |  | string |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| step2_babel_minimize | BabelMinimize | Energetically minimize small molecules. |
| step3_acpype_params_gmx | AcpypeParamsGMX | Small molecule parameterization for GROMACS MD package. |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step2_babel_minimize_out1 | output_path | File | Path to the output file |
| step3_acpype_params_gmx_out1 | output_path_gro | File | Path to the GRO output file |
| step3_acpype_params_gmx_out2 | output_path_itp | File | Path to the ITP output file |
| step3_acpype_params_gmx_out3 | output_path_top | File | Path to the TOP output file |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/255
- `workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata