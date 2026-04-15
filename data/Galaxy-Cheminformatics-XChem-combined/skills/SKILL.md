---
name: covid-19-cheminformatics-0-xchem-combined
description: This cheminformatics workflow performs virtual screening of the SARS-CoV-2 main protease by processing receptor, active site, candidate ligand, and reference molecule inputs through XChem docking, TransFS scoring, and SuCOS scoring subworkflows. Use this skill when you need to identify and rank potential drug candidates against the SARS-CoV-2 main protease using structure-based docking and multiple scoring methods to prioritize molecules for experimental validation.
homepage: https://github.com/galaxyproject/SARS-CoV-2
metadata:
  docker_image: "N/A"
---

# covid-19-cheminformatics-0-xchem-combined

## Overview

This Galaxy workflow is designed for the virtual screening of the SARS-CoV-2 main protease ($M^{pro}$), a key target for antiviral drug development. It integrates multiple specialized subworkflows to identify and rank potential inhibitors from a library of candidate ligands. The workflow was developed as part of a collaborative effort supported by the [de.NBI-cloud](https://www.denbi.de/cloud) and [STFC](https://stfc.ukri.org/).

The process begins by taking a receptor structure, a defined active site, a collection of candidate ligands, and reference molecules as primary inputs. These components are first processed through the **XChem Docking** subworkflow, which predicts the binding orientations and affinities of the candidate molecules within the protease's active site.

To refine the results, the workflow employs two distinct scoring methodologies. The **XChem TransFS Scoring** subworkflow utilizes deep learning-based models to evaluate the docked poses, while the **XChem SuCOS Scoring** subworkflow assesses the structural and feature-based similarity of the candidates relative to known reference molecules. This combined approach provides a comprehensive ranking system to prioritize compounds for further experimental validation.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Receptor | data_input |  |
| 1 | Active site | data_input |  |
| 2 | Candidate ligands | data_collection_input |  |
| 3 | Reference moelcules | data_input |  |


Ensure the receptor and active site files are provided in PDB or PDBQT format, while candidate ligands must be organized as a dataset collection of SDF or SMILES files to facilitate parallelized docking. Reference molecules should be uploaded in SDF format to ensure compatibility with SuCOS scoring steps. For comprehensive instructions on preparing these files and configuring tool parameters, refer to the detailed README.md. You can also automate the setup of these inputs by using `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | XChem Docking | (subworkflow) |  |
| 5 | XChem TransFS Scoring | (subworkflow) |  |
| 6 | XChem SuCOS Scoring | (subworkflow) |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Cheminformatics-0-XChem_combined.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Cheminformatics-0-XChem_combined.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Cheminformatics-0-XChem_combined.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Cheminformatics-0-XChem_combined.ga -o job.yml`
- Lint: `planemo workflow_lint Cheminformatics-0-XChem_combined.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Cheminformatics-0-XChem_combined.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)