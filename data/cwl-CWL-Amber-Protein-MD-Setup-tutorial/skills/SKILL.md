---
name: cwl-amber-protein-md-setup-tutorial
description: "This Common Workflow Language workflow automates the preparation and equilibration of protein structures for molecular dynamics simulations using BioExcel Building Blocks and the AmberTools suite. Use this skill when you need to generate solvated, charge-neutralized topologies and initial energy-minimized coordinates to study the structural behavior and stability of proteins in aqueous environments."
homepage: https://workflowhub.eu/workflows/260
---
# CWL Amber Protein MD Setup tutorial

## Overview

This [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/260) workflow automates the preparation of a protein system for Molecular Dynamics (MD) simulations. Based on the logic of the classic [GROMACS lysozyme tutorial](http://www.mdtutorials.com/gmx/lysozyme/index.html), this implementation utilizes the [BioExcel Building Blocks (biobb)](https://github.com/bioexcel/biobb) library to wrap the AmberTools MD package, ensuring a reproducible and standardized setup process.

The pipeline executes a series of structural preparation and refinement steps:
*   **Structure Cleaning:** Extracts the target molecule and optimizes the PDB structure using `Pdb4amber`.
*   **System Solvation:** Generates the system topology, adds water molecules (solvation), and neutralizes the system with counterions.
*   **Energy Minimization:** Performs an initial energy minimization using `Sander` to remove steric clashes, followed by output processing and coordinate conversion.

This workflow is licensed under Apache-2.0 and is designed to provide a seamless transition from a raw PDB structure to a minimized, solvent-equilibrated system ready for production MD runs. Detailed documentation and version history can be found on [WorkflowHub](https://workflowhub.eu/workflows/260).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step0_extract_molecule_input_structure_path |  | File |  |
| step0_extract_molecule_output_molecule_path |  | string |  |
| step1_pdb4amber_run_output_pdb_path |  | string |  |
| step2_leap_gen_top_config |  | string |  |
| step2_leap_gen_top_output_pdb_path |  | string |  |
| step2_leap_gen_top_output_top_path |  | string |  |
| step2_leap_gen_top_output_crd_path |  | string |  |
| step3_sander_mdrun_minH_config |  | string |  |
| step3_sander_mdrun_minH_output_traj_path |  | string |  |
| step3_sander_mdrun_minH_output_rst_path |  | string |  |
| step3_sander_mdrun_minH_output_log_path |  | string |  |
| step4_process_minout_minH_config |  | string |  |
| step4_process_minout_minH_output_dat_path |  | string |  |
| step5_sander_mdrun_min_config |  | string |  |
| step5_sander_mdrun_min_output_traj_path |  | string |  |
| step5_sander_mdrun_min_output_rst_path |  | string |  |
| step5_sander_mdrun_min_output_log_path |  | string |  |
| step6_process_minout_min_config |  | string |  |
| step6_process_minout_min_output_dat_path |  | string |  |
| step7_amber_to_pdb_output_pdb_path |  | string |  |
| step8_leap_solvate_config |  | string |  |
| step8_leap_solvate_output_pdb_path |  | string |  |
| step8_leap_solvate_output_top_path |  | string |  |
| step8_leap_solvate_output_crd_path |  | string |  |
| step9_leap_add_ions_config |  | string |  |
| step9_leap_add_ions_output_pdb_path |  | string |  |
| step9_leap_add_ions_output_top_path |  | string |  |
| step9_leap_add_ions_output_crd_path |  | string |  |
| step10_sander_mdrun_energy_config |  | string |  |
| step10_sander_mdrun_energy_output_traj_path |  | string |  |
| step10_sander_mdrun_energy_output_rst_path |  | string |  |
| step10_sander_mdrun_energy_output_log_path |  | string |  |
| step11_process_minout_energy_config |  | string |  |
| step11_process_minout_energy_output_dat_path |  | string |  |
| step12_sander_mdrun_warm_config |  | string |  |
| step12_sander_mdrun_warm_output_traj_path |  | string |  |
| step12_sander_mdrun_warm_output_rst_path |  | string |  |
| step12_sander_mdrun_warm_output_log_path |  | string |  |
| step13_process_mdout_warm_config |  | string |  |
| step13_process_mdout_warm_output_dat_path |  | string |  |
| step14_sander_mdrun_nvt_config |  | string |  |
| step14_sander_mdrun_nvt_output_traj_path |  | string |  |
| step14_sander_mdrun_nvt_output_rst_path |  | string |  |
| step14_sander_mdrun_nvt_output_log_path |  | string |  |
| step15_process_mdout_nvt_config |  | string |  |
| step15_process_mdout_nvt_output_dat_path |  | string |  |
| step16_sander_mdrun_npt_config |  | string |  |
| step16_sander_mdrun_npt_output_traj_path |  | string |  |
| step16_sander_mdrun_npt_output_rst_path |  | string |  |
| step16_sander_mdrun_npt_output_log_path |  | string |  |
| step17_process_mdout_npt_config |  | string |  |
| step17_process_mdout_npt_output_dat_path |  | string |  |
| step18_sander_mdrun_md_config |  | string |  |
| step18_sander_mdrun_md_output_traj_path |  | string |  |
| step18_sander_mdrun_md_output_rst_path |  | string |  |
| step18_sander_mdrun_md_output_log_path |  | string |  |
| step19_rmsd_first_config |  | string |  |
| step19_rmsd_first_output_cpptraj_path |  | string |  |
| step20_rmsd_exp_config |  | string |  |
| step20_rmsd_exp_input_exp_path |  | File |  |
| step20_rmsd_exp_output_cpptraj_path |  | string |  |
| step21_cpptraj_rgyr_config |  | string |  |
| step21_cpptraj_rgyr_output_cpptraj_path |  | string |  |
| step22_cpptraj_image_config |  | string |  |
| step22_cpptraj_image_output_cpptraj_path |  | string |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| step0_extract_molecule | ExtractMolecule | This class is a wrapper of the Structure Checking tool to extract a molecule from a 3D structure. |
| step1_pdb4amber_run | Pdb4amberRun | Analyse PDB files and clean them for further usage, especially with the LEaP programs of Amber, using pdb4amber tool from the AmberTools MD package |
| step2_leap_gen_top | LeapGenTop | Generates a MD topology from a molecule structure using tLeap tool from the AmberTools MD package |
| step3_sander_mdrun_minH | SanderMDRun | Runs energy minimization, molecular dynamics, and NMR refinements using sander tool from the AmberTools MD package |
| step4_process_minout_minH | ProcessMinOut | Parses the AMBER (sander) minimization output file (log) and dumps statistics that can then be plotted. Using the process_minout.pl tool from the AmberTools MD package |
| step5_sander_mdrun_min | SanderMDRun | Runs energy minimization, molecular dynamics, and NMR refinements using sander tool from the AmberTools MD package |
| step6_process_minout_min | ProcessMinOut | Parses the AMBER (sander) minimization output file (log) and dumps statistics that can then be plotted. Using the process_minout.pl tool from the AmberTools MD package |
| step7_amber_to_pdb | AmberToPDB | Generates a PDB structure from AMBER topology (parmtop) and coordinates (crd) files, using the ambpdb tool from the AmberTools MD package |
| step8_leap_solvate | LeapSolvate | Creates and solvates a system box for an AMBER MD system using tLeap tool from the AmberTools MD package |
| step9_leap_add_ions | LeapAddIons | Adds counterions to a system box for an AMBER MD system using tLeap tool from the AmberTools MD package |
| step10_sander_mdrun_energy | SanderMDRun | Runs energy minimization, molecular dynamics, and NMR refinements using sander tool from the AmberTools MD package |
| step11_process_minout_energy | ProcessMinOut | Parses the AMBER (sander) minimization output file (log) and dumps statistics that can then be plotted. Using the process_minout.pl tool from the AmberTools MD package |
| step12_sander_mdrun_warm | SanderMDRun | Runs energy minimization, molecular dynamics, and NMR refinements using sander tool from the AmberTools MD package |
| step13_process_mdout_warm | ProcessMDOut | Parses the AMBER (sander) md output file (log) and dumps statistics that can then be plotted. Using the process_mdout.pl tool from the AmberTools MD package |
| step14_sander_mdrun_nvt | SanderMDRun | Runs energy minimization, molecular dynamics, and NMR refinements using sander tool from the AmberTools MD package |
| step15_process_mdout_nvt | ProcessMDOut | Parses the AMBER (sander) md output file (log) and dumps statistics that can then be plotted. Using the process_mdout.pl tool from the AmberTools MD package |
| step16_sander_mdrun_npt | SanderMDRun | Runs energy minimization, molecular dynamics, and NMR refinements using sander tool from the AmberTools MD package |
| step17_process_mdout_npt | ProcessMDOut | Parses the AMBER (sander) md output file (log) and dumps statistics that can then be plotted. Using the process_mdout.pl tool from the AmberTools MD package |
| step18_sander_mdrun_md | SanderMDRun | Runs energy minimization, molecular dynamics, and NMR refinements using sander tool from the AmberTools MD package |
| step19_rmsd_first | CpptrajRms | Wrapper of the Ambertools Cpptraj module for calculating the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step20_rmsd_exp | CpptrajRms | Wrapper of the Ambertools Cpptraj module for calculating the Root Mean Square deviation (RMSd) of a given cpptraj compatible trajectory. |
| step21_cpptraj_rgyr | CpptrajRgyr | Wrapper of the Ambertools Cpptraj module for computing the radius of gyration (Rgyr) from a given cpptraj compatible trajectory. |
| step22_cpptraj_image | CpptrajImage | Wrapper of the Ambertools Cpptraj module for correcting periodicity (image) from a given cpptraj trajectory file. |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step0_extract_molecule_out1 | output_molecule_path | File | Output molecule file path |
| step1_pdb4amber_run_out1 | output_pdb_path | File | Output 3D structure PDB file |
| step2_leap_gen_top_out1 | output_pdb_path | File | Output 3D structure PDB file matching the topology file |
| step2_leap_gen_top_out2 | output_top_path | File | Output topology file (AMBER ParmTop) |
| step2_leap_gen_top_out3 | output_crd_path | File | Output coordinates file (AMBER crd) |
| step3_sander_mdrun_minH_out1 | output_traj_path | File | Output trajectory file |
| step3_sander_mdrun_minH_out2 | output_rst_path | File | Output restart file |
| step3_sander_mdrun_minH_out3 | output_log_path | File | Output log file |
| step4_process_minout_minH_out1 | output_dat_path | File | Dat output file containing data from the specified terms along the minimization process |
| step5_sander_mdrun_min_out1 | output_traj_path | File | Output trajectory file |
| step5_sander_mdrun_min_out2 | output_rst_path | File | Output restart file |
| step5_sander_mdrun_min_out3 | output_log_path | File | Output log file |
| step6_process_minout_min_out1 | output_dat_path | File | Dat output file containing data from the specified terms along the minimization process |
| step7_amber_to_pdb_out1 | output_pdb_path | File | Structure PDB file |
| step8_leap_solvate_out1 | output_pdb_path | File | Output 3D structure PDB file matching the topology file |
| step8_leap_solvate_out2 | output_top_path | File | Output topology file (AMBER ParmTop) |
| step8_leap_solvate_out3 | output_crd_path | File | Output coordinates file (AMBER crd) |
| step9_leap_add_ions_out1 | output_pdb_path | File | Output 3D structure PDB file matching the topology file |
| step9_leap_add_ions_out2 | output_top_path | File | Output topology file (AMBER ParmTop) |
| step9_leap_add_ions_out3 | output_crd_path | File | Output coordinates file (AMBER crd) |
| step10_sander_mdrun_energy_out1 | output_traj_path | File | Output trajectory file |
| step10_sander_mdrun_energy_out2 | output_rst_path | File | Output restart file |
| step10_sander_mdrun_energy_out3 | output_log_path | File | Output log file |
| step11_process_minout_energy_out1 | output_dat_path | File | Dat output file containing data from the specified terms along the minimization process |
| step12_sander_mdrun_warm_out1 | output_traj_path | File | Output trajectory file |
| step12_sander_mdrun_warm_out2 | output_rst_path | File | Output restart file |
| step12_sander_mdrun_warm_out3 | output_log_path | File | Output log file |
| step13_process_mdout_warm_out1 | output_dat_path | File | Dat output file containing data from the specified terms along the minimization process |
| step14_sander_mdrun_nvt_out1 | output_traj_path | File | Output trajectory file |
| step14_sander_mdrun_nvt_out2 | output_rst_path | File | Output restart file |
| step14_sander_mdrun_nvt_out3 | output_log_path | File | Output log file |
| step15_process_mdout_nvt_out1 | output_dat_path | File | Dat output file containing data from the specified terms along the minimization process |
| step16_sander_mdrun_npt_out1 | output_traj_path | File | Output trajectory file |
| step16_sander_mdrun_npt_out2 | output_rst_path | File | Output restart file |
| step16_sander_mdrun_npt_out3 | output_log_path | File | Output log file |
| step17_process_mdout_npt_out1 | output_dat_path | File | Dat output file containing data from the specified terms along the minimization process |
| step18_sander_mdrun_md_out1 | output_traj_path | File | Output trajectory file |
| step18_sander_mdrun_md_out2 | output_rst_path | File | Output restart file |
| step18_sander_mdrun_md_out3 | output_log_path | File | Output log file |
| step19_rmsd_first_out1 | output_cpptraj_path | File | Path to the output processed analysis |
| step20_rmsd_exp_out1 | output_cpptraj_path | File | Path to the output processed analysis |
| step21_cpptraj_rgyr_out1 | output_cpptraj_path | File | Path to the output analysis |
| step22_cpptraj_image_out1 | output_cpptraj_path | File | Path to the output processed trajectory |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/260
- `workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
