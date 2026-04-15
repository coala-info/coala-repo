---
name: gmx-ligand-parameterization
description: This Galaxy workflow automates the generation of GROMACS topology and coordinate files for small molecules by fetching a ligand, adding hydrogens, performing energy minimization with Open Babel, and calculating force field parameters using ACPYPE. Use this skill when you need to prepare a ligand for molecular dynamics simulations by creating accurate force field parameters and optimized structures compatible with the GROMACS engine.
homepage: https://mmb.irbbarcelona.org/biobb/
metadata:
  docker_image: "N/A"
---

# gmx-ligand-parameterization

## Overview

This workflow automates the generation of GROMACS topology parameters for a small molecule ligand using the BioExcel Building Blocks (biobb) ecosystem. It begins by retrieving the ligand structure and utilizing Open Babel to add missing hydrogen atoms, ensuring the chemical structure is complete and correctly protonated for simulation.

Following hydrogen addition, the structure undergoes energy minimization to optimize its 3D geometry. The final stage employs [ACPYPE](https://github.com/reskyner/acpype) to calculate partial charges and generate the necessary GROMACS files, including the structure (.gro) and topology (.itp, .top) files required for molecular dynamics.

Users can execute this pipeline on the [INB's Galaxy server](https://biobb.usegalaxy.es/) by importing the provided `.ga` workflow file. This automated approach streamlines the complex process of ligand parameterization, ensuring consistency and reproducibility in biomolecular simulation setups.

## Inputs and data preparation

_None listed._


To begin, ensure your input is a valid ligand identifier or a PDB file containing the small molecule to be parameterized. If you are processing multiple molecules simultaneously, organizing your inputs into a dataset collection will allow the workflow to run in batch mode efficiently. For comprehensive details on parameter settings and file preparation, refer to the README.md file included in the repository. You may also use `planemo workflow_job_init` to generate a `job.yml` file for automated command-line execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Ligand | biobb_io_ligand_ext |  |
| 1 | BabelAddHydrogens | biobb_chemistry_babel_add_hydrogens_ext |  |
| 2 | BabelMinimize | biobb_chemistry_babel_minimize_ext |  |
| 3 | AcpypeParamsGmx | biobb_chemistry_acpype_params_gmx_ext |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | myligand.pdb | output_pdb_path |
| 1 | output_path | output_path |
| 2 | mybabel_minimize.pdb | output_path |
| 3 | myacpype_params_gmx.itp | output_path_itp |
| 3 | myacpype_params_gmx.top | output_path_top |
| 3 | myacpype_params_gmx.gro | output_path_gro |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run biobb_wf_ligand_parameterization.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run biobb_wf_ligand_parameterization.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run biobb_wf_ligand_parameterization.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init biobb_wf_ligand_parameterization.ga -o job.yml`
- Lint: `planemo workflow_lint biobb_wf_ligand_parameterization.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `biobb_wf_ligand_parameterization.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)