---
name: amber-protein-md-setup
description: This workflow automates the preparation and simulation of protein structures using the AMBER force field, taking a PDB file as input and utilizing BioBB tools for system setup, solvation, energy minimization, and MD equilibration. Use this skill when you need to generate stable molecular dynamics trajectories for a protein to study its structural stability, conformational changes, or thermodynamic properties in an aqueous environment.
homepage: https://mmb.irbbarcelona.org/biobb/
metadata:
  docker_image: "N/A"
---

# amber-protein-md-setup

## Overview

This workflow automates the end-to-end setup and execution of a Molecular Dynamics (MD) simulation for a protein system using the AMBER force field. It utilizes the [BioExcel Building Blocks (BioBB)](https://mmb.irbbarcelona.org/biobb/) library to ensure interoperability and reproducibility within the Galaxy platform. The process begins by fetching a protein structure from the PDB, cleaning it with `pdb4amber`, and generating the initial topology and coordinate files via `Leap`.

The pipeline proceeds through system preparation by performing initial energy minimizations using the `sander` engine to resolve steric clashes. It then solvates the protein in a water box and neutralizes the system by adding counterions. Additional minimization and equilibration steps are conducted on the solvated system to ensure thermodynamic stability before proceeding to the production MD run.

In the final stages, the workflow handles trajectory processing and structural analysis. It uses `cpptraj` to calculate essential metrics such as Root Mean Square Deviation (RMSD) and Radius of Gyration (Rgyr) to monitor the protein's stability and compactness. The workflow also includes imaging steps to wrap the trajectory, making it ready for molecular visualization and further research.

## Inputs and data preparation

_None listed._


Ensure your input protein structure is in PDB format, ideally cleaned of non-standard residues or ligands to prevent errors during the initial PDB4amber and Leap processing stages. While this workflow primarily handles individual datasets, ensure all topology (TOP) and coordinate (CRD/RST) files are correctly associated as the simulation progresses through minimization and equilibration. For automated execution and parameter mapping, you can utilize `planemo workflow_job_init` to generate a `job.yml` file. Detailed configuration for each BioBB tool step and specific force field options are available in the README.md. Refer to the README.md for comprehensive instructions on preparing your environment and managing complex simulation parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Pdb | biobb_io_pdb_ext |  |
| 1 | Pdb4amberRun | biobb_amber_pdb4amber_run_ext |  |
| 2 | LeapGenTop | biobb_amber_leap_gen_top_ext |  |
| 3 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 4 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 5 | ProcessMinout | biobb_amber_process_minout_ext |  |
| 6 | AmberToPdb | biobb_amber_amber_to_pdb_ext |  |
| 7 | ProcessMinout | biobb_amber_process_minout_ext |  |
| 8 | LeapSolvate | biobb_amber_leap_solvate_ext |  |
| 9 | LeapAddIons | biobb_amber_leap_add_ions_ext |  |
| 10 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 11 | ProcessMinout | biobb_amber_process_minout_ext |  |
| 12 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 13 | ProcessMdout | biobb_amber_process_mdout_ext |  |
| 14 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 15 | ProcessMdout | biobb_amber_process_mdout_ext |  |
| 16 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 17 | ProcessMdout | biobb_amber_process_mdout_ext |  |
| 18 | SanderMdrun | biobb_amber_sander_mdrun_ext |  |
| 19 | CpptrajRms | biobb_analysis_cpptraj_rms_ext |  |
| 20 | CpptrajRms | biobb_analysis_cpptraj_rms_ext |  |
| 21 | CpptrajRgyr | biobb_analysis_cpptraj_rgyr_ext |  |
| 22 | CpptrajImage | biobb_analysis_cpptraj_image_ext |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | mypdb.pdb | output_pdb_path |
| 1 | mypdb4amber_run.pdb | output_pdb_path |
| 2 | myleap_gen_top.crd | output_crd_path |
| 2 | myleap_gen_top.top | output_top_path |
| 2 | myleap_gen_top.pdb | output_pdb_path |
| 3 | mysander_mdrun.rst | output_rst_path |
| 3 | mysander_mdrun.trj | output_traj_path |
| 3 | mysander_mdrun.cpout | output_cpout_path |
| 3 | mysander_mdrun.cprst | output_cprst_path |
| 3 | mysander_mdrun.mdinfo | output_mdinfo_path |
| 3 | mysander_mdrun.log | output_log_path |
| 4 | output_log_path | output_log_path |
| 4 | output_traj_path | output_traj_path |
| 4 | output_cpout_path | output_cpout_path |
| 4 | output_mdinfo_path | output_mdinfo_path |
| 4 | output_cprst_path | output_cprst_path |
| 4 | output_rst_path | output_rst_path |
| 5 | myprocess_minout.dat | output_dat_path |
| 6 | myamber_to_pdb.pdb | output_pdb_path |
| 7 | output_dat_path | output_dat_path |
| 8 | myleap_solvate.top | output_top_path |
| 8 | myleap_solvate.crd | output_crd_path |
| 8 | myleap_solvate.pdb | output_pdb_path |
| 9 | myleap_add_ions.pdb | output_pdb_path |
| 9 | myleap_add_ions.top | output_top_path |
| 9 | myleap_add_ions.crd | output_crd_path |
| 10 | output_traj_path | output_traj_path |
| 10 | output_log_path | output_log_path |
| 10 | output_rst_path | output_rst_path |
| 10 | output_mdinfo_path | output_mdinfo_path |
| 10 | output_cprst_path | output_cprst_path |
| 10 | output_cpout_path | output_cpout_path |
| 11 | output_dat_path | output_dat_path |
| 12 | output_rst_path | output_rst_path |
| 12 | output_traj_path | output_traj_path |
| 12 | output_log_path | output_log_path |
| 12 | output_mdinfo_path | output_mdinfo_path |
| 12 | output_cprst_path | output_cprst_path |
| 12 | output_cpout_path | output_cpout_path |
| 13 | myprocess_mdout.dat | output_dat_path |
| 14 | output_cpout_path | output_cpout_path |
| 14 | output_log_path | output_log_path |
| 14 | output_mdinfo_path | output_mdinfo_path |
| 14 | output_traj_path | output_traj_path |
| 14 | output_rst_path | output_rst_path |
| 14 | output_cprst_path | output_cprst_path |
| 15 | output_dat_path | output_dat_path |
| 16 | output_mdinfo_path | output_mdinfo_path |
| 16 | output_cprst_path | output_cprst_path |
| 16 | output_cpout_path | output_cpout_path |
| 16 | output_traj_path | output_traj_path |
| 16 | output_log_path | output_log_path |
| 16 | output_rst_path | output_rst_path |
| 17 | output_dat_path | output_dat_path |
| 18 | output_cprst_path | output_cprst_path |
| 18 | output_cpout_path | output_cpout_path |
| 18 | output_log_path | output_log_path |
| 18 | mysander_mdrun.netcdf | output_traj_path |
| 18 | output_mdinfo_path | output_mdinfo_path |
| 18 | output_rst_path | output_rst_path |
| 19 | mycpptraj_rms.dat | output_cpptraj_path |
| 20 | output_cpptraj_path | output_cpptraj_path |
| 21 | mycpptraj_rgyr.dat | output_cpptraj_path |
| 22 | mycpptraj_image.trr | output_cpptraj_path |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run biobb_wf_amber_md_setup.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run biobb_wf_amber_md_setup.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run biobb_wf_amber_md_setup.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init biobb_wf_amber_md_setup.ga -o job.yml`
- Lint: `planemo workflow_lint biobb_wf_amber_md_setup.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `biobb_wf_amber_md_setup.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)