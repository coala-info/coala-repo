---
name: mmgbsa-calculations-with-gromacs
description: This Galaxy workflow performs ensemble molecular dynamics simulations and MMGBSA free energy calculations for protein-ligand complexes using GROMACS and AmberTools, taking PDB and SDF files as primary inputs. Use this skill when you need to estimate the binding affinity of a small molecule to a protein target by averaging energy components across multiple simulation trajectories.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# mmgbsa-calculations-with-gromacs

## Overview

This Galaxy workflow performs ensemble Molecular Dynamics (MD) simulations and calculates binding free energies using the Molecular Mechanics Generalized Born Surface Area (MMGBSA) method. Starting from an apoprotein PDB and a ligand SDF file, the workflow utilizes a subworkflow to parameterize the protein-ligand complex. Users can customize the simulation environment by specifying the force field, water model, pH, and salt concentration.

The pipeline automates the standard GROMACS preparation and simulation steps, including structure configuration, solvation, ion addition, and energy minimization. It then proceeds through NVT and NPT equilibration phases before running the production MD simulations. The workflow is designed to handle an ensemble of simulations, the size of which is defined by the user to ensure statistical robustness.

Following the simulations, the trajectory data is processed using [MDTraj](https://www.mdtraj.org/) and analyzed via [AmberTools](https://ambermd.org/AmberTools.php) to calculate MMGBSA statistics. The final outputs include the simulation GRO and XTC files, detailed MMGBSA statistics, and a summary of the calculated free energy ensemble average. This workflow is released under the [MIT license](https://opensource.org/licenses/MIT).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Salt concentration | parameter_input | NaCl concentration |
| 1 | Number of simulations | parameter_input | Size of the MMGBSA ensemble |
| 2 | Apoprotein PDB | data_input | PDB input |
| 3 | Water model | parameter_input | Water model |
| 4 | pH | parameter_input | pH for protonation (-1.0 to skip) |
| 5 | Force field | parameter_input | Force field |
| 6 | Ligand SDF | data_input | SDF input |
| 7 | NVT equilibration steps | parameter_input | Number of steps for NVT equilibration |
| 8 | NPT equilibration steps | parameter_input | Number of steps for NPT equilibration |
| 9 | Production steps | parameter_input | Number of steps for production simulation |


Ensure your input protein is in PDB format and the ligand is provided as an SDF file, as these are essential for the initial parameterization subworkflow. You should verify that the force field and water model parameters match your specific molecular system requirements before starting the simulation ensemble. For large-scale runs, consider using `planemo workflow_job_init` to generate a `job.yml` for efficient parameter management. Refer to the README.md for comprehensive details on configuring simulation steps and salt concentrations. Detailed guidance on handling data collections for the ensemble outputs can also be found in the supplementary documentation.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 10 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 11 | Create GRO and TOP complex files | (subworkflow) |  |
| 12 | Create text file | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_text_file_with_recurring_lines/9.5+galaxy3 |  |
| 13 | GROMACS structure configuration | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_editconf/gmx_editconf/2022+galaxy0 |  |
| 14 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.2 |  |
| 15 | Parse parameter value | param_value_from_file |  |
| 16 | GROMACS solvation and adding ions | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_solvate/gmx_solvate/2022+galaxy0 |  |
| 17 | GROMACS energy minimization | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_em/gmx_em/2022+galaxy0 |  |
| 18 | Convert Parameters | toolshed.g2.bx.psu.edu/repos/chemteam/parmconv/parmconv/21.10+galaxy0 |  |
| 19 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 20 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 21 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2022+galaxy0 |  |
| 22 | MDTraj file converter | toolshed.g2.bx.psu.edu/repos/chemteam/md_converter/md_converter/1.9.6+galaxy0 |  |
| 23 | MMPBSA/MMGBSA | toolshed.g2.bx.psu.edu/repos/chemteam/mmpbsa_mmgbsa/mmpbsa_mmgbsa/21.10+galaxy0 |  |
| 24 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/9.5+galaxy3 |  |
| 25 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 26 | Cut | Cut1 |  |
| 27 | Summary Statistics | Summary_Statistics1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 21 | GRO files | output1 |
| 21 | XTC files | output4 |
| 23 | MMGBSA statistics | resultoutfile |
| 27 | MMGBSA free energy | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run gromacs-mmgbsa.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run gromacs-mmgbsa.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run gromacs-mmgbsa.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init gromacs-mmgbsa.ga -o job.yml`
- Lint: `planemo workflow_lint gromacs-mmgbsa.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `gromacs-mmgbsa.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)