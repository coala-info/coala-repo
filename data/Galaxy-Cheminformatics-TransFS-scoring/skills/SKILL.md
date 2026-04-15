---
name: covid-19-cheminformatics-4-transfs-scoring
description: This cheminformatics workflow evaluates protein-ligand complexes using the XChem TransFS pose scoring tool, taking a PDB protein structure and a collection of ligand poses as inputs. Use this skill when you need to rank or filter potential drug candidates based on deep learning-based binding affinity predictions for a specific viral target.
homepage: https://github.com/galaxyproject/SARS-CoV-2
metadata:
  docker_image: "N/A"
---

# covid-19-cheminformatics-4-transfs-scoring

## Overview

This Galaxy workflow is designed for the deep learning-based evaluation of protein-ligand complexes, specifically focusing on COVID-19 drug discovery. It utilizes the [XChem TransFS pose scoring](https://toolshed.g2.bx.psu.edu/repos/bgruening/xchem_transfs_scoring/xchem_transfs_scoring/0.2.0) tool to predict the quality of docked poses using a Transformer-based approach.

The process begins by taking a target protein in PDB format and a collection of ligand datasets as inputs. To ensure efficient processing, the workflow employs data management steps that collapse the input collection and then split the files into smaller batches. This preparation allows the scoring engine to handle large libraries of potential inhibitors systematically.

The final stage generates scoring predictions that help researchers prioritize compounds for further experimental validation. By applying advanced cheminformatics techniques to COVID-19 targets, this workflow streamlines the identification of high-confidence binding poses from initial docking results. Detailed documentation on the underlying methodology can be found in the [README.md](README.md) located in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Protein (PDB) | data_input |  |
| 1 | Input dataset collection | data_collection_input |  |


Ensure the protein input is provided in PDB format and the ligand collection contains structural files such as SDF to facilitate accurate pose scoring. Utilizing a dataset collection for ligands is essential here, as the workflow automatically splits the data for parallel processing before collapsing the results into a final output. For comprehensive details on specific parameterization and environment setup, always refer to the accompanying README.md. You can streamline the execution process by using `planemo workflow_job_init` to generate a template `job.yml` for your inputs.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 3 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.4.0 |  |
| 4 | XChem TransFS pose scoring | toolshed.g2.bx.psu.edu/repos/bgruening/xchem_transfs_scoring/xchem_transfs_scoring/0.2.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | output | output |
| 4 | predictions | predictions |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Cheminformatics-4-TransFS_scoring.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Cheminformatics-4-TransFS_scoring.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Cheminformatics-4-TransFS_scoring.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Cheminformatics-4-TransFS_scoring.ga -o job.yml`
- Lint: `planemo workflow_lint Cheminformatics-4-TransFS_scoring.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Cheminformatics-4-TransFS_scoring.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)