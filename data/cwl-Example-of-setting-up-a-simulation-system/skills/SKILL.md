---
name: example-of-setting-up-a-simulation-system
description: "This CWL workflow automates the preparation of a protein molecular dynamics simulation system using GROMACS tools to generate topologies, solvate the molecule, add ions, and perform energy minimization and equilibration. Use this skill when preparing biological macromolecules for atomistic simulations to ensure the system is properly solvated, neutralized, and energetically stable for production runs."
homepage: https://workflowhub.eu/workflows/98
---
# Example of setting up a simulation system

## Overview

This [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/98) workflow automates the preparation and initial equilibration of a molecular dynamics simulation system. Designed for High-Performance Computing (HPC) environments, it provides a standardized pipeline for transforming a raw protein structure into a stabilized system ready for production-level GROMACS simulations.

The workflow follows a logical progression of system setup and refinement:
* **System Preparation:** Generates the protein topology, defines the simulation box, and performs solvation and ion addition to ensure the system is neutralized.
* **Energy Minimization:** Executes a two-part minimization process to resolve steric clashes and reach a local potential energy minimum.
* **Equilibration:** Generates necessary GROMACS index files and performs NVT (constant Number of particles, Volume, and Temperature) equilibration to stabilize the system's thermal properties.

By encapsulating these steps in CWL, the workflow ensures reproducibility and portability across different computing infrastructures. It serves as a functional implementation of the `md_list.cwl` pipeline for researchers requiring automated MD system setup.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step1_pdb_file |  | File |  |
| step2_editconf_config |  | string |  |
| step4_grompp_genion_config |  | string |  |
| step5_genion_config |  | string |  |
| step6_grompp_min_config |  | string |  |
| step8_make_ndx_config |  | string |  |
| step9_grompp_nvt_config |  | string |  |
| step11_grompp_npt_config |  | string |  |
| step13_grompp_md_config |  | string |  |
| step14_mdrun_md_config |  | string |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| step1_pdb2gmx | Create Protein System Topology |  |
| step2_editconf | Create Solvent Box |  |
| step3_solvate | Fill the Box with Water Molecules |  |
| step4_grompp_genion | Add Ions - part 1 |  |
| step5_genion | Add Ions - part 2 |  |
| step6_grompp_min | Energetically Minimize the System - part 1 |  |
| step7_mdrun_min | Energetically Minimize the System - part 2 |  |
| step8_make_ndx | Generate GROMACS index file |  |
| step9_grompp_nvt | Equilibrate the System (NVT) - part 1 |  |
| step10_mdrun_nvt | Equilibrate the System (NVT) - part 2 |  |
| step11_grompp_npt | Equilibrate the System (NPT) - part 1 |  |
| step12_mdrun_npt | Equilibrate the System (NPT) - part 2 |  |
| step13_grompp_md | Free Molecular Dynamics Simulation - part 1 |  |
| step14_mdrun_md | Free Molecular Dynamics Simulation - part 2 |  |
| step15_gather_outputs | Archiving outputs to be returned to user |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| dir | whole workflow output | Directory | outputs from the whole workflow, containing these optional files: step14_mdrun_md/output_trr_file:   Raw trajectory from the free simulation step step14_mdrun_md/output_gro_file:   Raw structure from the free simulation step. step14_mdrun_md/output_cpt_file:   GROMACS portable checkpoint file, allowing to restore (continue) the                                    simulation from the last step of the setup process. step13_grompp_md/output_tpr_file:  GROMACS portable binary run input file, containing the starting structure                                    of the simulation, the molecular topology and all the simulation parameters. step5_genion/output_top_zip_file:  GROMACS topology file, containing the molecular topology in an ASCII                                    readable format.  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/98
- `1_md_list.cwl` — workflow definition (CWL)
- `md_list.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
