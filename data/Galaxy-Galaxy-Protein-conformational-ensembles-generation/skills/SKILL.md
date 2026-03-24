---
name: protein-conformational-ensembles-generation
description: "This Galaxy workflow generates protein conformational ensembles from a PDB structure using a suite of BioBB tools including ProDy, CONCOORD, iMODS, and FlexServ for normal mode analysis and molecular dynamics. Use this skill when you need to explore the structural flexibility and collective motions of a protein to understand its functional dynamics or to sample diverse conformational states for docking and simulation studies."
homepage: https://workflowhub.eu/workflows/490
---

# Protein conformational ensembles generation

## Overview

This Galaxy workflow provides a comprehensive pipeline for generating protein conformational ensembles using a variety of structural flexibility methods. Starting from a PDB structure, the workflow performs essential preprocessing steps such as model extraction, chain selection, and atom masking. It then leverages multiple computational approaches to explore the protein's conformational space, including Anisotropic Network Models (ANM) via [ProDy](http://prody.csb.pitt.edu/), Normal Mode Analysis (NMA) through [NOLB](https://chaconlab.org/modeling/nolb) and [iMODS](https://imods.chaconlab.org/), and distance constraint simulations using [CONCOORD](https://www3.mpibpc.mpg.de/groups/de_groot/concoord/).

