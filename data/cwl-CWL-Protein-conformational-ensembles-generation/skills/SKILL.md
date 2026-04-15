---
name: cwl-protein-conformational-ensembles-generation
description: This Common Workflow Language pipeline processes 3D protein structures using BioExcel Building Blocks, CPPTRAJ, CONCOORD, and ProDy to generate conformational ensembles and analyze molecular flexibility. Use this skill when you need to characterize the conformational landscape of a protein to understand its biological function, evaluate the impact of genetic variants on structural dynamics, or model collective motions for drug discovery.
homepage: https://mmb.irbbarcelona.org/biobb/
metadata:
  docker_image: "N/A"
---

# cwl-protein-conformational-ensembles-generation

## Overview

This CWL workflow generates protein conformational ensembles and analyzes molecular flexibility using the [BioExcel Building Blocks (biobb)](https://github.com/bioexcel/biobb) library. Developed as part of the [ELIXIR 3D-Bioinfo](https://elixir-europe.org/communities/3d-bioinfo) Implementation Study, the pipeline provides a reproducible method for benchmarking computational tools that predict protein motions and characterize the conformational landscape of native proteins.

The workflow begins by preprocessing PDB structures to extract specific models and chains. It then employs **CONCOORD** (`concoord_dist` and `concoord_disco`) to generate structural ensembles based on distance constraints. To model low-energy collective motions and flexibility, the pipeline integrates **ProDy** (`prody_anm`) for Anisotropic Network Model analysis.

Final analysis and data management are performed using **CPPTRAJ** tools, which handle atom masking, RMSD calculations, and trajectory format conversions. The resulting ensembles allow researchers to compare observed structural diversity against simulated biophysical descriptions of protein dynamics. Further details and version history can be found on [WorkflowHub](https://workflowhub.eu/workflows/488).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step0_extract_model_input_structure_path |  | File |  |
| step0_extract_model_output_structure_path |  | string |  |
| step0_extract_model_config |  | string |  |
| step1_extract_chain_output_structure_path |  | string |  |
| step1_extract_chain_config |  | string |  |
| step2_cpptraj_mask_output_cpptraj_path |  | string |  |
| step2_cpptraj_mask_config |  | string |  |
| step3_cpptraj_mask_output_cpptraj_path |  | string |  |
| step3_cpptraj_mask_config |  | string |  |
| step4_concoord_dist_output_pdb_path |  | string |  |
| step4_concoord_dist_output_gro_path |  | string |  |
| step4_concoord_dist_output_dat_path |  | string |  |
| step4_concoord_dist_config |  | string |  |
| step5_concoord_disco_output_traj_path |  | string |  |
| step5_concoord_disco_output_rmsd_path |  | string |  |
| step5_concoord_disco_output_bfactor_path |  | string |  |
| step4_concoord_disco_config |  | string |  |
| step6_cpptraj_rms_output_cpptraj_path |  | string |  |
| step6_cpptraj_rms_config |  | string |  |
| step7_cpptraj_convert_output_cpptraj_path |  | string |  |
| step7_cpptraj_convert_config |  | string |  |
| step8_prody_anm_output_pdb_path |  | string |  |
| step8_prody_anm_config |  | string |  |
| step9_cpptraj_rms_output_cpptraj_path |  | string |  |
| step9_cpptraj_rms_config |  | string |  |
| step10_cpptraj_convert_output_cpptraj_path |  | string |  |
| step10_cpptraj_convert_config |  | string |  |
| step11_bd_run_output_crd_path |  | string |  |
| step11_bd_run_output_log_path |  | string |  |
| step11_bd_run_config |  | string |  |
| step12_cpptraj_rms_output_cpptraj_path |  | string |  |
| step12_cpptraj_rms_output_traj_path |  | string |  |
| step12_cpptraj_rms_config |  | string |  |
| step13_dmd_run_output_crd_path |  | string |  |
| step13_dmd_run_output_log_path |  | string |  |
| step13_dmd_run_config |  | string |  |
| step14_cpptraj_rms_output_cpptraj_path |  | string |  |
| step14_cpptraj_rms_output_traj_path |  | string |  |
| step14_cpptraj_rms_config |  | string |  |
| step15_nma_run_output_crd_path |  | string |  |
| step15_nma_run_output_log_path |  | string |  |
| step15_nma_run_config |  | string |  |
| step16_cpptraj_rms_output_cpptraj_path |  | string |  |
| step16_cpptraj_rms_config |  | string |  |
| step17_cpptraj_convert_output_cpptraj_path |  | string |  |
| step17_cpptraj_convert_config |  | string |  |
| step18_nolb_nma_output_pdb_path |  | string |  |
| step18_nolb_nma_config |  | string |  |
| step19_cpptraj_rms_output_cpptraj_path |  | string |  |
| step19_cpptraj_rms_config |  | string |  |
| step20_cpptraj_convert_output_cpptraj_path |  | string |  |
| step20_cpptraj_convert_config |  | string |  |
| step21_imod_imode_output_dat_path |  | string |  |
| step21_imod_imode_config |  | string |  |
| step22_imod_imc_output_traj_path |  | string |  |
| step22_imod_imc_config |  | string |  |
| step23_cpptraj_rms_output_cpptraj_path |  | string |  |
| step23_cpptraj_rms_config |  | string |  |
| step24_cpptraj_convert_output_cpptraj_path |  | string |  |
| step24_cpptraj_convert_config |  | string |  |
| step26_make_ndx_output_ndx_path |  | string |  |
| step26_make_ndx_config |  | string |  |
| step27_gmx_cluster_output_pdb_path |  | string |  |
| step27_gmx_cluster_config |  | string |  |
| step28_cpptraj_rms_output_cpptraj_path |  | string |  |
| step28_cpptraj_rms_output_traj_path |  | string |  |
| step28_cpptraj_rms_config |  | string |  |
| step29_pcz_zip_output_pcz_path |  | string |  |
| step29_pcz_zip_config |  | string |  |
| step30_pcz_zip_output_pcz_path |  | string |  |
| step30_pcz_zip_config |  | string |  |
| step31_pcz_info_output_json_path |  | string |  |
| step32_pcz_evecs_output_json_path |  | string |  |
| step32_pcz_evecs_config |  | string |  |
| step33_pcz_animate_output_crd_path |  | string |  |
| step33_pcz_animate_config |  | string |  |
| step34_cpptraj_convert_output_cpptraj_path |  | string |  |
| step34_cpptraj_convert_config |  | string |  |
| step35_pcz_bfactor_output_dat_path |  | string |  |
| step35_pcz_bfactor_output_pdb_path |  | string |  |
| step35_pcz_bfactor_config |  | string |  |
| step36_pcz_hinges_output_json_path |  | string |  |
| step36_pcz_hinges_config |  | string |  |
| step37_pcz_hinges_output_json_path |  | string |  |
| step37_pcz_hinges_config |  | string |  |
| step38_pcz_hinges_output_json_path |  | string |  |
| step38_pcz_hinges_config |  | string |  |
| step39_pcz_stiffness_output_json_path |  | string |  |
| step39_pcz_stiffness_config |  | string |  |
| step40_pcz_collectivity_output_json_path |  | string |  |
| step40_pcz_collectivity_config |  | string |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| step0_extract_model | extract_model | Extracts a model from a 3D structure. |
| step1_extract_chain | extract_chain | Extracts a chain from a 3D structure. |
| step2_cpptraj_mask | cpptraj_mask | Extracts a selection of atoms from a given cpptraj compatible trajectory. |
| step3_cpptraj_mask | cpptraj_mask | Extracts a selection of atoms from a given cpptraj compatible trajectory. |
| step4_concoord_dist | concoord_dist | Wrapper of the Concoord_dist software. |
| step5_concoord_disco | concoord_disco | Wrapper of the Concoord_disco software. |
| step6_cpptraj_rms | cpptraj_rms | Calculates the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step7_cpptraj_convert | cpptraj_convert | Converts between cpptraj compatible trajectory file formats and/or extracting a selection of atoms or frames. |
| step8_prody_anm | prody_anm | Wrapper of the Prody software. |
| step9_cpptraj_rms | cpptraj_rms | Calculates the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step10_cpptraj_convert | cpptraj_convert | Converts between cpptraj compatible trajectory file formats and/or extracting a selection of atoms or frames. |
| step11_bd_run | bd_run | Run Brownian Dynamics from FlexServ. |
| step12_cpptraj_rms | cpptraj_rms | Calculates the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step13_dmd_run | dmd_run | Run Discrete Molecular Dynamics from FlexServ. |
| step14_cpptraj_rms | cpptraj_rms | Calculates the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step15_nma_run | nma_run | Run Normal Mode Analysis from FlexServ. |
| step16_cpptraj_rms | cpptraj_rms | Calculates the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step17_cpptraj_convert | cpptraj_convert | Converts between cpptraj compatible trajectory file formats and/or extracting a selection of atoms or frames. |
| step18_nolb_nma | nolb_nma | Wrapper of the Nolb software. |
| step19_cpptraj_rms | cpptraj_rms | Calculates the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step20_cpptraj_convert | cpptraj_convert | Converts between cpptraj compatible trajectory file formats and/or extracting a selection of atoms or frames. |
| step21_imod_imode | imod_imode | Wrapper of the imods_imode software. |
| step22_imod_imc | imod_imc | Wrapper of the imods_imc software. |
| step23_cpptraj_rms | cpptraj_rms | Calculates the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step24_cpptraj_convert | cpptraj_convert | Converts between cpptraj compatible trajectory file formats and/or extracting a selection of atoms or frames. |
| step26_make_ndx | make_ndx | Creates a GROMACS index file (NDX) from an input selection and an input GROMACS structure file. |
| step27_gmx_cluster | gmx_cluster | Clusters structures from a given GROMACS compatible trajectory. |
| step28_cpptraj_rms | cpptraj_rms | Calculates the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step29_pcz_zip | pcz_zip | Compress MD simulation trajectories with PCA suite. |
| step30_pcz_zip | pcz_zip | Compress MD simulation trajectories with PCA suite. |
| step31_pcz_info | pcz_info | Extract PCA info (variance, Dimensionality) from a compressed PCZ file. |
| step32_pcz_evecs | pcz_evecs | Extract PCA Eigen Vectors from a compressed PCZ file. |
| step33_pcz_animate | pcz_animate | Extract PCA animations from a compressed PCZ file. |
| step34_cpptraj_convert | cpptraj_convert | Converts between cpptraj compatible trajectory file formats and/or extracting a selection of atoms or frames. |
| step35_pcz_bfactor | pcz_bfactor | Extract residue bfactors x PCA mode from a compressed PCZ file. |
| step36_pcz_hinges | pcz_hinges | Compute possible hinge regions (residues around which large protein movements are organized) of a molecule from a compressed PCZ file. |
| step37_pcz_hinges | pcz_hinges | Compute possible hinge regions (residues around which large protein movements are organized) of a molecule from a compressed PCZ file. |
| step38_pcz_hinges | pcz_hinges | Compute possible hinge regions (residues around which large protein movements are organized) of a molecule from a compressed PCZ file. |
| step39_pcz_stiffness | pcz_stiffness | Extract PCA stiffness from a compressed PCZ file. |
| step40_pcz_collectivity | pcz_collectivity | Extract PCA collectivity (numerical measure of how many atoms are affected by a given mode) from a compressed PCZ file. |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step0_extract_model_out1 | output_structure_path | File | Path to the output file |
| step1_extract_chain_out1 | output_structure_path | File | Path to the output file |
| step2_cpptraj_mask_out1 | output_structure_path | File | Path to the output file |
| step3_cpptraj_mask_out1 | output_structure_path | File | Path to the output file |
| step4_concoord_dist_out1 | output_pdb_path | File | Path to the output file |
| step4_concoord_dist_out2 | output_gro_path | File | Path to the output file |
| step4_concoord_dist_out3 | output_dat_path | File | Path to the output file |
| step5_concoord_disco_out1 | output_traj_path | File | Path to the output file |
| step5_concoord_disco_out2 | output_rmsd_path | File | Path to the output file |
| step5_concoord_disco_out3 | output_bfactor_path | File | Path to the output file |
| step6_cpptraj_rms_out1 | output_cpptraj_path | File | Path to the output file |
| step7_cpptraj_convert_out1 | output_cpptraj_path | File | Path to the output file |
| step8_prody_anm_out1 | output_pdb_path | File | Path to the output file |
| step9_cpptraj_rms_out1 | output_cpptraj_path | File | Path to the output file |
| step10_cpptraj_convert_out1 | output_cpptraj_path | File | Path to the output file |
| step11_bd_run_out1 | output_crd_path | File | Path to the output file |
| step11_bd_run_out2 | output_log_path | File | Path to the output file |
| step12_cpptraj_rms_out1 | output_cpptraj_path | File | Path to the output file |
| step12_cpptraj_rms_out2 | output_traj_path | File | Path to the output file |
| step13_dmd_run_out1 | output_crd_path | File | Path to the output file |
| step13_dmd_run_out2 | output_log_path | File | Path to the output file |
| step14_cpptraj_rms_out1 | output_cpptraj_path | File | Path to the output file |
| step14_cpptraj_rms_out2 | output_traj_path | File | Path to the output file |
| step15_nma_run_out1 | output_crd_path | File | Path to the output file |
| step15_nma_run_out2 | output_log_path | File | Path to the output file |
| step16_cpptraj_rms_out1 | output_cpptraj_path | File | Path to the output file |
| step17_cpptraj_convert_out1 | output_cpptraj_path | File | Path to the output file |
| step18_nolb_nma_out1 | output_pdb_path | File | Path to the output file |
| step19_cpptraj_rms_out1 | output_cpptraj_path | File | Path to the output file |
| step20_cpptraj_convert_out1 | output_cpptraj_path | File | Path to the output file |
| step21_imod_imode_out1 | output_dat_path | File | Path to the output file |
| step22_imod_imc_out1 | output_traj_path | File | Path to the output file |
| step23_cpptraj_rms_out1 | output_cpptraj_path | File | Path to the output file |
| step24_cpptraj_convert_out1 | output_cpptraj_path | File | Path to the output file |
| step26_make_ndx_out1 | output_ndx_path | File | Path to the output file |
| step27_gmx_cluster_out1 | output_pdb_path | File | Path to the output file |
| step28_cpptraj_rms_out1 | output_cpptraj_path | File | Path to the output file |
| step28_cpptraj_rms_out2 | output_traj_path | File | Path to the output file |
| step29_pcz_zip_out1 | output_pcz_path | File | Path to the output file |
| step30_pcz_zip_out1 | output_pcz_path | File | Path to the output file |
| step31_pcz_info_out1 | output_json_path | File | Path to the output file |
| step32_pcz_evecs_out1 | output_json_path | File | Path to the output file |
| step33_pcz_animate_out1 | output_crd_path | File | Path to the output file |
| step34_cpptraj_convert_out1 | output_cpptraj_path | File | Path to the output file |
| step35_pcz_bfactor_out1 | output_dat_path | File | Path to the output file |
| step35_pcz_bfactor_out2 | output_pdb_path | File | Path to the output file |
| step36_pcz_hinges_out1 | output_json_path | File | Path to the output file |
| step37_pcz_hinges_out1 | output_json_path | File | Path to the output file |
| step38_pcz_hinges_out1 | output_json_path | File | Path to the output file |
| step39_pcz_stiffness_out1 | output_json_path | File | Path to the output file |
| step40_pcz_collectivity_out1 | output_json_path | File | Path to the output file |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/488
- `workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata