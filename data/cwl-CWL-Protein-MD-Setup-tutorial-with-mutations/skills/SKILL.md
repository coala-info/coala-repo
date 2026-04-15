---
name: cwl-protein-md-setup-tutorial-with-mutations
description: This Common Workflow Language pipeline prepares protein structures for molecular dynamics simulations by processing PDB files through BioExcel Building Blocks tools for hydrogen removal, side chain repair, and residue mutations. Use this skill when you need to generate a refined protein model with specific amino acid substitutions to investigate the structural or energetic impacts of mutations in a molecular dynamics environment.
homepage: https://mmb.irbbarcelona.org/biobb/
metadata:
  docker_image: "N/A"
---

# cwl-protein-md-setup-tutorial-with-mutations

## Overview

This workflow automates the initial setup of a protein simulation system using the [BioExcel Building Blocks (biobb)](https://mmb.irbbarcelona.org/biobb/) library. Modeled after the classic GROMACS Lysozyme tutorial (PDB 1AKI), the pipeline prepares a protein structure for Molecular Dynamics (MD) simulations by performing essential structural cleaning and preprocessing.

The process includes hydrogen removal, molecule extraction, and side-chain repair to ensure structural integrity. A specialized mutation subworkflow allows for the modification of specific residues, providing a flexible path for studying protein variants. The final steps involve concatenating PDB components and fixing side chains to produce a simulation-ready structure.

This implementation is available on [WorkflowHub](https://workflowhub.eu/workflows/289) as a Common Workflow Language (CWL) pipeline. It is licensed under Apache-2.0 and was developed by the MMB group at the Barcelona Supercomputing Center and the Institute for Research in Biomedicine for the BioExcel Center of Excellence.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| mutations_list |  | array |  |
| step0_reduce_remove_hydrogens_input_path |  | File |  |
| step0_reduce_remove_hydrogens_output_path |  | string |  |
| step1_extract_molecule_output_molecule_path |  | string |  |
| step00_cat_pdb_input_structure2 |  | File |  |
| step00_cat_pdb_output_structure_path |  | string |  |
| step2_fix_side_chain_output_pdb_path |  | string |  |
| step3_mutate_output_pdb_path |  | string |  |
| step4_pdb2gmx_config |  | string |  |
| step4_pdb2gmx_output_gro_path |  | string |  |
| step4_pdb2gmx_output_top_zip_path |  | string |  |
| step5_editconf_config |  | string |  |
| step5_editconf_output_gro_path |  | string |  |
| step6_solvate_output_gro_path |  | string |  |
| step6_solvate_output_top_zip_path |  | string |  |
| step7_grompp_genion_config |  | string |  |
| step7_grompp_genion_output_tpr_path |  | string |  |
| step8_genion_config |  | string |  |
| step8_genion_output_gro_path |  | string |  |
| step8_genion_output_top_zip_path |  | string |  |
| step9_grompp_min_config |  | string |  |
| step9_grompp_min_output_tpr_path |  | string |  |
| step10_mdrun_min_output_trr_path |  | string |  |
| step10_mdrun_min_output_gro_path |  | string |  |
| step10_mdrun_min_output_edr_path |  | string |  |
| step10_mdrun_min_output_log_path |  | string |  |
| step100_make_ndx_config |  | string |  |
| step100_make_ndx_output_ndx_path |  | string |  |
| step11_grompp_nvt_config |  | string |  |
| step11_grompp_nvt_output_tpr_path |  | string |  |
| step12_mdrun_nvt_output_trr_path |  | string |  |
| step12_mdrun_nvt_output_gro_path |  | string |  |
| step12_mdrun_nvt_output_edr_path |  | string |  |
| step12_mdrun_nvt_output_log_path |  | string |  |
| step12_mdrun_nvt_output_cpt_path |  | string |  |
| step13_grompp_npt_config |  | string |  |
| step13_grompp_npt_output_tpr_path |  | string |  |
| step14_mdrun_npt_output_trr_path |  | string |  |
| step14_mdrun_npt_output_gro_path |  | string |  |
| step14_mdrun_npt_output_edr_path |  | string |  |
| step14_mdrun_npt_output_log_path |  | string |  |
| step14_mdrun_npt_output_cpt_path |  | string |  |
| step15_grompp_md_config |  | string |  |
| step15_grompp_md_output_tpr_path |  | string |  |
| step16_mdrun_md_output_trr_path |  | string |  |
| step16_mdrun_md_output_gro_path |  | string |  |
| step16_mdrun_md_output_edr_path |  | string |  |
| step16_mdrun_md_output_log_path |  | string |  |
| step16_mdrun_md_output_cpt_path |  | string |  |
| step17_gmx_image1_config |  | string |  |
| step17_gmx_image1_output_traj_path |  | string |  |
| step18_gmx_image2_config |  | string |  |
| step18_gmx_image2_output_traj_path |  | string |  |
| step19_gmx_trjconv_str_config |  | string |  |
| step19_gmx_trjconv_str_output_str_path |  | string |  |
| step20_gmx_energy_config |  | string |  |
| step20_gmx_energy_output_xvg_path |  | string |  |
| step21_gmx_rgyr_config |  | string |  |
| step21_gmx_rgyr_output_xvg_path |  | string |  |
| step22_rmsd_first_config |  | string |  |
| step22_rmsd_first_output_xvg_path |  | string |  |
| step23_rmsd_exp_config |  | string |  |
| step23_rmsd_exp_output_xvg_path |  | string |  |
| step24_grompp_md_config |  | string |  |
| step24_grompp_md_output_tpr_path |  | string |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| step0_reduce_remove_hydrogens | ReduceRemoveHydrogens | Removes hydrogen atoms to small molecules. |
| step1_extract_molecule | ExtractMolecule | This class is a wrapper of the Structure Checking tool to extract a molecule from a 3D structure. |
| step00_cat_pdb | CatPDB | Class to concat two PDB structures in a single PDB file. |
| step2_fix_side_chain | FixSideChain | Reconstructs the missing side chains and heavy atoms of the given PDB file. |
| subworkflow_mutate | subworkflow_mutate |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| top_dir | Collected Simulation Data | array | Assorted data files output by the workflow  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/289
- `workflow.cwl` — workflow definition (CWL)
- `workflow_gather.cwl` — workflow definition (CWL)
- `workflow_list.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata