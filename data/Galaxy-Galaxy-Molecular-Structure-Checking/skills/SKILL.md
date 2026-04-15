---
name: molecular-structure-checking
description: This Galaxy workflow automates the cleaning and validation of protein structures from PDB files using BioBB tools and AMBER to fix structural defects like missing side chains, incorrect chirality, or backbone issues. Use this skill when you need to prepare high-quality, energetically minimized molecular models for downstream molecular dynamics simulations or docking studies by resolving common structural inconsistencies found in experimental data.
homepage: https://mmb.irbbarcelona.org/biobb/
metadata:
  docker_image: "N/A"
---

# molecular-structure-checking

## Overview

This workflow provides a comprehensive pipeline for the automated checking and preparation of molecular structures using the [BioExcel Building Blocks (BioBB)](https://mmb.irbbarcelona.org/biobb/) library. It begins by retrieving PDB data and canonical sequences, followed by an initial structural assessment to identify potential issues such as missing atoms, incorrect chirality, or backbone breaks.

The pipeline performs extensive cleaning and repair operations, including the extraction of specific models or chains and the management of disulfide bonds and alternate locations. It further refines the structure by removing unwanted molecules or water, adjusting hydrogen atoms, and correcting amide groups and side-chain orientations to ensure the model is chemically consistent.

To ensure thermodynamic stability, the workflow utilizes the Amber software suite to generate topologies and perform energy minimization via [Sander](https://biobb-amber.readthedocs.io/). The process concludes by converting the refined results back to PDB format and conducting a final structure check to verify the quality and readiness of the molecular system for further simulation or analysis.

## Inputs and data preparation

_None listed._


Ensure your input files are in standard PDB and FASTA formats, as these are essential for the initial structure retrieval and sequence alignment steps. While individual datasets are suitable for single protein analysis, consider using dataset collections if you plan to process multiple molecular structures in parallel. For comprehensive details on parameter settings and specific input requirements, please refer to the README.md file. You can automate the setup of your execution environment and input parameters by using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Pdb | biobb_io_pdb_ext |  |
| 1 | CanonicalFasta | biobb_io_canonical_fasta_ext |  |
| 2 | StructureCheck | biobb_structure_utils_structure_check_ext |  |
| 3 | ExtractModel | biobb_structure_utils_extract_model_ext |  |
| 4 | ExtractChain | biobb_structure_utils_extract_chain_ext |  |
| 5 | FixAltlocs | biobb_model_fix_altlocs_ext |  |
| 6 | FixSsbonds | biobb_model_fix_ssbonds_ext |  |
| 7 | RemoveMolecules | biobb_structure_utils_remove_molecules_ext |  |
| 8 | RemoveMolecules | biobb_structure_utils_remove_molecules_ext |  |
| 9 | ReduceRemoveHydrogens | biobb_chemistry_reduce_remove_hydrogens_ext |  |
| 10 | RemovePdbWater | biobb_structure_utils_remove_pdb_water_ext |  |
| 11 | FixAmides | biobb_model_fix_amides_ext |  |
| 12 | FixChirality | biobb_model_fix_chirality_ext |  |
| 13 | FixSideChain | biobb_model_fix_side_chain_ext |  |
| 14 | FixBackbone | biobb_model_fix_backbone_ext |  |
| 15 | LeapGenTop | biobb_amber_leap_gen_top_ext |  |
| 16 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 17 | AmberToPdb | biobb_amber_amber_to_pdb_ext |  |
| 18 | StructureCheck | biobb_structure_utils_structure_check_ext |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | mypdb.pdb | output_pdb_path |
| 1 | mycanonical_fasta.fasta | output_fasta_path |
| 2 | mystructure_check.json | output_summary_path |
| 3 | myextract_model.pdb | output_structure_path |
| 4 | myextract_chain.pdb | output_structure_path |
| 5 | myfix_altlocs.pdb | output_pdb_path |
| 6 | myfix_ssbonds.pdb | output_pdb_path |
| 7 | myremove_molecules.pdb | output_molecules_path |
| 8 | output_molecules_path | output_molecules_path |
| 9 | myreduce_remove_hydrogens.pdb | output_path |
| 10 | myremove_pdb_water.pdb | output_pdb_path |
| 11 | myfix_amides.pdb | output_pdb_path |
| 12 | myfix_chirality.pdb | output_pdb_path |
| 13 | myfix_side_chain.pdb | output_pdb_path |
| 14 | myfix_backbone.pdb | output_pdb_path |
| 15 | myleap_gen_top.top | output_top_path |
| 15 | myleap_gen_top.crd | output_crd_path |
| 15 | myleap_gen_top.pdb | output_pdb_path |
| 16 | mysander_mdrun.crd | output_traj_path |
| 16 | mysander_mdrun.rst | output_rst_path |
| 16 | mysander_mdrun.cpout | output_cpout_path |
| 16 | mysander_mdrun.cprst | output_cprst_path |
| 16 | mysander_mdrun.log | output_log_path |
| 16 | mysander_mdrun.mdinfo | output_mdinfo_path |
| 17 | myamber_to_pdb.pdb | output_pdb_path |
| 18 | output_summary_path | output_summary_path |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run biobb_wf_structure_checking.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run biobb_wf_structure_checking.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run biobb_wf_structure_checking.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init biobb_wf_structure_checking.ga -o job.yml`
- Lint: `planemo workflow_lint biobb_wf_structure_checking.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `biobb_wf_structure_checking.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)