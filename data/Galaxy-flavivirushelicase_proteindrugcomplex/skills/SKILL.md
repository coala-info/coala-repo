---
name: flavivirushelicase_proteindrugcomplex
description: "This workflow automates molecular dynamics simulations of Flavivirus helicase-drug complexes using ligand frcmod/mol2 files and protein-ligand PDB structures with tLEaP, acpype, and GROMACS. Use this skill when you need to characterize the binding stability and conformational changes of small molecule inhibitors within the Flavivirus helicase active site through trajectory analysis."
homepage: https://workflowhub.eu/workflows/761
---

# flavivirushelicase_proteindrugcomplex

## Overview

This workflow automates the preparation and molecular dynamics (MD) simulation of a flavivirus helicase protein-drug complex. It begins by processing a protein-ligand complex PDB file alongside specific ligand parameters provided in mol2 and frcmod formats. The pipeline is designed to streamline the transition from static structural data to dynamic simulation using industry-standard computational chemistry tools.

The initial system setup is performed using [tLEaP](https://ambermd.org/tleap.php) to generate Amber-based topology and coordinate files, which are subsequently converted to GROMACS format via [acpype](https://github.com/michellab/acpype). The workflow then handles GROMACS-specific preparation steps, including defining the simulation box, solvating the system, adding neutralizing ions, and creating position restraints to stabilize the complex during equilibration.

The simulation phase consists of energy minimization followed by multiple MD stages to equilibrate and run the production simulation. Finally, the workflow processes the resulting trajectories to perform structural analysis, specifically calculating Root Mean Square Deviation (RMSD) and Root Mean Square Fluctuation (RMSF) to assess the stability and flexibility of the protein-drug interaction.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | ligand frcmod file | data_input |  |
| 1 | ligand mol2 file | data_input |  |
| 2 | protein-ligand complex pdb file | data_input |  |


Ensure all input files are correctly formatted, specifically providing the ligand parameters as `frcmod` and `mol2` files alongside the protein-ligand complex in `pdb` format. Since this workflow processes specific molecular components, verify that the atom naming in your `mol2` file matches the `frcmod` definitions to avoid topology errors during the tLEaP step. While individual datasets are used for initial inputs, the workflow generates several collections for topology and coordinate files that facilitate downstream GROMACS simulations. Refer to the `README.md` for comprehensive details on force field selection and parameterization requirements. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

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
| 5 | Collection of txt | output_txt |
| 5 | Collection of coordinate files | output_coord |
| 5 | Build tLEaP: tleap.log | output_tleap |
| 5 | Collection of mol2 | output_mol2 |
| 5 | Collection of mol3 | output_mol3 |
| 5 | Build tLEaP: tleap.in | output_tleap_in |
| 5 | Collection of pdb | output_pdb |
| 5 | Collection of topology files | output_top |
| 6 | output | output |
| 7 | output | output |
| 8 | input dataset(s) (extracted element) | output |
| 9 | gro_output | gro_output |
| 9 | top_output | top_output |
| 10 | newtop | newtop |
| 11 | report | report |
| 11 | output | output |
| 12 | report | report |
| 12 | output2 | output2 |
| 12 | output1 | output1 |
| 13 | ndx | ndx |
| 13 | report | report |
| 14 | report | report |
| 14 | output1 | output1 |
| 15 | newtop | newtop |
| 16 | output2 | output2 |
| 16 | report | report |
| 16 | output1 | output1 |
| 17 | output5 | output5 |
| 17 | report | report |
| 17 | output1 | output1 |
| 18 | output1 | output1 |
| 18 | output5 | output5 |
| 18 | report | report |
| 19 | output5 | output5 |
| 19 | output1 | output1 |
| 19 | report | report |
| 19 | output3 | output3 |
| 20 | report | report |
| 20 | output5 | output5 |
| 20 | output3 | output3 |
| 20 | output1 | output1 |
| 21 | output3 | output3 |
| 21 | output1 | output1 |
| 21 | output5 | output5 |
| 21 | report | report |
| 22 | output5 | output5 |
| 22 | output1 | output1 |
| 22 | output3 | output3 |
| 22 | report | report |
| 23 | output | output |
| 24 | output | output |
| 25 | output | output |
| 26 | GROMACS calculation of RMSD on input dataset(s) | rmsd_output |
| 27 | GROMACS calculation of RMSF on input dataset(s) | rmsf_output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-flavivirushelicase_proteindrugcomplex.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-flavivirushelicase_proteindrugcomplex.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-flavivirushelicase_proteindrugcomplex.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-flavivirushelicase_proteindrugcomplex.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-flavivirushelicase_proteindrugcomplex.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-flavivirushelicase_proteindrugcomplex.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
