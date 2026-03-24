---
name: md-namd
description: "This Galaxy workflow performs molecular dynamics simulations in the computational chemistry domain using NAMD, processing PSF and CRD files through system setup, energy minimization, and NVT and NPT equilibration stages. Use this skill when you need to investigate the conformational dynamics and thermodynamic stability of biomolecular systems under specific temperature and pressure ensembles."
homepage: https://workflowhub.eu/workflows/1701
---

# MD NAMD

## Overview

This workflow provides a standardized pipeline for performing molecular dynamics (MD) simulations using the NAMD engine within the Galaxy framework. It is designed for [computational-chemistry](https://galaxyproject.org/use/computational-chemistry/) research, allowing users to simulate the physical movements of atoms and molecules over time to study their thermodynamic properties.

The process begins with the ingestion of structural and coordinate data (typically `.psf` and `.crd` files). The pipeline first performs a **System Setup** and an **Energy Minimizer** step to resolve steric clashes and ensure the molecular system is in a stable, low-energy state before the simulation begins.

Following minimization, the workflow executes two distinct simulation phases: an **NVT ensemble** (constant Number of particles, Volume, and Temperature) to equilibrate the system's temperature, followed by an **NPT ensemble** (constant Number of particles, Pressure, and Temperature) to reach a stable density and pressure. This sequence ensures a rigorous transition from static structures to dynamic trajectories suitable for analysis.

For detailed configuration instructions and tool parameters, refer to the [README.md](./README.md) in the Files section. This workflow is consistent with [GTN](https://training.galaxyproject.org/) best practices for reproducible bioinformatics and chemistry.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | 7cel.psf | data_input |  |
| 1 | 7cel.crd | data_input |  |


Ensure your input PSF and CRD files are correctly formatted and uploaded as individual datasets to match the workflow's initial requirements. While this specific setup uses single datasets for topology and coordinates, you can organize multiple simulation runs using Galaxy collections to streamline batch processing. Refer to the README.md for specific parameter configurations and detailed preparation steps for your protein-ligand systems. You can automate the execution of this NAMD workflow by defining your input paths in a job.yml file using planemo workflow_job_init.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | System Setup | setup |  |
| 3 | Energy Minimizer | minimizer |  |
| 4 | NAMD MD Simulator (NVT) | namd_nvt |  |
| 5 | NAMD MD Simulator (NPT) | namd_npt |  |


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
