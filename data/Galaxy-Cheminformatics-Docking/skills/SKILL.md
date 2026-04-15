---
name: covid-19-cheminformatics-3-docking
description: This cheminformatics workflow performs molecular docking of a ligand collection into a specific receptor active site using OpenBabel for compound conversion and rDock for binding simulations. Use this skill when you need to identify potential therapeutic candidates by predicting the binding affinity and orientation of small molecules against a target protein structure.
homepage: https://github.com/galaxyproject/SARS-CoV-2
metadata:
  docker_image: "N/A"
---

# covid-19-cheminformatics-3-docking

## Overview

This workflow is designed for high-throughput molecular docking as part of a COVID-19 cheminformatics pipeline. It automates the process of simulating how small molecule candidates interact with viral protein targets. The workflow requires three primary inputs: a prepared protein receptor, a defined active site, and a collection of input ligands.

The process begins with compound conversion using [Open Babel](https://toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/2.4.2.1.0) to ensure all ligands are in the appropriate format for simulation. To manage large libraries efficiently, the workflow concatenates the datasets and then splits them into a collection, allowing for optimized parallel processing during the docking stage.

The core simulation is performed using [rDock](https://toolshed.g2.bx.psu.edu/repos/bgruening/rdock_rbdock/rdock_rbdock/0.1.1), which calculates the preferred orientation and binding affinity of each ligand within the receptor's active site. The final output is a collection of docked ligands, providing the structural poses and scoring data necessary to identify potential therapeutic leads against COVID-19.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Receptor | data_input |  |
| 1 | Active site | data_input |  |
| 2 | input_ligands | data_collection_input |  |


Ensure the receptor and active site files are provided in PDB or ASL formats, while the input ligands should be organized as a dataset collection in SDF format to facilitate parallel processing. Utilizing a collection instead of individual datasets allows the workflow to efficiently split and dock large compound libraries across multiple compute nodes. For comprehensive instructions on preparing the active site and receptor files, consult the README.md. You can also streamline the execution process by using `planemo workflow_job_init` to create a `job.yml` for your specific data.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Compound conversion | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/2.4.2.1.0 |  |
| 4 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/0.1.0 |  |
| 5 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.4.0 |  |
| 6 | rDock docking | toolshed.g2.bx.psu.edu/repos/bgruening/rdock_rbdock/rdock_rbdock/0.1.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | Docked_Ligands | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Cheminformatics-3-Docking.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Cheminformatics-3-Docking.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Cheminformatics-3-Docking.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Cheminformatics-3-Docking.ga -o job.yml`
- Lint: `planemo workflow_lint Cheminformatics-3-Docking.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Cheminformatics-3-Docking.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)