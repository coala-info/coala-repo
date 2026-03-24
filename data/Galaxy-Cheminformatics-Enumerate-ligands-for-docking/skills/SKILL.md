---
name: covid-19-cheminformatics-1-enumerate-ligands-for-docking
description: "This cheminformatics workflow processes input ligand datasets for COVID-19 research by enumerating protonation states and converting chemical formats using tools like Enumerate Charges and OpenBabel. Use this skill when you need to prepare a diverse library of small molecule candidates for virtual screening or molecular docking by generating all relevant ionization states and standardizing chemical structures."
homepage: https://workflowhub.eu/workflows/12
---

# COVID-19 - Cheminformatics [1] Enumerate ligands for docking

## Overview

This Galaxy workflow automates the preparation and enumeration of chemical ligands, serving as the initial stage in a [COVID-19 cheminformatics](https://usegalaxy.eu/training-material/topics/computational-chemistry/tutorials/covid19-docking/tutorial.html) pipeline. It processes an input dataset of chemical structures to ensure they are correctly formatted and chemically consistent for downstream molecular docking simulations.

The process begins by using the **Enumerate charges** tool to generate various ionization states of the input molecules, which is critical for accurately modeling drug-receptor interactions. To optimize performance, the workflow utilizes **Split file** to divide the data into collections, allowing for parallel processing during the **Compound conversion** step.

In the final stages, the molecules are converted into the necessary 3D formats and unified using the **Concatenate datasets** tool. The resulting output is a comprehensive library of prepared ligands, ready for virtual screening against viral targets. For detailed implementation instructions, please refer to the `README.md` in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset | data_input |  |


The workflow requires a chemical structure file, typically in SMILES or SDF format, as the primary input for ligand enumeration. While the initial input is a single dataset, the workflow utilizes internal collections to parallelize the charge enumeration and conversion steps before concatenating the final prepared ligands. Ensure your input file contains valid chemical identifiers to avoid errors during the OpenBabel conversion process. Refer to the README.md for comprehensive parameter details, and consider using `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Enumerate changes | toolshed.g2.bx.psu.edu/repos/bgruening/enumerate_charges/enumerate_charges/0.1 |  |
| 2 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.4.0 |  |
| 3 | Compound conversion | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/2.4.2.1.0 |  |
| 4 | Concatenate datasets | cat1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | output | output |
| 4 | prepared_ligands | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Cheminformatics-1-Ligand_enumeration.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Cheminformatics-1-Ligand_enumeration.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Cheminformatics-1-Ligand_enumeration.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Cheminformatics-1-Ligand_enumeration.ga -o job.yml`
- Lint: `planemo workflow_lint Cheminformatics-1-Ligand_enumeration.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Cheminformatics-1-Ligand_enumeration.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
