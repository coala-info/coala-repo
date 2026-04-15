---
name: amber-protein-ligand-complex-md-setup
description: This Galaxy workflow automates the preparation and simulation of protein-ligand complexes using the AMBER force field, processing PDB structures through BioBB tools for ligand parameterization, solvation, and equilibration. Use this skill when you need to study the binding stability and conformational dynamics of a small molecule within a protein active site through molecular dynamics simulations.
homepage: https://mmb.irbbarcelona.org/biobb/
metadata:
  docker_image: "N/A"
---

# amber-protein-ligand-complex-md-setup

## Overview

This Galaxy workflow automates the setup and simulation of a protein-ligand complex using the [AMBER](https://ambermd.org/) force field and the [BioExcel Building Blocks (biobb)](https://mmb.irbbarcelona.org/biobb/) library. It begins by fetching a PDB structure and performing essential preprocessing, including water removal, ligand extraction, and structure cleaning with `pdb4amber`. The ligand is parameterized using `acpype` and `Open Babel`, while the protein and ligand are merged and solvated in a neutralized water box using `Leap`.

The simulation pipeline proceeds through multiple stages of energy minimization and molecular dynamics (MD) using the `sander` engine. This includes system equilibration and production runs to sample the complex's stability. The workflow concludes with comprehensive trajectory analysis using `cpptraj`, calculating metrics such as Root Mean Square Deviation (RMSD) and Radius of Gyration (Rgyr) to evaluate the structural integrity of the protein-ligand interaction.

For detailed instructions on how to import and run this workflow, please refer to the [README.md](README.md) in the Files section. This workflow is designed to be executed on the [INB Galaxy server](https://biobb.usegalaxy.es/).

## Inputs and data preparation

_None listed._


To prepare for this AMBER MD setup, ensure you have a high-resolution PDB file containing both your protein and ligand of interest. The workflow primarily handles individual datasets, but you should verify that the ligand is correctly identified for extraction and parameterization via Acpype. Key file types generated and required throughout the process include PDB, MOL2, PRMTOP, and INPCRD formats. For a comprehensive guide on parameter settings and input preparation, refer to the README.md file. You can also automate the job configuration using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Pdb | biobb_io_pdb_ext |  |
| 1 | RemovePdbWater | biobb_structure_utils_remove_pdb_water_ext |  |
| 2 | RemoveLigand | biobb_structure_utils_remove_ligand_ext |  |
| 3 | RemoveLigand | biobb_structure_utils_remove_ligand_ext |  |
| 4 | Pdb4amberRun | biobb_amber_pdb4amber_run_ext |  |
| 5 | ExtractHeteroatoms | biobb_structure_utils_extract_heteroatoms_ext |  |
| 6 | ReduceAddHydrogens | biobb_chemistry_reduce_add_hydrogens_ext |  |
| 7 | BabelMinimize | biobb_chemistry_babel_minimize_ext |  |
| 8 | AcpypeParamsAc | biobb_chemistry_acpype_params_ac_ext |  |
| 9 | LeapGenTop | biobb_amber_leap_gen_top_ext |  |
| 10 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 11 | ProcessMinout | biobb_amber_process_minout_ext |  |
| 12 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 13 | AmberToPdb | biobb_amber_amber_to_pdb_ext |  |
| 14 | ProcessMinout | biobb_amber_process_minout_ext |  |
| 15 | LeapSolvate | biobb_amber_leap_solvate_ext |  |
| 16 | LeapAddIons | biobb_amber_leap_add_ions_ext |  |
| 17 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 18 | ProcessMinout | biobb_amber_process_minout_ext |  |
| 19 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 20 | ProcessMdout | biobb_amber_process_mdout_ext |  |
| 21 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 22 | ProcessMdout | biobb_amber_process_mdout_ext |  |
| 23 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 24 | ProcessMdout | biobb_amber_process_mdout_ext |  |
| 25 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 26 | CpptrajRms | biobb_analysis_cpptraj_rms_ext |  |
| 27 | CpptrajRms | biobb_analysis_cpptraj_rms_ext |  |
| 28 | CpptrajRgyr | biobb_analysis_cpptraj_rgyr_ext |  |
| 29 | CpptrajImage | biobb_analysis_cpptraj_image_ext |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | mypdb.pdb | output_pdb_path |
| 1 | myremove_pdb_water.pdb | output_pdb_path |
| 2 | myremove_ligand.pdb | output_structure_path |
| 3 | output_structure_path | output_structure_path |
| 4 | mypdb4amber_run.pdb | output_pdb_path |
| 5 | myextract_heteroatoms.pdb | output_heteroatom_path |
| 6 | myreduce_add_hydrogens.pdb | output_path |
| 7 | mybabel_minimize.mol2 | output_path |
| 8 | myacpype_params_ac.prmtop | output_path_prmtop |
| 8 | myacpype_params_ac.inpcrd | output_path_inpcrd |
| 8 | myacpype_params_ac.frcmod | output_path_frcmod |
| 8 | myacpype_params_ac.lib | output_path_lib |
| 9 | myleap_gen_top.pdb | output_pdb_path |
| 9 | myleap_gen_top.top | output_top_path |
| 9 | myleap_gen_top.crd | output_crd_path |
| 10 | mysander_mdrun.log | output_log_path |
| 10 | mysander_mdrun.rst | output_rst_path |
| 10 | mysander_mdrun.cpout | output_cpout_path |
| 10 | mysander_mdrun.mdinfo | output_mdinfo_path |
| 10 | mysander_mdrun.cprst | output_cprst_path |
| 10 | mysander_mdrun.trj | output_traj_path |
| 11 | myprocess_minout.dat | output_dat_path |
| 12 | output_traj_path | output_traj_path |
| 12 | output_mdinfo_path | output_mdinfo_path |
| 12 | output_cpout_path | output_cpout_path |
| 12 | output_cprst_path | output_cprst_path |
| 12 | output_log_path | output_log_path |
| 12 | output_rst_path | output_rst_path |
| 13 | myamber_to_pdb.pdb | output_pdb_path |
| 14 | output_dat_path | output_dat_path |
| 15 | myleap_solvate.pdb | output_pdb_path |
| 15 | myleap_solvate.parmtop | output_top_path |
| 15 | myleap_solvate.crd | output_crd_path |
| 16 | myleap_add_ions.pdb | output_pdb_path |
| 16 | myleap_add_ions.crd | output_crd_path |
| 16 | myleap_add_ions.parmtop | output_top_path |
| 17 | output_cprst_path | output_cprst_path |
| 17 | output_cpout_path | output_cpout_path |
| 17 | output_rst_path | output_rst_path |
| 17 | output_traj_path | output_traj_path |
| 17 | output_log_path | output_log_path |
| 17 | output_mdinfo_path | output_mdinfo_path |
| 18 | output_dat_path | output_dat_path |
| 19 | output_cpout_path | output_cpout_path |
| 19 | output_rst_path | output_rst_path |
| 19 | output_traj_path | output_traj_path |
| 19 | output_mdinfo_path | output_mdinfo_path |
| 19 | output_cprst_path | output_cprst_path |
| 19 | output_log_path | output_log_path |
| 20 | myprocess_mdout.dat | output_dat_path |
| 21 | output_rst_path | output_rst_path |
| 21 | output_mdinfo_path | output_mdinfo_path |
| 21 | output_cprst_path | output_cprst_path |
| 21 | output_cpout_path | output_cpout_path |
| 21 | output_log_path | output_log_path |
| 21 | output_traj_path | output_traj_path |
| 22 | output_dat_path | output_dat_path |
| 23 | output_log_path | output_log_path |
| 23 | output_mdinfo_path | output_mdinfo_path |
| 23 | output_cprst_path | output_cprst_path |
| 23 | output_cpout_path | output_cpout_path |
| 23 | output_rst_path | output_rst_path |
| 23 | output_traj_path | output_traj_path |
| 24 | output_dat_path | output_dat_path |
| 25 | output_cpout_path | output_cpout_path |
| 25 | mysander_mdrun.netcdf | output_traj_path |
| 25 | output_mdinfo_path | output_mdinfo_path |
| 25 | output_log_path | output_log_path |
| 25 | output_rst_path | output_rst_path |
| 25 | output_cprst_path | output_cprst_path |
| 26 | mycpptraj_rms.dat | output_cpptraj_path |
| 27 | output_cpptraj_path | output_cpptraj_path |
| 28 | mycpptraj_rgyr.dat | output_cpptraj_path |
| 29 | mycpptraj_image.trr | output_cpptraj_path |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run biobb_wf_amber_complex_md_setup.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run biobb_wf_amber_complex_md_setup.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run biobb_wf_amber_complex_md_setup.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init biobb_wf_amber_complex_md_setup.ga -o job.yml`
- Lint: `planemo workflow_lint biobb_wf_amber_complex_md_setup.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `biobb_wf_amber_complex_md_setup.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)