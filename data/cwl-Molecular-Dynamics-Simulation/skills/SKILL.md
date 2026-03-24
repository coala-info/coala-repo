---
name: molecular-dynamics-simulation
description: "This CWL workflow automates the preparation and execution of molecular dynamics simulations for protein structures using GROMACS to perform system topology creation, solvation, and equilibration. Use this skill when you need to investigate the conformational dynamics of proteins or evaluate the structural impact of specific amino acid mutations under physiological conditions."
homepage: https://workflowhub.eu/workflows/121
---
# Molecular Dynamics Simulation

## Overview

This [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/121) workflow automates the system setup and execution of molecular dynamics (MD) simulations, specifically optimized for High-Performance Computing (HPC) environments. It provides an end-to-end pipeline that transforms a raw protein structure into an equilibrated system ready for production runs.

The process is divided into three primary phases: system preparation (topology creation, solvation, and ion addition), energy minimization to resolve steric clashes, and NVT equilibration. The workflow utilizes the `md_gather.cwl` sub-workflow to aggregate all generated outputs for final delivery.

For high-throughput applications, this workflow is designed to be called by parent "launcher" workflows. It can be integrated with `md_launch.cwl` to process multiple independent molecule files in parallel or `md_launch_mutate.cwl` to perform simulations on a single molecule across a list of specified mutations using CWL's scatter feature.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step1_pdb_file | Input file | File | Molecule to process (PDB format) |
| step2_editconf_config | Editconf configuration dictionary | string |  |
| step4_grompp_genion_config | GROMACS grompp configuration dictionary | string |  |
| step5_genion_config | Genion configuration dictionary | string |  |
| step6_grompp_min_config | GROMACS grompp configuration dictionary | string |  |
| step8_make_ndx_config | GROMACS make_ndx configuration dictionary | string |  |
| step9_grompp_nvt_config | GROMACS grompp configuration dictionary | string |  |
| step11_grompp_npt_config | GROMACS grompp configuration dictionary | string |  |
| step13_grompp_md_config | GROMACS grompp configuration dictionary | string |  |
| step14_mdrun_md_config | GROMACS mdrun configuration dictionary | string |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| step1_pdb2gmx | Create Protein System Topology | https://biobb-md.readthedocs.io/en/latest/gromacs.html#module-gromacs.pdb2gmx |
| step2_editconf | Create Solvent Box | https://biobb-md.readthedocs.io/en/latest/gromacs.html#module-gromacs.editconf |
| step3_solvate | Fill the Box with Water Molecules | https://biobb-md.readthedocs.io/en/latest/gromacs.html#module-gromacs.solvate |
| step4_grompp_genion | Add Ions - part 1 | https://biobb-md.readthedocs.io/en/latest/gromacs.html#module-gromacs.grompp |
| step5_genion | Add Ions - part 2 | https://biobb-md.readthedocs.io/en/latest/gromacs.html#module-gromacs.genion |
| step6_grompp_min | Energetically Minimize the System - part 1 | https://biobb-md.readthedocs.io/en/latest/gromacs.html#module-gromacs.grompp |
| step7_mdrun_min | Energetically Minimize the System - part 2 | https://biobb-md.readthedocs.io/en/latest/gromacs.html#module-gromacs.mdrun |
| step8_make_ndx | Generate GROMACS index file | https://biobb-md.readthedocs.io/en/latest/gromacs.html#module-gromacs.make_ndx |
| step9_grompp_nvt | Equilibrate the System (NVT) - part 1 | https://biobb-md.readthedocs.io/en/latest/gromacs.html#module-gromacs.grompp |
| step10_mdrun_nvt | Equilibrate the System (NVT) - part 2 | https://biobb-md.readthedocs.io/en/latest/gromacs.html#module-gromacs.mdrun |
| step11_grompp_npt | Equilibrate the System (NPT) - part 1 | https://biobb-md.readthedocs.io/en/latest/gromacs.html#module-gromacs.grompp |
| step12_mdrun_npt | Equilibrate the System (NPT) - part 2 | https://biobb-md.readthedocs.io/en/latest/gromacs.html#module-gromacs.mdrun |
| step13_grompp_md | Free Molecular Dynamics Simulation - part 1 | https://biobb-md.readthedocs.io/en/latest/gromacs.html#module-gromacs.grompp |
| step14_mdrun_md | Free Molecular Dynamics Simulation - part 2 | https://biobb-md.readthedocs.io/en/latest/gromacs.html#module-gromacs.mdrun |
| step15_gather_outputs | Archiving outputs to be returned to user | This uses the local md_gather.cwl workflow to gather all desired output files. A filter for missing files is applied (pickValue: all_non_null), which requires using a runner which is compliant with v1.2.0, or later, CWL standards.  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| dir | whole workflow output | Directory | outputs from the whole workflow, containing these optional files: step14_mdrun_md/output_trr_file:   Raw trajectory from the free simulation step step14_mdrun_md/output_gro_file:   Raw structure from the free simulation step. step14_mdrun_md/output_cpt_file:   GROMACS portable checkpoint file, allowing to restore (continue) the                                    simulation from the last step of the setup process. step13_grompp_md/output_tpr_file:  GROMACS portable binary run input file, containing the starting structure                                    of the simulation, the molecular topology and all the simulation parameters. step5_genion/output_top_zip_file:  GROMACS topology file, containing the molecular topology in an ASCII                                    readable format.  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/121
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
