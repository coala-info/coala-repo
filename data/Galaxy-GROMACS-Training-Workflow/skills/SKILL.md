---
name: gromacs-training-workflow
description: "This Galaxy workflow automates molecular dynamics simulations in computational chemistry by retrieving PDB files and utilizing GROMACS tools for system setup, solvation, energy minimization, and production runs. Use this skill when you need to investigate the thermodynamic stability, conformational changes, or atomic-level interactions of a protein within a solvated environment."
homepage: https://workflowhub.eu/workflows/1645
---

# GROMACS Training Workflow

## Overview

This workflow provides a standardized pipeline for conducting molecular dynamics (MD) simulations using [GROMACS](https://www.gromacs.org/), specifically tailored for [GTN](https://training.galaxyproject.org/) computational chemistry training. It automates the transition from raw structural data to a finished simulation, ensuring that all intermediate preparation steps follow best practices for reproducibility.

The process begins by retrieving a protein structure from the PDB database and performing initial text processing. The workflow then handles the core GROMACS setup, including defining the system topology, configuring the simulation box, and solvating the protein with the addition of counter-ions to ensure a neutral environment.

Following system preparation, the workflow executes energy minimization to resolve any steric clashes. It then proceeds through multiple simulation stages—typically encompassing equilibration and production runs—to model the dynamic behavior of the system. The final outputs include the processed structure files (GRO) and the simulation trajectory (XTC), which are essential for downstream analysis of molecular interactions.

## Inputs and data preparation

_None listed._


Ensure your primary input is a valid PDB file, as the workflow generates essential GRO and XTC files required for molecular dynamics analysis. While the workflow is configured for individual datasets, you may utilize dataset collections to scale your simulations for multiple protein structures simultaneously. Consult the README.md for comprehensive instructions on specific parameter settings and force field selection. You can automate the configuration of these inputs by generating a `job.yml` file using `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Get PDB file | toolshed.g2.bx.psu.edu/repos/bgruening/get_pdb/get_pdb/0.1.0 |  |
| 1 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 2 | GROMACS initial setup | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_setup/gmx_setup/2020.2+galaxy0 |  |
| 3 | GROMACS structure configuration | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_editconf/gmx_editconf/2020.2+galaxy0 |  |
| 4 | GROMACS solvation and adding ions | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_solvate/gmx_solvate/2020.2+galaxy0 |  |
| 5 | GROMACS energy minimization | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_em/gmx_em/2020.2+galaxy0 |  |
| 6 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2020.2+galaxy0 |  |
| 7 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2020.2+galaxy0 |  |
| 8 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2020.2+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | output | output |
| 1 | output | output |
| 3 | output | output |
| 8 | xtc_output | output4 |
| 8 | gro_output | output1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
