---
name: fpocket-protein-ligand-docking
description: "This Galaxy workflow performs automated protein-ligand docking by identifying potential binding sites with Fpocket and calculating binding affinities using AutoDock Vina from input PDB and SDF files. Use this skill when you need to predict the binding pose and affinity of a small molecule within the most probable cavities of a target protein structure for drug discovery applications."
homepage: https://workflowhub.eu/workflows/296
---

# Fpocket Protein-Ligand Docking

## Overview

This Galaxy workflow automates a complete virtual screening pipeline, focusing on protein-ligand docking by identifying potential binding sites. It begins by fetching protein and ligand structures using [BioBB](https://mmb.irbbarcelona.org/biobb/) tools, followed by structure preparation steps such as molecule extraction, hydrogen addition, and format conversion via Open Babel.

The core of the process utilizes **fpocket** to perform cavity analysis, identifying and filtering potential binding pockets based on specific physicochemical properties. Once the optimal pocket is selected, the workflow automatically defines a docking grid box around the site to guide the subsequent simulation.

The final stages involve molecular docking using **AutoDock Vina**, which predicts the binding pose and affinity of the ligand within the identified pocket. The workflow concludes by extracting the top-scoring models and concatenating the results into a final PDB structure for visualization and analysis. Detailed execution instructions can be found in the [README.md](README.md).

## Inputs and data preparation

_None listed._


To execute this workflow, provide the protein structure in PDB format and the ligand in SDF format as the primary inputs. Ensure that the PDB file is correctly formatted for BioBB tools and that the SDF contains the ideal coordinates for the ligand of interest. For large-scale screenings, organize your inputs into Galaxy datasets or collections to streamline the docking process across multiple pockets. Refer to the README.md for comprehensive details on parameter settings and file preparation. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Pdb | biobb_io_pdb_ext |  |
| 1 | IdealSdf | biobb_io_ideal_sdf_ext |  |
| 2 | ExtractMolecule | biobb_structure_utils_extract_molecule_ext |  |
| 3 | BabelConvert | biobb_chemistry_babel_convert_ext |  |
| 4 | FpocketRun | biobb_vs_fpocket_run_ext |  |
| 5 | StrCheckAddHydrogens | biobb_structure_utils_str_check_add_hydrogens_ext |  |
| 6 | BabelConvert | biobb_chemistry_babel_convert_ext |  |
| 7 | FpocketFilter | biobb_vs_fpocket_filter_ext |  |
| 8 | FpocketSelect | biobb_vs_fpocket_select_ext |  |
| 9 | Box | biobb_vs_box_ext |  |
| 10 | AutodockVinaRun | biobb_vs_autodock_vina_run_ext |  |
| 11 | ExtractModelPdbqt | biobb_vs_extract_model_pdbqt_ext |  |
| 12 | BabelConvert | biobb_chemistry_babel_convert_ext |  |
| 13 | CatPdb | biobb_structure_utils_cat_pdb_ext |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | mypdb.pdb | output_pdb_path |
| 1 | myideal_sdf.sdf | output_sdf_path |
| 2 | myextract_molecule.pdb | output_molecule_path |
| 3 | mybabel_convert.ent | output_path |
| 4 | myfpocket_run.zip | output_pockets_zip |
| 4 | myfpocket_run.json | output_summary |
| 5 | mystr_check_add_hydrogens.pdb | output_structure_path |
| 6 | output_path | output_path |
| 7 | myfpocket_filter.zip | output_filter_pockets_zip |
| 8 | myfpocket_select.pdb | output_pocket_pdb |
| 8 | myfpocket_select.pqr | output_pocket_pqr |
| 9 | mybox.pdb | output_pdb_path |
| 10 | myautodock_vina_run.log | output_log_path |
| 10 | myautodock_vina_run.pdbqt | output_pdbqt_path |
| 11 | myextract_model_pdbqt.pdbqt | output_pdbqt_path |
| 12 | output_path | output_path |
| 13 | mycat_pdb.pdb | output_structure_path |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run biobb_wf_virtual_screening.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run biobb_wf_virtual_screening.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run biobb_wf_virtual_screening.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init biobb_wf_virtual_screening.ga -o job.yml`
- Lint: `planemo workflow_lint biobb_wf_virtual_screening.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `biobb_wf_virtual_screening.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
