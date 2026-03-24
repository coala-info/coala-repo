---
name: fragment-based-virtual-screening-using-rdock-for-docking-and
description: "This Galaxy workflow performs fragment-based virtual screening by docking candidate compounds into a protein receptor using rDock and scoring the resulting poses against reference fragments with SuCOS. Use this skill when you need to identify potential lead compounds for a protein target by prioritizing molecules that mimic the binding mode and chemical features of known fragment hits."
homepage: https://workflowhub.eu/workflows/246
---

# Fragment-based virtual screening using rDock for docking and SuCOS for pose scoring

## Overview

This Galaxy workflow performs fragment-based virtual screening, specifically optimized for targeting the SARS-CoV-2 main protease. It automates the process of docking a compound library against a receptor and validating the resulting poses by comparing their feature overlap with a reference fragment.

The workflow begins by defining a docking cavity using the [Frankenstein ligand](https://www.informaticsmatters.com/blog/2018/11/23/cavities-and-frankenstein-molecules.html) technique, which merges multiple fragments to map the binding site. Candidate compounds provided in SMILES format are converted, enumerated for charges, and split into collections to enable highly parallelized docking using [rDock](https://toolshed.g2.bx.psu.edu/repos/bgruening/rxdock_rbdock/rxdock_rbdock/2013.1.1_148c5bd1+galaxy0).

Following the docking stage, the generated poses are evaluated using [SuCOS](https://toolshed.g2.bx.psu.edu/repos/bgruening/sucos_docking_scoring/sucos_docking_scoring/2020.03.4+galaxy1) to score their shape and chemical feature similarity against a known reference fragment. The workflow filters the results based on a user-specified SuCOS threshold, outputting a refined set of scored poses for further analysis.

For detailed information on input preparation and parameter settings, please refer to the [README.md](README.md) in the Files section. This workflow is released under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Number of poses | parameter_input | Number of docking poses to generate per input compound |
| 1 | Receptor (PDB) | data_input | PDB file for the receptor protein |
| 2 | All fragments (SDF) | data_input | Fragments in SDF format |
| 3 | Collection size for docking | parameter_input | Parameter for parallelization of docking |
| 4 | SuCOS threshold | parameter_input | Value between 0 and 1. All poses with a SuCOS score lower than this value will be filtered out. |
| 5 | Fragment for SuCOS scoring (SDF/MOL) | data_input | SDF or MOL file with the single fragment for SuCOS scoring |
| 6 | Candidate compounds (SMILES) | data_input | List of compounds for docking in SMILES format |


Ensure the receptor is provided in PDB format, while candidate compounds should be uploaded as a SMILES file and reference fragments as SDF or MOL files. To optimize performance, the workflow automatically splits compounds into a collection for parallelized docking; you should adjust the "Collection size" parameter to match your available computing resources. The "All fragments" SDF is specifically required to define the docking cavity using the Frankenstein ligand technique. For comprehensive instructions on preparing these inputs and setting the SuCOS threshold, refer to the README.md. You can also use `planemo workflow_job_init` to generate a `job.yml` for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | Compound conversion | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/3.1.1+galaxy0 |  |
| 8 | Create Frankenstein ligand | toolshed.g2.bx.psu.edu/repos/bgruening/ctb_frankenstein_ligand/ctb_frankenstein_ligand/2013.1-0+galaxy0 |  |
| 9 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 10 | Enumerate changes | toolshed.g2.bx.psu.edu/repos/bgruening/enumerate_charges/enumerate_charges/2020.03.4+galaxy0 |  |
| 11 | rDock cavity definition | toolshed.g2.bx.psu.edu/repos/bgruening/rxdock_rbcavity/rxdock_rbcavity/2013.1.1_148c5bd1+galaxy0 |  |
| 12 | Compound conversion | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/3.1.1+galaxy0 |  |
| 13 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.0 |  |
| 14 | rDock docking | toolshed.g2.bx.psu.edu/repos/bgruening/rxdock_rbdock/rxdock_rbdock/2013.1.1_148c5bd1+galaxy0 |  |
| 15 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 16 | Score docked poses using SuCOS | toolshed.g2.bx.psu.edu/repos/bgruening/sucos_docking_scoring/sucos_docking_scoring/2020.03.4+galaxy1 |  |
| 17 | rDock docking | toolshed.g2.bx.psu.edu/repos/bgruening/rdock_sort_filter/rdock_sort_filter/2013.1-0+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 14 | Docking poses | output |
| 17 | Scored and filtered poses | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run fragment-based-docking-scoring.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run fragment-based-docking-scoring.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run fragment-based-docking-scoring.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init fragment-based-docking-scoring.ga -o job.yml`
- Lint: `planemo workflow_lint fragment-based-docking-scoring.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `fragment-based-docking-scoring.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
