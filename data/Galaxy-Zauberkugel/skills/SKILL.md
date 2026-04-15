---
name: zauberkugel
description: This cheminformatics workflow predicts protein targets for a query ligand by performing hydrogen addition with Open Babel, conformer generation via RDConf, and pharmacophore alignment against a library using Align-it. Use this skill when you need to identify potential protein targets for a bioactive molecule or investigate its polypharmacology through pharmacophore-based virtual screening.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# zauberkugel

## Overview

The Zauberkugel workflow is designed for the protein target prediction of bioactive ligands using pharmacophore-based screening. By leveraging [Align-it](https://toolshed.g2.bx.psu.edu/repos/bgruening/align_it/ctb_alignit/1.0.4+galaxy0) and the ePharmaLib dataset, the pipeline identifies potential biological targets for a specific query molecule. This process is essential for drug discovery, polypharmacology studies, and understanding the mechanism of action for novel compounds within the [Galaxy](https://galaxyproject.org/) ecosystem.

The technical pipeline begins with ligand preparation, where [Open Babel](https://toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_addh/openbabel_addh/3.1.1+galaxy1) adds hydrogen atoms to the query molecule. To account for molecular flexibility, [RDConf](https://toolshed.g2.bx.psu.edu/repos/bgruening/rdconf/rdconf/2020.03.4+galaxy0) performs a low-energy conformer search. These conformers are then systematically aligned against a pharmacophore library to evaluate structural and chemical similarities.

In the final stages, the workflow processes the alignment data by concatenating and sorting the results to highlight the most probable protein targets. The output includes aligned structures and ranked score files, providing researchers with a prioritized list of potential interactions. This workflow is shared under an MIT license and is categorized under Cheminformatics and Computational Chemistry.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Query ligand | data_input |  |
| 1 | Pharmacophore library | data_input |  |


For optimal results, provide the query ligand in SDF or MOL2 format and ensure the pharmacophore library is organized as a dataset collection to enable efficient parallel processing during the alignment stage. Using a collection rather than individual datasets is essential for the "Split file" step to correctly distribute workloads across the cluster. Consult the `README.md` for comprehensive instructions on preparing the ePharmaLib database and specific conformer generation settings. You can streamline the configuration of these inputs by using `planemo workflow_job_init` to create a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Add hydrogen atoms | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_addh/openbabel_addh/3.1.1+galaxy1 |  |
| 3 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.0 |  |
| 4 | RDConf: Low-energy ligand conformer search | toolshed.g2.bx.psu.edu/repos/bgruening/rdconf/rdconf/2020.03.4+galaxy0 |  |
| 5 | Pharmacophore alignment | toolshed.g2.bx.psu.edu/repos/bgruening/align_it/ctb_alignit/1.0.4+galaxy0 |  |
| 6 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/0.1.1 |  |
| 7 | Sort | sort1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | outfile | outfile |
| 3 | list_output_generic | list_output_generic |
| 4 | outfile | outfile |
| 5 | aligned_pharmacophores | aligned_pharmacophores |
| 5 | score_result_file | score_result_file |
| 5 | aligned_structures | aligned_structures |
| 6 | out_file1 | out_file1 |
| 7 | out_file1 | out_file1 |


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