The workflow further extends the analysis by integrating the [FlexServ](https://mmb.irbbarcelona.org/FlexServ/) suite to run Brownian Dynamics (BD), Discrete Molecular Dynamics (DMD), and NMA-based ensembles. Trajectories generated from these diverse methods are processed using [CPPTRAJ](https://ambermd.org/Cpptraj.php) for RMSD calculations, coordinate fitting, and format conversion.

In the final stages, the individual ensembles are concatenated and clustered using [GROMACS](https://www.gromacs.org/) tools to identify representative structural states. The workflow also includes advanced principal component analysis (PCA) via the PCZ suite, providing detailed insights into protein stiffness, collectivity, hinge point identification, and B-factor profiles. This integrated approach allows researchers to compare different flexibility predictors and generate a robust representation of protein dynamics.

## Inputs and data preparation

_None listed._


To prepare for this workflow, ensure you have a protein structure file in PDB format as the primary input for the initial BioBB extraction and modeling steps. The workflow processes individual datasets to generate conformational ensembles, utilizing various trajectory formats such as TRR and MDCRD alongside coordinate files like GRO and PDB. For automated execution and job configuration, you can use `planemo workflow_job_init` to generate a `job.yml` file. Please refer to the `README.md` for comprehensive details on parameter settings and data preparation requirements. Detailed instructions on uploading the workflow to a Galaxy instance and managing the resulting trajectory collections are also provided in the project documentation.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Pdb | biobb_io_pdb_ext |  |
| 1 | ExtractModel | biobb_structure_utils_extract_model_ext |  |
| 2 | ExtractChain | biobb_structure_utils_extract_chain_ext |  |
| 3 | CpptrajMask | biobb_analysis_cpptraj_mask_ext |  |
| 4 | ConcoordDist | biobb_flexdyn_concoord_dist_ext |  |
| 5 | ProdyAnm | biobb_flexdyn_prody_anm_ext |  |
| 6 | ImodImode | biobb_flexdyn_imod_imode_ext |  |
| 7 | CpptrajMask | biobb_analysis_cpptraj_mask_ext |  |
| 8 | ConcoordDisco | biobb_flexdyn_concoord_disco_ext |  |
| 9 | CpptrajRms | biobb_analysis_cpptraj_rms_ext |  |
| 10 | CpptrajConvert | biobb_analysis_cpptraj_convert_ext |  |
| 11 | ImodImc | biobb_flexdyn_imod_imc_ext |  |
| 12 | BdRun | biobb_flexserv_bd_run_ext |  |
| 13 | DmdRun | biobb_flexserv_dmd_run_ext |  |
| 14 | NolbNma | biobb_flexdyn_nolb_nma_ext |  |
| 15 | MakeNdx | biobb_gromacs_make_ndx_ext |  |
| 16 | NmaRun | biobb_flexserv_nma_run_ext |  |
| 17 | CpptrajRms | biobb_analysis_cpptraj_rms_ext |  |
| 18 | CpptrajConvert | biobb_analysis_cpptraj_convert_ext |  |
| 19 | CpptrajRms | biobb_analysis_cpptraj_rms_ext |  |
| 20 | CpptrajConvert | biobb_analysis_cpptraj_convert_ext |  |
| 21 | CpptrajRms | biobb_analysis_cpptraj_rms_ext |  |
| 22 | CpptrajRms | biobb_analysis_cpptraj_rms_ext |  |
| 23 | CpptrajRms | biobb_analysis_cpptraj_rms_ext |  |
| 24 | CpptrajConvert | biobb_analysis_cpptraj_convert_ext |  |
| 25 | CpptrajRms | biobb_analysis_cpptraj_rms_ext |  |
| 26 | CpptrajConvert | biobb_analysis_cpptraj_convert_ext |  |
| 27 | Zip | toolshed.g2.bx.psu.edu/repos/cmonjeau/ziptool/zip/1.0.1 |  |
| 28 | Trjcat | biobb_gromacs_trjcat_ext |  |
| 29 | GmxCluster | biobb_analysis_gmx_cluster_ext |  |
| 30 | CpptrajRms | biobb_analysis_cpptraj_rms_ext |  |
| 31 | PczZip | biobb_flexserv_pcz_zip_ext |  |
| 32 | PczZip | biobb_flexserv_pcz_zip_ext |  |
| 33 | PczInfo | biobb_flexserv_pcz_info_ext |  |
| 34 | PczEvecs | biobb_flexserv_pcz_evecs_ext |  |
| 35 | PczAnimate | biobb_flexserv_pcz_animate_ext |  |
| 36 | PczBfactor | biobb_flexserv_pcz_bfactor_ext |  |
| 37 | PczStiffness | biobb_flexserv_pcz_stiffness_ext |  |
| 38 | PczCollectivity | biobb_flexserv_pcz_collectivity_ext |  |
| 39 | PczHinges | biobb_flexserv_pcz_hinges_ext |  |
| 40 | PczHinges | biobb_flexserv_pcz_hinges_ext |  |
| 41 | PczHinges | biobb_flexserv_pcz_hinges_ext |  |
| 42 | CpptrajConvert | biobb_analysis_cpptraj_convert_ext |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | mypdb.pdb | output_pdb_path |
| 1 | myextract_model.pdb | output_structure_path |
| 2 | myextract_monomer.pdb | output_structure_path |
| 3 | mycpptraj_mask_backbone | output_cpptraj_path |
| 4 | myconcoord_dist.dat | output_dat_path |
| 4 | myconcoord_dist.gro | output_gro_path |
| 4 | myconcoord_dist.pdb | output_pdb_path |
| 5 | myprody_anm_traj.pdb | output_pdb_path |
| 6 | myimod_imode_evecs.dat | output_dat_path |
| 7 | mycpptraj_mask_ca.pdb | output_cpptraj_path |
| 8 | myconcoord_disco_rmsd.dat | output_rmsd_path |
| 8 | myconcoord_disco_bfactor.pdb | output_bfactor_path |
| 8 | myconcoord_disco_traj.pdb | output_traj_path |
| 9 | mycpptraj_prody_rms.dat | output_cpptraj_path |
| 10 | mycpptraj_prody_anm_traj.trr | output_cpptraj_path |
| 11 | myimod_imc.pdb | output_traj_path |
| 12 | mybd_flexserv_bd_ensemble.mdcrd | output_crd_path |
| 12 | mybd_flexserv_bd_ensemble.log | output_log_path |
| 13 | mydmd_flexserv_dmd_ensemble.mdcrd | output_crd_path |
| 13 | mydmd_flexserv_dmd_ensemble.log | output_log_path |
| 14 | mynolb_ensemble.pdb | output_pdb_path |
| 15 | mymake_gmx_ndx.ndx | output_ndx_path |
| 16 | mynma_flexserv_nma_ensemble.log | output_log_path |
| 16 | mynma_flexserv_nma_ensemble.mdcrd | output_crd_path |
| 17 | output_cpptraj_path | output_cpptraj_path |
| 18 | mycpptraj_disco_traj.trr | output_cpptraj_path |
| 19 | output_cpptraj_path | output_cpptraj_path |
| 20 | mycpptraj_imods_ensemble.trr | output_cpptraj_path |
| 21 | mycpptraj_flexserv_bd_rmsd.dat | output_cpptraj_path |
| 21 | mycpptraj_flexserv_bd_traj_fitted.trr | output_traj_path |
| 22 | mycpptraj_flexserv_dmd_traj_fitted.trr | output_traj_path |
| 22 | mycpptraj_flexserv_dmd_rmsd.dat | output_cpptraj_path |
| 23 | mycpptraj_nolb_rmsd.dat | output_cpptraj_path |
| 24 | mycpptraj_nolb_ensemble.trr | output_cpptraj_path |
| 25 | mycpptraj_flexserv_nma_rmsd.dat | output_cpptraj_path |
| 26 | mycpptraj_flexserv_nma_ensemble.trr | output_cpptraj_path |
| 27 | concat_traj.zip | output |
| 28 | mytrjcat_concat_traj.trr | output_trj_path |
| 29 | mygmx_cluster.xvg | output_rmsd_dist_xvg_path |
| 29 | mygmx_cluster.log | output_cluster_log_path |
| 29 | mygmx_concat.cluster.pdb | output_pdb_path |
| 29 | mygmx_cluster.xpm | output_rmsd_cluster_xpm_path |
| 30 | mycpptraj_meta_traj_rmsd.dat | output_cpptraj_path |
| 30 | mycpptraj_meta_traj_fitted.crd | output_traj_path |
| 31 | output_pcz_path | output_pcz_path |
| 32 | output_pcz_path | output_pcz_path |
| 33 | mypcz_report.json | output_json_path |
| 34 | mypcz_evecs.json | output_json_path |
| 35 | mypcz_proj1.crd | output_crd_path |
| 36 | mypcz_bfactor_all.dat | output_dat_path |
| 36 | mypcz_bfactor_all.pdb | output_pdb_path |
| 37 | mypcz_stiffness.json | output_json_path |
| 38 | mypcz_collectivity.json | output_json_path |
| 39 | mypcz_hinges_bfactor_report.json | output_json_path |
| 40 | output_json_path | output_json_path |
| 41 | mypcz_hinges_fcte_report.json | output_json_path |
| 42 | mycpptraj_pcz_proj1.dcd | output_cpptraj_path |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run biobb_wf_flexdyn.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run biobb_wf_flexdyn.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run biobb_wf_flexdyn.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init biobb_wf_flexdyn.ga -o job.yml`
- Lint: `planemo workflow_lint biobb_wf_flexdyn.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `biobb_wf_flexdyn.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
