---
name: simple-analysis
description: "This computational chemistry workflow processes protein DCD trajectories and PDB structures using Bio3D tools to perform RMSD, RMSF, and principal component analysis. Use this skill when you need to evaluate the structural stability, residue-level flexibility, and dominant conformational motions of a protein throughout a molecular dynamics simulation."
homepage: https://workflowhub.eu/workflows/1697
---

# Simple Analysis

## Overview

This workflow provides a streamlined pipeline for the post-processing analysis of molecular dynamics (MD) simulations. It is designed to process structural data by taking two primary inputs: a trajectory file in DCD format (`protein_mdsimulation_dcd`) and a reference structure file in PDB format (`protein_pdb`).

The analysis is performed using the Bio3D suite of tools to evaluate protein stability and dynamics. The workflow executes three key computational steps: [RMSD Analysis](https://toolshed.g2.bx.psu.edu/repos/chemteam/bio3d_rmsd/bio3d_rmsd/2.3) to measure structural deviation over time, [RMSF Analysis](https://toolshed.g2.bx.psu.edu/repos/chemteam/bio3d_rmsf/bio3d_rmsf/2.3) to identify flexible residue positions, and [Principal Component Analysis (PCA)](https://toolshed.g2.bx.psu.edu/repos/chemteam/bio3d_pca/bio3d_pca/2.3) to characterize the dominant conformational motions.

The final outputs consist of three tabular datasets containing the numerical results for the RMSD, RMSF, and PCA calculations. This workflow is categorized under Computational-chemistry and aligns with [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) standards for reproducible simulation analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | protein_mdsimulation_dcd | data_input |  |
| 1 | protein_pdb | data_input |  |


Ensure the PDB structure file matches the topology of the DCD trajectory exactly to avoid coordinate mismatch errors during Bio3D analysis. While individual datasets are standard for single runs, consider using dataset collections if you are processing multiple simulation replicas simultaneously. Refer to the README.md for comprehensive details on parameter settings and any necessary preprocessing steps. You can also use `planemo workflow_job_init` to create a `job.yml` file for streamlined execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | RMSD Analysis | toolshed.g2.bx.psu.edu/repos/chemteam/bio3d_rmsd/bio3d_rmsd/2.3 |  |
| 3 | RMSF Analysis | toolshed.g2.bx.psu.edu/repos/chemteam/bio3d_rmsf/bio3d_rmsf/2.3 |  |
| 4 | PCA | toolshed.g2.bx.psu.edu/repos/chemteam/bio3d_pca/bio3d_pca/2.3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | rmsd_tabular_output | output |
| 3 | rmsf_tabular_output | output |
| 4 | pca_tabular_output | output |


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
