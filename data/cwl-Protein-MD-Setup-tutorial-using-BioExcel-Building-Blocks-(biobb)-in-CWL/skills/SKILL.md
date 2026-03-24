---
name: protein-md-setup-tutorial-using-bioexcel-building-blocks-bio
description: "This CWL workflow automates the preparation of protein structures for molecular dynamics simulations by fetching PDB files and performing system setup, solvation, and energy minimization using the BioExcel Building Blocks library. Use this skill when you need to establish a refined, solvated, and energetically stable protein system ready for studying molecular behavior and conformational dynamics."
homepage: https://workflowhub.eu/workflows/29
---
# Protein MD Setup tutorial using BioExcel Building Blocks (biobb) in CWL

## Overview

This workflow demonstrates the automated setup of a protein molecular dynamics (MD) simulation system using the [BioExcel Building Blocks (biobb)](https://workflowhub.eu/projects/11) library. Implemented in [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/29), the pipeline follows a standard preparation protocol using the Lysozyme protein (PDB 1AKI) as a primary example.

The process begins by fetching and fixing the raw PDB structure, followed by the generation of the protein system topology. The workflow then automates the solvation process by creating a solvent box, filling it with water molecules, and performing a two-part ion addition to neutralize the system.

To ensure structural stability, the pipeline concludes with a three-stage energetic minimization of the system. The final outputs include the processed protein structure and the resulting 3D trajectories, providing a simulation-ready environment for further molecular dynamics analysis.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step1_pdb_name |  | string |  |
| step1_pdb_config |  | string |  |
| step4_editconf_config |  | string |  |
| step6_gppion_config |  | string |  |
| step7_genion_config |  | string |  |
| step8_gppmin_config |  | string |  |
| step10_energy_min_config |  | string |  |
| step10_energy_min_name |  | string |  |
| step11_gppnvt_config |  | string |  |
| step13_energy_nvt_config |  | string |  |
| step13_energy_nvt_name |  | string |  |
| step14_gppnpt_config |  | string |  |
| step16_energy_npt_config |  | string |  |
| step16_energy_npt_name |  | string |  |
| step17_gppmd_config |  | string |  |
| step19_rmsfirst_config |  | string |  |
| step19_rmsfirst_name |  | string |  |
| step20_rmsexp_config |  | string |  |
| step20_rmsexp_name |  | string |  |
| step21_rgyr_config |  | string |  |
| step22_image_config |  | string |  |
| step23_dry_config |  | string |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| step1_pdb | Fetch PDB Structure | Download a protein structure from the PDB database  |
| step2_fixsidechain | Fix Protein structure | Fix the side chains, adding any side chain atoms missing in the original structure.  |
| step3_pdb2gmx | Create Protein System Topology |  |
| step4_editconf | Create Solvent Box |  |
| step5_solvate | Fill the Box with Water Molecules |  |
| step6_grompp_genion | Add Ions - part 1 |  |
| step7_genion | Add Ions - part 2 |  |
| step8_grompp_min | Energetically Minimize the System - part 1 |  |
| step9_mdrun_min | Energetically Minimize the System - part 2 |  |
| step10_energy_min | Energetically Minimize the System - part 3 |  |
| step11_grompp_nvt | Equilibrate the System (NVT) - part 1 |  |
| step12_mdrun_nvt | Equilibrate the System (NVT) - part 2 |  |
| step13_energy_nvt | Equilibrate the System (NVT) - part 3 |  |
| step14_grompp_npt | Equilibrate the System (NPT) - part 1 |  |
| step15_mdrun_npt | Equilibrate the System (NPT) - part 2 |  |
| step16_energy_npt | Equilibrate the System (NPT) - part 3 |  |
| step17_grompp_md | Free Molecular Dynamics Simulation - part 1 |  |
| step18_mdrun_md | Free Molecular Dynamics Simulation - part 2 |  |
| step19_rmsfirst | Post-processing Resulting 3D Trajectory - part 1 |  |
| step20_rmsexp | Post-processing Resulting 3D Trajectory - part 2 |  |
| step21_rgyr | Post-processing Resulting 3D Trajectory - part 3 |  |
| step22_image | Post-processing Resulting 3D Trajectory - part 4 |  |
| step23_dry | Post-processing Resulting 3D Trajectory - part 5 |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| trr | Trajectories - Raw trajectory | File | Raw trajectory from the free simulation step  |
| trr_imaged_dry | Trajectories - Post-processed trajectory | File | Post-processed trajectory, dehydrated, imaged (rotations and translations removed) and centered.  |
| gro_dry | Resulting protein structure | File | Resulting protein structure taken from the post-processed trajectory, to be used as a topology, usually for visualization purposes.  |
| gro | Structures - Raw structure | File | Raw structure from the free simulation step.  |
| cpt | Checkpoint file | File | GROMACS portable checkpoint file, allowing to restore (continue) the simulation from the last step of the setup process.  |
| tpr | Topologies GROMACS portable binary run | File | GROMACS portable binary run input file, containing the starting structure of the simulation, the molecular topology and all the simulation parameters.  |
| top | GROMACS topology file | File | GROMACS topology file, containing the molecular topology in an ASCII readable format.  |
| xvg_min | System Setup Observables - Potential Energy | File | Potential energy of the system during the minimization step.  |
| xvg_nvt | System Setup Observables - Temperature | File | Temperature of the system during the NVT equilibration step.  |
| xvg_npt | System Setup Observables - Pressure and density | File |  |
| xvg_rmsfirst | Simulation Analysis | File | Root Mean Square deviation (RMSd) throughout the whole free simulation step against the first snapshot of the trajectory (equilibrated system).  |
| xvg_rmsexp | Simulation Analysis | File | Root Mean Square deviation (RMSd) throughout the whole free simulation step against the experimental structure (minimized system).  |
| xvg_rgyr | Simulation Analysis | File | Radius of Gyration (RGyr) of the molecule throughout the whole free simulation step  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/29
- `protein_md.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
