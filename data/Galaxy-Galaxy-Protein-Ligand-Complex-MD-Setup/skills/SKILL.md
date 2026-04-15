---
name: gmx-protein-ligand-complex-md-setup
description: This Galaxy workflow automates the preparation and simulation of protein-ligand complexes by processing PDB structures through BioBB tools and GROMACS for parameterization, solvation, and energy minimization. Use this skill when you need to investigate the binding stability and dynamic interactions of a small molecule within a protein active site through molecular dynamics.
homepage: https://mmb.irbbarcelona.org/biobb/
metadata:
  docker_image: "N/A"
---

# gmx-protein-ligand-complex-md-setup

## Overview

This Galaxy workflow automates the setup and execution of a Molecular Dynamics (MD) simulation for a protein-ligand complex using the [GROMACS](https://www.gromacs.org/) engine and [BioExcel Building Blocks (biobb)](https://mmb.irbbarcelona.org/biobb/). It handles the entire pipeline from initial structure retrieval and cleaning to system equilibration and production runs.

The process begins by fetching a PDB structure and separating the protein from the ligand. The protein is processed to fix side chains and add missing hydrogens, while the ligand is parameterized using [Acpype](https://github.com/alanwilter/acpype) to generate compatible topologies. The workflow then merges these components, defines a simulation box, solvates the system, and neutralizes it with ions.

Following system preparation, the workflow performs energy minimization and multiple equilibration steps (NVT and NPT ensembles) to stabilize the complex. Finally, it executes the production MD simulation and provides a suite of analysis tools to calculate potential energy, Root Mean Square Deviation (RMSD), and Radius of Gyration (Rgyr), ensuring the trajectory is centered and imaged correctly for visualization.

## Inputs and data preparation

_None listed._


Ensure your input PDB files are correctly formatted with distinct protein and ligand identifiers to facilitate the automated extraction and parameterization steps. Use individual datasets for the initial structure files, as the workflow is designed to process specific molecular components through the BioBB toolset. For comprehensive details on parameter settings and file preparation, refer to the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Pdb | biobb_io_pdb_ext |  |
| 1 | ExtractHeteroatoms | biobb_structure_utils_extract_heteroatoms_ext |  |
| 2 | ExtractMolecule | biobb_structure_utils_extract_molecule_ext |  |
| 3 | ReduceAddHydrogens | biobb_chemistry_reduce_add_hydrogens_ext |  |
| 4 | FixSideChain | biobb_model_fix_side_chain_ext |  |
| 5 | BabelMinimize | biobb_chemistry_babel_minimize_ext |  |
| 6 | Pdb2gmx | biobb_gromacs_pdb2gmx_ext |  |
| 7 | AcpypeParamsGmx | biobb_chemistry_acpype_params_gmx_ext |  |
| 8 | GmxTrjconvStr | biobb_analysis_gmx_trjconv_str_ext |  |
| 9 | MakeNdx | biobb_gromacs_make_ndx_ext |  |
| 10 | GmxTrjconvStr | biobb_analysis_gmx_trjconv_str_ext |  |
| 11 | Genrestr | biobb_gromacs_genrestr_ext |  |
| 12 | CatPdb | biobb_structure_utils_cat_pdb_ext |  |
| 13 | AppendLigand | biobb_gromacs_append_ligand_ext |  |
| 14 | Editconf | biobb_gromacs_editconf_ext |  |
| 15 | Solvate | biobb_gromacs_solvate_ext |  |
| 16 | Grompp | biobb_gromacs_grompp_ext |  |
| 17 | Genion | biobb_gromacs_genion_ext |  |
| 18 | Grompp | biobb_gromacs_grompp_ext |  |
| 19 | Mdrun | biobb_gromacs_mdrun_ext |  |
| 20 | MakeNdx | biobb_gromacs_make_ndx_ext |  |
| 21 | GmxEnergy | biobb_analysis_gmx_energy_ext |  |
| 22 | Grompp | biobb_gromacs_grompp_ext |  |
| 23 | Mdrun | biobb_gromacs_mdrun_ext |  |
| 24 | GmxEnergy | biobb_analysis_gmx_energy_ext |  |
| 25 | Grompp | biobb_gromacs_grompp_ext |  |
| 26 | Mdrun | biobb_gromacs_mdrun_ext |  |
| 27 | GmxEnergy | biobb_analysis_gmx_energy_ext |  |
| 28 | Grompp | biobb_gromacs_grompp_ext |  |
| 29 | Mdrun | biobb_gromacs_mdrun_ext |  |
| 30 | GmxRgyr | biobb_analysis_gmx_rgyr_ext |  |
| 31 | GmxRms | biobb_analysis_gmx_rms_ext |  |
| 32 | GmxRms | biobb_analysis_gmx_rms_ext |  |
| 33 | GmxTrjconvStr | biobb_analysis_gmx_trjconv_str_ext |  |
| 34 | GmxImage | biobb_analysis_gmx_image_ext |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | mypdb_prot.pdb | output_pdb_path |
| 1 | myextract_heteroatoms.pdb | output_heteroatom_path |
| 2 | myextract_molecule.pdb | output_molecule_path |
| 3 | myreduce_add_hydrogens.pdb | output_path |
| 4 | myfix_side_chain.pdb | output_pdb_path |
| 5 | mybabel_minimize.mol2 | output_path |
| 6 | mypdb2gmx.zip | output_top_zip_path |
| 6 | mypdb2gmx.gro | output_gro_path |
| 7 | myacpype_params_gmx.itp | output_path_itp |
| 7 | myacpype_params_gmx.gro | output_path_gro |
| 7 | myacpype_params_gmx.top | output_path_top |
| 8 | mygmx_trjconv_str_prot.pdb | output_str_path |
| 9 | mymake_ndx.ndx | output_ndx_path |
| 10 | mygmx_trjconv_str_lig.pdb | output_str_path |
| 11 | mygenrestr.itp | output_itp_path |
| 12 | mycat_pdb.pdb | output_structure_path |
| 13 | myappend_ligand.zip | output_top_zip_path |
| 14 | myeditconf.gro | output_gro_path |
| 15 | mysolvate.gro | output_gro_path |
| 15 | mysolvate.zip | output_top_zip_path |
| 16 | mygrompp_ion.tpr | output_tpr_path |
| 17 | mygenion.gro | output_gro_path |
| 17 | mygenion.zip | output_top_zip_path |
| 18 | output_tpr_path | output_tpr_path |
| 19 | mymdrun.edr | output_edr_path |
| 19 | mymdrun.log | output_log_path |
| 19 | mymdrun.cpt | output_cpt_path |
| 19 | mymdrun.xvg | output_dhdl_path |
| 19 | mymdrun.trr | output_trr_path |
| 19 | mymdrun.gro | output_gro_path |
| 19 | mymdrun.xtc | output_xtc_path |
| 20 | output_ndx_path | output_ndx_path |
| 21 | mygmx_energy.xvg | output_xvg_path |
| 22 | output_tpr_path | output_tpr_path |
| 23 | output_edr_path | output_edr_path |
| 23 | output_dhdl_path | output_dhdl_path |
| 23 | output_trr_path | output_trr_path |
| 23 | output_log_path | output_log_path |
| 23 | output_xtc_path | output_xtc_path |
| 23 | output_cpt_path | output_cpt_path |
| 23 | output_gro_path | output_gro_path |
| 24 | output_xvg_path | output_xvg_path |
| 25 | output_tpr_path | output_tpr_path |
| 26 | output_log_path | output_log_path |
| 26 | output_gro_path | output_gro_path |
| 26 | output_xtc_path | output_xtc_path |
| 26 | output_trr_path | output_trr_path |
| 26 | output_cpt_path | output_cpt_path |
| 26 | output_dhdl_path | output_dhdl_path |
| 26 | output_edr_path | output_edr_path |
| 27 | output_xvg_path | output_xvg_path |
| 28 | output_tpr_path | output_tpr_path |
| 29 | output_xtc_path | output_xtc_path |
| 29 | output_trr_path | output_trr_path |
| 29 | output_gro_path | output_gro_path |
| 29 | output_edr_path | output_edr_path |
| 29 | output_cpt_path | output_cpt_path |
| 29 | output_log_path | output_log_path |
| 29 | output_dhdl_path | output_dhdl_path |
| 30 | mygmx_rgyr.xvg | output_xvg_path |
| 31 | output_xvg_path | output_xvg_path |
| 32 | mygmx_rms_exp.xvg | output_xvg_path |
| 33 | output_str_path | output_str_path |
| 34 | mygmx_image.trr | output_traj_path |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run biobb_wf_protein_complex_md_setup.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run biobb_wf_protein_complex_md_setup.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run biobb_wf_protein_complex_md_setup.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init biobb_wf_protein_complex_md_setup.ga -o job.yml`
- Lint: `planemo workflow_lint biobb_wf_protein_complex_md_setup.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `biobb_wf_protein_complex_md_setup.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)