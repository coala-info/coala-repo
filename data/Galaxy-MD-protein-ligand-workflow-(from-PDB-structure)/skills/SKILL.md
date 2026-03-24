---
name: md-protein-ligand-workflow-from-pdb-structure
description: "This computational chemistry workflow automates the preparation and execution of molecular dynamics simulations for protein-ligand complexes starting from a PDB code using GROMACS, ACPYPE, and OpenBabel. Use this skill when you need to investigate the structural stability and atomic-level interactions of a specific small molecule bound to a protein target over time."
homepage: https://workflowhub.eu/workflows/1686
---

# MD protein-ligand workflow (from PDB structure)

## Overview

This Galaxy workflow automates high-throughput molecular dynamics (MD) simulations for protein-ligand complexes, starting directly from a PDB accession code. It streamlines the preparation process by fetching the structure, isolating the protein and specified ligand, and generating the necessary topologies using [GROMACS](https://www.gromacs.org/) and [acpype](https://github.com/reslp/acpype) (AmberTools).

The pipeline handles the complex setup of the simulation environment, including system solvation, ion neutralization, and the merging of protein and ligand topologies. It then executes a standard MD protocol consisting of energy minimization followed by multiple simulation stages (equilibration and production runs).

This workflow is ideal for researchers performing computational chemistry and cheminformatics tasks who require a reproducible, automated path from a raw PDB structure to a finished MD trajectory. For detailed usage instructions, please refer to the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorials on molecular dynamics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | PDB code (e.g. 6hhr) | parameter_input |  |
| 1 | Ligand name (e.g. AG5E) | parameter_input |  |


Ensure the PDB code and ligand name match the target structure exactly to facilitate successful automated retrieval and extraction. For high-throughput applications, utilizing dataset collections allows for the parallel processing of multiple protein-ligand pairs. Always verify that the ligand identifier is present in the PDB file's HETATM records to prevent errors during topology generation. Refer to the README.md for exhaustive documentation on simulation settings and force field configurations. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined command-line execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Get PDB file | toolshed.g2.bx.psu.edu/repos/bgruening/get_pdb/get_pdb/0.1.0 |  |
| 3 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 4 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 5 | GROMACS initial setup | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_setup/gmx_setup/2019.1.4 |  |
| 6 | Compound conversion | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/2.4.2.2.0 |  |
| 7 | Generate MD topologies for small molecules | toolshed.g2.bx.psu.edu/repos/chemteam/ambertools_acpype/ambertools_acpype/19.11 |  |
| 8 | Merge GROMACS topologies | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_merge_topology_files/gmx_merge_topology_files/3.2.0 |  |
| 9 | GROMACS structure configuration | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_editconf/gmx_editconf/2019.1.4 |  |
| 10 | GROMACS solvation and adding ions | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_solvate/gmx_solvate/2019.1.4 |  |
| 11 | GROMACS energy minimization | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_em/gmx_em/2019.1.4 |  |
| 12 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2019.1.4.1 |  |
| 13 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2019.1.4.1 |  |
| 14 | GROMACS simulation | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_sim/gmx_sim/2019.1.4.1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

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
