---
name: protein-structure-flexibility
description: "This workflow analyzes protein structure flexibility by processing PDB files through coarse-grained methods including Normal Mode Analysis, Discrete Molecular Dynamics, and Brownian Dynamics using BioBB tools. Use this skill when you need to characterize macromolecular conformational ensembles, identify hinge points, or calculate B-factors and stiffness profiles to understand the functional dynamics of a protein."
homepage: https://workflowhub.eu/workflows/557
---

# Protein structure flexibility

## Overview

This workflow provides a comprehensive pipeline for analyzing protein structure flexibility using coarse-grained simulation methods. It begins by retrieving a protein structure from the PDB and extracting specific atoms—typically Alpha Carbons—to prepare the system for simplified conformational sampling.

The core of the process utilizes three distinct simulation techniques to explore the protein's mobility: Normal Mode Analysis (NMA), Discrete Molecular Dynamics (DMD), and Brownian Dynamics (BD). These methods generate structural ensembles that represent the protein's intrinsic dynamics and conformational space without the high computational cost of all-atom molecular dynamics.

Following the simulations, the workflow performs extensive analysis using [BioBB](https://mmb.irbbarcelona.org/biobb/) tools and `cpptraj`. It calculates RMSD trajectories and employs Principal Component Analysis (PCA) via the PCZ format to identify dominant motions. The pipeline generates animations of principal components and computes essential flexibility metrics, including B-factors, stiffness constants, collectivity indices, and hinge point locations.

The final outputs include trajectory files (DCD, MDCRD), compressed PCZ files, and detailed JSON reports. These results allow researchers to visualize functional movements and quantify the mechanical properties of the protein structure. For detailed setup instructions, refer to the README.md in the Files section.

## Inputs and data preparation

_None listed._


To begin this protein flexibility analysis, ensure your input is a valid PDB file containing the macromolecular structure of interest. The workflow utilizes BioBB tools to process these datasets, so verifying that your PDB file is properly formatted for atom extraction is essential for successful NMA, DMD, and BD simulations. For automated execution and parameter configuration, you can use `planemo workflow_job_init` to generate a `job.yml` file. Detailed instructions on file preparation and specific tool parameters are available in the README.md. Ensure all trajectory and coordinate outputs are correctly mapped to maintain data integrity throughout the coarse-grained analysis.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Pdb | biobb_io_pdb_ext |  |
| 1 | ExtractAtoms | biobb_structure_utils_extract_atoms_ext |  |
| 2 | NmaRun | biobb_flexserv_nma_run_ext |  |
| 3 | DmdRun | biobb_flexserv_dmd_run_ext |  |
| 4 | BdRun | biobb_flexserv_bd_run_ext |  |
| 5 | CpptrajRms | biobb_analysis_cpptraj_rms_ext |  |
| 6 | PczZip | biobb_flexserv_pcz_zip_ext |  |
| 7 | CpptrajRms | biobb_analysis_cpptraj_rms_ext |  |
| 8 | PczZip | biobb_flexserv_pcz_zip_ext |  |
| 9 | CpptrajRms | biobb_analysis_cpptraj_rms_ext |  |
| 10 | PczZip | biobb_flexserv_pcz_zip_ext |  |
| 11 | PczUnzip | biobb_flexserv_pcz_unzip_ext |  |
| 12 | PczBfactor | biobb_flexserv_pcz_bfactor_ext |  |
| 13 | PczAnimate | biobb_flexserv_pcz_animate_ext |  |
| 14 | PczInfo | biobb_flexserv_pcz_info_ext |  |
| 15 | PczEvecs | biobb_flexserv_pcz_evecs_ext |  |
| 16 | PczStiffness | biobb_flexserv_pcz_stiffness_ext |  |
| 17 | PczCollectivity | biobb_flexserv_pcz_collectivity_ext |  |
| 18 | PczUnzip | biobb_flexserv_pcz_unzip_ext |  |
| 19 | PczUnzip | biobb_flexserv_pcz_unzip_ext |  |
| 20 | PczHinges | biobb_flexserv_pcz_hinges_ext |  |
| 21 | PczHinges | biobb_flexserv_pcz_hinges_ext |  |
| 22 | PczHinges | biobb_flexserv_pcz_hinges_ext |  |
| 23 | CpptrajRms | biobb_analysis_cpptraj_rms_ext |  |
| 24 | CpptrajConvert | biobb_analysis_cpptraj_convert_ext |  |
| 25 | CpptrajRms | biobb_analysis_cpptraj_rms_ext |  |
| 26 | CpptrajRms | biobb_analysis_cpptraj_rms_ext |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | mypdb.pdb | output_pdb_path |
| 1 | structure_ca.pdb | output_structure_path |
| 2 | nma_ensemble.log | output_log_path |
| 2 | nma_ensemble.mdcrd | output_crd_path |
| 3 | dmd_ensemble.log | output_log_path |
| 3 | dmd_ensemble.mdcrd | output_crd_path |
| 4 | bd_ensemble.log | output_log_path |
| 4 | bd_ensemble.mdcrd | output_crd_path |
| 5 | output_cpptraj_path | output_cpptraj_path |
| 5 | output_traj_path | output_traj_path |
| 6 | output_pcz_path | output_pcz_path |
| 7 | output_cpptraj_path | output_cpptraj_path |
| 7 | output_traj_path | output_traj_path |
| 8 | output_pcz_path | output_pcz_path |
| 9 | bd_ensemble_rmsd.dcd | output_traj_path |
| 9 | bd_ensemble_rmsd.dat | output_cpptraj_path |
| 10 | bd_ensemble.pcz | output_pcz_path |
| 11 | output_crd_path | output_crd_path |
| 12 | bfactor_all.pdb | output_pdb_path |
| 12 | bfactor_all.dat | output_dat_path |
| 13 | pcz_proj1.crd | output_crd_path |
| 14 | pcz_report.json | output_json_path |
| 15 | pcz_evecs.json | output_json_path |
| 16 | pcz_stiffness.json | output_json_path |
| 17 | pcz_collectivity.json | output_json_path |
| 18 | output_crd_path | output_crd_path |
| 19 | bd_ensemble_uncompressed.crd | output_crd_path |
| 20 | output_json_path | output_json_path |
| 21 | hinges_bfactor_report.json | output_json_path |
| 22 | output_json_path | output_json_path |
| 23 | output_traj_path | output_traj_path |
| 23 | output_cpptraj_path | output_cpptraj_path |
| 24 | pcz_proj1.dcd | output_cpptraj_path |
| 25 | output_cpptraj_path | output_cpptraj_path |
| 25 | output_traj_path | output_traj_path |
| 26 | output_cpptraj_path | output_cpptraj_path |
| 26 | output_traj_path | output_traj_path |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run biobb_wf_flexserv.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run biobb_wf_flexserv.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run biobb_wf_flexserv.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init biobb_wf_flexserv.ga -o job.yml`
- Lint: `planemo workflow_lint biobb_wf_flexserv.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `biobb_wf_flexserv.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
