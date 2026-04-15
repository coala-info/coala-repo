---
name: biobb-wf-md-setup-protein
description: This Galaxy workflow automates the preparation and execution of protein molecular dynamics simulations by processing PDB structures through BioExcel Building Blocks and GROMACS tools for solvation, ionization, and equilibration. Use this skill when you need to generate a stable, solvated protein system and perform production MD runs to analyze structural properties like RMSD and radius of gyration.
homepage: https://mmb.irbbarcelona.org/biobb/
metadata:
  docker_image: "N/A"
---

# biobb-wf-md-setup-protein

## Overview

This workflow automates the setup and execution of a Molecular Dynamics (MD) simulation for a protein system using the [BioExcel Building Blocks (biobb)](https://mmb.irbbarcelona.org/biobb/) library. It begins by fetching a protein structure from the PDB, fixing missing side chains, and generating the GROMACS topology. The system is then defined within a simulation box, solvated, and neutralized with ions to prepare the environment for simulation.

The simulation process follows a standard protocol, starting with energy minimization to resolve steric clashes. This is followed by NVT and NPT equilibration phases to stabilize the system's temperature and pressure. These steps utilize GROMACS tools integrated via biobb wrappers, ensuring the protein is properly equilibrated before proceeding to the production MD run.

Upon completion of the production simulation, the workflow performs several analysis tasks to evaluate the results. These include trajectory imaging and centering, RMSD (Root Mean Square Deviation) calculations to assess structural stability, and Radius of Gyration (Rgyr) analysis to monitor protein compactness. The final outputs provide a comprehensive set of trajectories, energy plots, and structural data.

## Inputs and data preparation

_None listed._


Ensure your primary input is a valid PDB file containing the protein structure of interest, as the workflow begins by fetching or processing this specific format. While individual datasets are standard for single protein runs, consider using dataset collections if you plan to scale this setup for multiple protein variants simultaneously. Note that BioBB tools often package GROMACS topology files into ZIP archives to maintain required directory structures, so ensure these remain linked throughout the pipeline. Refer to the `README.md` for comprehensive details on specific parameter settings and force field selections required for each step. You can automate the configuration of these inputs by using `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Pdb | biobb_io_pdb_ext | Download a protein structure from the PDB database |
| 1 | FixSideChain | biobb_model_fix_side_chain_ext | Fix the side chains, adding any side chain atoms missing in the original structure |
| 2 | Pdb2gmx | biobb_md_pdb2gmx_ext | Create Protein System Topology |
| 3 | Editconf | biobb_md_editconf_ext | Create Solvent Box |
| 4 | Solvate | biobb_md_solvate_ext | Fill the box with water molecules |
| 5 | Grompp | biobb_md_grompp_ext | Add Ions - part 1 |
| 6 | Genion | biobb_md_genion_ext | Add Ions - part 2 |
| 7 | Grompp | biobb_md_grompp_ext | Energetically minimize the system - part 1 |
| 8 | Mdrun | biobb_md_mdrun_ext | Energetically minimize the system - part 2 |
| 9 | Grompp | biobb_md_grompp_ext | Equilibriate the system (NVT) - part 1 |
| 10 | GmxEnergy | biobb_analysis_gmx_energy_ext | Energetically minimize the system - part 3 |
| 11 | Mdrun | biobb_md_mdrun_ext | Equilibrate the system (NVT) - part 2 |
| 12 | Grompp | biobb_md_grompp_ext | Equilibrate the system (NPT) - part 1 |
| 13 | GmxEnergy | biobb_analysis_gmx_energy_ext | Equilibrate the system (NVT) - part 3 |
| 14 | Mdrun | biobb_md_mdrun_ext | Equilibrate the system (NPT) - part 2 |
| 15 | Grompp | biobb_md_grompp_ext | Free molecular dynamics simulation - part 1 |
| 16 | GmxEnergy | biobb_analysis_gmx_energy_ext | Equilibrate the system (NPT) - part 3 |
| 17 | Mdrun | biobb_md_mdrun_ext | Free molecular dynamics simulation - part 2 |
| 18 | GmxRms | biobb_analysis_gmx_rms_ext | Post-processing resulting 3D trajectory - part 1 |
| 19 | GmxImage | biobb_analysis_gmx_image_ext | Post-processing resulting 3D trajectory - part 4 |
| 20 | GmxTrjconvStr | biobb_analysis_gmx_trjconv_str_ext | Post-processing resulting 3D trajectory - part 5 |
| 21 | GmxRms | biobb_analysis_gmx_rms_ext | Post-processing resulting 3D trajectory - part 2 |
| 22 | GmxRgyr | biobb_analysis_gmx_rgyr_ext | Post-processing resulting 3D trajectory - part 3 |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | mypdb.pdb | output_pdb_path |
| 1 | myfix_side_chain.pdb | output_pdb_path |
| 2 | mypdb2gmx.gro | output_gro_path |
| 2 | mypdb2gmx.zip | output_top_zip_path |
| 3 | myeditconf.gro | output_gro_path |
| 4 | mysolvate.zip | output_top_zip_path |
| 4 | mysolvate.gro | output_gro_path |
| 5 | mygrompp.tpr | output_tpr_path |
| 6 | mygenion.gro | output_gro_path |
| 6 | mygenion.zip | output_top_zip_path |
| 7 | output_tpr_path | output_tpr_path |
| 8 | mymdrun.edr | output_edr_path |
| 8 | mymdrun.log | output_log_path |
| 8 | mymdrun.xtc | output_xtc_path |
| 8 | mymdrun.cpt | output_cpt_path |
| 8 | mymdrun.xvg | output_dhdl_path |
| 8 | mymdrun.trr | output_trr_path |
| 8 | mymdrun.gro | output_gro_path |
| 9 | output_tpr_path | output_tpr_path |
| 10 | energy_min.xvg | output_xvg_path |
| 11 | output_trr_path | output_trr_path |
| 11 | output_gro_path | output_gro_path |
| 11 | output_cpt_path | output_cpt_path |
| 11 | output_xtc_path | output_xtc_path |
| 11 | output_log_path | output_log_path |
| 11 | output_edr_path | output_edr_path |
| 11 | output_dhdl_path | output_dhdl_path |
| 12 | output_tpr_path | output_tpr_path |
| 13 | energy_nvt.xvg | output_xvg_path |
| 14 | output_log_path | output_log_path |
| 14 | output_xtc_path | output_xtc_path |
| 14 | output_edr_path | output_edr_path |
| 14 | output_trr_path | output_trr_path |
| 14 | output_gro_path | output_gro_path |
| 14 | output_cpt_path | output_cpt_path |
| 14 | output_dhdl_path | output_dhdl_path |
| 15 | output_tpr_path | output_tpr_path |
| 16 | energy_npt.xvg | output_xvg_path |
| 17 | output_trr_path | output_trr_path |
| 17 | output_dhdl_path | output_dhdl_path |
| 17 | output_edr_path | output_edr_path |
| 17 | output_gro_path | output_gro_path |
| 17 | output_xtc_path | output_xtc_path |
| 17 | output_log_path | output_log_path |
| 17 | output_cpt_path | output_cpt_path |
| 18 | rmsd_first.xvg | output_xvg_path |
| 19 | mygmx_image.xtc | output_traj_path |
| 20 | mygmx_trjconv_str.xtc | output_str_path |
| 21 | rmsd_exp.xvg | output_xvg_path |
| 22 | mygmx_rgyr.xvg | output_xvg_path |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-biobb-wf-md-setup-protein.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-biobb-wf-md-setup-protein.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-biobb-wf-md-setup-protein.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-biobb-wf-md-setup-protein.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-biobb-wf-md-setup-protein.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-biobb-wf-md-setup-protein.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)