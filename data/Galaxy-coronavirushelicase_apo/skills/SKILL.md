---
name: coronavirushelicase_apo
description: "This workflow processes protein PDB files and specialized force field parameters using tLEaP, ACPYPE, and GROMACS to perform molecular dynamics simulations and trajectory analysis. Use this skill when you need to model the structural dynamics, stability, and conformational changes of the coronavirus helicase protein in its apo state."
homepage: https://workflowhub.eu/workflows/764
---

# coronavirushelicase_apo

## Overview

This Galaxy workflow automates the molecular dynamics (MD) simulation setup and analysis for the coronavirus helicase in its apo state. The process begins by integrating a protein PDB file with specialized Amber force field parameters using [tLEaP](https://toolshed.g2.bx.psu.edu/repos/chemteam/tleap/tleap/21.10+galaxy0). These initial structures are then converted from Amber format to GROMACS format using [acpype](https://toolshed.g2.bx.psu.edu/repos/chemteam/acpype_amber2gromacs/acpype_Amber2Gromacs/21.10+galaxy0) to leverage GROMACS's simulation engine.

The workflow handles all standard system preparation steps, including box configuration, solvation, and the addition of ions. It further refines the system by generating index files and position restraints to ensure stability during the initial phases of the simulation. Following preparation, the system undergoes energy minimization to resolve steric clashes.

The final stages of the workflow consist of multiple GROMACS simulation production runs. Once the simulations are complete, the workflow concatenates the resulting trajectories and performs essential structural analyses, specifically calculating [RMSD](https://toolshed.g2.bx.psu.edu/repos/chemteam/gmx_rmsd/gmx_rmsd/2022+galaxy0) and [RMSF](https://toolshed.g2.bx.psu.edu/repos/chemteam/gmx_rmsf/gmx_rmsf/2022+galaxy0) to evaluate the stability and flexibility of the helicase structure over time.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | protein pdb file | data_input |  |
| 1 | specialized FF frcmod file | data_input |  |
| 2 | specialized FF prep file | data_input |  |


Ensure that the protein PDB file is properly formatted and that the specialized force field files (.frcmod and .prep) are uploaded as individual datasets to satisfy the tLEaP requirements. These inputs are critical for generating the initial Amber topology before conversion to GROMACS format. For automated execution and parameter mapping, you can use `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on parameter settings and specific force field configurations. All simulation steps rely on these initial preparations to ensure trajectory consistency and accurate RMSD/RMSF analysis.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | GROMACS copy file | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_get_builtin_file/gmx_get_builtin_file/2022+galaxy0 |  |
| 4 | GROMACS copy file | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_get_builtin_file/gmx_get_builtin_file/2022+galaxy0 |  |
| 5 | Build tLEaP | toolshed.g2.bx.psu.edu/repos/chemteam/tleap/tleap/21.10+galaxy0 |  |
| 6 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 7 | Extract dataset | __EXTRACT_DATASET__ |  |
| 8 | Extract dataset | __EXTRACT_DATASET__ |  |
| 9 | Convert Amber topology and coordinate files to GROMACS format | toolshed.g2.bx.psu.edu/repos/chemteam/acpype_amber2gromacs/acpype_Amber2Gromacs/21.10+galaxy0 |  |
| 10 | Adding New Topology Information | toolshed.g2.bx.psu.edu/repos/chemteam/gromacs_modify_topology/gromacs_modify_topology/0+galaxy0 |  |
| 11 | GROMACS structure configuration | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_editconf/gmx_editconf/2022+galaxy0 |  |
| 12 | GROMACS solvation and adding ions | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_solvate/gmx_solvate/2022+galaxy0 |  |
| 13 | Create GROMACS index files | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_makendx/gmx_makendx/2022+galaxy0 |  |
| 14 | Create GROMACS position restraints files | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_restraints/gmx_restraints/2022+galaxy0 |  |
| 15 | Adding New Topology Information | toolshed.g2.bx.psu.edu/repos/chemteam/gromacs_modify_topology/gromacs_modify_topology/0+galaxy0 |  |
| 16 | GROMACS energy minimization | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_em/gmx_em/2022+galaxy0 |  |
| 17 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 18 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 19 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 20 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 21 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 22 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 23 | Modify/convert and concatate GROMACS trajectories | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_trj/gmx_trj/2022+galaxy2 |  |
| 24 | Modify/convert and concatate GROMACS trajectories | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_trj/gmx_trj/2022+galaxy2 |  |
| 25 | Modify/convert and concatate GROMACS trajectories | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_trj/gmx_trj/2022+galaxy2 |  |
| 26 | GROMACS RMSD calculation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_rmsd/gmx_rmsd/2022+galaxy0 |  |
| 27 | GROMACS RMSF calculation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_rmsf/gmx_rmsf/2022+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | output1 | output1 |
| 4 | output1 | output1 |
| 5 | output_top | output_top |
| 5 | output_txt | output_txt |
| 5 | output_mol3 | output_mol3 |
| 5 | output_coord | output_coord |
| 5 | output_tleap_in | output_tleap_in |
| 5 | output_mol2 | output_mol2 |
| 5 | output_tleap | output_tleap |
| 5 | output_pdb | output_pdb |
| 6 | output | output |
| 7 | output | output |
| 8 | input dataset(s) (extracted element) | output |
| 9 | top_output | top_output |
| 9 | gro_output | gro_output |
| 10 | newtop | newtop |
| 11 | report | report |
| 11 | output | output |
| 12 | output1 | output1 |
| 12 | output2 | output2 |
| 12 | report | report |
| 13 | report | report |
| 13 | ndx | ndx |
| 14 | report | report |
| 14 | output1 | output1 |
| 15 | newtop | newtop |
| 16 | output1 | output1 |
| 16 | report | report |
| 16 | output2 | output2 |
| 17 | output1 | output1 |
| 17 | report | report |
| 17 | output5 | output5 |
| 18 | output1 | output1 |
| 18 | output5 | output5 |
| 18 | report | report |
| 19 | output5 | output5 |
| 19 | output3 | output3 |
| 19 | report | report |
| 19 | output1 | output1 |
| 20 | output1 | output1 |
| 20 | report | report |
| 20 | output3 | output3 |
| 20 | output5 | output5 |
| 21 | output3 | output3 |
| 21 | output1 | output1 |
| 21 | output5 | output5 |
| 21 | report | report |
| 22 | output8 | output8 |
| 22 | report | report |
| 22 | output1 | output1 |
| 22 | output3 | output3 |
| 22 | output5 | output5 |
| 23 | output | output |
| 24 | output | output |
| 25 | output | output |
| 26 | GROMACS calculation of RMSD on input dataset(s) | rmsd_output |
| 27 | GROMACS calculation of RMSF on input dataset(s) | rmsf_output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-coronavirushelicase_apo.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-coronavirushelicase_apo.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-coronavirushelicase_apo.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-coronavirushelicase_apo.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-coronavirushelicase_apo.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-coronavirushelicase_apo.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
