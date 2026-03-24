---
name: protein-ligand-docking-fpocket
description: "This Common Workflow Language pipeline performs protein-ligand docking by identifying potential binding pockets with FPocket and calculating binding affinities using AutoDock Vina within the BioExcel Building Blocks framework. Use this skill when you need to identify optimal binding sites on a protein surface and predict the preferred orientation and binding strength of small molecules for drug discovery or functional characterization."
homepage: https://workflowhub.eu/workflows/257
---
# Protein-ligand docking (fpocket)

## Overview

This [CWL workflow](https://workflowhub.eu/workflows/257) automates the protein-ligand docking process using the BioExcel Building Blocks (biobb) library. It provides a standardized pipeline to identify potential binding sites and predict the preferred orientation of a small molecule within a target protein.

The workflow executes the following functional stages:
*   **Pocket Identification:** Uses `fpocket` to detect potential binding sites and defines the docking grid coordinates (search box) around the selected pocket.
*   **Structure Preparation:** Manages ligand format conversion via Open Babel and prepares the protein structure by verifying integrity and adding missing hydrogen atoms.
*   **Docking Simulation:** Performs the final docking calculation using AutoDock Vina to predict the binding pose and affinity.

This pipeline ensures a reproducible computational environment for structure-based drug design, moving from raw structural files to docked complexes in a single automated run.

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

- WorkflowHub: https://workflowhub.eu/workflows/257
- `workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
