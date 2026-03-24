---
name: protein-conformational-transitions-calculations
description: "This Galaxy workflow calculates protein conformational transitions between two PDB structures using BioBB utility tools and the GO-dmd discrete molecular dynamics engine. Use this skill when you need to simulate the transition pathway between two known protein conformations to understand the structural dynamics and intermediate states involved in biological processes."
homepage: https://workflowhub.eu/workflows/558
---

# Protein conformational transitions calculations

## Overview

This workflow calculates the transition path between two protein conformations (origin and target) using Discrete Molecular Dynamics (dMD). It utilizes the [BioExcel Building Blocks (biobb)](https://mmb.irbbarcelona.org/biobb/) to automate the structural preparation and simulation setup required to study protein flexibility and conformational changes.

The pipeline begins by fetching the input PDB structures and performing necessary preprocessing, such as extracting specific chains and removing ligands or heteroatoms. Once the structures are cleaned, the workflow performs a structural alignment and prepares the system for the [GO-dMD](https://mmb.irbbarcelona.org/GOdMD/) algorithm, which computes the transition trajectory between the two defined states.

The final outputs include the transition trajectory in PDB and MDCRD formats, energy logs, and a converted DCD file suitable for visualization and further analysis. Users can execute this workflow on the [INB's Galaxy server](https://biobb.usegalaxy.es/) by importing the provided `.ga` file as described in the [README.md](README.md).

## Inputs and data preparation

_None listed._


Ensure your input files are in PDB format, specifically providing both the origin and target protein structures to initiate the GOdMD conformational transition calculation. Use the Galaxy history to organize these as individual datasets rather than collections, ensuring that chain identifiers are consistent across both structures for successful alignment and preparation. For automated execution and testing, you can initialize your configuration using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on parameter settings and specific data preparation requirements.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Pdb | biobb_io_pdb_ext |  |
| 1 | Pdb | biobb_io_pdb_ext |  |
| 2 | ExtractChain | biobb_structure_utils_extract_chain_ext |  |
| 3 | ExtractChain | biobb_structure_utils_extract_chain_ext |  |
| 4 | RemoveMolecules | biobb_structure_utils_remove_molecules_ext |  |
| 5 | GodmdPrep | biobb_godmd_godmd_prep_ext |  |
| 6 | GodmdRun | biobb_godmd_godmd_run_ext |  |
| 7 | CpptrajConvert | biobb_analysis_cpptraj_convert_ext |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | origin.pdb | output_pdb_path |
| 1 | target.pdb | output_pdb_path |
| 2 | origin.chains.pdb | output_structure_path |
| 3 | target.chains.pdb | output_structure_path |
| 4 | origin.chains.nolig.pdb | output_molecules_path |
| 5 | mygodmd_prep.aln | output_aln_orig_path |
| 5 | output_aln_target_path | output_aln_target_path |
| 6 | origin-target.godmd.mdcrd | output_trj_path |
| 6 | origin-target.godmd.pdb | output_pdb_path |
| 6 | origin-target.godmd.log | output_log_path |
| 6 | origin-target.godmd.ene.out | output_ene_path |
| 7 | origin-target.godmd.dcd | output_cpptraj_path |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run biobb_wf_godmd.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run biobb_wf_godmd.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run biobb_wf_godmd.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init biobb_wf_godmd.ga -o job.yml`
- Lint: `planemo workflow_lint biobb_wf_godmd.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `biobb_wf_godmd.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
