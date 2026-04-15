---
name: abcix-md-setup
description: This Galaxy workflow automates the preparation and equilibration of molecular systems for Amber molecular dynamics simulations using BioBB tools to perform topology generation, solvation, and energy minimization from an input PDB file. Use this skill when you need to generate a stable, solvated, and neutralized molecular environment with hydrogen mass repartitioning to ensure reliable production-level MD trajectories.
homepage: https://mmb.irbbarcelona.org/biobb/
metadata:
  docker_image: "N/A"
---

# abcix-md-setup

## Overview

This Galaxy workflow automates the setup and equilibration of Molecular Dynamics (MD) simulations using the [AmberTools](https://ambermd.org/AmberTools.php) suite via **BioBB** (BioExcel Building Blocks). It guides a system from an initial PDB structure through topology generation, solvation, and ion neutralization, followed by a comprehensive series of minimization and equilibration steps.

The process begins with `LeapGenTop` to generate the initial topology and coordinates, followed by solvation and ion addition. A key optimization step includes `ParmedHmassrepartition`, which applies hydrogen mass repartitioning to allow for longer simulation time steps. The workflow then utilizes `SanderMdrun` across multiple stages to perform energy minimization, heating, and NPT/NVT equilibration, ensuring the system is stable before production runs.

Analysis tools like `ProcessMinout`, `ProcessMdout`, and `CpptrajRandomizeIons` are integrated to monitor simulation properties and randomize ion positions. Users must provide an initial `input.pdb` file and a set of configuration files (`.in`) for each MD stage to define the specific simulation parameters for the Sander engine. For detailed setup instructions, refer to the [README.md](README.md) in the Files section.

## Inputs and data preparation

_None listed._


Ensure all required PDB structures and configuration files are uploaded as individual datasets, specifically matching the `.pdb` and `.in` file types required for Amber MD setup. You must provide the initial `input.pdb` for the LeapGenTop step and map each specific `stepX.in` file from the configuration folder to its corresponding SanderMdrun block. For large-scale testing, you can use `planemo workflow_job_init` to generate a `job.yml` for automated input mapping. Refer to the README.md for the complete list of configuration file assignments and detailed preparation steps.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | LeapGenTop | biobb_amber_leap_gen_top_ext |  |
| 1 | LeapSolvate | biobb_amber_leap_solvate_ext |  |
| 2 | LeapAddIons | biobb_amber_leap_add_ions_ext |  |
| 3 | ParmedHmassrepartition | biobb_amber_parmed_hmassrepartition_ext |  |
| 4 | CpptrajRandomizeIons | biobb_amber_cpptraj_randomize_ions_ext |  |
| 5 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 6 | ProcessMinout | biobb_amber_process_minout_ext |  |
| 7 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 8 | ProcessMdout | biobb_amber_process_mdout_ext |  |
| 9 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 10 | ProcessMinout | biobb_amber_process_minout_ext |  |
| 11 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 12 | ProcessMinout | biobb_amber_process_minout_ext |  |
| 13 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 14 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 15 | ProcessMinout | biobb_amber_process_minout_ext |  |
| 16 | ProcessMdout | biobb_amber_process_mdout_ext |  |
| 17 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 18 | ProcessMdout | biobb_amber_process_mdout_ext |  |
| 19 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 20 | ProcessMdout | biobb_amber_process_mdout_ext |  |
| 21 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 22 | ProcessMdout | biobb_amber_process_mdout_ext |  |
| 23 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 24 | ProcessMdout | biobb_amber_process_mdout_ext |  |
| 25 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | myleap_gen_top.crd | output_crd_path |
| 0 | myleap_gen_top.top | output_top_path |
| 0 | myleap_gen_top.pdb | output_pdb_path |
| 1 | myleap_solvate.crd | output_crd_path |
| 1 | myleap_solvate.parmtop | output_top_path |
| 1 | myleap_solvate.pdb | output_pdb_path |
| 2 | myleap_add_ions.parmtop | output_top_path |
| 2 | myleap_add_ions.pdb | output_pdb_path |
| 2 | myleap_add_ions.crd | output_crd_path |
| 3 | myparmed_hmassrepartition.top | output_top_path |
| 4 | mycpptraj_randomize_ions.crd | output_crd_path |
| 4 | mycpptraj_randomize_ions.pdb | output_pdb_path |
| 5 | mysander_mdrun.log | output_log_path |
| 5 | mysander_mdrun.cpout | output_cpout_path |
| 5 | mysander_mdrun.cprst | output_cprst_path |
| 5 | mysander_mdrun.nc | output_traj_path |
| 5 | mysander_mdrun.ncrst | output_rst_path |
| 5 | mysander_mdrun.mdinfo | output_mdinfo_path |
| 6 | myprocess_minout.dat | output_dat_path |
| 7 | output_cprst_path | output_cprst_path |
| 7 | output_cpout_path | output_cpout_path |
| 7 | output_log_path | output_log_path |
| 7 | output_traj_path | output_traj_path |
| 7 | output_rst_path | output_rst_path |
| 7 | output_mdinfo_path | output_mdinfo_path |
| 8 | myprocess_mdout.dat | output_dat_path |
| 9 | output_traj_path | output_traj_path |
| 9 | output_mdinfo_path | output_mdinfo_path |
| 9 | output_cprst_path | output_cprst_path |
| 9 | output_cpout_path | output_cpout_path |
| 9 | output_rst_path | output_rst_path |
| 9 | output_log_path | output_log_path |
| 10 | output_dat_path | output_dat_path |
| 11 | output_traj_path | output_traj_path |
| 11 | output_log_path | output_log_path |
| 11 | output_mdinfo_path | output_mdinfo_path |
| 11 | output_rst_path | output_rst_path |
| 11 | output_cpout_path | output_cpout_path |
| 11 | output_cprst_path | output_cprst_path |
| 12 | output_dat_path | output_dat_path |
| 13 | output_cprst_path | output_cprst_path |
| 13 | output_mdinfo_path | output_mdinfo_path |
| 13 | output_cpout_path | output_cpout_path |
| 13 | output_log_path | output_log_path |
| 13 | output_rst_path | output_rst_path |
| 13 | output_traj_path | output_traj_path |
| 14 | output_cprst_path | output_cprst_path |
| 14 | output_mdinfo_path | output_mdinfo_path |
| 14 | output_log_path | output_log_path |
| 14 | output_cpout_path | output_cpout_path |
| 14 | output_rst_path | output_rst_path |
| 14 | output_traj_path | output_traj_path |
| 15 | output_dat_path | output_dat_path |
| 16 | output_dat_path | output_dat_path |
| 17 | output_rst_path | output_rst_path |
| 17 | output_traj_path | output_traj_path |
| 17 | output_cprst_path | output_cprst_path |
| 17 | output_cpout_path | output_cpout_path |
| 17 | output_log_path | output_log_path |
| 17 | output_mdinfo_path | output_mdinfo_path |
| 18 | output_dat_path | output_dat_path |
| 19 | output_traj_path | output_traj_path |
| 19 | output_rst_path | output_rst_path |
| 19 | output_mdinfo_path | output_mdinfo_path |
| 19 | output_log_path | output_log_path |
| 19 | output_cpout_path | output_cpout_path |
| 19 | output_cprst_path | output_cprst_path |
| 20 | output_dat_path | output_dat_path |
| 21 | output_cprst_path | output_cprst_path |
| 21 | output_log_path | output_log_path |
| 21 | output_cpout_path | output_cpout_path |
| 21 | output_traj_path | output_traj_path |
| 21 | output_rst_path | output_rst_path |
| 21 | output_mdinfo_path | output_mdinfo_path |
| 22 | output_dat_path | output_dat_path |
| 23 | output_log_path | output_log_path |
| 23 | output_rst_path | output_rst_path |
| 23 | output_traj_path | output_traj_path |
| 23 | output_cprst_path | output_cprst_path |
| 23 | output_cpout_path | output_cpout_path |
| 23 | output_mdinfo_path | output_mdinfo_path |
| 24 | output_dat_path | output_dat_path |
| 25 | output_traj_path | output_traj_path |
| 25 | output_cpout_path | output_cpout_path |
| 25 | output_log_path | output_log_path |
| 25 | output_cprst_path | output_cprst_path |
| 25 | output_rst_path | output_rst_path |
| 25 | output_mdinfo_path | output_mdinfo_path |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run biobb_wf_amber_abc_md_setup.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run biobb_wf_amber_abc_md_setup.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run biobb_wf_amber_abc_md_setup.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init biobb_wf_amber_abc_md_setup.ga -o job.yml`
- Lint: `planemo workflow_lint biobb_wf_amber_abc_md_setup.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `biobb_wf_amber_abc_md_setup.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)