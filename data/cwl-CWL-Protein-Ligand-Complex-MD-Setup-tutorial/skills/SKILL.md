---
name: cwl-protein-ligand-complex-md-setup-tutorial
description: This Common Workflow Language workflow automates the structural preparation and topology generation for protein-ligand complexes using BioExcel Building Blocks and GROMACS. Use this skill when you need to characterize molecular interactions, evaluate binding stability, or investigate the conformational dynamics of a small molecule within a protein binding pocket.
homepage: https://mmb.irbbarcelona.org/biobb/
metadata:
  docker_image: "N/A"
---

# cwl-protein-ligand-complex-md-setup-tutorial

## Overview

This CWL workflow automates the preparation of a molecular dynamics (MD) simulation system for a protein-ligand complex. Based on the [official GROMACS tutorial](http://www.mdtutorials.com/gmx/complex/index.html), it utilizes the [BioExcel Building Blocks (biobb)](https://workflowhub.eu/workflows/258) library to standardize the preprocessing steps required to move from a raw PDB structure to a simulation-ready environment.

The pipeline performs essential structure refinement and topology generation. Key steps include removing existing hydrogens, extracting specific molecules, fixing protein side chains, and merging the protein and ligand into a single PDB file. It then employs GROMACS tools to generate the system topology, create index files, and apply position restraints.

Developed by the MMB group at BSC and IRB, this workflow is available on [WorkflowHub](https://workflowhub.eu/workflows/258) under the [Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0) license. It provides a reproducible framework for researchers to set up complex systems, such as the T4 lysozyme (3HTB) bound with the 2-propylphenol (JZ4) ligand, ensuring all components are correctly formatted for GROMACS simulations.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step0_reduce_remove_hydrogens_input_path |  | File |  |
| step0_reduce_remove_hydrogens_output_path |  | string |  |
| step2_extract_molecule_output_molecule_path |  | string |  |
| step00_cat_pdb_input_structure2 |  | File |  |
| step00_cat_pdb_output_structure_path |  | string |  |
| step4_fix_side_chain_output_pdb_path |  | string |  |
| step5_pdb2gmx_config |  | string |  |
| step5_pdb2gmx_output_gro_path |  | string |  |
| step5_pdb2gmx_output_top_zip_path |  | string |  |
| step9_make_ndx_config |  | string |  |
| step9_make_ndx_input_structure_path |  | File |  |
| step9_make_ndx_output_ndx_path |  | string |  |
| step10_genrestr_config |  | string |  |
| step10_genrestr_input_structure_path |  | File |  |
| step10_genrestr_output_itp_path |  | string |  |
| step11_gmx_trjconv_str_protein_config |  | string |  |
| step11_gmx_trjconv_str_protein_output_str_path |  | string |  |
| step12_gmx_trjconv_str_ligand_config |  | string |  |
| step12_gmx_trjconv_str_ligand_input_structure_path |  | File |  |
| step12_gmx_trjconv_str_ligand_input_top_path |  | File |  |
| step12_gmx_trjconv_str_ligand_output_str_path |  | string |  |
| step13_cat_pdb_hydrogens_output_structure_path |  | string |  |
| step14_append_ligand_config |  | string |  |
| step14_append_ligand_input_itp_path |  | File |  |
| step14_append_ligand_output_top_zip_path |  | string |  |
| step15_editconf_config |  | string |  |
| step15_editconf_output_gro_path |  | string |  |
| step16_solvate_output_gro_path |  | string |  |
| step16_solvate_output_top_zip_path |  | string |  |
| step17_grompp_genion_config |  | string |  |
| step17_grompp_genion_output_tpr_path |  | string |  |
| step18_genion_config |  | string |  |
| step18_genion_output_gro_path |  | string |  |
| step18_genion_output_top_zip_path |  | string |  |
| step19_grompp_min_config |  | string |  |
| step19_grompp_min_output_tpr_path |  | string |  |
| step20_mdrun_min_output_trr_path |  | string |  |
| step20_mdrun_min_output_gro_path |  | string |  |
| step20_mdrun_min_output_edr_path |  | string |  |
| step20_mdrun_min_output_log_path |  | string |  |
| step21_gmx_energy_min_config |  | string |  |
| step21_gmx_energy_min_output_xvg_path |  | string |  |
| step22_make_ndx_config |  | string |  |
| step22_make_ndx_output_ndx_path |  | string |  |
| step23_grompp_nvt_config |  | string |  |
| step23_grompp_nvt_output_tpr_path |  | string |  |
| step24_mdrun_nvt_output_trr_path |  | string |  |
| step24_mdrun_nvt_output_gro_path |  | string |  |
| step24_mdrun_nvt_output_edr_path |  | string |  |
| step24_mdrun_nvt_output_log_path |  | string |  |
| step24_mdrun_nvt_output_cpt_path |  | string |  |
| step25_gmx_energy_nvt_config |  | string |  |
| step25_gmx_energy_nvt_output_xvg_path |  | string |  |
| step26_grompp_npt_config |  | string |  |
| step26_grompp_npt_output_tpr_path |  | string |  |
| step27_mdrun_npt_output_trr_path |  | string |  |
| step27_mdrun_npt_output_gro_path |  | string |  |
| step27_mdrun_npt_output_edr_path |  | string |  |
| step27_mdrun_npt_output_log_path |  | string |  |
| step27_mdrun_npt_output_cpt_path |  | string |  |
| step28_gmx_energy_npt_config |  | string |  |
| step28_gmx_energy_npt_output_xvg_path |  | string |  |
| step29_grompp_md_config |  | string |  |
| step29_grompp_md_output_tpr_path |  | string |  |
| step30_mdrun_md_output_trr_path |  | string |  |
| step30_mdrun_md_output_gro_path |  | string |  |
| step30_mdrun_md_output_edr_path |  | string |  |
| step30_mdrun_md_output_log_path |  | string |  |
| step30_mdrun_md_output_cpt_path |  | string |  |
| step34_gmx_image_config |  | string |  |
| step34_gmx_image_output_traj_path |  | string |  |
| step34b_gmx_image2_config |  | string |  |
| step34b_gmx_image2_output_traj_path |  | string |  |
| step35_gmx_trjconv_str_config |  | string |  |
| step35_gmx_trjconv_str_output_str_path |  | string |  |
| step31_rmsd_first_config |  | string |  |
| step31_rmsd_first_output_xvg_path |  | string |  |
| step32_rmsd_exp_config |  | string |  |
| step32_rmsd_exp_output_xvg_path |  | string |  |
| step33_gmx_rgyr_config |  | string |  |
| step33_gmx_rgyr_output_xvg_path |  | string |  |
| step36_grompp_md_config |  | string |  |
| step36_grompp_md_output_tpr_path |  | string |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| step0_reduce_remove_hydrogens | ReduceRemoveHydrogens | Removes hydrogen atoms to small molecules. |
| step2_extract_molecule | ExtractMolecule | This class is a wrapper of the Structure Checking tool to extract a molecule from a 3D structure. |
| step00_cat_pdb | CatPDB | Class to concat two PDB structures in a single PDB file. |
| step4_fix_side_chain | FixSideChain | Reconstructs the missing side chains and heavy atoms of the given PDB file. |
| step5_pdb2gmx | Pdb2gmx | Creates a compressed (ZIP) GROMACS topology (TOP and ITP files) from a given PDB file. |
| step9_make_ndx | MakeNdx | Creates a GROMACS index file (NDX) from an input selection and an input GROMACS structure file. |
| step10_genrestr | Genrestr | Creates a new GROMACS compressed topology applying the indicated force restrains to the given input compressed topology. |
| step11_gmx_trjconv_str_protein | GMXTrjconvStr | Wrapper of the GROMACS trjconv module for converting between GROMACS compatible structure file formats and/or extracting a selection of atoms. |
| step12_gmx_trjconv_str_ligand | GMXTrjconvStr | Wrapper of the GROMACS trjconv module for converting between GROMACS compatible structure file formats and/or extracting a selection of atoms. |
| step13_cat_pdb_hydrogens | CatPDB | Class to concat two PDB structures in a single PDB file. |
| step14_append_ligand | AppendLigand | Takes a ligand ITP file and inserts it in a topology. |
| step15_editconf | Editconf | Creates a GROMACS structure file (GRO) adding the information of the solvent box to the input structure file. |
| step16_solvate | Solvate | Creates a new compressed GROMACS topology file adding solvent molecules to a given input compressed GROMACS topology file. |
| step17_grompp_genion | Grompp | Creates a GROMACS portable binary run input file (TPR) applying the desired properties from the input compressed GROMACS topology. |
| step18_genion | Genion | Creates a new compressed GROMACS topology adding ions until reaching the desired concentration to the input compressed GROMACS topology.  |
| step19_grompp_min | Grompp | Creates a GROMACS portable binary run input file (TPR) applying the desired properties from the input compressed GROMACS topology. |
| step20_mdrun_min | Mdrun | Performs molecular dynamics simulations from an input GROMACS TPR file. |
| step21_gmx_energy_min | GMXEnergy | Wrapper of the GROMACS energy module for extracting energy components from a given GROMACS energy file. |
| step22_make_ndx | MakeNdx | Creates a GROMACS index file (NDX) from an input selection and an input GROMACS structure file. |
| step23_grompp_nvt | Grompp | Creates a GROMACS portable binary run input file (TPR) applying the desired properties from the input compressed GROMACS topology. |
| step24_mdrun_nvt | Mdrun | Performs molecular dynamics simulations from an input GROMACS TPR file. |
| step25_gmx_energy_nvt | GMXEnergy | Wrapper of the GROMACS energy module for extracting energy components from a given GROMACS energy file. |
| step26_grompp_npt | Grompp | Creates a GROMACS portable binary run input file (TPR) applying the desired properties from the input compressed GROMACS topology. |
| step27_mdrun_npt | Mdrun | Performs molecular dynamics simulations from an input GROMACS TPR file. |
| step28_gmx_energy_npt | GMXEnergy | Wrapper of the GROMACS energy module for extracting energy components from a given GROMACS energy file. |
| step29_grompp_md | Grompp | Creates a GROMACS portable binary run input file (TPR) applying the desired properties from the input compressed GROMACS topology. |
| step30_mdrun_md | Mdrun | Performs molecular dynamics simulations from an input GROMACS TPR file. |
| step34_gmx_image | GMXImage | Wrapper of the GROMACS trjconv module for correcting periodicity (image) from a given GROMACS compatible trajectory file. |
| step34b_gmx_image2 | GMXImage | Wrapper of the GROMACS trjconv module for correcting periodicity (image) from a given GROMACS compatible trajectory file. |
| step35_gmx_trjconv_str | GMXTrjconvStr | Wrapper of the GROMACS trjconv module for converting between GROMACS compatible structure file formats and/or extracting a selection of atoms. |
| step31_rmsd_first | GMXRms | Wrapper of the GROMACS module for calculating the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step32_rmsd_exp | GMXRms | Wrapper of the GROMACS module for calculating the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step33_gmx_rgyr | GMXRgyr | Wrapper of the GROMACS gyrate module for computing the radius of gyration (Rgyr) of a molecule about the x-, y- and z-axes, as a function of time, from a given GROMACS compatible trajectory. |
| step36_grompp_md | Grompp | Creates a GROMACS portable binary run input file (TPR) applying the desired properties from the input compressed GROMACS topology. |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step0_reduce_remove_hydrogens_out1 | output_path | File | Path to the output file |
| step2_extract_molecule_out1 | output_molecule_path | File | Output molecule file path |
| step00_cat_pdb_out1 | output_structure_path | File | Output protein file path |
| step4_fix_side_chain_out1 | output_pdb_path | File | Output PDB file path |
| step5_pdb2gmx_out1 | output_gro_path | File | Path to the output GRO file |
| step5_pdb2gmx_out2 | output_top_zip_path | File | Path the output TOP topology in zip format |
| step9_make_ndx_out1 | output_ndx_path | File | Path to the output index NDX file |
| step10_genrestr_out1 | output_itp_path | File | Path the output ITP topology file with restrains |
| step11_gmx_trjconv_str_protein_out1 | output_str_path | File | Path to the output file |
| step12_gmx_trjconv_str_ligand_out1 | output_str_path | File | Path to the output file |
| step13_cat_pdb_hydrogens_out1 | output_structure_path | File | Output protein file path |
| step14_append_ligand_out1 | output_top_zip_path | File | Path/Name the output topology TOP and ITP files zipball |
| step15_editconf_out1 | output_gro_path | File | Path to the output GRO file |
| step16_solvate_out1 | output_gro_path | File | Path to the output GRO file |
| step16_solvate_out2 | output_top_zip_path | File | Path the output topology in zip format |
| step17_grompp_genion_out1 | output_tpr_path | File | Path to the output portable binary run file TPR |
| step18_genion_out1 | output_gro_path | File | Path to the input structure GRO file |
| step18_genion_out2 | output_top_zip_path | File | Path the output topology TOP and ITP files zipball |
| step19_grompp_min_out1 | output_tpr_path | File | Path to the output portable binary run file TPR |
| step20_mdrun_min_out1 | output_trr_path | File | Path to the GROMACS uncompressed raw trajectory file TRR |
| step20_mdrun_min_out2 | output_gro_path | File | Path to the output GROMACS structure GRO file |
| step20_mdrun_min_out3 | output_edr_path | File | Path to the output GROMACS portable energy file EDR |
| step20_mdrun_min_out4 | output_log_path | File | Path to the output GROMACS trajectory log file LOG |
| step21_gmx_energy_min_out1 | output_xvg_path | File | Path to the XVG output file |
| step22_make_ndx_out1 | output_ndx_path | File | Path to the output index NDX file |
| step23_grompp_nvt_out1 | output_tpr_path | File | Path to the output portable binary run file TPR |
| step24_mdrun_nvt_out1 | output_trr_path | File | Path to the GROMACS uncompressed raw trajectory file TRR |
| step24_mdrun_nvt_out2 | output_gro_path | File | Path to the output GROMACS structure GRO file |
| step24_mdrun_nvt_out3 | output_edr_path | File | Path to the output GROMACS portable energy file EDR |
| step24_mdrun_nvt_out4 | output_log_path | File | Path to the output GROMACS trajectory log file LOG |
| step24_mdrun_nvt_out5 | output_cpt_path | File | Path to the output GROMACS checkpoint file CPT |
| step25_gmx_energy_nvt_out1 | output_xvg_path | File | Path to the XVG output file |
| step26_grompp_npt_out1 | output_tpr_path | File | Path to the output portable binary run file TPR |
| step27_mdrun_npt_out1 | output_trr_path | File | Path to the GROMACS uncompressed raw trajectory file TRR |
| step27_mdrun_npt_out2 | output_gro_path | File | Path to the output GROMACS structure GRO file |
| step27_mdrun_npt_out3 | output_edr_path | File | Path to the output GROMACS portable energy file EDR |
| step27_mdrun_npt_out4 | output_log_path | File | Path to the output GROMACS trajectory log file LOG |
| step27_mdrun_npt_out5 | output_cpt_path | File | Path to the output GROMACS checkpoint file CPT |
| step28_gmx_energy_npt_out1 | output_xvg_path | File | Path to the XVG output file |
| step29_grompp_md_out1 | output_tpr_path | File | Path to the output portable binary run file TPR |
| step30_mdrun_md_out1 | output_trr_path | File | Path to the GROMACS uncompressed raw trajectory file TRR |
| step30_mdrun_md_out2 | output_gro_path | File | Path to the output GROMACS structure GRO file |
| step30_mdrun_md_out3 | output_edr_path | File | Path to the output GROMACS portable energy file EDR |
| step30_mdrun_md_out4 | output_log_path | File | Path to the output GROMACS trajectory log file LOG |
| step30_mdrun_md_out5 | output_cpt_path | File | Path to the output GROMACS checkpoint file CPT |
| step34_gmx_image_out1 | output_traj_path | File | Path to the output file |
| step34b_gmx_image2_out1 | output_traj_path | File | Path to the output file |
| step35_gmx_trjconv_str_out1 | output_str_path | File | Path to the output file |
| step31_rmsd_first_out1 | output_xvg_path | File | Path to the XVG output file |
| step32_rmsd_exp_out1 | output_xvg_path | File | Path to the XVG output file |
| step33_gmx_rgyr_out1 | output_xvg_path | File | Path to the XVG output file |
| step36_grompp_md_out1 | output_tpr_path | File | Path to the output portable binary run file TPR |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/258
- `workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata