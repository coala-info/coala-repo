---
name: cwl-protein-ligand-docking-tutorial-fpocket
description: This CWL workflow identifies protein active site cavities and performs protein-ligand docking using FPocket, Open Babel, and AutoDock Vina. Use this skill when you need to predict the binding pose of a small molecule inhibitor within a protein's active site or identify potential druggable cavities for drug discovery.
homepage: https://mmb.irbbarcelona.org/biobb/
metadata:
  docker_image: "N/A"
---

# cwl-protein-ligand-docking-tutorial-fpocket

## Overview

This [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/259) workflow automates the process of protein-ligand docking using the BioExcel Building Blocks (biobb) library. It is designed to predict the binding orientation of small molecule inhibitors within a target protein, such as the Mitogen-activated protein kinase 14 ([3HEC](https://www.rcsb.org/structure/3HEC)), by identifying potential active sites without prior coordinate knowledge.

The workflow follows a structured pipeline to prepare both the receptor and the ligand for simulation:
*   **Pocket Identification:** Uses `FPocketSelect` and `Box` to detect the active site cavity and define the docking grid coordinates.
*   **Structure Preparation:** Employs `BabelConvert` for ligand formatting and `StrCheckAddHydrogens` to refine the protein structure.
*   **Docking Simulation:** Executes `AutoDockVinaRun` to calculate the final protein-ligand complex.

By integrating pocket detection with docking, this workflow enables "blind" docking scenarios where the binding site is unknown. The implementation ensures a reproducible path from raw protein structures to predicted complexes, following the standards maintained in the [BioExcel](https://bioexcel.eu/) ecosystem.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step1_fpocket_select_config |  | string |  |
| step1_fpocket_select_input_pockets_zip |  | File |  |
| step1_fpocket_select_output_pocket_pdb |  | string |  |
| step1_fpocket_select_output_pocket_pqr |  | string |  |
| step2_box_config |  | string |  |
| step2_box_output_pdb_path |  | string |  |
| step3_babel_convert_prep_lig_config |  | string |  |
| step3_babel_convert_prep_lig_input_path |  | File |  |
| step3_babel_convert_prep_lig_output_path |  | string |  |
| step4_str_check_add_hydrogens_config |  | string |  |
| step4_str_check_add_hydrogens_input_structure_path |  | File |  |
| step4_str_check_add_hydrogens_output_structure_path |  | string |  |
| step5_autodock_vina_run_output_pdbqt_path |  | string |  |
| step5_autodock_vina_run_output_log_path |  | string |  |
| step6_babel_convert_pose_pdb_config |  | string |  |
| step6_babel_convert_pose_pdb_output_path |  | string |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| step1_fpocket_select | FPocketSelect | Selects a single pocket in the outputs of the fpocket building block.. |
| step2_box | Box | This class sets the center and the size of a rectangular parallelepiped box around a set of residues or a pocket. |
| step3_babel_convert_prep_lig | BabelConvert | Small molecule format conversion. |
| step4_str_check_add_hydrogens | StrCheckAddHydrogens | This class is a wrapper of the Structure Checking tool to add hydrogens to a 3D structure. |
| step5_autodock_vina_run | AutoDockVinaRun | Wrapper of the AutoDock Vina software. |
| step6_babel_convert_pose_pdb | BabelConvert | Small molecule format conversion. |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step1_fpocket_select_out1 | output_pocket_pdb | File | Path to the PDB file with the cavity found by fpocket |
| step1_fpocket_select_out2 | output_pocket_pqr | File | Path to the PQR file with the pocket found by fpocket |
| step2_box_out1 | output_pdb_path | File | PDB including the annotation of the box center and size as REMARKs |
| step3_babel_convert_prep_lig_out1 | output_path | File | Path to the output file |
| step4_str_check_add_hydrogens_out1 | output_structure_path | File | Output structure file path |
| step5_autodock_vina_run_out1 | output_pdbqt_path | File | Path to the output PDBQT file |
| step5_autodock_vina_run_out2 | output_log_path | File | Path to the log file |
| step6_babel_convert_pose_pdb_out1 | output_path | File | Path to the output file |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/259
- `workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata