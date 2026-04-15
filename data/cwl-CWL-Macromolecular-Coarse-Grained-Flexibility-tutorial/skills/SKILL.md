---
name: cwl-macromolecular-coarse-grained-flexibility-tutorial
description: This CWL workflow utilizes BioExcel Building Blocks to generate protein conformational ensembles from 3D structures using Brownian Dynamics, Discrete Molecular Dynamics, and Normal Mode Analysis tools. Use this skill when you need to characterize macromolecular flexibility or explore the conformational landscape of a protein to understand its dynamic behavior and biological function.
homepage: https://mmb.irbbarcelona.org/biobb/
metadata:
  docker_image: "N/A"
---

# cwl-macromolecular-coarse-grained-flexibility-tutorial

## Overview

This CWL workflow implements the Macromolecular Coarse-Grained Flexibility (FlexServ) protocol using the [BioExcel Building Blocks (biobb)](https://mmb.irbbarcelona.org/biobb/) library. It is designed to generate protein conformational ensembles from 3D structures and perform comprehensive molecular flexibility analysis. The workflow is available on [WorkflowHub](https://workflowhub.eu/workflows/552) and is licensed under [Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0).

The pipeline utilizes three distinct coarse-grained methods to explore protein dynamics. After an initial atom extraction step, the workflow executes Brownian Dynamics (`bd_run`), Discrete Molecular Dynamics (`dmd_run`), and Normal Mode Analysis (`nma_run`) to sample the protein's conformational space.

Following the simulations, the workflow processes the trajectories to quantify flexibility. It calculates Root Mean Square (RMS) deviations using `cpptraj_rms` and compresses the resulting principal component data via `pcz_zip`. The final outputs provide a detailed characterization of the macromolecule's flexibility profile and structural ensembles.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step0_extract_atoms_input_structure_path | Input file | File | Input structure file path. |
| step0_extract_atoms_output_structure_path | Output file | string | Output structure file path. |
| step0_extract_atoms_config | Config file | string | Configuration file for biobb_structure_utils.extract_atoms tool. |
| step1_bd_run_output_crd_path | Output file | string | Output ensemble. |
| step1_bd_run_output_log_path | Output file | string | Output log file. |
| step1_bd_run_config | Config file | string | Configuration file for biobb_flexserv.bd_run tool. |
| step2_cpptraj_rms_output_cpptraj_path | Output file | string | Path to the output processed analysis. |
| step2_cpptraj_rms_output_traj_path | Output file | string | Path to the output processed trajectory. |
| step2_cpptraj_rms_config | Config file | string | Configuration file for biobb_analysis.cpptraj_rms tool. |
| step3_dmd_run_output_crd_path | Output file | string | Output ensemble. |
| step3_dmd_run_output_log_path | Output file | string | Output log file. |
| step4_cpptraj_rms_output_cpptraj_path | Output file | string | Path to the output processed analysis. |
| step4_cpptraj_rms_output_traj_path | Output file | string | Path to the output processed trajectory. |
| step4_cpptraj_rms_config | Config file | string | Configuration file for biobb_analysis.cpptraj_rms tool. |
| step5_nma_run_output_crd_path | Output file | string | Output ensemble. |
| step5_nma_run_output_log_path | Output file | string | Output log file. |
| step5_nma_run_config | Config file | string | Configuration file for biobb_flexserv.nma_run tool. |
| step6_cpptraj_rms_output_cpptraj_path | Output file | string | Path to the output processed analysis. |
| step6_cpptraj_rms_output_traj_path | Output file | string | Path to the output processed trajectory. |
| step6_cpptraj_rms_config | Config file | string | Configuration file for biobb_analysis.cpptraj_rms tool. |
| step7_pcz_zip_output_pcz_path | Output file | string | Output compressed trajectory. |
| step7_pcz_zip_config | Config file | string | Configuration file for biobb_flexserv.pcz_zip tool. |
| step8_pcz_zip_output_pcz_path | Output file | string | Output compressed trajectory. |
| step8_pcz_zip_config | Config file | string | Configuration file for biobb_flexserv.pcz_zip tool. |
| step9_pcz_zip_output_pcz_path | Output file | string | Output compressed trajectory. |
| step9_pcz_zip_config | Config file | string | Configuration file for biobb_flexserv.pcz_zip tool. |
| step10_pcz_unzip_output_crd_path | Output file | string | Output uncompressed trajectory. |
| step11_pcz_unzip_output_crd_path | Output file | string | Output uncompressed trajectory. |
| step12_pcz_unzip_output_crd_path | Output file | string | Output uncompressed trajectory. |
| step13_cpptraj_rms_output_cpptraj_path | Output file | string | Path to the output processed analysis. |
| step13_cpptraj_rms_output_traj_path | Output file | string | Path to the output processed trajectory. |
| step13_cpptraj_rms_config | Config file | string | Configuration file for biobb_analysis.cpptraj_rms tool. |
| step14_cpptraj_rms_output_cpptraj_path | Output file | string | Path to the output processed analysis. |
| step14_cpptraj_rms_output_traj_path | Output file | string | Path to the output processed trajectory. |
| step14_cpptraj_rms_config | Config file | string | Configuration file for biobb_analysis.cpptraj_rms tool. |
| step15_cpptraj_rms_output_cpptraj_path | Output file | string | Path to the output processed analysis. |
| step15_cpptraj_rms_output_traj_path | Output file | string | Path to the output processed trajectory. |
| step15_cpptraj_rms_config | Config file | string | Configuration file for biobb_analysis.cpptraj_rms tool. |
| step16_pcz_info_output_json_path | Output file | string | Output json file with PCA info such as number of components, variance and dimensionality. |
| step17_pcz_evecs_output_json_path | Output file | string | Output json file with PCA Eigen Vectors. |
| step17_pcz_evecs_config | Config file | string | Configuration file for biobb_flexserv.pcz_evecs tool. |
| step18_pcz_animate_output_crd_path | Output file | string | Output PCA animated trajectory file. |
| step18_pcz_animate_config | Config file | string | Configuration file for biobb_flexserv.pcz_animate tool. |
| step19_cpptraj_convert_output_cpptraj_path | Output file | string | Path to the output processed trajectory. |
| step19_cpptraj_convert_config | Config file | string | Configuration file for biobb_analysis.cpptraj_convert tool. |
| step20_pcz_bfactor_output_dat_path | Output file | string | Output Bfactor x residue x PCA mode file. |
| step20_pcz_bfactor_output_pdb_path | Output file | string | Output PDB with Bfactor x residue x PCA mode file. |
| step20_pcz_bfactor_config | Config file | string | Configuration file for biobb_flexserv.pcz_bfactor tool. |
| step21_pcz_hinges_output_json_path | Output file | string | Output hinge regions x PCA mode file. |
| step21_pcz_hinges_config | Config file | string | Configuration file for biobb_flexserv.pcz_hinges tool. |
| step22_pcz_hinges_output_json_path | Output file | string | Output hinge regions x PCA mode file. |
| step22_pcz_hinges_config | Config file | string | Configuration file for biobb_flexserv.pcz_hinges tool. |
| step23_pcz_hinges_output_json_path | Output file | string | Output hinge regions x PCA mode file. |
| step23_pcz_hinges_config | Config file | string | Configuration file for biobb_flexserv.pcz_hinges tool. |
| step24_pcz_stiffness_output_json_path | Output file | string | Output json file with PCA Stiffness. |
| step24_pcz_stiffness_config | Config file | string | Configuration file for biobb_flexserv.pcz_stiffness tool. |
| step25_pcz_collectivity_output_json_path | Output file | string | Output json file with PCA Collectivity indexes per mode. |
| step25_pcz_collectivity_config | Config file | string | Configuration file for biobb_flexserv.pcz_collectivity tool. |
| step26_pcz_similarity_input_pcz_path2 | Input file | File | Input compressed trajectory file 2. |
| step26_pcz_similarity_output_json_path | Output file | string | Output json file with PCA Similarity results. |
| step27_pcz_similarity_input_pcz_path2 | Input file | File | Input compressed trajectory file 2. |
| step27_pcz_similarity_output_json_path | Output file | string | Output json file with PCA Similarity results. |
| step28_pcz_similarity_input_pcz_path2 | Input file | File | Input compressed trajectory file 2. |
| step28_pcz_similarity_output_json_path | Output file | string | Output json file with PCA Similarity results. |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| step0_extract_atoms | extract_atoms | Class to extract atoms from a 3D structure. |
| step1_bd_run | bd_run | Run Brownian Dynamics from FlexServ |
| step2_cpptraj_rms | cpptraj_rms | Wrapper of the Ambertools Cpptraj module for calculating the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step3_dmd_run | dmd_run | Run Discrete Molecular Dynamics from FlexServ |
| step4_cpptraj_rms | cpptraj_rms | Wrapper of the Ambertools Cpptraj module for calculating the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step5_nma_run | nma_run | Run Normal Mode Analysis from FlexServ |
| step6_cpptraj_rms | cpptraj_rms | Wrapper of the Ambertools Cpptraj module for calculating the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step7_pcz_zip | pcz_zip | Compress MD simulation trajectories with PCA suite |
| step8_pcz_zip | pcz_zip | Compress MD simulation trajectories with PCA suite |
| step9_pcz_zip | pcz_zip | Compress MD simulation trajectories with PCA suite |
| step10_pcz_unzip | pcz_unzip | Uncompress MD simulation trajectories with PCA suite |
| step11_pcz_unzip | pcz_unzip | Uncompress MD simulation trajectories with PCA suite |
| step12_pcz_unzip | pcz_unzip | Uncompress MD simulation trajectories with PCA suite |
| step13_cpptraj_rms | cpptraj_rms | Wrapper of the Ambertools Cpptraj module for calculating the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step14_cpptraj_rms | cpptraj_rms | Wrapper of the Ambertools Cpptraj module for calculating the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step15_cpptraj_rms | cpptraj_rms | Wrapper of the Ambertools Cpptraj module for calculating the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step16_pcz_info | pcz_info | Extract PCA info (variance, Dimensionality) from a compressed PCZ file |
| step17_pcz_evecs | pcz_evecs | Extract PCA Eigen Vectors from a compressed PCZ file |
| step18_pcz_animate | pcz_animate | Extract PCA animations from a compressed PCZ file |
| step19_cpptraj_convert | cpptraj_convert | Wrapper of the Ambertools Cpptraj module for converting between cpptraj compatible trajectory file formats and/or extracting a selection of atoms or frames. |
| step20_pcz_bfactor | pcz_bfactor | Extract residue bfactors x PCA mode from a compressed PCZ file |
| step21_pcz_hinges | pcz_hinges | Compute possible hinge regions (residues around which large protein movements are organized) of a molecule from a compressed PCZ file |
| step22_pcz_hinges | pcz_hinges | Compute possible hinge regions (residues around which large protein movements are organized) of a molecule from a compressed PCZ file |
| step23_pcz_hinges | pcz_hinges | Compute possible hinge regions (residues around which large protein movements are organized) of a molecule from a compressed PCZ file |
| step24_pcz_stiffness | pcz_stiffness | Extract PCA stiffness from a compressed PCZ file |
| step25_pcz_collectivity | pcz_collectivity | Extract PCA collectivity (numerical measure of how many atoms are affected by a given mode) from a compressed PCZ file |
| step26_pcz_similarity | pcz_similarity | Compute PCA similarity between two given compressed PCZ files |
| step27_pcz_similarity | pcz_similarity | Compute PCA similarity between two given compressed PCZ files |
| step28_pcz_similarity | pcz_similarity | Compute PCA similarity between two given compressed PCZ files |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step0_extract_atoms_out1 | output_structure_path | File | Output structure file path. |
| step1_bd_run_out1 | output_crd_path | File | Output ensemble. |
| step1_bd_run_out2 | output_log_path | File | Output log file. |
| step2_cpptraj_rms_out1 | output_cpptraj_path | File | Path to the output processed analysis. |
| step2_cpptraj_rms_out2 | output_traj_path | File | Path to the output processed trajectory. |
| step3_dmd_run_out1 | output_crd_path | File | Output ensemble. |
| step3_dmd_run_out2 | output_log_path | File | Output log file. |
| step4_cpptraj_rms_out1 | output_cpptraj_path | File | Path to the output processed analysis. |
| step4_cpptraj_rms_out2 | output_traj_path | File | Path to the output processed trajectory. |
| step5_nma_run_out1 | output_crd_path | File | Output ensemble. |
| step5_nma_run_out2 | output_log_path | File | Output log file. |
| step6_cpptraj_rms_out1 | output_cpptraj_path | File | Path to the output processed analysis. |
| step6_cpptraj_rms_out2 | output_traj_path | File | Path to the output processed trajectory. |
| step7_pcz_zip_out1 | output_pcz_path | File | Output compressed trajectory. |
| step8_pcz_zip_out1 | output_pcz_path | File | Output compressed trajectory. |
| step9_pcz_zip_out1 | output_pcz_path | File | Output compressed trajectory. |
| step10_pcz_unzip_out1 | output_crd_path | File | Output uncompressed trajectory. |
| step11_pcz_unzip_out1 | output_crd_path | File | Output uncompressed trajectory. |
| step12_pcz_unzip_out1 | output_crd_path | File | Output uncompressed trajectory. |
| step13_cpptraj_rms_out1 | output_cpptraj_path | File | Path to the output processed analysis. |
| step13_cpptraj_rms_out2 | output_traj_path | File | Path to the output processed trajectory. |
| step14_cpptraj_rms_out1 | output_cpptraj_path | File | Path to the output processed analysis. |
| step14_cpptraj_rms_out2 | output_traj_path | File | Path to the output processed trajectory. |
| step15_cpptraj_rms_out1 | output_cpptraj_path | File | Path to the output processed analysis. |
| step15_cpptraj_rms_out2 | output_traj_path | File | Path to the output processed trajectory. |
| step16_pcz_info_out1 | output_json_path | File | Output json file with PCA info such as number of components, variance and dimensionality. |
| step17_pcz_evecs_out1 | output_json_path | File | Output json file with PCA Eigen Vectors. |
| step18_pcz_animate_out1 | output_crd_path | File | Output PCA animated trajectory file. |
| step19_cpptraj_convert_out1 | output_cpptraj_path | File | Path to the output processed trajectory. |
| step20_pcz_bfactor_out1 | output_dat_path | File | Output Bfactor x residue x PCA mode file. |
| step20_pcz_bfactor_out2 | output_pdb_path | File | Output PDB with Bfactor x residue x PCA mode file. |
| step21_pcz_hinges_out1 | output_json_path | File | Output hinge regions x PCA mode file. |
| step22_pcz_hinges_out1 | output_json_path | File | Output hinge regions x PCA mode file. |
| step23_pcz_hinges_out1 | output_json_path | File | Output hinge regions x PCA mode file. |
| step24_pcz_stiffness_out1 | output_json_path | File | Output json file with PCA Stiffness. |
| step25_pcz_collectivity_out1 | output_json_path | File | Output json file with PCA Collectivity indexes per mode. |
| step26_pcz_similarity_out1 | output_json_path | File | Output json file with PCA Similarity results. |
| step27_pcz_similarity_out1 | output_json_path | File | Output json file with PCA Similarity results. |
| step28_pcz_similarity_out1 | output_json_path | File | Output json file with PCA Similarity results. |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/552
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata