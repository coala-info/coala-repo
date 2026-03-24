---
name: covid-19-cheminformatics-4-sucos-scoring
description: "This cheminformatics workflow calculates SuCOS scores for a collection of ligands against reference molecules using tools like SuCOS max score and SDF sort and filter. Use this skill when you need to rank potential inhibitors based on their structural and chemical feature overlap with known active compounds to prioritize candidates for further screening."
homepage: https://workflowhub.eu/workflows/15
---

# COVID-19 - Cheminformatics [4] SuCOS scoring

## Overview

This workflow is a specialized component of a COVID-19 cheminformatics pipeline designed to evaluate and prioritize potential drug candidates. It utilizes the SuCOS scoring method, which provides a measure of shape and chemical feature overlap between candidate ligands and known reference molecules. By comparing docked poses against established binders, researchers can identify compounds that most closely mimic the binding mode of active substances.

The process begins by taking a collection of ligands and a set of reference molecules as inputs. It employs [SDF sort and filter](https://toolshed.g2.bx.psu.edu/repos/bgruening/rdock_sort_filter/rdock_sort_filter/0.1.0) to organize the chemical data before calculating the [Max SuCOS score](https://toolshed.g2.bx.psu.edu/repos/bgruening/sucos_max_score/sucos_max_score/0.2.0). This core step determines the maximum similarity score for each ligand relative to the reference set, helping to rank the candidates based on their structural and pharmacophoric relevance.

To ensure efficient data handling, the workflow uses [Collapse Collection](https://toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2) and [Split file](https://toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.4.0) utilities to manage the transition between dataset collections and individual files. The final output is a consolidated, scored dataset that serves as a critical decision-making tool in the virtual screening process for COVID-19 therapeutics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | ligands to score | data_collection_input |  |
| 1 | reference molecules | data_input |  |


Ensure your input ligands are provided as a data collection and reference molecules as a single dataset, preferably in SDF format to maintain the 3D spatial information required for SuCOS scoring. Utilizing a collection for the candidate ligands facilitates efficient batch processing before the workflow collapses and sorts the results based on shape and feature similarity. For a complete guide on preparing your chemical libraries and configuring tool parameters, consult the README.md file. You may also use planemo workflow_job_init to create a job.yml for streamlined job submission.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 3 | SDF sort and filter | toolshed.g2.bx.psu.edu/repos/bgruening/rdock_sort_filter/rdock_sort_filter/0.1.0 |  |
| 4 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.4.0 |  |
| 5 | Max SuCOS score | toolshed.g2.bx.psu.edu/repos/bgruening/sucos_max_score/sucos_max_score/0.2.0 |  |
| 6 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | SuCOS_Scored | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Cheminformatics-4-SuCOS_scoring.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Cheminformatics-4-SuCOS_scoring.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Cheminformatics-4-SuCOS_scoring.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Cheminformatics-4-SuCOS_scoring.ga -o job.yml`
- Lint: `planemo workflow_lint Cheminformatics-4-SuCOS_scoring.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Cheminformatics-4-SuCOS_scoring.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
