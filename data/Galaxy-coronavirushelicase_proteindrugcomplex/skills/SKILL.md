---
name: coronavirushelicase_proteindrugcomplex
description: This workflow processes protein-ligand complex PDB files and ligand force field parameters using tLEaP, acpype, and GROMACS to perform molecular dynamics simulations and trajectory analysis. Use this skill when investigating the structural stability and binding interactions of potential drug candidates with the coronavirus helicase protein through atomistic molecular dynamics simulations.
homepage: https://zenodo.org/records/7492987
metadata:
  docker_image: "N/A"
---

# coronavirushelicase_proteindrugcomplex

## Overview

This workflow automates the molecular dynamics (MD) simulation and analysis of a coronavirus helicase protein-drug complex. It begins by integrating ligand parameters (mol2 and frcmod) with the protein-ligand PDB structure using [tLEaP](https://ambermd.org/tleap.php). The process incorporates specialized force field files to ensure accurate parameterization of the complex before simulation.

The initial Amber-based topology and coordinate files are converted to GROMACS format using [acpype](https://github.com/mccabe615/acpype). The workflow then prepares the system for simulation by defining the simulation box geometry, solvating the complex, adding neutralizing ions, and generating necessary index and position restraint files.

The simulation pipeline consists of energy minimization followed by multiple stages of GROMACS MD production runs. In the final stages, the workflow concatenates the resulting trajectories and performs structural analyses, including Root Mean Square Deviation (RMSD) and Root Mean Square Fluctuation (RMSF) calculations, to evaluate the stability and conformational dynamics of the protein-drug interaction.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | ligand frcmod file | data_input |  |
| 1 | ligand mol2 file | data_input |  |
| 2 | protein-ligand complex pdb file | data_input |  |
| 3 | specialized FF frcmod file | data_input |  |
| 4 | specialized FF prep file | data_input |  |


Ensure all input files are correctly formatted, specifically providing the ligand in `.mol2` and `.frcmod` formats alongside the protein-ligand complex in `.pdb` format to satisfy tLEaP requirements. You must also supply the specialized force field `.prep` and `.frcmod` files as individual datasets to ensure proper parameterization of the complex. For large-scale testing or automated execution, you can use `planemo workflow_job_init` to generate a `job.yml` file for managing these inputs. Refer to the `README.md` for comprehensive details on parameter settings and specific force field configurations. One paragraph only.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | GROMACS copy file | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_get_builtin_file/gmx_get_builtin_file/2022+galaxy0 |  |
| 6 | GROMACS copy file | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_get_builtin_file/gmx_get_builtin_file/2022+galaxy0 |  |
| 7 | Build tLEaP | toolshed.g2.bx.psu.edu/repos/chemteam/tleap/tleap/21.10+galaxy0 |  |
| 8 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 9 | Extract dataset | __EXTRACT_DATASET__ |  |
| 10 | Extract dataset | __EXTRACT_DATASET__ |  |
| 11 | Convert Amber topology and coordinate files to GROMACS format | toolshed.g2.bx.psu.edu/repos/chemteam/acpype_amber2gromacs/acpype_Amber2Gromacs/21.10+galaxy0 |  |
| 12 | Adding New Topology Information | toolshed.g2.bx.psu.edu/repos/chemteam/gromacs_modify_topology/gromacs_modify_topology/0+galaxy0 |  |
| 13 | GROMACS structure configuration | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_editconf/gmx_editconf/2022+galaxy0 |  |
| 14 | GROMACS solvation and adding ions | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_solvate/gmx_solvate/2022+galaxy0 |  |
| 15 | Create GROMACS index files | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_makendx/gmx_makendx/2022+galaxy0 |  |
| 16 | Create GROMACS position restraints files | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_restraints/gmx_restraints/2022+galaxy0 |  |
| 17 | Adding New Topology Information | toolshed.g2.bx.psu.edu/repos/chemteam/gromacs_modify_topology/gromacs_modify_topology/0+galaxy0 |  |
| 18 | GROMACS energy minimization | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_em/gmx_em/2022+galaxy0 |  |
| 19 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 20 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 21 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 22 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 23 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 24 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 25 | Modify/convert and concatate GROMACS trajectories | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_trj/gmx_trj/2022+galaxy2 |  |
| 26 | Modify/convert and concatate GROMACS trajectories | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_trj/gmx_trj/2022+galaxy2 |  |
| 27 | Modify/convert and concatate GROMACS trajectories | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_trj/gmx_trj/2022+galaxy2 |  |
| 28 | GROMACS RMSD calculation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_rmsd/gmx_rmsd/2022+galaxy0 |  |
| 29 | GROMACS RMSF calculation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_rmsf/gmx_rmsf/2022+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | output1 | output1 |
| 6 | output1 | output1 |
| 7 | output_tleap | output_tleap |
| 7 | output_pdb | output_pdb |
| 7 | output_top | output_top |
| 7 | output_txt | output_txt |
| 7 | output_coord | output_coord |
| 7 | output_mol2 | output_mol2 |
| 7 | output_mol3 | output_mol3 |
| 7 | output_tleap_in | output_tleap_in |
| 8 | output | output |
| 9 | output | output |
| 10 | input dataset(s) (extracted element) | output |
| 11 | top_output | top_output |
| 11 | gro_output | gro_output |
| 12 | newtop | newtop |
| 13 | output | output |
| 13 | report | report |
| 14 | output2 | output2 |
| 14 | report | report |
| 14 | output1 | output1 |
| 15 | ndx | ndx |
| 15 | report | report |
| 16 | output1 | output1 |
| 16 | report | report |
| 17 | newtop | newtop |
| 18 | output1 | output1 |
| 18 | report | report |
| 18 | output2 | output2 |
| 19 | output1 | output1 |
| 19 | report | report |
| 19 | output5 | output5 |
| 20 | output1 | output1 |
| 20 | output5 | output5 |
| 20 | report | report |
| 21 | output5 | output5 |
| 21 | output3 | output3 |
| 21 | report | report |
| 21 | output1 | output1 |
| 22 | output1 | output1 |
| 22 | output3 | output3 |
| 22 | output5 | output5 |
| 22 | report | report |
| 23 | report | report |
| 23 | output1 | output1 |
| 23 | output3 | output3 |
| 23 | output5 | output5 |
| 24 | output1 | output1 |
| 24 | output3 | output3 |
| 24 | output5 | output5 |
| 24 | report | report |
| 24 | output8 | output8 |
| 25 | output | output |
| 26 | output | output |
| 27 | output | output |
| 28 | GROMACS calculation of RMSD on input dataset(s) | rmsd_output |
| 29 | GROMACS calculation of RMSF on input dataset(s) | rmsf_output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-coronavirushelicase_proteindrugcomplex.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-coronavirushelicase_proteindrugcomplex.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-coronavirushelicase_proteindrugcomplex.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-coronavirushelicase_proteindrugcomplex.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-coronavirushelicase_proteindrugcomplex.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-coronavirushelicase_proteindrugcomplex.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)