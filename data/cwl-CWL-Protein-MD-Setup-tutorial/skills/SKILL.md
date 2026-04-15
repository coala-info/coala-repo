---
name: cwl-protein-md-setup-tutorial
description: This CWL workflow automates the preparation of protein structures for molecular dynamics simulations using BioExcel Building Blocks to perform hydrogen removal, side-chain repair, solvation, and system neutralization. Use this skill when you need to generate a physically valid and equilibrated aqueous environment for a protein to investigate its structural stability, folding dynamics, or atomic-level interactions.
homepage: https://mmb.irbbarcelona.org/biobb/
metadata:
  docker_image: "N/A"
---

# cwl-protein-md-setup-tutorial

## Overview

This CWL workflow automates the initial setup of a protein Molecular Dynamics (MD) simulation system using the [BioExcel Building Blocks (biobb)](https://workflowhub.eu/workflows/279) library. It is based on the standard [GROMACS lysozyme tutorial](http://www.mdtutorials.com/gmx/lysozyme/index.html), providing a standardized pipeline to prepare biological macromolecules for simulation.

The process begins with structure preprocessing, including the removal of native hydrogens and the extraction of the target molecule. The workflow then utilizes tools to fix side chains and generate a GROMACS-compatible topology. This ensures the protein structure is chemically complete and correctly parameterized for the force field.

In the final stages, the workflow defines the simulation box geometry and performs solvation. It concludes by adding counterions to neutralize the system, resulting in a prepared structure ready for energy minimization and production MD runs. The complete implementation is available on [WorkflowHub](https://workflowhub.eu/workflows/279) under the Apache-2.0 license.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step0_reduce_remove_hydrogens_input_path |  | File |  |
| step0_reduce_remove_hydrogens_output_path |  | string |  |
| step1_extract_molecule_output_molecule_path |  | string |  |
| step00_cat_pdb_input_structure2 |  | File |  |
| step00_cat_pdb_output_structure_path |  | string |  |
| step2_fix_side_chain_output_pdb_path |  | string |  |
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
| step4_pdb2gmx | Pdb2gmx | Creates a compressed (ZIP) GROMACS topology (TOP and ITP files) from a given PDB file. |
| step5_editconf | Editconf | Creates a GROMACS structure file (GRO) adding the information of the solvent box to the input structure file. |
| step6_solvate | Solvate | Creates a new compressed GROMACS topology file adding solvent molecules to a given input compressed GROMACS topology file. |
| step7_grompp_genion | Grompp | Creates a GROMACS portable binary run input file (TPR) applying the desired properties from the input compressed GROMACS topology. |
| step8_genion | Genion | Creates a new compressed GROMACS topology adding ions until reaching the desired concentration to the input compressed GROMACS topology.  |
| step9_grompp_min | Grompp | Creates a GROMACS portable binary run input file (TPR) applying the desired properties from the input compressed GROMACS topology. |
| step10_mdrun_min | Mdrun | Performs molecular dynamics simulations from an input GROMACS TPR file. |
| step100_make_ndx | MakeNdx | Creates a GROMACS index file (NDX) from an input selection and an input GROMACS structure file. |
| step11_grompp_nvt | Grompp | Creates a GROMACS portable binary run input file (TPR) applying the desired properties from the input compressed GROMACS topology. |
| step12_mdrun_nvt | Mdrun | Performs molecular dynamics simulations from an input GROMACS TPR file. |
| step13_grompp_npt | Grompp | Creates a GROMACS portable binary run input file (TPR) applying the desired properties from the input compressed GROMACS topology. |
| step14_mdrun_npt | Mdrun | Performs molecular dynamics simulations from an input GROMACS TPR file. |
| step15_grompp_md | Grompp | Creates a GROMACS portable binary run input file (TPR) applying the desired properties from the input compressed GROMACS topology. |
| step16_mdrun_md | Mdrun | Performs molecular dynamics simulations from an input GROMACS TPR file. |
| step17_gmx_image1 | GMXImage | Wrapper of the GROMACS trjconv module for correcting periodicity (image) from a given GROMACS compatible trajectory file. |
| step18_gmx_image2 | GMXImage | Wrapper of the GROMACS trjconv module for correcting periodicity (image) from a given GROMACS compatible trajectory file. |
| step19_gmx_trjconv_str | GMXTrjconvStr | Wrapper of the GROMACS trjconv module for converting between GROMACS compatible structure file formats and/or extracting a selection of atoms. |
| step20_gmx_energy | GMXEnergy | Wrapper of the GROMACS energy module for extracting energy components from a given GROMACS energy file. |
| step21_gmx_rgyr | GMXRgyr | Wrapper of the GROMACS gyrate module for computing the radius of gyration (Rgyr) of a molecule about the x-, y- and z-axes, as a function of time, from a given GROMACS compatible trajectory. |
| step22_rmsd_first | GMXRms | Wrapper of the GROMACS module for calculating the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step23_rmsd_exp | GMXRms | Wrapper of the GROMACS module for calculating the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step24_grompp_md | Grompp | Creates a GROMACS portable binary run input file (TPR) applying the desired properties from the input compressed GROMACS topology. |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step0_reduce_remove_hydrogens_out1 | output_path | File | Path to the output file |
| step1_extract_molecule_out1 | output_molecule_path | File | Output molecule file path |
| step00_cat_pdb_out1 | output_structure_path | File | Output protein file path |
| step2_fix_side_chain_out1 | output_pdb_path | File | Output PDB file path |
| step4_pdb2gmx_out1 | output_gro_path | File | Path to the output GRO file |
| step4_pdb2gmx_out2 | output_top_zip_path | File | Path the output TOP topology in zip format |
| step5_editconf_out1 | output_gro_path | File | Path to the output GRO file |
| step6_solvate_out1 | output_gro_path | File | Path to the output GRO file |
| step6_solvate_out2 | output_top_zip_path | File | Path the output topology in zip format |
| step7_grompp_genion_out1 | output_tpr_path | File | Path to the output portable binary run file TPR |
| step8_genion_out1 | output_gro_path | File | Path to the input structure GRO file |
| step8_genion_out2 | output_top_zip_path | File | Path the output topology TOP and ITP files zipball |
| step9_grompp_min_out1 | output_tpr_path | File | Path to the output portable binary run file TPR |
| step10_mdrun_min_out1 | output_trr_path | File | Path to the GROMACS uncompressed raw trajectory file TRR |
| step10_mdrun_min_out2 | output_gro_path | File | Path to the output GROMACS structure GRO file |
| step10_mdrun_min_out3 | output_edr_path | File | Path to the output GROMACS portable energy file EDR |
| step10_mdrun_min_out4 | output_log_path | File | Path to the output GROMACS trajectory log file LOG |
| step100_make_ndx_out1 | output_ndx_path | File | Path to the output index NDX file |
| step11_grompp_nvt_out1 | output_tpr_path | File | Path to the output portable binary run file TPR |
| step12_mdrun_nvt_out1 | output_trr_path | File | Path to the GROMACS uncompressed raw trajectory file TRR |
| step12_mdrun_nvt_out2 | output_gro_path | File | Path to the output GROMACS structure GRO file |
| step12_mdrun_nvt_out3 | output_edr_path | File | Path to the output GROMACS portable energy file EDR |
| step12_mdrun_nvt_out4 | output_log_path | File | Path to the output GROMACS trajectory log file LOG |
| step12_mdrun_nvt_out5 | output_cpt_path | File | Path to the output GROMACS checkpoint file CPT |
| step13_grompp_npt_out1 | output_tpr_path | File | Path to the output portable binary run file TPR |
| step14_mdrun_npt_out1 | output_trr_path | File | Path to the GROMACS uncompressed raw trajectory file TRR |
| step14_mdrun_npt_out2 | output_gro_path | File | Path to the output GROMACS structure GRO file |
| step14_mdrun_npt_out3 | output_edr_path | File | Path to the output GROMACS portable energy file EDR |
| step14_mdrun_npt_out4 | output_log_path | File | Path to the output GROMACS trajectory log file LOG |
| step14_mdrun_npt_out5 | output_cpt_path | File | Path to the output GROMACS checkpoint file CPT |
| step15_grompp_md_out1 | output_tpr_path | File | Path to the output portable binary run file TPR |
| step16_mdrun_md_out1 | output_trr_path | File | Path to the GROMACS uncompressed raw trajectory file TRR |
| step16_mdrun_md_out2 | output_gro_path | File | Path to the output GROMACS structure GRO file |
| step16_mdrun_md_out3 | output_edr_path | File | Path to the output GROMACS portable energy file EDR |
| step16_mdrun_md_out4 | output_log_path | File | Path to the output GROMACS trajectory log file LOG |
| step16_mdrun_md_out5 | output_cpt_path | File | Path to the output GROMACS checkpoint file CPT |
| step17_gmx_image1_out1 | output_traj_path | File | Path to the output file |
| step18_gmx_image2_out1 | output_traj_path | File | Path to the output file |
| step19_gmx_trjconv_str_out1 | output_str_path | File | Path to the output file |
| step20_gmx_energy_out1 | output_xvg_path | File | Path to the XVG output file |
| step21_gmx_rgyr_out1 | output_xvg_path | File | Path to the XVG output file |
| step22_rmsd_first_out1 | output_xvg_path | File | Path to the XVG output file |
| step23_rmsd_exp_out1 | output_xvg_path | File | Path to the XVG output file |
| step24_grompp_md_out1 | output_tpr_path | File | Path to the output portable binary run file TPR |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/279
- `workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata