---
name: flavivirushelicase_apo
description: "This workflow processes a protein PDB file to perform molecular dynamics simulations of a flavivirus helicase in its apo state using tLEaP for topology generation and GROMACS for solvation, equilibration, and trajectory analysis. Use this skill when you need to investigate the intrinsic flexibility and structural behavior of a viral helicase protein through atomistic simulations to identify potential druggable sites or understand its functional mechanisms."
homepage: https://workflowhub.eu/workflows/762
---

# flavivirushelicase_apo

## Overview

This workflow automates the molecular dynamics (MD) simulation of a flavivirus helicase in its apo state. It begins by processing a protein PDB file using [tLEaP](https://toolshed.g2.bx.psu.edu/repos/chemteam/tleap/tleap/21.10+galaxy0) to build initial topology and coordinate files. These Amber-format files are subsequently converted to GROMACS format using [acpype](https://toolshed.g2.bx.psu.edu/repos/chemteam/acpype_amber2gromacs/acpype_Amber2Gromacs/21.10+galaxy0) to facilitate simulation within the GROMACS ecosystem.

The preparation phase involves structural configuration, solvation, and the addition of ions to create a realistic biological environment. The workflow then executes a series of GROMACS steps, including energy minimization and multiple successive simulation stages (NVT, NPT, and production runs) to equilibrate the system and sample the protein's conformational space.

In the final stages, the workflow concatenates the resulting trajectories and performs essential post-simulation analyses. It generates [RMSD](https://toolshed.g2.bx.psu.edu/repos/chemteam/gmx_rmsd/gmx_rmsd/2022+galaxy0) and [RMSF](https://toolshed.g2.bx.psu.edu/repos/chemteam/gmx_rmsf/gmx_rmsf/2022+galaxy0) calculations to evaluate the structural stability and residue-level flexibility of the helicase throughout the simulation.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | protein pdb file | data_input |  |


Ensure the input protein PDB file is properly formatted and free of missing residues or non-standard atoms to prevent errors during the tLEaP building and GROMACS solvation stages. While the workflow primarily processes individual datasets, several steps generate collections of topology and coordinate files that are essential for downstream simulation and trajectory analysis. For automated execution and parameter mapping, you can use `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on force field selection and specific GROMACS configuration parameters. Always verify that the initial structure is correctly oriented within the simulation box before proceeding to the energy minimization and production runs.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | GROMACS copy file | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_get_builtin_file/gmx_get_builtin_file/2022+galaxy0 |  |
| 2 | GROMACS copy file | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_get_builtin_file/gmx_get_builtin_file/2022+galaxy0 |  |
| 3 | Build tLEaP | toolshed.g2.bx.psu.edu/repos/chemteam/tleap/tleap/21.10+galaxy0 |  |
| 4 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 5 | Extract dataset | __EXTRACT_DATASET__ |  |
| 6 | Extract dataset | __EXTRACT_DATASET__ |  |
| 7 | Convert Amber topology and coordinate files to GROMACS format | toolshed.g2.bx.psu.edu/repos/chemteam/acpype_amber2gromacs/acpype_Amber2Gromacs/21.10+galaxy0 |  |
| 8 | Adding New Topology Information | toolshed.g2.bx.psu.edu/repos/chemteam/gromacs_modify_topology/gromacs_modify_topology/0+galaxy0 |  |
| 9 | GROMACS structure configuration | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_editconf/gmx_editconf/2022+galaxy0 |  |
| 10 | GROMACS solvation and adding ions | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_solvate/gmx_solvate/2022+galaxy0 |  |
| 11 | Create GROMACS index files | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_makendx/gmx_makendx/2022+galaxy0 |  |
| 12 | Create GROMACS position restraints files | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_restraints/gmx_restraints/2022+galaxy0 |  |
| 13 | Adding New Topology Information | toolshed.g2.bx.psu.edu/repos/chemteam/gromacs_modify_topology/gromacs_modify_topology/0+galaxy0 |  |
| 14 | GROMACS energy minimization | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_em/gmx_em/2022+galaxy0 |  |
| 15 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 16 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 17 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 18 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 19 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 20 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 21 | Modify/convert and concatate GROMACS trajectories | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_trj/gmx_trj/2022+galaxy2 |  |
| 22 | Modify/convert and concatate GROMACS trajectories | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_trj/gmx_trj/2022+galaxy2 |  |
| 23 | Modify/convert and concatate GROMACS trajectories | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_trj/gmx_trj/2022+galaxy2 |  |
| 24 | GROMACS RMSD calculation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_rmsd/gmx_rmsd/2022+galaxy0 |  |
| 25 | GROMACS RMSF calculation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_rmsf/gmx_rmsf/2022+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | output1 | output1 |
| 2 | output1 | output1 |
| 3 | Collection of topology files | output_top |
| 3 | Collection of pdb | output_pdb |
| 3 | Collection of txt | output_txt |
| 3 | Collection of coordinate files | output_coord |
| 3 | Build tLEaP: tleap.log | output_tleap |
| 3 | Collection of mol2 | output_mol2 |
| 3 | Collection of mol3 | output_mol3 |
| 3 | Build tLEaP: tleap.in | output_tleap_in |
| 4 | output | output |
| 5 | output | output |
| 6 | input dataset(s) (extracted element) | output |
| 7 | top_output | top_output |
| 7 | gro_output | gro_output |
| 8 | newtop | newtop |
| 9 | output | output |
| 9 | report | report |
| 10 | output1 | output1 |
| 10 | output2 | output2 |
| 10 | report | report |
| 11 | ndx | ndx |
| 11 | report | report |
| 12 | output1 | output1 |
| 12 | report | report |
| 13 | newtop | newtop |
| 14 | output2 | output2 |
| 14 | report | report |
| 14 | output1 | output1 |
| 15 | output5 | output5 |
| 15 | report | report |
| 15 | output1 | output1 |
| 16 | report | report |
| 16 | output1 | output1 |
| 16 | output5 | output5 |
| 17 | report | report |
| 17 | output1 | output1 |
| 17 | output3 | output3 |
| 17 | output5 | output5 |
| 18 | output3 | output3 |
| 18 | output5 | output5 |
| 18 | report | report |
| 18 | output1 | output1 |
| 19 | output3 | output3 |
| 19 | output1 | output1 |
| 19 | output5 | output5 |
| 19 | report | report |
| 20 | output1 | output1 |
| 20 | output3 | output3 |
| 20 | output5 | output5 |
| 20 | report | report |
| 21 | output | output |
| 22 | output | output |
| 23 | output | output |
| 24 | GROMACS calculation of RMSD on input dataset(s) | rmsd_output |
| 25 | GROMACS calculation of RMSF on input dataset(s) | rmsf_output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-flavivirushelicase_apo.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-flavivirushelicase_apo.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-flavivirushelicase_apo.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-flavivirushelicase_apo.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-flavivirushelicase_apo.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-flavivirushelicase_apo.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
