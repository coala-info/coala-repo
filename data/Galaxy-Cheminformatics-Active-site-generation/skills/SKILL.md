---
name: covid-19-cheminformatics-2-active-site-generation
description: This cheminformatics workflow processes protein PDB structures and ligand SDF files using Open Babel and rDock to generate a defined active site cavity. Use this skill when you need to precisely define the binding pocket of a viral protease to prepare for structure-based drug design or virtual screening.
homepage: https://github.com/galaxyproject/SARS-CoV-2
metadata:
  docker_image: "N/A"
---

# covid-19-cheminformatics-2-active-site-generation

## Overview

This Galaxy workflow is designed for the preparation of the SARS-CoV-2 Main Protease (Mpro) active site, a critical step in structure-based drug design. It focuses on defining the specific binding pocket where potential inhibitors can be docked during virtual screening.

The process begins by taking a desolvated protein structure in PDB format and a set of reference hits in SDF format. It utilizes [OpenBabel](https://toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/2.4.2.1.0) for compound conversion and the [rDock cavity definition](https://toolshed.g2.bx.psu.edu/repos/bgruening/rdock_rbcavity/rdock_rbcavity/0.1) tool to map the docking volume based on the reference ligands.

The final output is a defined active site (cavity) file, which is essential for subsequent docking simulations. This workflow is a key component of the broader [COVID-19](https://galaxyproject.org/projects/covid19/) cheminformatics pipeline, facilitating the identification of new therapeutic candidates.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | hits_frankenstein_17.sdf | data_input |  |
| 1 | Mpro-x0195_0_apo-desolv.pdb | data_input |  |


Ensure your protein structure is in PDB format and ligand hits are in SDF format to maintain essential chemical metadata during the conversion process. While individual datasets are used for this specific workflow, utilizing collections is recommended if you plan to scale the rDock cavity definition step across multiple protein-ligand pairs. Refer to the `README.md` for comprehensive details on parameterizing the cavity definition and handling desolvated structures. You can also streamline the configuration of these inputs by generating a `job.yml` file with `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Compound conversion | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/2.4.2.1.0 |  |
| 3 | rDock cavity definition | toolshed.g2.bx.psu.edu/repos/bgruening/rdock_rbcavity/rdock_rbcavity/0.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | activesite | activesite |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Cheminformatics-2-Active_site_generation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Cheminformatics-2-Active_site_generation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Cheminformatics-2-Active_site_generation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Cheminformatics-2-Active_site_generation.ga -o job.yml`
- Lint: `planemo workflow_lint Cheminformatics-2-Active_site_generation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Cheminformatics-2-Active_site_generation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)