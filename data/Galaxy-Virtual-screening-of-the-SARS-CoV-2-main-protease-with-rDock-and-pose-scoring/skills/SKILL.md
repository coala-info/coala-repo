---
name: virtual-screening-of-the-sars-cov-2-main-protease-with-rdock
description: "This computational chemistry workflow performs virtual screening of candidate ligands against the SARS-CoV-2 main protease using rDock for molecular docking and TransFS or SuCOS for advanced pose scoring. Use this skill when you need to identify potential inhibitors for the SARS-CoV-2 main protease by docking large libraries of chemical compounds and ranking them based on predicted binding poses and structural similarity to known active fragments."
homepage: https://workflowhub.eu/workflows/1658
---

# Virtual screening of the SARS-CoV-2 main protease with rDock and pose scoring

## Overview

This Galaxy workflow performs high-throughput virtual screening of candidate molecules against the SARS-CoV-2 main protease (Mpro). It automates the preparation of chemical libraries by enumerating charges and converting formats using [OpenBabel](https://openbabel.org/wiki/Main_Page). To define the active site accurately, the workflow utilizes a "Frankenstein ligand" approach, which combines information from known hits to guide the docking cavity definition.

The primary docking engine used is [rDock](http://rdock.sourceforge.net/), which evaluates the binding poses of candidate compounds within the Mpro structure. The workflow is designed for efficiency, utilizing file splitting and collection processing to parallelize the docking tasks across the available computational resources.

Following the docking simulations, the results are refined through advanced pose scoring techniques. The workflow integrates [XChem TransFS](https://github.com/xchem/trans-fs), a deep learning-based scoring tool, and calculates [SuCOS](https://github.com/susanhleung/SuCOS) scores to determine the structural and feature similarity of the docked poses to known active fragments. This multi-layered evaluation helps prioritize the most promising inhibitors for further research in computational chemistry.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Candidates | data_input |  |
| 1 | Mpro-x0195_0_apo-desolv.pdb | data_input |  |
| 2 | hits.sdf | data_input |  |


To run this workflow, ensure your candidate ligands are in SDF format and the protein target is a clean PDB file (e.g., Mpro-x0195). Using a dataset collection for the candidate molecules is recommended to optimize the parallel processing of the rDock docking and pose scoring steps. For automated execution, you can initialize your environment using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on parameter settings and specific library preparation requirements.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Enumerate changes | toolshed.g2.bx.psu.edu/repos/bgruening/enumerate_charges/enumerate_charges/0.1 |  |
| 4 | Compound conversion | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/2.4.2.2.0 |  |
| 5 | Create Frankenstein ligand | toolshed.g2.bx.psu.edu/repos/bgruening/ctb_frankenstein_ligand/ctb_frankenstein_ligand/0.1.1 |  |
| 6 | Compound conversion | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/2.4.2.2.0 |  |
| 7 | rDock cavity definition | toolshed.g2.bx.psu.edu/repos/bgruening/rdock_rbcavity/rdock_rbcavity/0.1 |  |
| 8 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.4.0 |  |
| 9 | rDock docking | toolshed.g2.bx.psu.edu/repos/bgruening/rdock_rbdock/rdock_rbdock/0.1.4 |  |
| 10 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 11 | XChem TransFS pose scoring | xchem_pose_scoring |  |
| 12 | Max SuCOS score | toolshed.g2.bx.psu.edu/repos/bgruening/sucos_max_score/sucos_max_score/0.2.3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | outfile | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow.ga -o job.yml`
- Lint: `planemo workflow_lint workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
