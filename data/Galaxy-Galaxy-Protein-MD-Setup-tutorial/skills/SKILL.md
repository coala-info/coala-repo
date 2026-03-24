---
name: gmx-protein-md-setup
description: "This Galaxy workflow automates the preparation, solvation, and execution of GROMACS molecular dynamics simulations for protein structures using BioBB building blocks. Use this skill when you need to characterize the structural stability, energy profiles, and conformational changes of a protein within a simulated aqueous environment."
homepage: https://workflowhub.eu/workflows/277
---

# GMX Protein MD Setup

## Overview

This workflow automates the setup and execution of a Molecular Dynamics (MD) simulation for a protein system using GROMACS, powered by the [BioExcel Building Blocks (BioBB)](https://mmb.irbbarcelona.org/biobb/) library. It streamlines the process from initial structure retrieval to production MD, ensuring a standardized pipeline for biomolecular simulations.

The process begins by fetching a protein structure from the PDB and repairing missing side chains. It then transitions into the GROMACS preparation phase, which includes generating the system topology, defining the simulation box, solvating the protein, and neutralizing the system with ions. These steps ensure the molecular system is properly equilibrated and ready for thermodynamic sampling.

The simulation pipeline performs energy minimization followed by NVT and NPT equilibration steps to stabilize temperature and pressure. Once equilibrated, the workflow executes the production MD run and provides a suite of analysis tools to calculate energy properties, Root Mean Square Deviation (RMSD), and Radius of Gyration (Rg). It also includes trajectory processing steps for visualization and structural analysis.

For detailed instructions on how to import the `.ga` file and execute this pipeline on the [INB's Galaxy server](https://biobb.usegalaxy.es/), please refer to the [README.md](README.md) in the Files section.

## Inputs and data preparation

_None listed._


To prepare for this GROMACS molecular dynamics setup, ensure you have a valid PDB structure file as the primary input, as the workflow will handle side-chain fixing and topology generation. You should upload your protein structure as a single dataset, while the subsequent BioBB steps will automatically manage the generation of compressed ZIP topologies and GRO coordinate files. For large-scale testing or automated execution, you can initialize your environment using `planemo workflow_job_init` to create a `job.yml` file. Detailed instructions on parameterizing the equilibration and production runs are available in the README.md. Always verify that your input PDB is free of non-standard residues that might require custom force field parameters not included in the default PDB2GMX step.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Pdb | biobb_io_pdb_ext |  |
| 1 | FixSideChain | biobb_model_fix_side_chain_ext |  |
| 2 | Pdb2gmx | biobb_gromacs_pdb2gmx_ext |  |
| 3 | Editconf | biobb_gromacs_editconf_ext |  |
| 4 | Solvate | biobb_gromacs_solvate_ext |  |
| 5 | Grompp | biobb_gromacs_grompp_ext |  |
| 6 | Genion | biobb_gromacs_genion_ext |  |
| 7 | Grompp | biobb_gromacs_grompp_ext |  |
| 8 | Mdrun | biobb_gromacs_mdrun_ext |  |
| 9 | Grompp | biobb_gromacs_grompp_ext |  |
| 10 | GmxEnergy | biobb_analysis_gmx_energy_ext |  |
| 11 | Mdrun | biobb_gromacs_mdrun_ext |  |
| 12 | Grompp | biobb_gromacs_grompp_ext |  |
| 13 | GmxEnergy | biobb_analysis_gmx_energy_ext |  |
| 14 | Mdrun | biobb_gromacs_mdrun_ext |  |
| 15 | Grompp | biobb_gromacs_grompp_ext |  |
| 16 | GmxEnergy | biobb_analysis_gmx_energy_ext |  |
| 17 | Mdrun | biobb_gromacs_mdrun_ext |  |
| 18 | GmxRms | biobb_analysis_gmx_rms_ext |  |
| 19 | GmxRms | biobb_analysis_gmx_rms_ext |  |
| 20 | GmxRgyr | biobb_analysis_gmx_rgyr_ext |  |
| 21 | GmxImage | biobb_analysis_gmx_image_ext |  |
| 22 | GmxTrjconvStr | biobb_analysis_gmx_trjconv_str_ext |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | mypdb.pdb | output_pdb_path |
| 1 | myfix_side_chain.pdb | output_pdb_path |
| 2 | mypdb2gmx.gro | output_gro_path |
| 2 | mypdb2gmx.zip | output_top_zip_path |
| 3 | myeditconf.pdb | output_gro_path |
| 4 | mysolvate.gro | output_gro_path |
| 4 | mysolvate.zip | output_top_zip_path |
| 5 | mygrompp.tpr | output_tpr_path |
| 6 | mygenion.zip | output_top_zip_path |
| 6 | mygenion.gro | output_gro_path |
| 7 | output_tpr_path | output_tpr_path |
| 8 | mymdrun.xtc | output_xtc_path |
| 8 | mymdrun.log | output_log_path |
| 8 | mymdrun.cpt | output_cpt_path |
| 8 | mymdrun.xvg | output_dhdl_path |
| 8 | mymdrun.gro | output_gro_path |
| 8 | mymdrun.edr | output_edr_path |
| 8 | mymdrun.trr | output_trr_path |
| 9 | output_tpr_path | output_tpr_path |
| 10 | mygmx_energy.xvg | output_xvg_path |
| 11 | output_log_path | output_log_path |
| 11 | output_trr_path | output_trr_path |
| 11 | output_dhdl_path | output_dhdl_path |
| 11 | output_cpt_path | output_cpt_path |
| 11 | output_xtc_path | output_xtc_path |
| 11 | output_gro_path | output_gro_path |
| 11 | output_edr_path | output_edr_path |
| 12 | output_tpr_path | output_tpr_path |
| 13 | output_xvg_path | output_xvg_path |
| 14 | output_edr_path | output_edr_path |
| 14 | output_gro_path | output_gro_path |
| 14 | output_trr_path | output_trr_path |
| 14 | output_dhdl_path | output_dhdl_path |
| 14 | output_log_path | output_log_path |
| 14 | output_xtc_path | output_xtc_path |
| 14 | output_cpt_path | output_cpt_path |
| 15 | output_tpr_path | output_tpr_path |
| 16 | output_xvg_path | output_xvg_path |
| 17 | output_trr_path | output_trr_path |
| 17 | output_xtc_path | output_xtc_path |
| 17 | output_gro_path | output_gro_path |
| 17 | output_dhdl_path | output_dhdl_path |
| 17 | output_cpt_path | output_cpt_path |
| 17 | output_log_path | output_log_path |
| 17 | output_edr_path | output_edr_path |
| 18 | output_xvg_path | output_xvg_path |
| 19 | mygmx_rms.xvg | output_xvg_path |
| 20 | mygmx_rgyr.xvg | output_xvg_path |
| 21 | mygmx_image.xtc | output_traj_path |
| 22 | mygmx_trjconv_str.pdb | output_str_path |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run biobb_wf_md_setup.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run biobb_wf_md_setup.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run biobb_wf_md_setup.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init biobb_wf_md_setup.ga -o job.yml`
- Lint: `planemo workflow_lint biobb_wf_md_setup.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `biobb_wf_md_setup.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
